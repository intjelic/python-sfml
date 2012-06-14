Installation
============
Here you'll find all the necessary explainations for installing the binding 
on your favorite platform. Unfortunately the procedures for the **Mac OSX** and 
**Fedora** packages are not available yet.

.. contents:: :local:

   
Windows
-------
Simply download the correct installer and follow the instructions.

	* `pySFML2-1.1.0.win32-py2.7.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.1.0.win32-py2.7.exe>`_ [1.6 MB] [Python 2.7] [32 bit]
	* `pySFML2-1.1.0.win32-py3.2.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.1.0.win32-py3.2.exe>`_ [1.6 MB] [Python 3.2] [32 bit]
	* `pySFML2-1.1.0.win64-py2.7.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.1.0.win64-py2.7.exe>`_ [1.6 MB] [Python 2.7] [64 bit]
	* `pySFML2-1.1.0.win64-py3.2.exe <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.1.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]

Compillation for this platform is not available yet.

Mac OSX
-------
This platform is not supported yet. If you download the source and if 
you know a bit of Cython, you should be able to compile the source but 
I advise you to wait for the next release which will have Mac OSX 
supported.

Ubuntu
------
Packages are available via launchpad depot, just type ::

   sudo add-apt-repository ppa:sonkun/sfml
   sudo apt-get update
   sudo apt-get install python-sfml2
   # or
   sudo apt-get install python3-sfml2

.. NOTE::
   The ppa *sonkun/sfml* provides many packages. The library sfml2.0-rc 
   and the binding are included along with their examples. Packages are:

      * libsfml2
      * libsfml2-dev
      * libsfml2-dbg
      * libsfml2-doc
      * sfml2-examples

      * python-sfml2
      * python3-sfml2
      * python-sfml2-doc
      * pysfml2-examples

   Once example packages are installed you may want to launch them to 
   see if the library works well with your graphics card. To do that  
   just run the following commands. ::

      sfml2-sound # will run the example 'sound'
      sfml2-shader
      sfml2-x11
      sfml2-voip

      pysfml2-sound # will run the same example but it's actually a python script that uses the binding
      pysfml2-pong
      pysfml2-sockets
      pysfml2-spacial-music # not an official sfml example
      pysfml2-pyqt4         # not an official sfml example 


Fedora
------
No RPM packages are provided yet. They probably will be for the next 
release. Meanwhile you'll have to compile by yourself.

Compilation
-----------

   .. note:: The following instructions only work on the Linux platforms as I use an internal version of setup.py to compile on Windows.

To compile you must have `sfml2-rc <http://openhelbreath.net/python-sfml2/downloads/sfml2-rc.tar.gz>`_ 
and `cython <http://cython.org/>`_ installed on your computer.

Download the source tarball `here <http://openhelbreath.net/python-sfml2/downloads/python-sfml2-1.1.tar.gz>`_. 
Then just type the following for python 2::

   sudo python setup.py install
   
Or this for python 3::

   sudo python3 setup.py install
