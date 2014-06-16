import sfml.network as sf

# python 2.* compatability
try: input = raw_input
except NameError: pass

def run_tcp_server():
    """ Launch a server. The server waits for an incoming connection,
    sends a message and waits for the answer. """

    try:
        # create a server socket to accept new connections
        listener = sf.TcpListener()

        # listen to the given port for incoming connections
        listener.listen(PORT)

        print("Server is listening to port {0}, waiting for connections...".format(PORT))

        # wait for a connection
        socket = listener.accept()
        print("Client connected: {0}".format(socket.remote_address))

        # send a message to the connected client
        message = "Hi, I'm the server"
        socket.send(message.encode('utf-8'))
        print("Message sent to the client: {0}".format(message))

        # recieve a message back from the client
        answer = socket.receive(128).decode('utf-8')
        print("Answer received from the client: {0}".format(answer))

    except sf.SocketException as error:
        print("An error occured!")
        print(error)
        return

def run_tcp_client():
    """ Create a client. The client is connected to a server, displays
    the welcome message and sends an answer. """

    server = input("Type the address or name of the server to connect to: ")
    server = sf.IpAddress.from_string(server)

    # create a socket for communicating with the server
    socket = sf.TcpSocket()

    # connect to the server
    try:
        socket.connect(server, PORT)
        print("Connected to server {0}".format(server))

        # receive a message from the server
        message = socket.receive(128).decode('utf-8')
        print("Message received from the server: {0}".format(message))

        # send an answer to the server
        answer = "Hi, I'm a client"
        socket.send(answer.encode('utf-8'))
        print("Message sent to the server: {0}".format(answer))

    except sf.SocketException as error:
        print("An error occured!")
        print(error)
        return

def run_udp_server():
    """ Launch a server. The server waits for a message then sends an
    answer. """

    # create a socket to receive a message from anyone
    socket = sf.UdpSocket()

    try:
        # listen to messages on the specified port
        socket.bind(PORT)
        print("Server is listening to port {0}, waiting for message...".format(PORT))

        # wait for a message
        message, ip, port = socket.receive(128)
        print("Message received from client {0}: {1}".format(ip, message.decode('utf-8')))

        # send an answer to the client
        answer = "Hi, I'm the server"
        socket.send(answer.encode('utf-8'), ip, port)
        print("Message sent to the client: {0}".format(answer))

    except sf.SocketException as error:
        print("An error occured!")
        print(error)
        return

def run_udp_client():
    """ Send a message to the server, wait for the answer. """

    # ask for the server address
    server = input("Type the address or name of the server to connect to: ")
    server = sf.IpAddress.from_string(server)

    # create a socket for communicating with the server
    socket = sf.UdpSocket()

    try:
        # send a message to the server
        message = "Hi, I'm a client"
        socket.send(message.encode('utf-8'), server, PORT)
        print("Message sent to the server: {0}".format(message))

        # receive an answer from anyone (but most likely from the server)
        answer, ip, port = socket.receive(128)
        print("Message received from {0}: {1}".format(ip, answer.decode('utf-8')))

    except sf.SocketException as error:
        print("An error occured!")
        print(error)
        return

if __name__ == "__main__":
    # choose an arbitrary port for opening sockets
    PORT = 50001

    # TCP or UDP ?
    print("Do you want to use TCP (t) or UDP (u) ?")
    protocol = input()

    # client or server ?
    print("Do you want to be a server (s) or a client (c) ?")
    who = input()

    if protocol == 't':
        if who == 's': run_tcp_server()
        else: run_tcp_client()
    else:
        if who == 's': run_udp_server()
        else: run_udp_client()

    input("Press any key to exit...")
