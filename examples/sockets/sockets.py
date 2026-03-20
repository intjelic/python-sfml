from sfml import network as sf_network


PORT = 50001


def decode_bytes(value):
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return str(value)


def ip_to_text(address):
    return decode_bytes(address.string)

def run_tcp_server():
    """Launch a server, send a message, and wait for the answer."""

    try:
        listener = sf_network.TcpListener()
        listener.listen(PORT, sf_network.IpAddress.ANY)

        print("Server is listening to port {0}, waiting for connections...".format(PORT))

        socket = listener.accept()
        print("Client connected: {0}".format(ip_to_text(socket.remote_address)))

        message = "Hi, I'm the server"
        sent = socket.send(message.encode('utf-8'))
        print("Sent {0} bytes to the client: {1}".format(sent, message))

        answer = socket.receive(128).decode('utf-8')
        print("Answer received from the client: {0}".format(answer))

    except sf_network.SocketException as error:
        print("An error occurred!")
        print(error)
        return

def run_tcp_client():
    """Create a client, receive a message, and answer it."""

    server = input("Type the address or name of the server to connect to: ")
    server = sf_network.IpAddress.from_string(server)

    socket = sf_network.TcpSocket()

    try:
        socket.connect(server, PORT)
        print("Connected to server {0}".format(ip_to_text(server)))

        message = socket.receive(128).decode('utf-8')
        print("Message received from the server: {0}".format(message))

        answer = "Hi, I'm a client"
        sent = socket.send(answer.encode('utf-8'))
        print("Sent {0} bytes to the server: {1}".format(sent, answer))

    except sf_network.SocketException as error:
        print("An error occurred!")
        print(error)
        return

def run_udp_server():
    """Launch a UDP server, wait for a message, and answer it."""

    socket = sf_network.UdpSocket()

    try:
        socket.bind(PORT, sf_network.IpAddress.ANY)
        print("Server is listening to port {0}, waiting for message...".format(PORT))

        message, ip, port = socket.receive(128)
        print("Message received from client {0}: {1}".format(ip_to_text(ip), message.decode('utf-8')))

        answer = "Hi, I'm the server"
        socket.send(answer.encode('utf-8'), ip, port)
        print("Message sent to the client: {0}".format(answer))

    except sf_network.SocketException as error:
        print("An error occurred!")
        print(error)
        return

def run_udp_client():
    """Send a message to the server and wait for the answer."""

    server = input("Type the address or name of the server to connect to: ")
    server = sf_network.IpAddress.from_string(server)

    socket = sf_network.UdpSocket()

    try:
        message = "Hi, I'm a client"
        socket.send(message.encode('utf-8'), server, PORT)
        print("Message sent to the server: {0}".format(message))

        answer, ip, port = socket.receive(128)
        print("Message received from {0}: {1}".format(ip_to_text(ip), answer.decode('utf-8')))

    except sf_network.SocketException as error:
        print("An error occurred!")
        print(error)
        return

if __name__ == "__main__":
    print("Do you want to use TCP (t) or UDP (u) ?")
    protocol = input().strip().lower()

    print("Do you want to be a server (s) or a client (c) ?")
    who = input().strip().lower()

    if protocol == 't':
        if who == 's':
            run_tcp_server()
        else:
            run_tcp_client()
    else:
        if who == 's':
            run_udp_server()
        else:
            run_udp_client()
