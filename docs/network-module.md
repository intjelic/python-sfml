# Network Module

The SFML network module provides lightweight IPv4 networking, socket polling, and FTP and HTTP client wrappers.

## Quick Feel

```python
from sfml import network

socket = network.TcpSocket()
server = network.IpAddress.from_string("127.0.0.1")

socket.connect(server, 5000)
written = socket.send(b"hello")
reply = socket.receive(64)

print(written, reply)
```

`TcpSocket.send(...)` returns the number of bytes written. That matters for nonblocking code.

## Blocking And Nonblocking Sockets

Socket status is exception-based in Python.

```python
from sfml import network

socket = network.TcpSocket()
socket.blocking = False

try:
    socket.connect(network.IpAddress.LOCAL_HOST, 5000)
except network.SocketNotReady:
    pass
```

The key exceptions are:

- `SocketNotReady`
- `SocketDisconnected`
- `SocketError`

If you switch to nonblocking mode, be ready to handle partial progress and readiness checks explicitly.

## Socket Selectors

`SocketSelector` gives you a simple readiness wait across multiple sockets.

```python
from sfml import network, system

selector = network.SocketSelector()
selector.add(socket)

if selector.wait(system.seconds(0.5)) and selector.is_ready(socket):
    data = socket.receive(4096)
    print(data)
```

## UDP

UDP is message-oriented.

```python
from sfml import network

udp = network.UdpSocket()
udp.bind(network.Socket.ANY_PORT)

payload, address, port = udp.receive(1024)
udp.send(payload, address, port)
```

## HTTP And FTP

The HTTP and FTP wrappers return response objects instead of raising protocol-level exceptions.

```python
from sfml import network

http = network.Http(b"example.com")
request = network.HttpRequest()
request.set_method(network.HttpRequest.GET)
request.set_uri(b"/")

response = http.send_request(request)
print(response.status)
print(response.body)
```

Important current-surface detail: these helpers are still bytes-oriented in the stubs. URIs, header fields, request bodies, and HTTP host names use `bytes`, not Python `str`.

FTP has the same general model: call methods on `Ftp`, then inspect the returned response object.

## Differences From C++ Worth Knowing

- Python uses exceptions for socket readiness, disconnection, and error conditions.
- `TcpSocket.send(...)` returns a byte count so partial sends stay visible.
- `SocketSelector` works well with the exception-first socket model.
- Several higher-level helpers still expose `bytes` in the current release, including `Http`, `HttpRequest`, `HttpResponse.body`, and FTP response messages.
- Optional address lookups such as `IpAddress.get_public_address(...)` return `None` on failure.

## Missing Or Deferred Pieces

Two limitations matter most today:

- the `Packet` API is intentionally not part of the public surface yet
- broader validation around partial-send behavior and some protocol paths is still incomplete

For now, the documented path is to use raw `bytes` payloads and handle framing in Python code when you need it.

## Related Guides

- See `system-module.md` for timeout values.
- See `modules.md` for the top-level module map.