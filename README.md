# PySFML

PySFML provides Python bindings for **SFML**.

The current package targets **SFML 2.6.2** with modern Python packaging, pytest-based validation, and wheel builds.

PySFML is distributed under the terms of the **zlib** license.

## Installation

Install the published package with pip:

```bash
python -m pip install SFML
```

Binary wheels are the preferred installation path.

## Current Baseline

- Supported Python versions: **3.10+**
- Bound SFML release: **2.6.2**
- Packaging baseline: **pyproject.toml**, **setuptools**, **setuptools-scm**, **Cython 3.2.x**
- Validation baseline: **pytest** smoke coverage for all compiled modules plus curated window and graphics coverage under Xvfb on Linux

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
text = graphics.Text("Hello PySFML", font, 50)

music = audio.Music.from_file("nice_music.ogg")
music.play()

while render_window.is_open:
	for event in render_window.events:
		if event.type == window.EventType.CLOSED:
			render_window.close()

	render_window.clear()
	render_window.draw(sprite)
	render_window.draw(text)
	render_window.display()
```

The main differences from the C++ form are:

- resource loading is constructor-style via `from_file(...)`
- event kinds use `window.EventType`
- the event loop is exposed as `render_window.events`
- module imports are the preferred style instead of a single monolithic namespace

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

GitHub Actions is centered on:

- editable-install validation on Linux against a pinned SFML 2.6.2 build
- packaging validation for both wheel and sdist artifacts
- smoke-install checks on Linux, macOS, and Windows
- curated typing validation using `mypy`
- tag-driven wheel and sdist builds via `cibuildwheel` and `python -m build`

Release publishing is restricted to `v*` tags:

- prerelease tags containing `a`, `b`, or `rc` publish to TestPyPI
- other `v*` tags publish to PyPI

Release artifacts are validated before publish with `.github/scripts/validate-dist.py` and `twine check`, and the wheel builds run the deterministic wheel-safe pytest subset configured in `pyproject.toml`.

There is also a manual `TestPyPI Validation` GitHub Actions workflow for installing an already-uploaded TestPyPI version on fresh Linux, macOS, and Windows runners.

## Documentation

- `docs/getting-started.md`: installation and source-build guidance
- `docs/recipes.md`: minimal task-oriented snippets for common PySFML patterns
- `docs/modules.md`: module overview and import strategy
- `docs/compatibility.md`: support boundaries, known differences, and unsupported features
- `examples/README.md`: maintained examples policy and classification
- `pyproject.toml`: packaging metadata and test configuration
- `.github/workflows/`: CI, release, and TestPyPI validation workflows

The repository source of truth is GitHub:

- Repository: <https://github.com/intjelic/python-sfml>
- Issues: <https://github.com/intjelic/python-sfml/issues>

## Author

Jonathan De Wachter <dewachter.jonathan@gmail.com>
