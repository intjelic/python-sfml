Add-Ons
=======

We've also developed bindings to popular utility libraries that add
functionality not provided by vanilla SFML.

sfeMovie
--------

This add-on provides a single :class:`sfemovie.Movie` class, which can be used
to play movies::

   import sfemovie as sfe

   movie = sfe.Movie.from_file('some_movie.ovg')
   movie.play()

For complete examples and documentation, please visit the `sfeMovie project page`_.

Thor
----
This add-on allows you to use the Thor library in Python

For complete examples and documentation, please visit the `pyThor project page`_.

.. _sfeMovie project page: http://sfemovie.python-sfml.org
.. _pyThor project page: http://thor.python-sfml.org
