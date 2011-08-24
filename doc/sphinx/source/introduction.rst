Introduction
============


What is this project about?
---------------------------

This project allows you use to use `SFML 2 <http://sfml-dev.org/>`_
from Python.  As SFML's author puts it, "SFML is a free multimedia C++
API that provides you low and high level access to graphics, input,
audio, etc."  It's the kind of library you use for writing multimedia
applications such as games or video players.


What isn't this project about?
------------------------------

This binding currently doesn't aim to be used as an OpenGL wrapper,
unlike the original SFML library.  This is because there are already
such wrappers available in Python, such as Pygame, PyOpenGL or pyglet.


Doesn't SFML already have a Python binding?
-------------------------------------------

It does, but the binding needed to be rewritten, mainly because the
current binding is directly written in C++ and is a maintenance
nightmare.  This new binding is written in `Cython
<http://cython.org>`_, hence the name.

Also, I find that the current binding lacks some features, such as:

* It doesn't follow Python's naming conventions.
* It lacks some fancy features such as properties, exceptions and
  iterators (for example, my binding allows you to iterate on events
  with a simple ``for`` loop).

You should also note that the current PySFML release on SFML's website
is buggy (for example, ``Image.SetSmooth()`` doesn't work).
You'd need to compile the latest version yourself to avoid these bugs.


Why SFML 2?
-----------

SFML 1 is now part of the past; it contains some important bugs and
apparently won't be updated anymore.

SFML 2 is still a work in progress, but it's stable enough for many
projects and it only breaks a few parts of SFML 1's API.

SFML 2 brings in important changes, such as new features, performance
improvement and a more consistent API.  In my opinion, if you aren't
tied to SFML 1, you should stop using it and try SFML 2.
