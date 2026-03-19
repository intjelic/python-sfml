# Getting Started

PySFML provides Python bindings for SFML.

The current package targets SFML 2.6.2 and Python 3.10+.

## Install From PyPI

Binary wheels are the preferred installation path:

```bash
python -m pip install SFML
```

Use a wheel when one is available for your platform. Source builds require a local SFML installation.

Verify a fresh install with a minimal import check:

```bash
python -c "from sfml import audio, graphics, network, system, window; print('PySFML import ok')"
```

## Supported Baseline

- Python: 3.10+
- Bound SFML release: 2.6.2
- Packaging baseline: pyproject.toml, setuptools, setuptools-scm, Cython 3.2.x
- Published distribution name: SFML
- Import namespace: sfml

## Build From Source

Source builds require an SFML 2.6.2-compatible installation with headers and libraries available locally.

PySFML discovers SFML with these environment variables:

- `SFML_HEADERS`: include directory containing the SFML headers
- `SFML_LIBRARIES`: library directory containing the SFML libraries

If the repository-local prefix `.deps/sfml-2.6.2-install` exists, local builds prefer that install automatically. Set the environment variables explicitly to override that default.

Build a source distribution or wheel:

```bash
python -m pip install --upgrade pip build
export SFML_HEADERS=/path/to/sfml/include
export SFML_LIBRARIES=/path/to/sfml/lib
python -m build
```

Install directly from a local checkout:

```bash
python -m pip install --upgrade pip
export SFML_HEADERS=/path/to/sfml/include
export SFML_LIBRARIES=/path/to/sfml/lib
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
LD_LIBRARY_PATH=$PWD/.deps/sfml-2.6.2-install/lib python -m pytest -q tests
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
		if event.type == window.EventType.CLOSED:
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
text = graphics.Text("Hello SFML", font, 50)
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

The convenience module `sfml.sf` re-exports the binding surface, but module-specific imports are the primary structure of the project.

## Where To Look Next

- See `recipes.md` for small copyable snippets such as window loops, sprite drawing, audio playback, and TCP networking.
- See `modules.md` for a module-by-module orientation.
- See `compatibility.md` for PySFML differences, unsupported features, and known parity gaps.
- See `../examples/README.md` for the maintained examples set.
- See `../pyproject.toml` for packaging metadata and test configuration.
- See `../.github/workflows/` for CI, release, and TestPyPI validation workflows.