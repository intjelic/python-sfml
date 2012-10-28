Introduction
============
These bindings are based on the `first release candidate
<http://www.sfml-dev.org/download.php#2.0-rc>`_ of SFML2, and are exhaustive, 
meaning that all of SFML's api has been exposed to Python, even if Python itself 
includes a functionally equivalent set of APIs. [#]_

These bindings consist of a top-level :mod:`sfml` package which in-turn is
composed of five modules, each of which correspond to those provided by the C++
API:

    :mod:`.system`, :mod:`.window`, :mod:`.graphics`, :mod:`.audio`, and 
    :py:mod:`.network`.


We provide detailed :doc:`examples </examples>` and :doc:`tutorials </tutorials>`, as
well as a complete :doc:`API reference </api/api_index>` to assist you as you
learn pySFML2.

History
-------
This binding was forked from the `official Python binding 
<https://github.com/bastienleonard/pysfml2-cython>`_ created by Bastien 
Léonard on the 16th of November, 2011.

I decided to fork because his project was (and still is) a work in progress,
and I urgently needed some unimplemented features in order to port my current
C++ projects to Python. Since then, it has vastly improved and I have decided
to share my work under a new license: LGPLv3.

Altought his project was taken as a starting point, months went by, SFML2 
matured rapidly, and everything was re-coded and re-thought from A to Z.

Overview
--------
.. warning::

    On Windows, typing these commands directly in a console might cause the
    console to freeze, in which case it is better to save the lines of code
    (without the '>>>' prompt) to a file to run later. 

Open a terminal and run the Python interpreter. Now we can experiment::

   >>> import sfml as sf
   >>> w = sf.RenderWindow(sf.VideoMode(640, 480), "My first pySFML Window - or not ?")
   >>> w.clear(sf.Color.BLUE)
   >>> w.display()
   >>> w.size = (800, 600)
   >>> w.clear(sf.Color.GREEN)
   >>> w.display()
   >>> w.title = "Yes, it's my first PySFML Window"
   >>> w.display()
   >>> w.capture().show()
   >>> w.close()
   >>> exit()

	
Running the Examples
--------------------
As mentioned before, pySFML2 comes with plenty of examples. If you downloaded
a source archive, they will be located in the examples subdirectory. If running
on a Debian-based Linux distribution and you installed the pysfml2-examples
package, each example can be run by tacking on the name of the example to the
end of `pysfml-`. For example, to run the official sound example, type the
following in a terminal::

    pysfml2-sound

.. Note::
   Examples are only avalaible for Python3.2 and can be found in 
   /usr/lib/games/pysfml2-examples/ should you wish to read the code.
   
A word about Cython
-------------------
This binding has been coded in Cython, a language that allows you to 
make extending Python as easy as Python itself. 

An extension is coded in C or C++ using the Python C API. Unlike a pure 
Python module, an extension module may take in its functions/methods a 
precise type, a fact worth keeping in mind:

In normal Python code you'll be able to pass anything everywhere you 
have to provide an argument. If your argument is wrong, no 
check will be performed until something goes wrong and your program 
stops running. A Python philosophy says: "Python supposes you know what 
a function/methods expects. By consequence, if you pass a wrong 
argument, it means there was an error earlier"

For an extension module this is not the case and if you pass a 
:class:`sfml.graphics.Transform` when an :class:`sfml.graphics.Color` is expected, an exception **will**
be raised. Incidentally, having a precise type makes things execute much faster 
sincethe  Python interpreter doesn't have to check whether the argument type 
you just passed is right or not at runtime.


Contributors
------------
.. glossary::

    Edwin Marshall
        Active contributor who wrote unit tests, improved the documentation, implemented various API 
        improvements, and is currently working on writing an SFML backend for 
        `kivy <http://www.kivy.org>`_ using these bindings.

    Laurent Gomilla
        Author of SFML2.

    Jorge Araya Navarro
        Made the binding officialy supported on **Parabola GNU/Linux-libre**

    Bastien Léonard
        Helped me discover Cython

    Richard Sims
        Corrected my text and provids hosting.

Next version
------------
The next version will be a bug-fix release as I can't track all bugs 
by myself, despite performing many tests. In addition to Mac OS X being
**officially** supported, binary rpm packages (eg. Fedora) will be made
available. Also, platform-specific examples should be available as well.

For more specific details about what is planned and what has been accomplished,
please visit the `issues page on github
<http://github.com/Sonkun/python-sfml2/issues>`_ and :doc:`changelog`
respectively.

.. rubric:: Footnotes

.. [#] For example, we have provided bindings for SFML's network module. Though
       such functionality could be found in Python's standard library's socket
       module, we feel like its inclusion not only aids developers as they
       port their software from c++ to Python or vice-versa, but is also more
       convient in some cases (eg. getting a public IP address).
