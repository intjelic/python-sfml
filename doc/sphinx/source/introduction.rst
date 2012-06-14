Introduction
============
This is a non-official binding based on the first release candidate of 
SFML2.

This binding is **complete** as it provides all classes found in SFML and 
all its features. The module is split into five distinct sub-modules: system, 
window, graphics, audio and network.

Unlike the official one this binding provides the network module in 
order to be **exauhstive** altought its use is **discouraged** since the 
standard python library has already has one.

At the moment it is only supported on **Windows** and **Linux** platforms, but should be supported by 
MacOS X very soon. Actually, it should already work but unlike 
the two other platforms no tests have been performed and no packages, 
installers or installation procedure are provided.

Examples, tutorials and **complete documentation** come along to help 
you with using pySFML2.

History
-------
This binding was forked from the official python binding created by Bastien 
Léonard 16th of November 2011.

I decided to fork because his project was (and still is) a work in progress and I urgently needed 
some features in order to port my current C++ projects to Python. 
Since then, it has widely improved and I have decided to share my work under 
a new license: GPLv3.

Altought his project was taken as a starting point months went by, SFML2 
grew up much, and everything was recoded and re-thoughf from A to Z.

A word about Cython
-------------------
This binding has been coded in Cython, a language that allows you to 
make extending python as easy as Python itself. 

An extension is coded in C or C++ using the Python C API. Unlike a pure 
python module, an extension module may take in its functions/methods a 
precise type and this is something you have to keep in mind, I'm 
explaining:

In normal python code you'll be able to pass anything everywhere you 
have to provide an argument. If your argument is wrong no 
check will be performed until something goes wrong and your program 
stops running. A python philosophy says: "Python supposes you know what 
a function/methods expects. By consequence, if you pass a wrong 
argument, it means there was an error earlier"

For an extension module this is not the case and if you pass a 
sf.Transform when a sf.Color is needed an exception will **be 
raised**. Actually, having a precise type makes things much faster as the 
python interpreter doesn't have to check whether the 
argument type you just passed is right or not at runtime.


Contributors
------------
- **Laurent Gomilla** for creating SFML2
- **Bastien Léonard** who helped me discover Cython
- **Lewis Ellis** for his wise advice
- **Edwin Marshall** for his relevant comments
- **Richard Sims** who corrected my text and provided hosting.

Next version
------------
The next version will be a fix release as I can't track all bugs 
by myself, despite performing many tests. Also Mac OSX will be added in the 
platform supported list. Also you'll find packages for Fedora and the 
official platform-specific example should be added as well.
