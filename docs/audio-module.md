# Audio Module

This guide shows the Python surface available in the SFML 3 release line and calls out the current support boundaries.

> The SFML audio module covers playback devices, listener state, buffered sounds, streamed music, recording, and low-level callback-based audio hooks.

## Quick Feel

```python
from sfml import audio

buffer = audio.SoundBuffer.from_file("click.wav")
sound = audio.Sound(buffer)

sound.play()
```

For longer files, use `Music` instead of `SoundBuffer` + `Sound`.

## Buffered Sounds And Streamed Music

Use `SoundBuffer` when you want the whole sample set loaded in memory. Use `Music` when you want streamed playback.

```python
from sfml import audio, system

effect_buffer = audio.SoundBuffer.from_file("click.wav")
effect = audio.Sound(effect_buffer)

music = audio.Music.from_file("theme.ogg")
music.loop_points = (system.seconds(1), system.seconds(8))

effect.play()
music.play()
```

This is the main mental split to remember:

- `SoundBuffer` is for short, reusable sound data
- `Music` is for streamed audio files

## Devices And Listener State

PySFML exposes the SFML 3 device and listener surface.

```python
from sfml import audio, system

print(audio.PlaybackDevice.get_available_devices())
print(audio.PlaybackDevice.get_default_device())

audio.Listener.set_position((0, 0, 0))
audio.Listener.set_direction((0, 0, -1))
audio.Listener.set_up_vector((0, 1, 0))
audio.Listener.set_cone(audio.Cone(system.degrees(30), system.degrees(90), 0.25))
```

Useful additions compared with older PySFML releases include:

- playback-device enumeration and selection
- velocity and up-vector support on the listener
- shared `Cone` values for directional audio
- explicit channel maps through `SoundChannel`

## Source Properties

All audio sources share a common state model through `SoundSource`.

```python
sound.position = (2, 0, -4)
sound.direction = (0, 0, 1)
sound.spatialization_enabled = True
sound.min_distance = 1.0
sound.attenuation = 0.4
```

That makes ordinary sounds, custom streams, and music feel consistent in Python.

## Working With Raw Samples

`Chunk` is the Python-owned sample container. You will see it when:

- building a `SoundBuffer` from samples
- implementing a custom `SoundStream`
- implementing a custom `SoundRecorder`

```python
from sfml import audio


samples = audio.Chunk(b"\x00\x00\x10\x00\x20\x00\x10\x00")
buffer = audio.SoundBuffer.from_samples(samples, channel_count=1, sample_rate=44100)
```

`Chunk` is binding-specific. It is not a direct one-to-one C++ type.

## Callback-Based Streams And Recording

The low-level extension points are subclass-based:

- `SoundStream.on_get_data(chunk)` fills or rewrites the provided `Chunk`
- `SoundStream.on_seek(time_offset)` handles repositioning
- `SoundRecorder.on_process_samples(chunk)` receives captured samples

The important Python-specific point is that the callback contract is mutation-based. You work with the provided `Chunk` instead of returning a new sample block each time.

## Differences From C++ Worth Knowing

- `Chunk` is a Python binding type used to hold 16-bit PCM sample data.
- The listener is a static facade, so you do not instantiate `Listener`.
- `Music.loop_points` is a Python property that uses a `(Time, Time)` tuple.
- Channel layout is exposed explicitly through `SoundChannel` and `channel_map`.
- The callback surface for custom streams and recorders is shaped around Python subclass methods.

## Missing Or Deferred Pieces

The main unfinished pieces are deliberate:

- audio effect-processor APIs are deferred until there is a solid Python threading and callback story
- broader documentation and tests for custom stream generation still need expansion
- `Music.from_memory(...)` has a real lifetime constraint: the backing bytes must stay alive for as long as the stream uses them

That last point matters in Python because streamed audio may outlive the local variable that originally held the bytes.

## Related Guides

- See `system-module.md` for `Time`, `Angle`, and `Vector3`.
- See `modules.md` for the top-level module map.