# Compatibility And Known Gaps

This page is the central reference for PySFML support boundaries on the SFML 3 release line.

## Supported Line

- Python baseline: 3.10+
- Upstream target: SFML 3.0.2
- Release line: PySFML for SFML 3
- Packaging and testing target: the modernized Python packaging and pytest-based validation flow in this repository

PySFML uses its own version numbers. Compatibility with upstream SFML should be read from project metadata and release notes rather than inferred from the package version alone.

## Intentional Python API Differences

The bindings do not try to mirror the C++ API mechanically.

- The public Python vector types are dynamic `Vector2` and `Vector3` classes instead of exposing the C++ typed variants directly.
- `Clock` uses Python properties for state access (`elapsed_time`, `is_running`) and methods for lifecycle changes (`start()`, `stop()`, `restart()`, `reset()`).
- `Angle` is exposed publicly from `sfml.system`, and graphics rotation APIs accept either `Angle` instances or degree scalars while returning `Angle` values.
- The stable public resource-loading API is file- and memory-based constructors such as `from_file(...)` and `from_memory(...)`.
- `sfml.window` exposes concrete typed event classes such as `KeyPressedEvent` and `MouseMovedEvent`; legacy SFML 2 payload wrappers such as `KeyEvent` and `MouseMoveEvent` are intentionally not public.
- The `sfml.sf` convenience module remains available, but module-specific imports are the primary import style.

## Intentionally Unsupported Or Deferred Features

The following areas are outside the documented support contract for this release line:

- Public wrappers for SFML threading primitives
- A public `InputStream` wrapper
- The network `Packet` API
- A finalized Python-side migration guide from the stable SFML 2 line

These may be revisited later, but they are not part of the current compatibility contract.

## Known Parity Gaps

The `sfml.window` surface uses typed event objects and explicit setter methods consistently across the runtime, stubs, docs, and tests.

The `sfml.audio` surface includes the main SFML 3 audio additions that were previously missing from the older PySFML shape:

- `PlaybackDevice` with Python `str` device names
- `SoundChannel` and explicit channel-map handling
- shared `Cone` values for listener and source directional audio
- expanded `Listener` and `SoundSource` spatial-audio state
- recorder channel-count and channel-map configuration
- `Music.loop_points`
- safe `Music.from_memory(...)` ownership for streamed in-memory audio

The `sfml.network` surface includes the main SFML 3 cleanup items that were previously missing from the older PySFML shape:

- canonical `IpAddress.ANY` naming with `NONE` retained only as a compatibility alias
- `Socket.PARTIAL` and a raw `TcpSocket.send(...)` contract that returns the byte count instead of flattening partial sends
- address-aware `TcpListener.listen(...)` and `UdpSocket.bind(...)`
- explicit `HttpRequest.set_*` builder methods
- fuller HTTP request and response enum coverage
- `Http()` default construction plus `set_host(...)`
- `Ftp.upload(..., append=...)` and `Ftp.send_command(...)`

Remaining gaps are primarily broader module coverage and deferred low-level integration areas rather than the core window event model.

## What This Page Does Not Cover

This page documents project-level compatibility boundaries. It is not a full API reference and does not enumerate every method, property, or module symbol.

For module orientation, see `modules.md`.