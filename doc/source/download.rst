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

* `pySFML-1.3.0.win32-py2.7.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win32-py2.7.exe>`_ [Python 2.7] [32 bit]
* `pySFML-1.3.0.win32-py3.2.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win32-py3.2.exe>`_ [Python 3.2] [32 bit]
* `pySFML-1.3.0.win32-py3.3.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win32-py3.3.exe>`_ [Python 3.3] [32 bit]
* `pySFML-1.3.0.win64-py2.7.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win64-py2.7.exe>`_ [Python 2.7] [64 bit]
* `pySFML-1.3.0.win64-py3.2.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win64-py3.2.exe>`_ [Python 3.2] [64 bit]
* `pySFML-1.3.0.win64-py3.3.exe <http://python-sfml.org/1.3/downloads/pySFML-1.3.0.win64-py3.3.exe>`_ [Python 3.3] [64 bit]

Mac OSX
-------
While official support for Mac OSX is slated for the next release, those eager
should feel free to download the source code and compile manually.

For example, through pip (don't forget to have cython 0.19 and SFML 2.0
installed and as mentioned below): ::

   pip install git+git://github.com/Sonkun/python-sfml.git


Ubuntu
------
Packages are available (for Ubuntu 12.04LTS, 12.10 & 13.04LTS) via launchpad::

   sudo add-apt-repository ppa:sonkun/sfml-stable
   sudo apt-get update
   sudo apt-get install python-sfml
   # or
   sudo apt-get install python3-sfml

Want the development version ? Use `ppa:sonkun/sfml-development` repository.

.. note::
   The *sonkun/sfml-stable* ppa provides many packages. The library SFML
   and the bindings are included along with their examples. Packages are:

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
      pysfml-spacial-music
      pysfml-pyqt4

Fedora
------
Packages are available `here <http://python-sfml.org/1.3/downloads>`_

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

You'll also need `SFML`_ and `Cython`_ 0.19 installed on your computer.

Linux and Mac OSX
^^^^^^^^^^^^^^^^^
In order to compile, you'll need the Python developement files.

To build the bindings for Python, type::

   python2 setup.py install
   python3 setup.py install

Windows
^^^^^^^
Compiling on Windows requires more steps.

To have binaries fully compatible you should compile with the optimizing
C/C++ compiler used to build Python for Windows. The SDK can be
downloaded on the microsoft download center:

For Python 2.7 & 3.2: `Windows SDK 7.0 <http://www.microsoft.com/en-us/download/details.aspx?id=18950>`_

For Python 3.3: `Windows SDK 7.1 <http://www.microsoft.com/en-us/download/details.aspx?id=8442>`_

You need **GRMSDKX_EN_DVD.iso** if you target a **AMD64** Python version. It
can build for x86 arch too.

Observe that you don't need Microsoft Visual C++ Express.

If SFML headers and libraries aren't installed in the respective compilers, do
it now. It would look like: ::

   C:\Porgram Files (x86)\Microsoft Visual Studio 9\VC\include\SFML
   C:\Porgram Files (x86)\Microsoft Visual Studio 9\VC\lib\sfml-system-2.lib
   C:\Porgram Files (x86)\Microsoft Visual Studio 9\VC\lib\sfml-window-2.lib
   ...

Open the SDK command window and type::

	C:\Program Files\Microsoft SDKs\Windows\v7.0>set DISTUTILS_USE_SDK=1
	C:\Program Files\Microsoft SDKs\Windows\v7.0>setenv /x64 /release

Adjust according the targetted architecture (x86 or x84) and mode (release or debug).

Then head to the source directory and type::

    python setup.py install

You'll still need sfml DLLs in your source directories unless you copy
them in the Python Lib directory: `/PythonXY/Lib/site-packages/sfml/sfml-*.dll`

.. note::
	I use an internal version of setup.py to create the available Windows
	installers in order to to include DLLs, so you don't need to compile
	it when using installers.

.. _SFML: http://python-sfml.org/downloads/sfml-2.0.0.tar.gz
.. _cython: http://cython.org
