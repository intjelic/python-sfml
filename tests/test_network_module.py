import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

import pytest

import sfml.network as sf
import sfml.system as system


def test_ip_address_constructors_round_trip():
    address = sf.IpAddress.from_bytes(127, 0, 0, 1)

    assert address.string == b"127.0.0.1"
    assert address.integer == 2_130_706_433
    assert sf.IpAddress.ANY.integer == 0
    assert sf.IpAddress.NONE.integer == 0
    assert sf.IpAddress.from_string("127.0.0.1").integer == address.integer
    assert sf.IpAddress.from_integer(address.integer).string == address.string


def test_http_request_builder_methods_and_constants_are_available():
    request = sf.HttpRequest()

    request.set_uri(b"/status")
    request.set_body(b"payload")
    request.set_http_version(1, 1)
    request.set_field(b"Host", b"example.test")
    request.set_method(sf.HttpRequest.PUT)

    assert sf.HttpRequest.PUT != sf.HttpRequest.HEAD
    assert sf.HttpRequest.DELETE != sf.HttpRequest.GET
    assert sf.HttpResponse.NOT_MODIFIED == 304
    assert sf.HttpResponse.BAD_REQUEST == 400
    assert sf.Socket.PARTIAL == 2


def test_nonblocking_listener_accept_raises_socket_not_ready():
    listener = sf.TcpListener()
    listener.blocking = False
    listener.listen(0, sf.IpAddress.LOCAL_HOST)

    try:
        with pytest.raises(sf.SocketNotReady):
            listener.accept()
    finally:
        listener.close()


def test_tcp_listener_and_socket_round_trip_loopback_data():
    listener = sf.TcpListener()
    listener.listen(0, sf.IpAddress.LOCAL_HOST)
    received = {}

    def server():
        server_socket = listener.accept()
        try:
            received["data"] = server_socket.receive(4)
            received["sent"] = server_socket.send(b"pong")
        finally:
            server_socket.disconnect()
            listener.close()

    thread = threading.Thread(target=server)
    thread.start()

    client = sf.TcpSocket()

    try:
        client.connect(sf.IpAddress.LOCAL_HOST, listener.local_port, system.seconds(1))
        assert client.send(b"ping") == 4
        assert client.receive(4) == b"pong"
    finally:
        client.disconnect()
        thread.join()

    assert received["data"] == b"ping"
    assert received["sent"] == 4


def test_udp_socket_and_selector_work_on_loopback():
    listener = sf.TcpListener()
    listener.listen(0, sf.IpAddress.LOCAL_HOST)
    selector = sf.SocketSelector()
    selector.add(listener)

    client = sf.TcpSocket()

    try:
        client.connect(sf.IpAddress.LOCAL_HOST, listener.local_port, system.seconds(1))
        assert selector.wait(system.milliseconds(500)) is True
        assert selector.is_ready(listener) is True
        server_socket = listener.accept()
        server_socket.disconnect()
    finally:
        client.disconnect()
        listener.close()

    server = sf.UdpSocket()
    client_udp = sf.UdpSocket()

    try:
        server.bind(0, sf.IpAddress.LOCAL_HOST)
        client_udp.bind(0, sf.IpAddress.LOCAL_HOST)
        client_udp.send(b"hello", sf.IpAddress.LOCAL_HOST, server.local_port)
        payload, remote_address, remote_port = server.receive(5)
    finally:
        server.unbind()
        client_udp.unbind()

    assert payload == b"hello"
    assert remote_address.string == b"127.0.0.1"
    assert remote_port > 0


def test_http_client_round_trips_local_response_wrapper_with_set_host():
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(b"ok")

        def do_PUT(self):
            content_length = int(self.headers.get("Content-Length", "0"))
            body = self.rfile.read(content_length)
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(body.upper())

        def log_message(self, format, *args):
            pass

    server = ThreadingHTTPServer(("127.0.0.1", 0), Handler)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()

    try:
        client = sf.Http()
        client.set_host(b"127.0.0.1", server.server_port)
        request = sf.HttpRequest()
        request.set_uri(b"/status")
        response = client.send_request(request, system.seconds(1))

        put_request = sf.HttpRequest(b"/status", sf.HttpRequest.PUT, b"payload")
        put_request.set_field(b"Content-Type", b"text/plain")
        put_response = client.send_request(put_request, system.seconds(1))
    finally:
        server.shutdown()
        server.server_close()
        thread.join()

    assert response.status == sf.HttpResponse.OK
    assert response.body == b"ok"
    assert response.get_field(b"Content-Type") == b"text/plain"
    assert put_response.status == sf.HttpResponse.OK
    assert put_response.body == b"PAYLOAD"


def test_ftp_response_wrappers_are_usable_with_local_failure_fixture():
    ftp = sf.Ftp()

    connect_response = ftp.connect(sf.IpAddress.LOCAL_HOST, 1, system.milliseconds(100))
    disconnect_response = ftp.disconnect()
    listing_response = ftp.get_directory_listing()
    directory_response = ftp.get_working_directory()

    assert isinstance(connect_response, sf.FtpResponse)
    assert connect_response.ok is False
    assert connect_response.status == sf.FtpResponse.CONNECTION_FAILED
    assert connect_response.message == b""

    assert isinstance(disconnect_response, sf.FtpResponse)
    assert disconnect_response.ok is False
    assert disconnect_response.status == sf.FtpResponse.CONNECTION_CLOSED

    assert isinstance(listing_response, sf.FtpListingResponse)
    assert listing_response.ok is False
    assert listing_response.status == sf.FtpResponse.CONNECTION_CLOSED
    assert listing_response.filenames == ()

    assert isinstance(directory_response, sf.FtpDirectoryResponse)
    assert directory_response.ok is False
    assert directory_response.status == sf.FtpResponse.CONNECTION_CLOSED
    assert directory_response.get_directory() == b""


def test_ftp_send_command_and_upload_append_are_available_with_local_failure_fixture(tmp_path):
    ftp = sf.Ftp()
    local_file = tmp_path / "payload.txt"
    local_file.write_bytes(b"payload")

    command_response = ftp.send_command("NOOP")
    upload_response = ftp.upload(str(local_file), "remote.txt", sf.Ftp.BINARY, append=True)

    assert isinstance(command_response, sf.FtpResponse)
    assert command_response.ok is False
    assert command_response.status == sf.FtpResponse.CONNECTION_CLOSED

    assert isinstance(upload_response, sf.FtpResponse)
    assert upload_response.ok is False
    assert upload_response.status == sf.FtpResponse.CONNECTION_CLOSED