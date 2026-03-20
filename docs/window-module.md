# Window Module

This page focuses on the current Python binding surface. It is meant to help you get oriented quickly, not to replace the API reference.

> The SFML window module is the low-level windowing and input layer. It covers native windows, events, video modes, OpenGL context settings, and device polling.

## Quick Feel

```python
from sfml import window

app = window.Window(
    window.VideoMode(800, 600),
    "Window only",
    window.Style.DEFAULT,
    window.State.WINDOWED,
)

while app.is_open:
    for event in app.events:
        if isinstance(event, window.ClosedEvent):
            app.close()
```

If you want drawing as well as window management, use `graphics.RenderWindow` from `sfml.graphics`. The event and input model comes from this module either way.

## Window Creation

The main pieces are:

- `VideoMode` for width, height, and color depth
- `Style` for decorations such as titlebar, resize, and close controls
- `State` for whether the window is `WINDOWED` or `FULLSCREEN`
- `ContextSettings` for depth, stencil, antialiasing, version, and sRGB flags

```python
from sfml import system, window

settings = window.ContextSettings(depth=24, stencil=8, antialiasing=4)

app = window.Window(
    window.VideoMode(1280, 720),
    "Configured window",
    window.Style.DEFAULT,
    window.State.WINDOWED,
    settings,
)

event = app.wait_event(system.seconds(0.25))
```

One important SFML 3 change is visible here: fullscreen is a window `State`, not a `Style` flag.

## Events

Event handling is based on concrete Python classes.

```python
from sfml import window

for event in app.events:
    if isinstance(event, window.ResizedEvent):
        print("new size:", tuple(event.size))
    elif isinstance(event, window.KeyPressedEvent):
        print(window.Keyboard.get_description(event.scancode))
    elif isinstance(event, window.MouseMovedEvent):
        print(tuple(event.position))
```

Common event classes include:

- `ClosedEvent`
- `ResizedEvent`
- `TextEnteredEvent`
- `KeyPressedEvent` and `KeyReleasedEvent`
- `MouseMovedEvent`, `MouseButtonPressedEvent`, `MouseWheelScrolledEvent`
- joystick, touch, and sensor event classes

## Input Facades

You can poll state without waiting for events.

```python
from sfml import window

if window.Keyboard.is_scancode_pressed(window.Scancode.SPACE):
    print("space is down")

mouse_position = window.Mouse.get_position(app)
print(tuple(mouse_position))
```

The module also exposes:

- `Mouse`
- `Joystick`
- `Touch`
- `Sensor`
- `Clipboard`
- `Cursor`

Example clipboard and cursor usage:

```python
from sfml import window

window.Clipboard.set_string("PySFML")
cursor = window.Cursor.from_system(window.CursorType.HAND)
app.set_mouse_cursor(cursor)
```

## Window Configuration

This module prefers explicit methods for side effects.

```python
app.set_title("New title")
app.set_visible(True)
app.set_mouse_cursor_visible(False)
app.set_vertical_synchronization_enabled(True)
app.set_framerate_limit(60)
```

Window size constraints are properties:

```python
app.minimum_size = (320, 240)
app.maximum_size = (1920, 1080)
```

## Differences From C++ Worth Knowing

- Window state uses `State.WINDOWED` and `State.FULLSCREEN` instead of folding fullscreen into style bits.
- Events arrive as concrete typed objects, so `isinstance(...)` checks are the normal pattern.
- Positions and sizes use shared `Vector2` values and tuple-friendly setters.
- Configuration changes use explicit methods such as `set_title()` and `set_mouse_cursor()` rather than property-style wrappers everywhere.
- `wait_event()` accepts a `system.Time` timeout or `None`.

## Missing Or Deferred Pieces

Some areas are intentionally not documented as stable parts of the current public API:

- Vulkan helpers
- native-handle embedding stories beyond the raw `system_handle`
- broad cross-platform guarantees for joystick, touch, sensor, clipboard, and cursor behavior

Those APIs may exist, but platform coverage and tests are still catching up.

## Related Guides

- See `graphics-module.md` for `RenderWindow` and drawing.
- See `system-module.md` for `Time`, `Vector2`, and `Vector3`.
- See `modules.md` for the high-level module map.