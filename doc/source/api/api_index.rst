API Reference
=============

Here you will find the project's documentation. It's mainly a 
translation from the original SFML2's documentation.

.. warning::

   In order **not to pollute** the documenation, **announced depreciations** such 
   **copy methods** and **open_from**, **save_to** and **load_from methods** **have been 
   removed**. They still do exists to keep backward compabilities.

.. only:: pdf

   The online doc will always be more up-to-date, with corrections, 
   you can consult it at any time: http://openhelbreath.net/python-sfml2

Choose the module:

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
         
         **HandledWindow** is not documented, see **PyQt4** integration example.
         
   * .. glossary::

      :doc:`audio`
        The audio module documentation.
         
   * .. glossary::

      :doc:`network`
         The network module documentation. 
         
         Althought **SocketSelector**, **Ftp** and **Http** classes are implemented, they are not yet documented. 
         
         Refer to official examples to know how they work.

.. toctree::
   :maxdepth: 1
   :hidden:
   
   system
   window
   graphics
   audio
   network
