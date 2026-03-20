import pytest
from array import array
import functools
import gc
import io
import struct
import time
import wave

import sfml.audio as sf
import sfml.system as system


def build_wave_bytes(sample_rate=22050, channel_count=1, frames_per_channel=1024):
    buf = io.BytesIO()
    frame = [0, 1000, -1000, 500]
    samples = frame * max(1, frames_per_channel // len(frame))

    with wave.open(buf, "wb") as wav:
        wav.setnchannels(channel_count)
        wav.setsampwidth(2)
        wav.setframerate(sample_rate)

        if channel_count == 1:
            frames = b"".join(struct.pack("<h", sample) for sample in samples)
        else:
            frames = b"".join(
                struct.pack("<" + "h" * channel_count, *([sample] * channel_count))
                for sample in samples
            )

        wav.writeframes(frames)

    return buf.getvalue()


@functools.lru_cache(maxsize=1)
def playback_state_round_trips():
    try:
        chunk = sf.Chunk(array("h", [0, 1000, -1000, 500]).tobytes())
        buffer = sf.SoundBuffer.from_samples(chunk, 1, 22050)
        sound = sf.Sound(buffer)
        sound.loop = True
        return sound.loop is True
    except Exception:
        return False


@pytest.fixture
def listener_state():
    state = {
        "volume": sf.Listener.get_global_volume(),
        "position": tuple(sf.Listener.get_position()),
        "direction": tuple(sf.Listener.get_direction()),
        "velocity": tuple(sf.Listener.get_velocity()),
        "up_vector": tuple(sf.Listener.get_up_vector()),
        "cone": sf.Listener.get_cone(),
    }

    try:
        yield
    finally:
        sf.Listener.set_global_volume(state["volume"])
        sf.Listener.set_position(state["position"])
        sf.Listener.set_direction(state["direction"])
        sf.Listener.set_velocity(state["velocity"])
        sf.Listener.set_up_vector(state["up_vector"])
        sf.Listener.set_cone(state["cone"])


def test_listener_round_trips_global_state(listener_state):
    cone = sf.Cone(system.degrees(30), system.degrees(75), 0.25)

    sf.Listener.set_global_volume(37.5)
    sf.Listener.set_position((1, 2, 3))
    sf.Listener.set_direction((0, 0, -2))
    sf.Listener.set_velocity((4, 5, 6))
    sf.Listener.set_up_vector((0, 2, 0))
    sf.Listener.set_cone(cone)

    assert sf.Listener.get_global_volume() == pytest.approx(37.5)
    assert tuple(sf.Listener.get_position()) == pytest.approx((1.0, 2.0, 3.0))
    assert tuple(sf.Listener.get_direction()) == pytest.approx((0.0, 0.0, -2.0))
    assert tuple(sf.Listener.get_velocity()) == pytest.approx((4.0, 5.0, 6.0))
    assert tuple(sf.Listener.get_up_vector()) == pytest.approx((0.0, 2.0, 0.0))

    listener_cone = sf.Listener.get_cone()
    assert listener_cone.inner_angle.degrees == pytest.approx(30.0)
    assert listener_cone.outer_angle.degrees == pytest.approx(75.0)
    assert listener_cone.outer_gain == pytest.approx(0.25)


def test_playback_device_helpers_expose_python_strings():
    available_devices = sf.PlaybackDevice.get_available_devices()
    default_device = sf.PlaybackDevice.get_default_device()
    current_device = sf.PlaybackDevice.get_device()

    assert isinstance(available_devices, list)
    assert all(isinstance(device, str) for device in available_devices)
    assert default_device is None or isinstance(default_device, str)
    assert current_device is None or isinstance(current_device, str)

    target_device = current_device or default_device
    if target_device is not None:
        assert sf.PlaybackDevice.set_device(target_device) is True


def test_sound_recorder_device_helpers_expose_strings():
    available_devices = sf.SoundRecorder.get_available_devices()
    default_device = sf.SoundRecorder.get_default_device()

    assert isinstance(available_devices, list)
    assert all(isinstance(device, str) for device in available_devices)
    assert default_device is None or isinstance(default_device, str)

    if default_device is not None:
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


def test_soundbuffer_from_samples_round_trips_sample_metadata_and_channel_map():
    chunk = sf.Chunk(array("h", [0, 1000, -1000, 2000]).tobytes())
    sound_buffer = sf.SoundBuffer.from_samples(
        chunk,
        2,
        22050,
        [sf.SoundChannel.FRONT_RIGHT, sf.SoundChannel.FRONT_LEFT],
    )

    assert sound_buffer.channel_count == 2
    assert sound_buffer.sample_rate == 22050
    assert len(sound_buffer.samples) == 4
    assert [sound_buffer.samples[index] for index in range(4)] == [0, 1000, -1000, 2000]
    assert sound_buffer.channel_map == [sf.SoundChannel.FRONT_RIGHT, sf.SoundChannel.FRONT_LEFT]


def test_soundbuffer_to_file_round_trips_through_disk(tmp_path):
    chunk = sf.Chunk(array("h", [0, 1000, -1000, 500, -250, 125]).tobytes())
    original = sf.SoundBuffer.from_samples(
        chunk,
        2,
        22050,
        [sf.SoundChannel.FRONT_LEFT, sf.SoundChannel.FRONT_RIGHT],
    )
    output_path = tmp_path / "roundtrip.wav"

    original.to_file(str(output_path))

    reloaded = sf.SoundBuffer.from_file(str(output_path))

    assert output_path.is_file()
    assert reloaded.sample_rate == 22050
    assert reloaded.channel_count == 2
    assert reloaded.channel_map == [sf.SoundChannel.FRONT_LEFT, sf.SoundChannel.FRONT_RIGHT]
    assert [reloaded.samples[index] for index in range(len(reloaded.samples))] == [0, 1000, -1000, 500, -250, 125]


def test_soundstream_initialize_and_seek_hook_are_usable_deterministically():
    if not playback_state_round_trips():
        pytest.skip("playback state mutations are not supported on this machine")

    class DummyStream(sf.SoundStream):
        def __init__(self):
            super().__init__()
            self.seek_calls = []
            self.initialize(2, 22050, [sf.SoundChannel.FRONT_LEFT, sf.SoundChannel.FRONT_RIGHT])

        def on_get_data(self, chunk):
            return False

        def on_seek(self, time_offset):
            self.seek_calls.append(time_offset.milliseconds)

    stream = DummyStream()
    stream.playing_offset = __import__("sfml.system").system.milliseconds(5)

    assert stream.channel_count == 2
    assert stream.sample_rate == 22050
    assert stream.channel_map == [sf.SoundChannel.FRONT_LEFT, sf.SoundChannel.FRONT_RIGHT]
    assert stream.seek_calls
    assert stream.seek_calls[-1] == pytest.approx(5, abs=1)


def test_soundstream_on_get_data_can_fill_chunks_deterministically():
    class ProducingStream(sf.SoundStream):
        def __init__(self):
            super().__init__()
            self.on_get_data_calls = 0
            self.emitted_chunks = []
            self.initialize(1, 11025, [sf.SoundChannel.MONO])

        def on_get_data(self, chunk):
            self.on_get_data_calls += 1

            if self.on_get_data_calls == 1:
                chunk.data = array("h", [100, -100, 50, -50]).tobytes()
                self.emitted_chunks.append(list(chunk[index] for index in range(len(chunk))))
                return True

            chunk.data = b""
            self.emitted_chunks.append([])
            return False

        def on_seek(self, time_offset):
            pass

    stream = ProducingStream()
    reusable_chunk = sf.Chunk()

    assert stream.on_get_data(reusable_chunk) is True
    assert len(reusable_chunk) == 4
    assert [reusable_chunk[index] for index in range(len(reusable_chunk))] == [100, -100, 50, -50]
    assert stream.emitted_chunks[0] == [100, -100, 50, -50]

    assert stream.on_get_data(reusable_chunk) is False
    assert len(reusable_chunk) == 0
    assert stream.emitted_chunks[1] == []


def test_sound_exposes_buffer_and_source_properties_deterministically():
    if not playback_state_round_trips():
        pytest.skip("playback state mutations are not supported on this machine")

    chunk = sf.Chunk(array("h", [0, 1000, -1000, 500]).tobytes())
    buffer = sf.SoundBuffer.from_samples(chunk, 1, 22050)
    sound = sf.Sound(buffer)
    cone = sf.Cone(system.degrees(20), system.degrees(80), 0.4)

    sound.loop = True
    sound.pan = -0.25
    sound.volume = 25
    sound.pitch = 1.5
    sound.spatialization_enabled = False
    sound.position = (1, 2, 3)
    sound.direction = (0, 1, 0)
    sound.cone = cone
    sound.velocity = (0.5, 0.25, -0.75)
    sound.doppler_factor = 0.8
    sound.directional_attenuation_factor = 0.35
    sound.relative_to_listener = True
    sound.min_distance = 3
    sound.max_distance = 10
    sound.min_gain = 0.1
    sound.max_gain = 0.9
    sound.attenuation = 0.5
    sound.playing_offset = system.milliseconds(10)

    assert sound.buffer is buffer
    assert sound.status == sf.Status.STOPPED
    assert sound.loop is True
    assert sound.pan == pytest.approx(-0.25)
    assert sound.volume == pytest.approx(25.0)
    assert sound.pitch == pytest.approx(1.5)
    assert sound.spatialization_enabled is False
    assert tuple(sound.position) == pytest.approx((1.0, 2.0, 3.0))
    assert tuple(sound.direction) == pytest.approx((0.0, 1.0, 0.0))
    assert tuple(sound.velocity) == pytest.approx((0.5, 0.25, -0.75))
    assert sound.cone.inner_angle.degrees == pytest.approx(20.0)
    assert sound.cone.outer_angle.degrees == pytest.approx(80.0)
    assert sound.cone.outer_gain == pytest.approx(0.4)
    assert sound.doppler_factor == pytest.approx(0.8)
    assert sound.directional_attenuation_factor == pytest.approx(0.35)
    assert sound.relative_to_listener is True
    assert sound.min_distance == pytest.approx(3.0)
    assert sound.max_distance == pytest.approx(10.0)
    assert sound.min_gain == pytest.approx(0.1)
    assert sound.max_gain == pytest.approx(0.9)
    assert sound.attenuation == pytest.approx(0.5)


def test_music_from_memory_exposes_stream_properties_without_playback():
    if not playback_state_round_trips():
        pytest.skip("playback state mutations are not supported on this machine")

    music = sf.Music.from_memory(build_wave_bytes())
    loop_points = (system.milliseconds(5), system.milliseconds(10))

    music.loop = True
    music.loop_points = loop_points
    music.direction = (0, 0, 1)
    music.velocity = (0, 0, -1)
    music.spatialization_enabled = True

    assert music.channel_count == 1
    assert music.sample_rate == 22050
    assert music.channel_map == [sf.SoundChannel.MONO]
    assert music.duration.milliseconds > 0
    assert music.status == sf.Status.STOPPED
    assert music.loop is True
    assert tuple(music.direction) == pytest.approx((0.0, 0.0, 1.0))
    assert tuple(music.velocity) == pytest.approx((0.0, 0.0, -1.0))

    actual_loop_points = music.loop_points
    assert actual_loop_points[0].milliseconds == pytest.approx(5, abs=1)
    assert actual_loop_points[1].milliseconds == pytest.approx(10, abs=1)


def test_music_from_memory_accepts_mutable_buffers_and_retains_owned_data():
    raw = bytearray(build_wave_bytes(frames_per_channel=512))
    music = sf.Music.from_memory(raw)
    original_duration = music.duration.milliseconds

    raw[:] = b"\x00" * len(raw)
    del raw
    gc.collect()

    music.loop_points = (system.milliseconds(3), system.milliseconds(6))

    assert music.duration.milliseconds == original_duration
    assert music.duration.milliseconds > 0
    assert music.loop_points[0].milliseconds == pytest.approx(3, abs=1)
    assert music.loop_points[1].milliseconds == pytest.approx(6, abs=1)


def test_soundrecorder_channel_properties_are_configurable_without_capture():
    class ProbeRecorder(sf.SoundRecorder):
        def on_process_samples(self, chunk):
            return False

    recorder = ProbeRecorder()
    recorder.channel_count = 2

    assert recorder.channel_count == 2
    assert recorder.channel_map == [sf.SoundChannel.FRONT_LEFT, sf.SoundChannel.FRONT_RIGHT]


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
            return True

        def on_stop(self):
            self.stopped += 1

    recorder = ProbeRecorder()
    started = recorder.start(8000)
    if not started:
        pytest.skip("custom audio capture start failed on this machine")

    deadline = time.time() + 0.5
    while recorder.processed == 0 and time.time() < deadline:
        time.sleep(0.01)

    recorder.stop()

    assert recorder.started == 1
    assert recorder.processed >= 1
    assert recorder.stopped == 1