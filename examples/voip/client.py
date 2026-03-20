from struct import pack

from sfml import audio as sf_audio
from sfml import network as sf_network


AUDIO_DATA = 1
END_OF_STREAM = 2


def send_all(socket, data):
    offset = 0

    while offset < len(data):
        sent = socket.send(data[offset:])
        if sent <= 0:
            raise sf_network.SocketError("socket.send() made no forward progress")
        offset += sent


class NetworkRecorder(sf_audio.SoundRecorder):
    def __init__(self, host, port):
        sf_audio.SoundRecorder.__init__(self)

        self.host = host
        self.port = port
        self.socket = sf_network.TcpSocket()

    def on_start(self):
        try:
            self.socket.connect(self.host, self.port)
        except sf_network.SocketException:
            return False

        return True

    def on_process_samples(self, chunk):
        payload = chunk.data
        data = pack("!BI", AUDIO_DATA, len(payload)) + payload

        try:
            send_all(self.socket, data)
        except sf_network.SocketException:
            return False

        return True

    def on_stop(self):
        try:
            send_all(self.socket, bytes([END_OF_STREAM]))
        finally:
            self.socket.disconnect()


def run_client(port):
    if not sf_audio.SoundRecorder.is_available():
        print("Sorry, audio capture is not supported by your system")
        return

    server = input("Type address or name of the server to connect to: ")
    server = sf_network.IpAddress.from_string(server)

    recorder = NetworkRecorder(server, port)

    input("Press enter to start recording audio")

    recorder.start(44100)
    input("Recording... press enter to stop")
    recorder.stop()
