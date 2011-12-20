from time import sleep
import sfml.network as sf

def main():
    listener = sf.TcpListener()
    listener.blocking = True

    clients = []
    if listener.listen(5004) == sf.Socket.DONE:
        status, client = listener.accept()
        if status == sf.Socket.DONE:
            print("Client connected!")
            client.send(b"Hello you. I'm your server!")
            sleep(2)
            s, mess = client.recieve(10)
            print(mess)
    listener.close()
    
if __name__ == "__main__":
    main()
