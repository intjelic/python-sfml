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
        if event.type == window.EventType.CLOSED:
            render_window.close()

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
        if event.type == window.EventType.CLOSED:
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
        if event.type == window.EventType.CLOSED:
            render_window.close()
        elif event.type == window.EventType.KEY_PRESSED:
            print("Pressed:", event.get("code"))

    if window.Keyboard.is_key_pressed(window.Keyboard.LEFT):
        print("Left is currently held down")

    render_window.clear()
    render_window.display()
```

Event payloads are mapping-style at runtime. Use `event.get("code")` or `event["code"]`, not `event.code`.

## Audio Playback

Play a short buffered sound together with streamed music:

```python
from sfml import audio, system


click_buffer = audio.SoundBuffer.from_file("click.wav")
click = audio.Sound(click_buffer)
music = audio.Music.from_file("theme.ogg")

click.play()
music.play()

while music.status == audio.Status.PLAYING:
    system.sleep(system.milliseconds(100))
```

Use `Sound` for short effects kept in memory and `Music` for streamed background audio.

## TCP Client

Connect to a server, send bytes, and read a reply:

```python
from sfml import network


socket = network.TcpSocket()
server = network.IpAddress.from_string("127.0.0.1")

socket.connect(server, 5000)
socket.send(b"hello from PySFML")
reply = socket.receive(256)

print(reply.decode("utf-8", errors="replace"))
socket.disconnect()
```

## TCP Server

Listen on a port, accept one client, and answer a request:

```python
from sfml import network


listener = network.TcpListener()
listener.listen(5000)
client = listener.accept()

request = client.receive(256)
print(request.decode("utf-8", errors="replace"))

client.send(b"hello from server")
client.disconnect()
listener.close()
```

## Where To Go Next

- See `getting-started.md` for installation and initial setup
- See `modules.md` for module-level orientation
- See `../examples/README.md` for the maintained example programs