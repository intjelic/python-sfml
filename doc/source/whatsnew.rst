What's New?
===========
This page lists the most prominent milestones achieved by the python-sfml
developers. For more specific details about what is planned and what has been
accomplished, please visit the `issues page on github` and the
:doc:`changelog </changelog>`, respectively.

Milestones
----------

1 February 2013 : Thor library

   Most of the `Thor <http://www.bromeon.ch/libraries/thor/>`_ library modules
   have been ported and can be interpolated with the SFML bindings. This port
   joins sfeMovie in the list of officially supported add-ons.

   .. seealso::

      Website: http://thor.python-sfml.org

      Github: https://github.com/Sonkun/python-thor

1 Decembre 2012 : Version 1.2 is out

   This version includes a C/Cython API allowing you to embbed Python using
   pySFML to C++ code or write your own Python extension using pySFML.

   The load/open/create methods have been deprecated in favor of their **from_foo**
   counterparts, which we believe more closely resemble the standard library's
   naming conventions. Similarly, the save/conversion methods have been
   deprecated in favor of **to_bar** methods.

1 October 2012 : sfeMovie
   `sfeMovie <http://lucas.soltic.etu.p.luminy.univmed.fr/sfeMovie/>`_ has been
   ported to Python. For documentation and installation instructions, please
   consult the `website <http://sfemovie.python-sfml.org>`_. Just as the
   original project depends on SFML, the new sfeMovie bindings
   depend on these SFML bindings.

   .. seealso::
      Github: https://github.com/Sonkun/python-sfemovie

18 November 2012 : New setup script
   In addition to migrating from distutils to distribute, a new command has been
   added which allows developers to launch the unit test suite::

      python setup.py test

   While the number of unit tests present are scarce, this will change shortly.

16 Juny 2012 : Deprecated some un-pythonic methods
   `save_to_file()`, `open_from_*()` and `load_from_*()` methods have been deprecated
   in favor of `from_*()` and `to_file()`.

   Additionally, `copy()` methods have been deprecated in favor of Python's
   `__copy__()` special methods.

.. _issues page on github: http://github.com/Sonkun/python-sfml/issues
