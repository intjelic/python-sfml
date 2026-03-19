import pytest
from array import array
import io
import struct
import time
import wave

import sfml.audio as sf
import sfml.system as system


@pytest.fixture
def listener_state():
    state = {
        "volume": sf.Listener.get_global_volume(),
        "position": tuple(sf.Listener.get_position()),
        "direction": tuple(sf.Listener.get_direction()),
        "up_vector": tuple(sf.Listener.get_up_vector()),
    }

    try:
        yield
    finally:
        sf.Listener.set_global_volume(state["volume"])
        sf.Listener.set_position(state["position"])
        sf.Listener.set_direction(state["direction"])
        sf.Listener.set_up_vector(state["up_vector"])


def test_listener_round_trips_global_state(listener_state):
    sf.Listener.set_global_volume(37.5)
    sf.Listener.set_position((1, 2, 3))
    sf.Listener.set_direction((0, 0, -2))
    sf.Listener.set_up_vector((0, 2, 0))

    assert sf.Listener.get_global_volume() == pytest.approx(37.5)
    assert tuple(sf.Listener.get_position()) == pytest.approx((1.0, 2.0, 3.0))
    assert tuple(sf.Listener.get_direction()) == pytest.approx((0.0, 0.0, -2.0))
    assert tuple(sf.Listener.get_up_vector()) == pytest.approx((0.0, 2.0, 0.0))


def test_sound_recorder_device_helpers_expose_bytes():
    available_devices = sf.SoundRecorder.get_available_devices()
    default_device = sf.SoundRecorder.get_default_device()

    assert isinstance(available_devices, list)
    assert all(isinstance(device, bytes) for device in available_devices)
    assert isinstance(default_device, bytes)

    if available_devices:
        assert default_device in available_devices


def test_chunk_initializes_from_bytes_and_supports_indexing():
    samples = array("h", [100, -200, 300, -400])
    chunk = sf.Chunk(samples.tobytes())

    assert len(chunk) == 4
    assert [chunk[index] for index in range(len(chunk))] == [100, -200, 300, -400]

    chunk[1] = 250

    assert chunk[1] == 250
    assert chunk.data == array("h", [100, 250, 300, -400]).tobytes()


def test_chunk_rejects_out_of_range_access():
    chunk = sf.Chunk(array("h", [1, 2]).tobytes())

    with pytest.raises(IndexError):
        _ = chunk[2]

    with pytest.raises(IndexError):
        chunk[2] = 3


def test_chunk_rejects_odd_byte_lengths():
    with pytest.raises(ValueError, match="must be even"):
        sf.Chunk(b"\x01")


def test_soundbuffer_from_samples_round_trips_sample_metadata():
    chunk = sf.Chunk(array("h", [0, 1000, -1000, 2000]).tobytes())
    sound_buffer = sf.SoundBuffer.from_samples(chunk, 1, 22050)

    assert sound_buffer.channel_count == 1
    assert sound_buffer.sample_rate == 22050
    assert len(sound_buffer.samples) == 4
    assert [sound_buffer.samples[index] for index in range(4)] == [0, 1000, -1000, 2000]


def test_soundstream_initialize_and_seek_hook_are_usable_deterministically():
    class DummyStream(sf.SoundStream):
        def __init__(self):
            super().__init__()
            self.seek_calls = []
            self.initialize(1, 22050)

        def on_get_data(self, chunk):
            return False

        def on_seek(self, time_offset):
            self.seek_calls.append(time_offset.milliseconds)

    stream = DummyStream()
    stream.playing_offset = __import__("sfml.system").system.milliseconds(5)

    assert stream.channel_count == 1
    assert stream.sample_rate == 22050
    assert stream.seek_calls
    assert stream.seek_calls[-1] == 5


def test_sound_exposes_buffer_and_source_properties_deterministically():
    chunk = sf.Chunk(array("h", [0, 1000, -1000, 500]).tobytes())
    buffer = sf.SoundBuffer.from_samples(chunk, 1, 22050)
    sound = sf.Sound(buffer)

    sound.loop = True
    sound.volume = 25
    sound.pitch = 1.5
    sound.position = (1, 2, 3)
    sound.relative_to_listener = True
    sound.min_distance = 3
    sound.attenuation = 0.5
    sound.playing_offset = system.milliseconds(10)

    assert sound.buffer is buffer
    assert sound.status == sf.Status.STOPPED
    assert sound.loop is True
    assert sound.volume == pytest.approx(25.0)
    assert sound.pitch == pytest.approx(1.5)
    assert tuple(sound.position) == pytest.approx((1.0, 2.0, 3.0))
    assert sound.relative_to_listener is True
    assert sound.min_distance == pytest.approx(3.0)
    assert sound.attenuation == pytest.approx(0.5)


def test_music_from_memory_exposes_stream_properties_without_playback():
    buf = io.BytesIO()
    with wave.open(buf, "wb") as wav:
        wav.setnchannels(1)
        wav.setsampwidth(2)
        wav.setframerate(22050)
        frames = b"".join(struct.pack("<h", sample) for sample in ([0, 1000, -1000, 500] * 64))
        wav.writeframes(frames)

    music = sf.Music.from_memory(buf.getvalue())
    music.loop = True

    assert music.channel_count == 1
    assert music.sample_rate == 22050
    assert music.duration.milliseconds > 0
    assert music.status == sf.Status.STOPPED
    assert music.loop is True


def test_soundbufferrecorder_capture_smoke_when_available():
    if not sf.SoundRecorder.is_available():
        pytest.skip("audio capture is not available")

    recorder = sf.SoundBufferRecorder()
    default_device = sf.SoundRecorder.get_default_device()

    if default_device:
        assert recorder.set_device(default_device) is True
        assert recorder.get_device() == default_device

    started = recorder.start(8000)
    if not started:
        pytest.skip("audio capture start failed on this machine")

    time.sleep(0.05)
    recorder.stop()

    assert recorder.sample_rate == 8000
    assert recorder.buffer.channel_count >= 1
    assert recorder.buffer.sample_rate == 8000


def test_custom_soundrecorder_callbacks_run_when_capture_available():
    if not sf.SoundRecorder.is_available():
        pytest.skip("audio capture is not available")

    class ProbeRecorder(sf.SoundRecorder):
        def __init__(self):
            super().__init__()
            self.started = 0
            self.processed = 0
            self.stopped = 0

        def on_start(self):
            self.started += 1
            return True

        def on_process_samples(self, chunk):
            self.processed += 1
            return self.processed < 2

        def on_stop(self):
            self.stopped += 1

    recorder = ProbeRecorder()
    started = recorder.start(8000)
    if not started:
        pytest.skip("custom audio capture start failed on this machine")

    time.sleep(0.05)
    recorder.stop()

    assert recorder.started == 1
    assert recorder.processed >= 1
    assert recorder.stopped == 1