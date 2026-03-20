# Module Overview

PySFML exposes five primary modules that mirror the major SFML areas while keeping a Python-oriented API surface.

This page is the top-level map. Each module also has its own quick usage guide:

- `sfml.system`: see `system-module.md`
- `sfml.window`: see `window-module.md`
- `sfml.graphics`: see `graphics-module.md`
- `sfml.audio`: see `audio-module.md`
- `sfml.network`: see `network-module.md`

## `sfml.system`

Core utility types such as time values, clocks, angles, and vectors live here.

Example:

```python
from sfml import system


clock = system.Clock()
timeout = system.seconds(0.5)

if clock.elapsed_time > timeout:
    print("Half a second elapsed")
```

Use this module for:

- clocks and elapsed time measurement
- time values and conversions
- angle values and normalization
- vector data structures shared by other modules

Python-specific note:

- the preferred clock interface uses `elapsed_time` rather than a C++-style getter name
- angle handling is exposed directly through `system.Angle`, `system.degrees(...)`, and `system.radians(...)`

## `sfml.window`

This module covers windows, events, OpenGL context settings, and input devices.

Example:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "Window example")

for event in render_window.events:
    if isinstance(event, window.KeyPressedEvent):
        print("Key pressed:", window.Keyboard.get_description(event.scancode))
```

Use this module for:

- opening native windows
- polling and waiting for events
- explicit window state and method-based window configuration
- clipboard and cursor integration
- keyboard, mouse, joystick, touch, and sensor input facades
- context and video-mode configuration

Python-specific note:

- event polling returns concrete event objects with typed payload attributes
- the window surface separates `State.WINDOWED` and `State.FULLSCREEN` from the `Style` flags
- the runtime prefers explicit setter methods such as `set_title()`, `set_visible()`, and `set_mouse_cursor()`

## `sfml.graphics`

This module provides images, textures, fonts, shapes, sprites, text, transforms, views, and render targets.

Example:

```python
from sfml import graphics


texture = graphics.Texture.from_file("player.png")
sprite = graphics.Sprite(texture)
font = graphics.Font.from_file("arial.ttf")
label = graphics.Text(font, "Hello", 24)
label.position = (20, 20)
```

Use this module for:

- 2D drawing and scene composition
- loading and manipulating graphics resources
- rendering to windows and off-screen textures
- transforms, views, and drawable abstractions

Python-specific note:

- the graphics surface uses names such as `scale`, `scale_by()`, `set_uniform()`, `TextStyle`, and `VertexBuffer`
- angles come from `sfml.system`, not from a graphics-local type
- `PrimitiveType` does not include `QUADS`

## `sfml.audio`

This module provides playback-device management, listener state, sound buffers, sound sources, music streaming, recording, and low-level audio callback integration.

Example:

```python
from sfml import audio, system


click_buffer = audio.SoundBuffer.from_file("click.wav")
click = audio.Sound(click_buffer)
music = audio.Music.from_file("theme.ogg")

audio.Listener.set_position((0, 0, 0))
audio.Listener.set_direction((0, 0, -1))
music.loop_points = (system.seconds(1), system.seconds(4))

click.play()
music.play()
```

Use this module for:

- playback-device discovery and selection
- short buffered sounds
- streamed music playback
- custom audio streams and recorders
- listener and sound-source configuration, including channel maps and directional audio state

Python-specific note:

- the audio surface includes `PlaybackDevice`, `SoundChannel`, `Cone`, richer `Listener` state, recorder channel configuration, and `Music.loop_points`
- callback-oriented audio classes expose a Python surface intended for subclassing

## `sfml.network`

This module covers IPv4 addresses, TCP and UDP networking, socket readiness selection, and the FTP and HTTP client wrappers.

Example:

```python
from sfml import network


socket = network.TcpSocket()
server = network.IpAddress.from_string("127.0.0.1")
socket.connect(server, 5000)
sent = socket.send(b"hello")
reply = socket.receive(64)

print(sent, reply)
```

Use this module for:

- TCP and UDP sockets
- multiplexing sockets with selectors
- simple FTP operations
- HTTP request and response handling

Python-specific note:

- `TcpSocket.send(...)` returns the number of bytes written so nonblocking callers can observe partial progress explicitly
- HTTP requests use explicit builder methods such as `set_uri()`, `set_field()`, and `set_body()`
- `Http()` can be created without a host and configured later with `set_host(...)`
- the documented public network surface does not currently include `Packet`

## Import Strategy

Prefer importing the modules you use directly:

```python
from sfml import audio, graphics, system, window
```

The `sfml.sf` convenience module remains available for broad imports, but module-specific imports make it clearer which SFML area a piece of code depends on.

For example, a small app that mixes several modules is still explicit about where each API comes from:

```python
from sfml import audio, graphics, system, window


clock = system.Clock()
render_window = graphics.RenderWindow(window.VideoMode(640, 480), "Mixed modules")
sound_buffer = audio.SoundBuffer.from_file("click.wav")
sound = audio.Sound(sound_buffer)

print(clock.elapsed_time)
print(render_window.is_open)
print(sound.status)
```

## Scope Of This Guide

This page is an orientation guide. It does not replace examples or provide a complete API reference.

- See `system-module.md`, `window-module.md`, `graphics-module.md`, `audio-module.md`, and `network-module.md` for module-specific quick usage guides.
- See `recipes.md` for small task-oriented code snippets.
- See `getting-started.md` for installation and source builds.
- See `compatibility.md` for known differences and unsupported features.
- See `../examples/README.md` for maintained examples.