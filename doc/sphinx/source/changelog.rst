Change Log
===========

These lists are **not exhaustive**.

v0.9 -> v1.0
------------
* :mod:`sfml.system` module updated to the new API interface
* :mod:`sfml.window` module updated to the new API interface
* :mod:`sfml.graphics` module updated to the new API interface
* :mod: `sfml.audio` module updated to the new API interface
* :mod: `sfml.network` module updated to the new API interface
* Code entirely clean and follow convention

* :mod:`sfml.audio` module imports :mod:`sfml.system` system module with it
* The official ftp example implemented

v1.0 -> v1.1
------------
* `sfml.system.Position` moved to built-in type and renamed `sfml.system.Vector2`
* `sfml.system.Size` removed; use `sfml.system.Vector2` instead
* `sfml.system.Vector3` added
* Full variable/method/function/class name are clean
* Error message handler implemented
* open/load functions raises IOError and not sfml.system.SFMLException
* sfml.graphics.Shader's constants (VERTEX and FRAGMENT) removed
* sfml.graphics.Shader's constructors implemented
* sfml.graphics.Shader.set_parameter implemented
* sfml.graphics.Texture.update() implemented
* sfml.graphics.Vertex implemented
* sfml.graphics.VertexArray implemented
* Shader example added
* Pong example added
* sfml.graphics.Color are unpackable
* Network module uses sfml.system.Time
* Audio module uses sfml.system.Time
* Image.show() is implemented and platform-independant
* SoundStream and SoundRecorder can be subclassed

