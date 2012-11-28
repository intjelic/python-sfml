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
It follows other **conventions** and the **technical implementation choices**
are different which allows (for example) to **use these binding in C or C++ code** (as a C API interface 
or at least the headers are provided) or (another example) **a third-party developer to 
create other binding that integrates with the main one** (as we did for 
sfeMovie:link:).

Where is this project going ?
-----------------------------
First, this project is active and open to ideas. 

It's mainly maintained by two 
developpers who have large projects (unreleased yet) based on these 
bindings, thus as long as we work on them, a support will be guaranted. 
Our projects are also an evidence pysfml2 is usable and make sure it
is ready for mature projects as our final goal is enjoying a complete
and stable SFML2 experience in Python.

Another goal is to introduce SFML2 without going throught the C++ 
documentation, or even knowing SFML2 is originaly a C++ library. That's 
why as soon as the sfml2 tutorials are written, they're going to be 
translated for this binding as well.

The project is also being ported to use with kivy. (add details ?).

Other SFML-based libraries are planned to be port such **Thor** and **TGUI**. 
Porting them should help improve the C API of these bindings.

Bindings overview
-----------------
.. warning::

    On Windows, typing these commands directly in a console might cause the
    console to freeze, in which case it is better to save the lines of code
    (without the '>>>' prompt) to a file to run later. 

Open a terminal and run the Python interpreter. Now we can experiment::

   >>> from sfml import graphics as sf
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

	
Running the examples
--------------------
As mentioned before, pySFML2 comes with plenty of examples. If you downloaded
a source archive, they will be located in the examples subdirectory. If running
on a Debian-based Linux distribution and you installed the pysfml2-examples
package, each example can be run by tacking on the name of the example to the
end of `pysfml-`. For example, to run the official sound example, type the
following in a terminal::

    pysfml2-sound


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
since the  Python interpreter doesn't have to check whether the argument type 
you just passed is right or not at runtime.


Contributors
------------
.. glossary::

    Edwin Marshall
        Active contributor who wrote unit tests, improved the documentation, implemented various API 
        improvements, and is currently working on writing an SFML backend for 
        `kivy <http://www.kivy.org>`_ using these bindings.

    Jorge Araya Navarro
        Made the binding officialy supported on **Parabola GNU/Linux-libre**

    Richard Sims
        Corrected my text and provids hosting.

Also, thanks to **Laurent Gomilla**, author of SFML2 and **Bastien 
Léonard**, who help start the project.

Next version
------------
The next version will update the bindings to the last sfml2 changes 
and hopes to be released as soon as the final sfml2 version is availabe. 
In addition to Mac OS X being **officially** supported, platform-specific 
examples will be made available. The remaining unit tests should be 
finished as well.

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
