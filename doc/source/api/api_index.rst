API Reference
=============
.. note::

   In order to keep the documentation concise and to the point, deprecated
   features have been omitted, though they still exist for backward
   compatability.

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
         The system module documentation.
         
   * .. glossary::

      :doc:`window`
         The window module documentation.
         
   * .. glossary::

      :doc:`graphics`
         The graphics module documentation.
         
   * .. glossary::

      :doc:`audio`
        The audio module documentation.
         
   * .. glossary::

      :doc:`network`
         The network module documentation.

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
       SFML's API more convient in some cases (e.g. when obtaining a public IP
       address).
