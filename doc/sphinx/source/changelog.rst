Change Log
===========

These lists are **not exhaustive**.

v0.9 -> v1.0
------------
* :mod:`sfml.system` module updated to the new API interface
* :mod:`sfml.window` module updated to the new API interface
* :mod:`sfml.graphics` module updated to the new API interface
* :mod:`sfml.audio` module updated to the new API interface
* :mod:`sfml.network` module updated to the new API interface
* Code entirely clean and follow convention

* :mod:`sfml.audio` module imports :mod:`sfml.system` system module with it
* The official ftp example implemented

v1.0 -> v1.1
------------
* :class:`sfml.system.Position` moved to built-in type and renamed `sfml.system.Vector2`
* :class:`sfml.system.Size` removed; use `sfml.system.Vector2` instead
* :class:`sfml.system.Vector3` added
* Full variable/method/function/class name are clean
* Error message handler implemented
* open/load functions raises IOError and not sfml.system.SFMLException
* :class:`sfml.graphics.Shader`'s constants (VERTEX and FRAGMENT) removed
* :class:`sfml.graphics.Shader`'s constructors implemented
* :meth:`sfml.graphics.Shader.set_parameter()` implemented
* :meth:`sfml.graphics.Texture.update()` implemented
* :class:`sfml.graphics.Vertex` implemented
* :class:`sfml.graphics.VertexArray` implemented
* Shader example added
* Pong example added
* :class:`sfml.graphics.Color` are unpackable
* :mod:`sfml.network` module uses :class:`sfml.system.Time`
* :mod:`sfml.audio` module uses :class:`sfml.system.Time`
* :meth:`sfml.graphics.Image.show()` is implemented and platform-independant
* :class:`sfml.audio.SoundStream` and :class:`sfml.audio.SoundRecorder` can be subclassed

