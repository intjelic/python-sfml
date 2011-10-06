.. PySFML 2 - Cython documentation master file, created by
   sphinx-quickstart on Fri Feb 18 08:41:37 2011.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to PySFML 2 - Cython's documentation!
=============================================

A new Python binding for SFML 2, made with `Cython
<http://cython.org>`_.  Many features of SFML are currently available,
but this is still a work in progress.  Feel free to report any issue
you encounter.

You can find the source code and the issue tracker here:
https://github.com/bastienleonard/pysfml2-cython

Currently the reference just lists the available classes, their
members, and information specific to this binding.  For the
documentation itself, please see the `SFML 2 documentation
<http://sfml-dev.org/documentation/2.0/annotated>`_.  The mapping
between SFML and this binding should be fairly easy to grasp.

.. note::

   A current limitation is that :class:`sf.Texture` objects won't work
   as expected unless they are created after your
   :class:`sf.RenderWindow`.  It isn't a big problem in practice, but
   it's something to keep in mind until the issue is fixed.

Contents:

.. toctree::
   :maxdepth: 2

   introduction
   building
   tutorial
   reference


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

