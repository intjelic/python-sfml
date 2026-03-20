# Minimal Recipes

This page collects small, copyable PySFML snippets for common tasks.

They are intentionally short and focused. Use them as starting points, then move to the maintained examples tree when you need a fuller program structure.

## Window Loop

Open a window, process close events, and present frames:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "PySFML")

while render_window.is_open:
    for event in render_window.events:
        if isinstance(event, window.ClosedEvent):
            render_window.close()

    render_window.clear()
    render_window.display()
```

## Window Features

Open a window with explicit state, react to scancode-based input, copy to the clipboard, and swap cursors:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(
    window.VideoMode(960, 540),
    "Window features",
    window.Style.DEFAULT,
    window.State.WINDOWED,
)

arrow_cursor = window.Cursor.from_system(window.CursorType.ARROW)
hand_cursor = window.Cursor.from_system(window.CursorType.HAND)
render_window.set_mouse_cursor(hand_cursor)

while render_window.is_open:
    for event in render_window.events:
        if isinstance(event, window.ClosedEvent):
            render_window.close()
        elif isinstance(event, window.KeyPressedEvent):
            if event.scancode == window.Scancode.ESCAPE:
                render_window.close()
            elif event.scancode == window.Scancode.C:
                window.Clipboard.set_string("Copied from PySFML")
            elif event.scancode == window.Scancode.H:
                render_window.set_mouse_cursor(hand_cursor)
            elif event.scancode == window.Scancode.A:
                render_window.set_mouse_cursor(arrow_cursor)

    render_window.clear()
    render_window.display()
```

## Sprite Drawing

Load a texture and draw a sprite every frame:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "Sprite")
texture = graphics.Texture.from_file("player.png")
sprite = graphics.Sprite(texture)
sprite.position = (120, 90)

while render_window.is_open:
    for event in render_window.events:
        if isinstance(event, window.ClosedEvent):
            render_window.close()

    render_window.clear()
    render_window.draw(sprite)
    render_window.display()
```

## Keyboard Input

React to both real-time key state and discrete key press events:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "Keyboard")

while render_window.is_open:
    for event in render_window.events:
        if isinstance(event, window.ClosedEvent):
            render_window.close()
        elif isinstance(event, window.KeyPressedEvent):
            print("Pressed:", window.Keyboard.get_description(event.scancode))

    if window.Keyboard.is_scancode_pressed(window.Scancode.LEFT):
        print("Left is currently held down")

    render_window.clear()
    render_window.display()
```

Event polling returns concrete typed event objects. Prefer `isinstance(event, window.KeyPressedEvent)` and access payloads directly, such as `event.code` or `event.position`.

## Audio Playback

Play a short buffered sound together with streamed music while using the SFML 3 listener and loop-point surface:

```python
from sfml import audio, system


click_buffer = audio.SoundBuffer.from_file("click.wav")
click = audio.Sound(click_buffer)
music = audio.Music.from_file("theme.ogg")

audio.Listener.set_position((0, 0, 0))
audio.Listener.set_direction((0, 0, -1))
click.position = (2, 0, 0)
click.cone = audio.Cone(system.degrees(30), system.degrees(90), 0.35)
music.loop_points = (system.seconds(1), system.seconds(8))

click.play()
music.play()

while music.status == audio.Status.PLAYING:
    system.sleep(system.milliseconds(100))
```

Use `Sound` for short effects kept in memory and `Music` for streamed background audio.

`SoundBuffer.from_samples(...)`, `SoundStream.initialize(...)`, and recorder configuration also accept explicit `channel_map` values built from `audio.SoundChannel` when mono or stereo defaults are not enough.

## TCP Client

Connect to a server, send bytes, and read a reply:

```python
from sfml import network


socket = network.TcpSocket()
server = network.IpAddress.from_string("127.0.0.1")

socket.connect(server, 5000)
sent = socket.send(b"hello from PySFML")
reply = socket.receive(256)

print(f"sent {sent} bytes")
print(reply.decode("utf-8", errors="replace"))
socket.disconnect()
```

## TCP Server

Listen on a port, accept one client, and answer a request:

```python
from sfml import network


listener = network.TcpListener()
listener.listen(5000, network.IpAddress.ANY)
client = listener.accept()

request = client.receive(256)
print(request.decode("utf-8", errors="replace"))

sent = client.send(b"hello from server")
print(f"sent {sent} bytes")
client.disconnect()
listener.close()
```

## HTTP Request Builder

Build an HTTP request with the current PySFML method-based HTTP API:

```python
from sfml import network, system


http = network.Http()
http.set_host(b"127.0.0.1", 8080)

request = network.HttpRequest(b"/status", network.HttpRequest.PUT, b"payload")
request.set_field(b"Content-Type", b"text/plain")
request.set_http_version(1, 1)

response = http.send_request(request, system.seconds(1))

print(response.status)
print(response.body)
```

## Where To Go Next

- See `getting-started.md` for installation and initial setup
- See `modules.md` for module-level orientation
- See `../examples/README.md` for the maintained example programs