import threading
from struct import unpack

from sfml import audio as sf_audio
from sfml import network as sf_network
from sfml import system as sf_system


AUDIO_DATA = 1
END_OF_STREAM = 2
CHUNK_SAMPLE_COUNT = 4096


def receive_exact(socket, size):
    data = bytearray()

    while len(data) < size:
        chunk = socket.receive(size - len(data))
        if not chunk:
            raise sf_network.SocketDisconnected("Connection closed while receiving audio data")
        data.extend(chunk)

    return bytes(data)


class NetworkAudioStream(sf_audio.SoundStream):
    def __init__(self):
        sf_audio.SoundStream.__init__(self)

        self.offset = 0
        self.has_finished = False
        self.listener = sf_network.TcpListener()
        self.samples = bytearray()
        self.lock = threading.Lock()
        self.client = None

        self.initialize(1, 44100)

    def start_stream(self, port):
        if not self.has_finished:
            try:
                self.listener.listen(port, sf_network.IpAddress.ANY)
                print("Server is listening to port {0}, waiting for connections... ".format(port))

                self.client = self.listener.accept()
                print("Client connected: {0}".format(self.client.remote_address.string.decode("utf-8", errors="replace")))

            except sf_network.SocketException as error:
                print(error)
                return

            self.play()
            self.receive_loop()
        else:
            self.play()

    def on_get_data(self, chunk):
        while True:
            with self.lock:
                available_samples = len(self.samples) // 2 - self.offset
                if available_samples > 0:
                    sample_count = min(CHUNK_SAMPLE_COUNT, available_samples)
                    start = self.offset * 2
                    end = start + sample_count * 2
                    chunk.data = bytes(self.samples[start:end])
                    self.offset += len(chunk)
                    return True

                if self.has_finished:
                    return False

            sf_system.sleep(sf_system.milliseconds(10))

    def on_seek(self, time_offset):
        self.offset = time_offset.milliseconds * self.sample_rate * self.channel_count // 1000

    def receive_loop(self):
        while not self.has_finished:
            try:
                message_id = unpack("!B", receive_exact(self.client, 1))[0]

                if message_id == AUDIO_DATA:
                    payload_size = unpack("!I", receive_exact(self.client, 4))[0]
                    payload = receive_exact(self.client, payload_size)
                    with self.lock:
                        self.samples.extend(payload)
                elif message_id == END_OF_STREAM:
                    print("Audio data has been 100% received!")
                    self.has_finished = True
                else:
                    print("Invalid data received...")
                    self.has_finished = True
            except sf_network.SocketException as error:
                print(error)
                self.has_finished = True


def run_server(port):
    audio_stream = NetworkAudioStream()
    audio_stream.start_stream(port)

    while audio_stream.status != sf_audio.Status.STOPPED:
        sf_system.sleep(sf_system.milliseconds(100))

    input("Press enter to replay the sound...")

    audio_stream.playing_offset = sf_system.seconds(0)
    audio_stream.play()

    while audio_stream.status != sf_audio.Status.STOPPED:
        sf_system.sleep(sf_system.milliseconds(100))
