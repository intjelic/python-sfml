import sfml as sf

# the goal is to handle socket status elegantly.

PORT = 1

# OLD METHOD

#listener = sf.TcpListener()
#status = listener.old_listen(PORT)

#if status != sf.Socket.DONE:
	#if status == sf.Socket.NOT_READY:
		#print("The socket is not ready!")
	#elif status == sf.Socket.DISCONNECTED:
		#print("The socket is disconnected!")
	#elif status == sf.Socket.ERROR:
		#print("An error occured!")
	
	
# NEW METHOD

listener = sf.TcpListener()

#try:
	#listener.new_listen(PORT)
#except sf.SocketNotReady:
	#print("The socket is not ready!")
#except sf.SocketDisconnected:
		#print("The socket is disconnected!")
#except sf.SocketError:
		#print("An error occured!")

# We often don't need to handle errors, so just type:

try: listener.new_listen(PORT)
except sf.SFMLException: print("An error occued!")

