# System Module

This page is a quick usage guide for the Python binding surface in the SFML 3 release line. It is not a full reference.

> The SFML system module holds the small building blocks that the other modules lean on: time values, clocks, angles, and vectors.

## Quick Feel

```python
from sfml import system

clock = system.Clock()
frame_budget = system.milliseconds(16)

if clock.elapsed_time >= frame_budget:
    print("update")
    clock.restart()
```

## Time And Clocks

`Time` is a value object. You usually create it with the helper functions:

- `system.seconds(...)`
- `system.milliseconds(...)`
- `system.microseconds(...)`

`Clock` gives you elapsed time and a small lifecycle API:

```python
from sfml import system

clock = system.Clock()

clock.stop()
paused_at = clock.elapsed_time

clock.start()
dt = clock.restart()
print(dt.seconds)
```

Useful details:

- `elapsed_time` is a property, not a `get_elapsed_time()` method.
- `restart()` returns the elapsed time and keeps the clock running.
- `reset()` returns the elapsed time and leaves the clock stopped.
- `Time.ZERO` is available when you need an explicit zero duration.

## Angles

SFML 3 promotes angles to a first-class type, and the Python bindings expose that in `sfml.system`.

```python
from sfml import system

rotation = system.degrees(450)
wrapped = rotation.wrap_signed()

print(rotation.degrees)
print(wrapped.degrees)
```

Use `system.degrees(...)` or `system.radians(...)` to construct them.

This matters outside `sfml.system` too: graphics rotation APIs accept either an `Angle` or a degree scalar, and return `Angle` values.

## Vectors

`Vector2` and `Vector3` are the shared coordinate types across the bindings.

```python
from sfml import system

position = system.Vector2(20, 40)
velocity = system.Vector2(2.5, -1)

position += velocity
print(tuple(position))
```

Python-specific notes:

- there is one dynamic `Vector2` and one dynamic `Vector3` class instead of separate typed variants such as `Vector2f` and `Vector2i`
- most APIs also accept plain tuples, so `(10, 20)` is commonly valid where a vector is expected
- vector arithmetic works directly in Python

## Where You Will See This Module

- `Time` is used by audio playback offsets, networking timeouts, and event waiting
- `Angle` is used by graphics transforms, sprite rotation, text rotation, and cones in audio
- `Vector2` shows up in window positions, texture sizes, shape geometry, and 2D transforms
- `Vector3` is used mostly in audio listener and source positioning, and for some sensor values

## Differences From C++ Worth Knowing

- Python uses properties such as `clock.elapsed_time` and `angle.degrees` instead of getter-heavy naming.
- The public vector surface is Python-oriented and dynamic rather than exposing the C++ typed vector family directly.
- Text handling uses Python `str` at the binding boundary instead of exposing an `sf::String` wrapper.

## Missing Or Deferred Pieces

Some low-level system-layer pieces are intentionally not part of the public contract yet:

- no public threading wrappers
- no public `InputStream` surface
- internal string and Unicode helpers stay internal to the bindings

Those APIs are not part of the current public PySFML surface.

## Related Guides

- See `modules.md` for the top-level module map.
- See `window-module.md` for event loops and input.
- See `graphics-module.md` for transforms, drawables, and render targets.
- See `audio-module.md` for `Time`, `Angle`, and `Vector3` in spatial audio.
- See `network-module.md` for timeout handling.