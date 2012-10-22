SFML2 for Python
================
This is version |version| of the unofficial python binding for `SFML2 <http://www.sfml-dev.org/>`_ 
released under the `LGPLv3 <http://www.gnu.org/copyleft/lgpl.html>`_ license.

A python binding really is the perfect way to sketch a software using 
SFML.

By combining the strength of SFML with the ease of the python language,
we can provide an amazing tool to quickly build multimedia software.

.. note ::

        So far, this binding has only been tested thoroughly on Linux,
        though minimal testing has been done on Windows.
	
.. toctree::
   :maxdepth: 1
   :hidden:
   
   introduction
   download   
   gettingstarted
   examples
   tutorials
   api_reference
   changelog

.. hlist::
   :columns: 2

   * .. glossary::

      :doc:`introduction`
         Where you should start reading if you've never been here before.

   * .. glossary::
   
      :doc:`download`
         Download is available for all platforms: Windows, Mac OSX, Linux.
         
         It also give instructions to install and compile.

   * .. glossary::
   
      :doc:`gettingstarted`
         A documentation to help you get started with the binding.
      
   * .. glossary::
   
      :doc:`tutorials`
         Good place to learn or/and grab knowledges.

   * .. glossary::
   
      :doc:`api_reference`
         The official documentation enterily translated for this binding.

   * .. glossary::
   
      :doc:`examples`
         Various piece of examples.
      
What's new ?
------------

**1 October 2012**: sfeMovie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The project **sfeMovie** has been ported for this binding: check out the 
web page for documentation and installation procedure. Like this 
binding, it supports all platforms.

The two binding are **independant** but sfeMovie won't work if pysfml2 is 
not installed, of course.

Webpage: http://openhelbreath/python-sfeMovie
 
Github: https://github.com/Sonkun/python-sfeMovie

**30 August 2012**: New commands
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Two new commands available::

   python setup.py doc # to gen the doc
   python setup.py tests # to launch unit tests


**16 Juny 2012**: Depreciated some methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

'save_to_file', 'open_from_*' and 'load_from_*' have been depreciated 
and you should know use 'from_*' and 'to_file'.
