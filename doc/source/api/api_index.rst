API Reference
=============
.. note::

   In order to keep the documentation concise and to the point, deprecated
   features have been omitted, though they still exist for backward
   compatibility.

.. only:: pdf

   The online documentation will always be more up-to-date unless built from
   source. it is always available at http://openhelbreath.net/python-sfml2.

All of SFML's api has been exposed to Python, even if Python itself
includes a functionally equivalent set of APIs. [#]_

These bindings consist of a top-level :mod:`sfml` package which in-turn is
composed of five modules, each of which correspond to those provided by the C++
API:


.. hlist::
   :columns: 2

   * .. glossary::

      :doc:`system`
         Base module of SFML, defining various utilities.

   * .. glossary::

      :doc:`window`
         Provides OpenGL-based windows, and abstractions for events and input
         handling

   * .. glossary::

      :doc:`graphics`
         2D graphics module: sprites, text, shapes, ...

   * .. glossary::

      :doc:`audio`
        Sounds, streaming (musics or custom sources), recording, spatialization.

   * .. glossary::

      :doc:`network`
         Socket-based communication, utilities and higher-level network
         protocols (HTTP, FTP).

.. toctree::
   :maxdepth: 1
   :hidden:

   system
   window
   graphics
   audio
   network

.. rubric:: Footnotes

.. [#] For example, we provide bindings for SFML's network module. Even
       Though such functionality can be found in Python's socket module, we
       believe that its inclusion not only aids developers as they
       port their software from C++ to Python or vice-versa, but we also find
       SFML's API more convenient in some cases (e.g. when obtaining a public IP
       address).
