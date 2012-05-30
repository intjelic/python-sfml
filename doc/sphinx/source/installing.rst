Installing
==========
Windows
-------
Just simply download the right installer and follow the instructions.

	* `pySFML2-1.0.0.win32-py2.7.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.0.0.win32-py2.7.exe>`_ [1.6 MB] [Python 2.7] [32 bit]
	* `pySFML2-1.0.0.win32-py3.2.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.0.0.win32-py3.2.exe>`_ [1.6 MB] [Python 3.2] [32 bit]

Compiling for this platform is not available yet.

MacOS
-----
This platform is not supported yet.

Ubuntu
------
Packages are available via launchpad depot, just type ::


   sudo add-apt-repository ppa:sonkun/sfml
   sudo apt-get update
   sudo apt-get install python-sfml2
   # or
   sudo apt-get install python3-sfml2

Note that these commands install the lastest stable version available. 
So far it's the 1.0 but soon the 1.1 will be released.

.. NOTE::
   The ppa *sonkun/sfml* provides many packages; the library sfml2.0-rc, 
   the binding but also their examples. Packages are:
		
		* libsfml2
		* libsfml2-dev
		* libsfml2-dbg
		* libsfml2-doc
		* sfml2-examples
		
		* python-sfml2
		* python3-sfml2
		* python-sfml2-doc
		* pysfml2-examples
		
	Once examples packages are installed, you may want to launch them to 
	see if the library works well with your graphic card. To do that, 
	just run the following commands. ::
	
		sfml2-sound # will run the example 'sound'
		sfml2-shader
		sfml2-x11
		sfml2-voip
		
		pysfml2-sound # will run the same example but it is actually a python script that use the binding
		pysfml2-sockets
		pysfml2-spacial-music # not an official sfml example
		pysfml2-pyqt4         # not an official sfml example 
		
   
Fedora
------
No RPM packages are provided, probably for the next release. Meanwhile, 
you'll have to compile by yourself.

Compiling
---------
	.. note:: The following instructions work only on Linux platforms as I use an internal version of setup.py to compile on Windows.

To compile you must have `sfml2-rc <http://openhelbreath.net/python-sfml2/downloads/sfml2-rc.tar.gz>`_ 
and `cython <http://cython.org/>`_ (0.16) installed on your computer.

Download the source ball `here <http://openhelbreath.net/python-sfml2/downloads/python-sfml2-1.0.tar.gz>`_. 
Then, just type that for python 2::

   sudo python setup.py install
   
Or that, for python 3::

   sudo python3 setup.py install
