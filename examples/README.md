# Examples

The examples in this repository target the current PySFML release line for SFML 3.

This page documents the maintained examples scope for end users. It is not a promise that every historical example directory remains equally supported.

Historical or PySFML-specific experiments that are no longer part of the maintained example set are archived outside the main repository tree.

## Policy

The primary goal is to mirror the example set provided by the upstream SFML repository where that makes sense for Python.

Maintained examples are expected to track the current SFML 3 binding surface. If one of them drifts from the documented module APIs, treat that as a regression to fix in the repository.

For graphics examples on the SFML 3 line, that means using the public API directly: font-first `Text(...)` construction, `fill_color` and related text styling names, and `Shader.set_uniform(...)` with `CurrentTexture` where texture uniforms are needed.

PySFML-specific or framework-specific examples that do not match the maintained upstream-aligned scope should be archived outside the main repository tree.

For installation, module orientation, and compatibility notes, start from `../docs/getting-started.md`, `../docs/modules.md`, and `../docs/compatibility.md`.

The `window` and `opengl` examples use PyOpenGL in addition to the PySFML bindings.

## Current Classification

### Maintained SFML 3 mirror examples

- `event_handling`
- `ftp`
- `joystick`
- `keyboard`
- `opengl`
- `raw_input`
- `shader`
- `sockets`
- `sound`
- `sound_capture`
- `voip`
- `window`

### Archived examples

- `embedding`: PySFML-specific embedding sample archived outside the main repo examples tree
- `extending`: PySFML-specific Cython extension sample archived outside the main repo examples tree
- `pyqt4`: legacy integration sample archived outside the main repo examples tree
- `pyqt5`: Qt integration sample archived outside the main repo examples tree

## Follow-up Direction

The next additions should favor upstream examples that still add value on the Python binding side without pulling in deferred APIs or heavy platform assumptions. There is no immediate must-port follow-up in the maintained mirror set; additional ports should be justified case by case against binding coverage and maintenance cost.

Archived examples are intentionally outside the main documentation path and should not be treated as the recommended way to start with PySFML.