Introduction
============
This is version |version| of the unofficial Python bindings for `SFML2`_,
based on `the first release candidate` and is made available under the terms of
the `LGPLv3`_ license.

By combining the strength of SFML with the ease of the Python language,
we can provide an amazing tool to quickly build multimedia software.

.. note ::

        So far, these bindings have only been tested thoroughly on Linux,
        though minimal testing has been done on Windows.

Project History
===============
These bindings were forked from the `official Python bindings`_
created by Bastien Léonard on the 16th of November, 2011.

I decided to fork because his project was (and still is) a work in progress,
and I urgently needed some unimplemented features in order to port my current
C++ projects to Python. Since then, it has vastly improved and I have decided
to share my work under a new license: LGPLv3.

Altought his project was taken as a starting point, months went by, SFML2 
matured rapidly, and everything was re-coded and re-thought from A to Z.

Table of Contents
=================

.. toctree::
   :maxdepth: 1
   :hidden:
   
   download   
   gettingstarted
   examples
   tutorials
   api/api_index
   add-ons
   changelog

.. hlist::
   :columns: 2

   * .. glossary::
   
      :doc:`download`
         Instructions on where and how to install these bindings for various
         platforms. Includes information on how to compile them from source.
         
   * .. glossary::
   
      :doc:`gettingstarted`
         A gentle introduction to these bindings, covering some basic
         principles.
      
   * .. glossary::
   
      :doc:`examples`
         Practical examples demonstrating how various parts of this binding can
         work together with each other as well as other APIs.
         
   * .. glossary::
   
      :doc:`tutorials`
         Tutorials focusing on the various core principles integral to
         understanding how SFML works.

   * .. glossary::
   
      :doc:`api/api_index`
         Complete library reference organized by each of the binding's five
         core modules.

   * .. glossary::
   
      :doc:`add-ons`
         Documentation for complementary SFML-based libraries that have also
         been ported to Python.

Contributors
============
.. glossary::

    Jonathan DeWachter
        Author of these bindings.

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

What's new ?
============

**1 October 2012**: sfeMovie
----------------------------

`sfeMovie <http://lucas.soltic.perso.luminy.univmed.fr/sfeMovie/>`_ has been
ported to Python. For documentation and installation instructions, please
consult the `website <http://openhelbreath/python-sfeMovie>`_. Just as the
original project depends on SFML being installed, the new sfeMovie bindings
depend on these SFML bindings.

.. seealso::
    Github: https://github.com/Sonkun/python-sfeMovie

**18 November 2012**: New setup script
--------------------------------------

In addition to migrating from distutils to distribute, a new command has been
added which allows developers to launch the unit test suite::

   python setup.py test

**16 Juny 2012**: Deprecated some methods
-----------------------------------------

`save_to_file()`, `open_from_*()` and `load_from_*()` methods have been deprecated 
in favor of `from_*()` and `to_file()`.

In addition, `copy()` methods have been deprecated in favor of Python's
`__copy__()` special methods. 

Next Version
============
Version 1.2.1 will concentrate on fixing bugs that were unresolved in the
|release| release and packaging the bindings for various platforms. 
In addition, it will be the first version to `officially support Mac OS X`_.

For more specific details about what is planned and what has been accomplished,
please visit the `issues page on github` and the :doc:`changelog </changelog>`, 
respectively.

.. _officially support Mac OS X: http://github.com/Sonkun/python-sfml2/issues/44
.. _issues page on github: http://github.com/Sonkun/python-sfml2/issues


.. _SFML2: http://www.sfml-dev.org/
.. _the first release candidate: http://www.sfml-dev.org/download.php#2.0-rc
.. _LGPLv3: htp://www.gnu.org/copyleft/lgpl.html
.. _official Python bindings: https://github.com/bastienleonard/pysfml2-cython
