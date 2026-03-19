# Examples

The examples in this repository are being reviewed as part of the SFML 2.6.x modernization line.

This page documents the maintained examples scope for end users. It is not a promise that every historical example directory remains equally supported.

Historical or PySFML-specific experiments that are no longer part of the maintained example set are archived outside the main repository tree.

## Policy

The primary goal is to mirror the example set provided by the upstream SFML repository where that makes sense for Python.

PySFML-specific or framework-specific examples that do not match the maintained upstream-aligned scope should be archived outside the main repository tree.

For installation, module orientation, and compatibility notes, start from `../docs/getting-started.md`, `../docs/modules.md`, and `../docs/compatibility.md`.

## Current Classification

### Core examples

- `ftp`
- `opengl`
- `shader`
- `sockets`
- `sound`
- `sound_capture`
- `voip`
- `pong`

### Archived examples

- `embedding`: PySFML-specific embedding sample archived outside the main repo examples tree
- `extending`: PySFML-specific Cython extension sample archived outside the main repo examples tree
- `pyqt4`: legacy integration sample archived outside the main repo examples tree
- `pyqt5`: Qt integration sample archived outside the main repo examples tree

## Follow-up Direction

The next additions should favor foundational ports from the upstream SFML examples tree, especially examples equivalent to `text`, `window`, and `event_handling`.

Archived examples are intentionally outside the main documentation path and should not be treated as the recommended way to start with PySFML.