import sfml as sf

print("Many constructors:")
a1 = sf.IpAddress()
print(a1)
a2 = sf.IpAddress.from_string(b"192.168.1.1")
print(a2)
#a3 = sf.IpAddress(6216447)
#print(a3)
#a3 = sf.IpAddress(6216447)
#print(a3)
#a3 = sf.IpAddress(6216447)
#print(a3)
a6 = sf.IpAddress.local_address()
print(a6)
a7 = sf.IpAddress.public_address()
print(a7)
a8 = sf.IpAddress.from_integer(6216447)
print(a8, end="\n\n")

print("Making a server + client:")
# create a listener
listener = sf.TcpListener()

# check its blocking stat and set False
print(listener.blocking)
listener.blocking = False

# make it listen to connexion
status = listener.listen(5001)
print("listener.listen({0}): {1}".format(listener.local_port, status))

socket = sf.TcpSocket()
socket.blocking = False
socket.connect(sf.IpAddress.local_address(), 5001, 5)
#print("socket.connect({0}, {1}, {2})".format(listener.local_port, status))

client = sf.TcpSocket()
status = listener.accept(client)

client.send(b'Hello world')

data_reieved_length = 0
data = b''
data_length = len(b'Hello world')
socket.recieve(data, data_length, data_reieved_length)

print("data_reieved_length: {0}".format(data_reieved_length))
print("data: {0}".format(data))
print("data_length: {0}".format(data_length))

print("socket.local_port: {0}".format(socket.local_port))
print("socket.remote_address: {0}".format(socket.remote_address))
print("socket.remote_port: {0}".format(socket.remote_port))

print("sf.Socket.DONE: {0}".format(sf.Socket.DONE))
print("sf.Socket.NOT_READY: {0}".format(sf.Socket.NOT_READY))
print("sf.Socket.DISCONNECTED: {0}".format(sf.Socket.DISCONNECTED))
print("sf.Socket.ERROR: {0}".format(sf.Socket.ERROR))
