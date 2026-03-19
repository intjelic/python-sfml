# Compatibility And Known Gaps

This page is the central reference for PySFML support boundaries on the SFML 2.6 modernization line.

## Supported Line

- Python baseline: 3.10+
- Upstream target: SFML 2.6.x
- Packaging and testing target: the modernized Python packaging and pytest-based validation flow in this repository

PySFML uses its own version numbers. Compatibility with upstream SFML should be read from project metadata and release notes rather than inferred from the package version alone.

## Intentional Python API Differences

The bindings do not try to mirror the C++ API mechanically.

- The public Python vector types are dynamic `Vector2` and `Vector3` classes instead of exposing the C++ typed variants directly.
- The preferred clock API is the `elapsed_time` property together with `restart()`.
- The stable public resource-loading API is file- and memory-based constructors such as `from_file(...)` and `from_memory(...)`.
- The `sfml.sf` convenience module remains available, but module-specific imports are the primary import style.

## Intentionally Unsupported Or Deferred Features

The following areas are outside the documented SFML 2.6 public surface for this project:

- Public wrappers for SFML threading primitives
- A public `InputStream` wrapper
- The network `Packet` API
- SFML 3 features and migration guidance

These may be revisited later, but they are not part of the current compatibility contract.

## Known Parity Gaps

Some runtime behavior still differs from what a user might expect from upstream SFML documentation or from the shipped type stubs.

- `sfml.window.KeyEvent.scancode` is not currently exposed at runtime.
- `sfml.window.ContextSettings.sRgbCapable` is not currently exposed at runtime.
- Event payload access is mapping-style at runtime. Use forms such as `event['code']`; attribute-style access such as `event.code` is not implemented.
- Some APIs remain setter-oriented in practice even when the stubs suggest a fuller property surface.

When these gaps are resolved, they should be removed from this page and reflected in tests and stubs in the same change.

## What This Page Does Not Cover

This page documents project-level compatibility boundaries. It is not a full API reference and does not enumerate every method, property, or module symbol.

For module orientation, see `modules.md`.