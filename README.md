# PySFML

PySFML provides Python bindings for **SFML**.

This release line targets **SFML 3.0.2**.

PySFML is distributed under the terms of the **zlib** license.

## Status

- Supported Python versions: **3.10+**
- Upstream target: **SFML 3.0.2**
- Packaging baseline: **pyproject.toml**, **setuptools**, **setuptools-scm**, **Cython 3.2.x**
- Test baseline: **pytest** smoke coverage for all compiled modules plus curated window and graphics coverage under Xvfb on Linux
- Published distribution name: **SFML**
- Import namespace: **sfml**

## Installation

Install the current release from PyPI:

```bash
python -m pip install --upgrade pip
python -m pip install SFML
```

If you need the older bindings for **SFML 2.6.2**, install that release explicitly:

```bash
python -m pip install SFML==2.6.2
```

For local development or custom SFML builds, install from a local checkout against a local SFML install:

```bash
python -m pip install --upgrade pip
export SFML_INSTALL_PREFIX=/path/to/sfml
python -m pip install .
```

If you prefer explicit paths, set `SFML_HEADERS` and `SFML_LIBRARIES` instead of `SFML_INSTALL_PREFIX`.

## Quick Example

The following PySFML program is the direct Python-style equivalent of the classic SFML C++ example that opens a window, displays a sprite and some text, and plays music:

```python
from sfml import audio, graphics, window


render_window = graphics.RenderWindow(
	window.VideoMode(800, 600),
	"PySFML window",
)

texture = graphics.Texture.from_file("cute_image.jpg")
sprite = graphics.Sprite(texture)

font = graphics.Font.from_file("arial.ttf")
text = graphics.Text(font, "Hello SFML", 50)

music = audio.Music.from_file("nice_music.ogg")
music.play()

while render_window.is_open:
	for event in render_window.events:
		if isinstance(event, window.ClosedEvent):
			render_window.close()

	render_window.clear()
	render_window.draw(sprite)
	render_window.draw(text)
	render_window.display()
```

The main differences from the C++ form are:

- resource loading is constructor-style via `from_file(...)`
- events are concrete typed objects such as `window.ClosedEvent`
- the event loop is exposed as `render_window.events`
- module imports are the preferred style instead of a single monolithic namespace

The example above reflects the current Python binding surface.

On the audio side, PySFML exposes the SFML 3 listener, device, and channel-map surface, including `PlaybackDevice`, `SoundChannel`, `Cone`, richer `SoundSource` state, and `Music.loop_points`.

See `docs/getting-started.md` for source-build prerequisites and the local build flow.

## Package Layout

The bindings are organized by SFML module:

- `sfml.system`
- `sfml.window`
- `sfml.graphics`
- `sfml.audio`
- `sfml.network`

The `sfml.sf` module remains available as a convenience import that re-exports the full binding surface, but the module-specific imports are the primary structure of the project.

See `docs/modules.md` for a module-by-module orientation.
See `docs/compatibility.md` for Python-specific behavior differences, unsupported features, and known parity gaps.

## Examples

The examples tree is curated around maintained upstream-aligned examples only.

See `examples/README.md` for the current examples policy and classification.

## Development

Local source-build prerequisites and test commands are documented in `docs/getting-started.md`.

Packaging metadata and test configuration live in `pyproject.toml`.

The CI and release workflows referenced below live in `.github/workflows/`.

## CI And Releases

The repository includes CI, release, and TestPyPI validation workflows under `.github/workflows/`.

For contributor-facing release and packaging details, see `CONTRIBUTING.md` together with the workflow definitions in `.github/workflows/`.

## Documentation

- `docs/getting-started.md`: installation and source-build guidance
- `docs/recipes.md`: minimal task-oriented snippets for common PySFML patterns
- `docs/modules.md`: module overview and import strategy
- `docs/system-module.md`, `docs/window-module.md`, `docs/graphics-module.md`, `docs/audio-module.md`, `docs/network-module.md`: quick Python-oriented guides for each primary module
- `docs/compatibility.md`: support boundaries, known differences, and unsupported features
- `examples/README.md`: maintained examples policy and classification
- `pyproject.toml`: packaging metadata and test configuration
- `.github/workflows/`: CI, release, and TestPyPI validation workflows

The repository source of truth is GitHub:

- Repository: <https://github.com/intjelic/python-sfml>
- Issues: <https://github.com/intjelic/python-sfml/issues>

## Author

Jonathan De Wachter <dewachter.jonathan@gmail.com>
