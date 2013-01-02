Add-Ons
=======

We've also developed bindings to popular utility libraries that add
functionality not provided by vanilla SFML2. 

sfeMovie
--------

This add-on provides a single :class:`sfemovie.Movie` class, which can be used
to play movies::

   import sfemovie as sfe

   movie = sfe.Movie.from_file('some_movie.ovg')
   movie.play()

For complete examples and documentation, please visit the `project page`_.

.. _project page: http://github.com/Sonkun/python-sfemovie
