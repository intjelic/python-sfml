# Module Overview

PySFML exposes five primary modules that mirror the major SFML areas while keeping a Python-oriented API surface.

## `sfml.system`

Core utility types such as time values, clocks, vectors, and rectangles live here.

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
- vector and rectangle data structures shared by other modules

Python-specific note:

- the preferred clock interface uses `elapsed_time` rather than a C++-style getter name

## `sfml.window`

This module covers windows, events, OpenGL context settings, and input devices.

Example:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "Window example")

for event in render_window.events:
	if event.type == window.EventType.KEY_PRESSED:
		print("Key pressed:", event.get("code"))
```

Use this module for:

- opening native windows
- polling and waiting for events
- keyboard, mouse, joystick, touch, and sensor input facades
- context and video-mode configuration

Python-specific note:

- event payload data is accessed as mapping data at runtime rather than attribute fields

## `sfml.graphics`

This module provides images, textures, fonts, shapes, sprites, text, transforms, views, and render targets.

Example:

```python
from sfml import graphics


texture = graphics.Texture.from_file("player.png")
sprite = graphics.Sprite(texture)
label = graphics.Text("Hello", graphics.Font.from_file("arial.ttf"), 24)
label.position = (20, 20)
```

Use this module for:

- 2D drawing and scene composition
- loading and manipulating graphics resources
- rendering to windows and off-screen textures
- transforms, views, and drawable abstractions

Python-specific note:

- some naming differs from SFML where the binding has historically adopted a more Python-friendly surface

## `sfml.audio`

This module provides listener state, sound buffers, sound sources, music streaming, recording, and low-level audio callback integration.

Example:

```python
from sfml import audio


click_buffer = audio.SoundBuffer.from_file("click.wav")
click = audio.Sound(click_buffer)
music = audio.Music.from_file("theme.ogg")

click.play()
music.play()
```

Use this module for:

- short buffered sounds
- streamed music playback
- custom audio streams and recorders
- listener and sound-source configuration

Python-specific note:

- callback-oriented audio classes expose a Python surface intended for subclassing and deterministic tests where practical

## `sfml.network`

This module covers IPv4 addresses, TCP/UDP networking, socket readiness selection, and the FTP and HTTP client wrappers.

Example:

```python
from sfml import network


socket = network.TcpSocket()
server = network.IpAddress.from_string("127.0.0.1")
socket.connect(server, 5000)
socket.send(b"hello")
reply = socket.receive(64)
```

Use this module for:

- TCP and UDP sockets
- multiplexing sockets with selectors
- simple FTP operations
- HTTP request and response handling

Python-specific note:

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
sound = audio.Sound()

print(clock.elapsed_time)
print(render_window.is_open)
print(sound.status)
```

## Scope Of This Guide

This page is an orientation guide. It does not replace examples or provide a complete API reference.

- See `recipes.md` for small task-oriented code snippets.
- See `getting-started.md` for installation and source builds.
- See `compatibility.md` for known differences and unsupported features.
- See `../examples/README.md` for maintained examples.