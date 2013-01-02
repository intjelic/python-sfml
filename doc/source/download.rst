Download
========
Here you'll find all the necessary explainations for installing the binding 
on your favorite platform. Unfortunately the procedures for the **Mac OSX** 
and **Windows 8** are not available yet.

.. contents:: :local:
   :depth: 1
   
Windows
-------
Simply download the correct installer and follow the instructions. 

.. warning::

	You may need to run the following installers in **compatibility mode **
	for Windows XP at least otherwise it will result a **crash during 
	the installation process**. Don't ask me why.
	
	E.g: On Windows 7: Right-click on the executable -> Properties -> 
	Compatibility tab -> Check "Run this program in compability mode for
	-> choose Window XP (Service Pack 3).

* `pySFML-1.2.0.win32-py2.6.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py2.6.exe>`_ [1.6 MB] [Python 2.6] [32 bit]
* `pySFML-1.2.0.win32-py2.7.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py2.7.exe>`_ [1.6 MB] [Python 2.7] [32 bit]
* `pySFML-1.2.0.win32-py3.2.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py3.2.exe>`_ [1.6 MB] [Python 3.2] [32 bit]
* `pySFML-1.2.0.win64-py2.6.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py2.6.exe>`_ [1.6 MB] [Python 2.6] [64 bit]
* `pySFML-1.2.0.win64-py2.7.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py2.7.exe>`_ [1.6 MB] [Python 2.7] [64 bit]
* `pySFML-1.2.0.win64-py3.2.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]

Mac OSX
-------
Packages for Mac OSX couldn't be made since the official sfml2-rc 
installer contains issues. Having a lack of Mac OSX 
knowledges, I couldn't make it work and by consequences was unable to 
test the bindings as well as creating packages for the platform.

That makes this platform unsupported yet. Anyways, if you download the source 
and if you know a bit of Cython, you should be able to compile the 
source but I advise you to wait for the next release which will have 
Mac OSX supported.

Ubuntu
------
Packages are available (for Ubuntu 12.04LTS and 12.10) via launchpad depot, just type ::

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

SFML2 (release candidate)
^^^^^^^^^^^^^^^^^^^^^^^^^

	* `sfml2-rc1 <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]
	* `sfml2-examples <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]
   
Bindings for SFML2
^^^^^^^^^^^^^^^^^^

	* `python-sfml2 <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]
	* `python3-sfml2 <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]
	* `pysfml2-examples <http://openhelbreath.net/python-sfml2/downloads/pySFML2-1.2.0.win64-py3.2.exe>`_ [1.6 MB] [Python 3.2] [64 bit]

See Ubuntu section to know what you can do with the example package.

ArchLinux
---------
Packages are available: https://aur.archlinux.org/packages/python-sfml-git/

Compilation
-----------
The compilation section is split into two sub-sections: one for Unix 
systems and one for Windows. 

But before entering one of them, download the source tarball 
`here <http://python-sfml.org/1.2/downloads/pysfml-1.2.tar.gz>`_.

You'll also need to compile `sfml2-rc <http://python-sfml.org/downloads/sfml2-rc.tar.gz>`_ 
and `cython 17.3 or later <http://cython.org/>`_ installed on your computer.

Unix
^^^^ 
In order to compile you'll need the Python developement files, X11 and 
optionally setuptools module for Python in order to run tests.

* python-dev or python3-dev
* libx11-dev
* python-setuptools or python3-setuptools

Then just type the following for python 2::

   sudo python setup.py install
   
Or this for python 3::

   sudo python3 setup.py install
   
Windows
^^^^^^^
Compiling on Windows requires more steps.

To have binaries fully compatible you should compile with the optimizing 
C/C++ compiler used to build Python for Windows. The SDK can be 
downloaded on the microsoft download center: 
`Windows SDK C/C++ compiler <http://www.microsoft.com/downloads/en/details.aspx?familyid=71DEB800-C591-4F97-A900-BEA146E4FAE1&displaylang=en>`_ 

You need **GRMSDKX_EN_DVD.iso** if you target a **AMD64** Python version. It can build for x86 arch too.

Observe that you don't need Microsoft Visual C++ Express.

If SFML2 isn't compiled yet, procceed. You'll find **libs/** and **include/** in the 
Python directory. Copy the generated libraries in *libs/* folder and 
SFML headers files in *include/*.

It should look like this::

	C:\Python32\libs\sfml-system.lib
	C:\Python32\libs\sfml-window.lib
	...

	C:\Python32\include\SFML\
	C:\Python32\include\SFML\System.hpp
	C:\Python32\include\SFML\Window.hpp
	...
	
Open the SDK command window and type::

	C:\Program Files\Microsoft SDKs\Windows\v7.0>set DISTUTILS_USE_SDK=1
	C:\Program Files\Microsoft SDKs\Windows\v7.0>setenv /x64 /release
	
Adjust according the targetted architecture (x86 or x84) and mode (release or debug).

Then head to the source directory and::

	python setup.py install
	
You'll still need sfml dlls in your source directories unless you copy 
them in the Python Lib directory (*Python32/Lib/site-packages/sfml/sfml-*.dll*)

.. note:: 
	I use an internal version of setup.py to create the available Windows 
	installers in order to to include dlls, so you don't need to compile 
	it when using installers.
