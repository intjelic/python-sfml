Introduction
============
This is the unofficial binding based on the first release candidate of 
SFML2.

This binding is **complete**, providing access to all of SFML's API's and
features. The module is split into five distinct sub-modules:
:py:mod:`.system`, :py:mod:`.window`, :py:mod:`.graphics`, :py:mod:`.audio`, 
and :py:mod:`.network`.

Unlike the official one this binding provides the network module in 
order to be **exhaustive**, although its use is **discouraged** since python's
standard library already has equivalent modules.

At the moment, official support only exists for the **Windows** and **Linux**,
though official **Mac OS X** support is coming soon. [#]_

Examples, tutorials and **complete documentation** come along to help 
you with using pySFML2.

History
-------
This binding was forked from the `official python binding 
<https://github.com/bastienleonard/pysfml2-cython>`_ created by Bastien 
Léonard on the 16th of November, 2011.

I decided to fork because his project was (and still is) a work in progress 
and I urgently needed some unimplemented features in order to port my current 
C++ projects to Python. Since then, it has widely improved and I have decided 
to share my work under a new license: GPLv3.

Altought his project was taken as a starting point, months went by, SFML2 
matured rapidly, and everything was re-coded and re-thought from A to Z.

A word about Cython
-------------------
This binding has been coded in Cython, a language that allows you to 
make extending python as easy as Python itself. 

An extension is coded in C or C++ using the Python C API. Unlike a pure 
python module, an extension module may take in its functions/methods a 
precise type, a fact worth keeping in mind:

In normal python code you'll be able to pass anything everywhere you 
have to provide an argument. If your argument is wrong, no 
check will be performed until something goes wrong and your program 
stops running. A python philosophy says: "Python supposes you know what 
a function/methods expects. By consequence, if you pass a wrong 
argument, it means there was an error earlier"

For an extension module this is not the case and if you pass a 
:class:`sfml.graphics.Transform` when an :class:`sfml.graphics.Color` is expected, an exception **will**
be raised. Incidentally, having a precise type makes things execute much faster 
sincethe  python interpreter doesn't have to check whether the argument type 
you just passed is right or not at runtime.


Contributors
------------
- **Edwin Marshall**: active contributor who made test units and improved the doc. He also created a sfml2 back-end to the `kivy project <http://kivy.org/>`_ .
- **Laurent Gomilla** for creating SFML2
- **Jorge Araya Navarro** who made the binding officialy supported on **Parabola GNU/Linux-libre**
- **Bastien Léonard** who helped me discover Cython
- **Richard Sims** who corrected my text and provided hosting.

Next version
------------
The next version will be a bug-fix release as I can't track all bugs 
by myself, despite performing many tests. In addition to Mac OS X being
**officially** supported, binary rpm packages (eg. Fedora) will be made
available. Also, platform-specific examples should be available as well.

You might want to consult the :doc:`changelog` page.


.. [#] In theory, this binding should work fine on Mac OS X, but unit tests,
       binary packages, and a formal install procedure have yet to be established.


