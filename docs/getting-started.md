# Getting Started

PySFML provides Python bindings for SFML.

This release line targets SFML 3.0.2 and Python 3.10+.

## Install From PyPI

Install the current release with:

```bash
python -m pip install --upgrade pip
python -m pip install SFML
```

If you need the older bindings for SFML 2.6.2, install that release explicitly with:

```bash
python -m pip install SFML==2.6.2
```

Verify a fresh install with a minimal import check:

```bash
python -c "from sfml import audio, graphics, network, system, window; print('PySFML import ok')"
```

## Supported Baseline

- Python: 3.10+
- Upstream target: SFML 3.0.2
- Release line: PySFML for SFML 3
- Packaging baseline: pyproject.toml, setuptools, setuptools-scm, Cython 3.2.x
- Published distribution name: SFML
- Import namespace: sfml

## Build From Source

Source builds require an SFML installation with headers and libraries available locally. The intended target for this release line is SFML 3.0.2.

PySFML discovers SFML with these environment variables:

- `SFML_INSTALL_PREFIX`: install prefix containing `include` and `lib` directories
- `SFML_HEADERS`: include directory containing the SFML headers
- `SFML_LIBRARIES`: library directory containing the SFML libraries

If a repository-local prefix exists, local builds currently check these directories in order:

- `.deps/sfml-3.0.2-install`
- `.deps/sfml-3-install`
- `.deps/sfml-2.6.2-install`

The `.deps/sfml-2.6.2-install` fallback remains available for legacy validation during local development.

For local Python environments, use `.venv-build-3.0.2` for SFML 3 work and `.venv-build-2.6.2` for legacy SFML 2.6.2 validation when needed.

Build a source distribution or wheel:

```bash
python -m pip install --upgrade pip build
export SFML_INSTALL_PREFIX=/path/to/sfml
python -m build
```

Install directly from a local checkout:

```bash
python -m pip install --upgrade pip
export SFML_INSTALL_PREFIX=/path/to/sfml
python -m pip install .
```

Install an editable checkout for local development:

```bash
python -m pip install --upgrade pip
export SFML_HEADERS=/path/to/sfml/include
export SFML_LIBRARIES=/path/to/sfml/lib
python -m pip install -e ".[test]"
```

On Linux, make sure the dynamic loader can find the SFML runtime libraries when importing the extension modules. The pinned local validation flow uses:

```bash
LD_LIBRARY_PATH=/path/to/sfml/lib python -m pytest -q tests
```

## First Imports

The public bindings are organized into five modules:

- `sfml.system`
- `sfml.window`
- `sfml.graphics`
- `sfml.audio`
- `sfml.network`

Typical imports are module-specific:

```python
from sfml import graphics, window
```

The smallest useful window example looks like this:

```python
from sfml import graphics, window


render_window = graphics.RenderWindow(window.VideoMode(640, 480), "PySFML")

while render_window.is_open:
	for event in render_window.events:
		if isinstance(event, window.ClosedEvent):
			render_window.close()

	render_window.clear()
	render_window.display()
```

If you want a direct SFML-style example with graphics and audio resources as well:

```python
from sfml import audio, graphics, window


render_window = graphics.RenderWindow(window.VideoMode(800, 600), "SFML window")
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

The convenience module `sfml.sf` re-exports the binding surface, but module-specific imports are the primary structure of the project.

The code examples on this page match the current PySFML SFML 3 surface. On Linux, export `LD_LIBRARY_PATH` to include the local SFML `lib` directory before running them against a source-built checkout.

## Where To Look Next

- See `recipes.md` for small copyable snippets such as window loops, sprite drawing, audio playback, and TCP networking.
- See `modules.md` for a module-by-module orientation.
- See `compatibility.md` for PySFML differences, unsupported features, and known parity gaps.
- See `../examples/README.md` for the maintained examples set.
- See `../pyproject.toml` for packaging metadata and test configuration.
- See `../.github/workflows/` for CI, release, and TestPyPI validation workflows.