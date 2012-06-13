Introduction
============
This is a non-official binding based on the first release candidate of 
SFML2.

This binding is **complete** as it provides all classes found in SFML and 
all its features. The module is split into five distinct sub-module: system, 
window, graphics, audio and network.

Unlike the official one, this binding provides the network module in 
order to be **exauhstive** altought it is **discouraged** for use since the 
standard python library has already one.

It is supported by **Windows** and **Linux** platforms but should be supported by 
MacOS X very soon. Actually, it should already work but unlike 
the two other platforms, no tests have been performed and no packages, 
installers or installation procedure are provided.

Examples, tutorials and a **complete documentation** come along to help 
you with using pySFML2.

History
-------
This binding was forked from the official python binding created by Bastien 
Léonard 16th of November 2011.

I decided to fork because his project was (and still is) a work in progress and I needed 
some features urgently in order to port my current C++ projects to Python. 
It has since then widely improved and I decided to share my work under 
a new license: GPLv3.

Altought his project was taken as a starting point, months went by, SFML2 
grew up much, and everything has been recoded and re-though from A to Z.

A word about Cython
-------------------
This binding has been coded in Cython, a language that allows you to 
make python extension as easily as Python itself. 

An extension is coded in C or C++ using the Python C API. Unlike a pure 
python module, an extension module may take in its functions/methods a 
precise type and this is something you have to keep in mind, I'm 
explaining:

In normal python code, everywhere you have to provide an argument, 
you'll be able to pass anything. And if your argument is wrong, no 
check will be performed until something goes wrong and your program 
stops running. A python philosophy says: "Python supposes you know what 
a function/methods expect, by consequence, if you pass a wrong 
argument, it means there was an error earlier"

For an extension module, this is not the case and if you pass a 
sf.Transform when a sf.Color is needed, an exception will **straightly be 
raised**. Actually, having a precise type make things much faster as the 
python interpreter doesn't have to check at runtime whether the 
argument type you just passed is right or not.


Contributors
------------
- **Laurent Gomilla** to create SFML2
- **Bastien Léonard** who made me discovered Cython
- **Lewis Ellis** for his wise advice
- **Edwin Marshall** for his relevant comments
- **Richard Sims** who corrected my texts and to provide me a host.

Next version
------------
The next version will be a fix release (as I can't track all bugs 
by myself altought I perfomed many tests) and Mac OSX will be added in the 
platform supported list. Also you'll find packages for Fedora and the 
official platform-specific example should be added as well.
