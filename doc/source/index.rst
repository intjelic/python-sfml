SFML2 for Python
================
This is version |version| of the unofficial Python bindings for `SFML2 <http://www.sfml-dev.org/>`_ 
released under the `LGPLv3 <http://www.gnu.org/copyleft/lgpl.html>`_ license.

Python bindings really are the perfect way to sketch software using SFML.

By combining the strength of SFML with the ease of the Python language,
we can provide an amazing tool to quickly build multimedia software.

.. note ::

        So far, these bindings have only been tested thoroughly on Linux,
        though minimal testing has been done on Windows.
	
.. toctree::
   :maxdepth: 1
   :hidden:
   
   introduction
   download   
   gettingstarted
   examples
   tutorials
   api/api_index
   addons
   changelog

.. hlist::
   :columns: 2

   * .. glossary::

      :doc:`introduction`
         Explains what this project is, who is responsible, and where this
         project is going.

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
   
      :doc:`addons`
         Documentation for complementary SFML-based libraries that have also
         been ported to Python.
      
   
What's new ?
------------

**1 October 2012**: sfeMovie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`sfeMovie <http://lucas.soltic.perso.luminy.univmed.fr/sfeMovie/>`_ has been
ported to Python. For documentation and installation instructions, please
consult the `website <http://openhelbreath/python-sfeMovie>`_. Just as the
original project depends on SFML being installed, the new sfeMovie bindings
depend on these SFML bindings.

.. seealso::
    Github: https://github.com/Sonkun/python-sfeMovie

**30 August 2012**: New commands
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Two new commands have been added to the setup script::

   python setup.py doc # generates html documentation
   python setup.py tests # runs the test suite


**16 Juny 2012**: Deprecated some methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`save_to_file()`, `open_from_*()` and `load_from_*()` methods have been deprecated 
in favor of `from_*()` and `to_file()`.

In addition, `copy()` methods have been deprecated in favor of Python's
`__copy__()` special methods. 
