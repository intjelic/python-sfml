What's New?
===========
This page lists the most prominent milestones achieved by the python-sfml
developers. For more specific details about what is planned and what has been 
accomplished, please visit the `issues page on github` and the 
:doc:`changelog </changelog>`, respectively.

Milestones
----------

1 October 2012 : sfeMovie
   `sfeMovie <http://lucas.soltic.perso.luminy.univmed.fr/sfeMovie/>`_ has been
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

Next Version
------------
Version 1.3.0 will concentrate on fixing bugs that were unresolved in the
|release| release and packaging the bindings for various platforms. 
In addition, it will be the first version to `officially support Mac OS X`_.

.. _officially support Mac OS X: http://github.com/Sonkun/python-sfml/issues/44
.. _issues page on github: http://github.com/Sonkun/python-sfml/issues
