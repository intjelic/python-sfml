Download
========
Here you'll find all the necessary explanations for installing these bindings
on your favourite platform. Unfortunately the procedures for **Mac OSX**
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

* `pySFML-2.1.0.win32-py2.7.exe <http://python-sfml.org/2.1/downloads/pySFML-2.1.0.win32-py2.7.exe>`_ [Python 2.7] [32 bit]
* `pySFML-2.1.0.win32-py3.4.exe <http://python-sfml.org/2.1/downloads/pySFML-2.1.0.win32-py3.4.exe>`_ [Python 3.4] [32 bit]
* `pySFML-2.1.0.win64-py2.7.exe <http://python-sfml.org/2.1/downloads/pySFML-2.1.0.win64-py2.7.exe>`_ [Python 2.7] [64 bit]
* `pySFML-2.1.0.win64-py3.4.exe <http://python-sfml.org/2.1/downloads/pySFML-2.1.0.win64-py3.4.exe>`_ [Python 3.4] [64 bit]

Mac OSX
-------
While official support for Mac OSX is slated for the next release, those eager
should feel free to download the source code and compile manually.

For example, through pip (don't forget to have cython 0.20 and SFML 2.1
installed and as mentioned below): ::

   pip install git+git://github.com/Sonkun/python-sfml.git


Ubuntu
------
Packages are available for Ubuntu starting from 14.04 or greater via launchpad::

   sudo add-apt-repository ppa:sfml/stable
   sudo apt-get update
   sudo apt-get install python-sfml
   # or
   sudo apt-get install python3-sfml

Want the development version to benefit the latest bug fixes or features ?
Use `ppa:sfml/development` repository, daily builds are available.

.. note::
   These repositories provide many packages. The library SFML
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
Packages are available `here <http://python-sfml.org/2.1/downloads>`_

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

You'll also need `SFML`_ 2.1 and `Cython`_ 0.20 installed on your computer.

Linux and Mac OSX
^^^^^^^^^^^^^^^^^
In order to compile, you'll need the Python development files.

To build the bindings for Python, type::

   python2 setup.py install
   python3 setup.py install

Windows
^^^^^^^
Compiling on Windows requires more steps.

To have binaries fully compatible you should compile with the optimizing
C/C++ compiler used to build Python for Windows. The SDK can be
downloaded on the Microsoft download center:

For Python 2.7 until 3.2: `Windows SDK 7.0 <http://www.microsoft.com/en-us/download/details.aspx?id=18950>`_

For Python 3.3 and later: `Windows SDK 7.1 <http://www.microsoft.com/en-us/download/details.aspx?id=8442>`_

.. note::

   If you planned to compile for both version (and thus install both SDKs (7.0 and 7.1),
   dont't install redistributable packages otherwise you'll run accross an installation
   failure when installing the second SDK. To do that, uncheck "Microsoft Visual C++ 2010"
   case.

You need **GRMSDKX_EN_DVD.iso** if you target a **AMD64** Python version. It
can build for x86 arch too.

Observe that you don't need Microsoft Visual C++ Express.

Open the SDK command window and type::

	C:\Program Files\Microsoft SDKs\Windows\v7.0>set DISTUTILS_USE_SDK=1
	C:\Program Files\Microsoft SDKs\Windows\v7.0>setenv /x64 /release

Adjust according the targeted architecture (x86 or x84) and mode (release or debug).

Then head to the source directory and type::

    python setup.py install

It you want to create an installer, simply type::

	python setup.py bdist_msi

.. _SFML: http://python-sfml.org/downloads/sfml-2.1.0.tar.gz
.. _cython: http://cython.org
