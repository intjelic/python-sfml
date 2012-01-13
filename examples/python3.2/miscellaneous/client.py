from time import sleep
import sfml.network as sf

def main():
    socket = sf.TcpSocket()
    socket.blocking = True
    
    status = socket.connect(sf.IpAddress.local_address(), 5004, 5)
    
    if (status != sf.Socket.DONE):
        print("Connexion has failed!")
        exit()

    print("Connexion etablished!")
    sleep(1)
    
    # try to recieve a message
    status, message = socket.recieve(len(b"Hello you. I'm your server!")/2)
    print("message from the server: {0}".format(message))    
    status, message = socket.recieve(len(b"Hello you. I'm your server!")/2)
    print("message from the server: {0}".format(message))
    
    socket.send(b"Bouhhhh")
    socket.disconnect()
    
if __name__ == "__main__":
    main()
