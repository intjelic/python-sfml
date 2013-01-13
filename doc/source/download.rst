Download
========
Here you'll find all the necessary explainations for installing the binding 
on your favorite platform. Unfortunately the procedures for **Mac OSX** 
and **Windows 8** are not yet available.

.. contents:: :local:
   :depth: 1
   
Windows
-------
Simply download the correct installer and follow the instructions. 

.. note:: 

    If you experience issues during installation, try running the installer
    again in compatibility mode:

        1. Right-click the installer and select "Properties"
        2. Navigate to the "Compatibility" tab.
        3. Check "Run this program in compatibility mode for"
        4. Select "Windows XP (Service Pack 3)
	
* `pySFML-1.2.0.win32-py2.6.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py2.6.exe>`_ [Python 2.6] [32 bit]
* `pySFML-1.2.0.win32-py2.7.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py2.7.exe>`_ [Python 2.7] [32 bit]
* `pySFML-1.2.0.win32-py3.2.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win32-py3.2.exe>`_ [Python 3.2] [32 bit]
* `pySFML-1.2.0.win64-py2.6.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py2.6.exe>`_ [Python 2.6] [64 bit]
* `pySFML-1.2.0.win64-py2.7.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py2.7.exe>`_ [Python 2.7] [64 bit]
* `pySFML-1.2.0.win64-py3.2.exe <http://python-sfml.org/1.2/downloads/pySFML-1.2.0.win64-py3.2.exe>`_ [Python 3.2] [64 bit]

Mac OSX
-------
Packages for Mac OSX couldn't be made since the official sfml2-rc 
installer contains issues. 

While official support for Mac OSX is slated for the next release, those eager
should feel free to download the source code and compile manually. 

Ubuntu
------
.. warning::

	For those who used this package repository, note it has been renamed 
	from `sfml` to `sfml-stable`. Please delete the old one and add the 
	new one::
		
		sudo add-apt-repository --remove ppa:sonkun/sfml
		sudo add-apt-repository ppa:sonkun/sfml-stable
		sudo apt-get update
		
Packages are available (for Ubuntu 12.04LTS and 12.10) via launchpad::

   sudo add-apt-repository ppa:sonkun/sfml-stable
   sudo apt-get update
   sudo apt-get install python-sfml
   # or
   sudo apt-get install python3-sfml

.. NOTE::
   The *sonkun/sfml-stable* ppa provides many packages. The library sfml2.0-rc 
   and the binding are included along with their examples. Packages are:

      * libsfml
      * libsfml-dev
      * libsfml-dbg
      * libsfml-doc
      * sfml-examples

      * python-sfml
      * python3-sfml
      * python-sfml-doc
      * pysfml-examples

   Once example packages are installed you may want to launch them to 
   see if the library works well with your graphics card. To do that  
   just run the following commands. ::

      sfml-sound # will run the example 'sound'
      sfml-shader
      sfml-X11
      sfml-voip

      pysfml-sound # will run the same example but it's actually a python script that uses the binding
      pysfml-pong
      pysfml-sockets
      pysfml-spacial-music # not an official sfml example
      pysfml-pyqt4         # not an official sfml example 

Fedora
------
Packages are available `here <http://python-sfml.org/1.2/downloads>`_

See Ubuntu section to know what you can do with the example package.

Arch Linux
----------
Packages are available on the AUR:

    * Python: http://aur.archlinux.org/packages/python-sfml-git/
    * Python2: https://aur.archlinux.org/packages/python2-sfml-git/

Compilation
-----------
Before attempting to compile, it is important that you obtain a copy of the
source code, either from git::

    git clone git://github.com/Sonkun/python-sfml.git

Or as a pre-packaged tarball archive::
    
    wget http://python-sfml.org/1.2/downloads/pysfml-1.2.tar.gz

You'll also need `sfml2-rc`_ and `cython`_ 0.17.3 installed on your computer.

Linux and Mac OSX
^^^^^^^^^^^^^^^^^
In order to compile, you'll need the Python developement files, X11 and 
the setuptools module for Python.

To build the bindings for Python, type::

   python2 setup.py build_ext -i

For Python 3::

   python3 setup.py build_ext -i
   
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

Then head to the source directory and type::

    python setup.py build_ext -i
	
You'll still need sfml dlls in your source directories unless you copy 
them in the Python Lib directory (*Python32/Lib/site-packages/sfml/sfml-*.dll*)

.. note:: 
	I use an internal version of setup.py to create the available Windows 
	installers in order to to include dlls, so you don't need to compile 
	it when using installers.

.. _sfml2-rc: http://python-sfml.org/downloads/sfml2-rc.tar.gz
.. _cython: http://cython.org
