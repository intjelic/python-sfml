Change Log
===========

.. note::

    These lists are not exhaustive.

v0.9 -> v1.0 (based on SFML-1.9)
--------------------------------
* :mod:`sfml.system` module updated to the new API interface
* :mod:`sfml.window` module updated to the new API interface
* :mod:`sfml.graphics` module updated to the new API interface
* :mod:`sfml.audio` module updated to the new API interface
* :mod:`sfml.network` module updated to the new API interface
* Code entirely clean and follow convention

* :mod:`sfml.audio` module imports :mod:`sfml.system` system module with it
* The official ftp example implemented

v1.0 -> v1.1 (based on SFML2-RC)
--------------------------------
* :class:`sfml.system.Position` moved to built-in type and renamed :class:`sfml.system.Vector2`
* :class:`sfml.system.Size` removed; use :class:`sfml.system.Vector2` instead
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
* :meth:`sfml.graphics.Image.show()` is implemented and platform-independent
* :class:`sfml.audio.SoundStream` and :class:`sfml.audio.SoundRecorder` can be subclassed

v1.1 -> v1.2 (based on SFML2-RC)
--------------------------------
* The license has changed: GPLv3 -> LGPLv3
* Unit tests partially implemented
* Load/open/create methods are depreciated (use `from_foo` instead) [#]_
* Save/conversion methods are depreciated (use `to_bar` instead) [#]_
* Copy methods are depreciated (use the copy module instead)
* :class:`sfml.Window.events` returns now a generator
* Voip example implemented
* Improved :class:`sfml.audio.Chunk`
* Fixe bug in :class:`sfml.audio.SoundStream`
* :meth:`sfml.graphics.View.move` takes now two integer (x and y) instead of a vector
* Fixe bug in :class:`sfml.audio.SoundRecorder` (when calling stop())
* :func:`sfml.system.sleep` works now well in multi-threaded application
* :class:`sfml.graphics.Color` is copiable via the copy module
* Added unary operator to :class:`sfml.system.Vector2` and :class:`sfml.system.Vector3`
* Fixed :attr:`sfml.graphics.Rectangle.bottom`
* :class:`sfml.network.IpAddress` can be compared
* Ubuntu packages available for 12.04LTS and 12.10
* Installer script for Arch Linux users available
* sfeMovie available as add-on
* Fixe bug in sf.MouseMoveEvent.position
* Fixe various threading issues in the network module (GIL not released)
* Fixe bug in views returned by sf.RenderTarget (view wasn't linked)
* Fixe sf.TransformableDrawable (its properties work)
* Documentation entirely revised
* Website redesigned
* Install C/Cython API to code your own extensions using the bindings (1/3)
* Window.opened is deprecated, use Window.is_open property instead
* Improve setup.py to detect Cython and/or force its usage


v1.2 -> v1.3 (based on SFML2)
-----------------------------
* Removed deprecated methods
* Updated all modules to new SFML interface (SFML2)
* Fixed issue #60 (convert_coords methods return None no matter what)
* Added intersphinx mapping for official python documentation
* Install C/Cython API to code your own extensions using the bindings (2/3)
* Fedora packages available
* Ubuntu packages available for 13.04LTS
* Thor library available as add-on
* Implemented :class:`.Thread`, :class:`.Mutex` and :class:`.Lock`
* Some official tutorials have been translated
* Implemented OpenGL example
* Spacial music example takes the Z axis into account #25
* Replaced X11 dependency with ctype usage
* Added two new examples: extending and embedding.
* Removed sf.Time.reset function
* Removed SFMLException and replaced with the standard ones
* Removed vsync and visibility trackers from sf.Window

.. [#] E.g: **Do not use** sf.Texture.load_from_file(filename) but **sf.Texture.from_file(filename)** instead.
.. [#] E.g: **Do not use** sf.Texture.image.save_to_file() but **sf.Texture.to_image().to_file()** .
