TODO list
=========

Altough this is the **first** version of pySFML enterely based on SFML2 (the
final version), it isn't the perfect version I want because there are still
remaining minor tasks.

While all its functionnalities are present with *an interface that
won't change*, the internal implementation can still be improved to provide
a better C/Cython API as well as other minor
things. See :doc:`C/Cython section</c_api>`.

Also, only some part of the documentation hasn't yet been revised (though,
95% should be correct) and most of the unit tests are still need to be
implemented.

Justying the differences
^^^^^^^^^^^^^^^^^^^^^^^^
I want to provide a comprehensive list of all the differences between the
original API and these Python bindings API. As Python isn't C++, the design
can't be exactly the same because of languages differences or philosophy. I'd
like to provide a document justifying all these differences.


Some unit tests still need to be implemented
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Only unit tests for the system moduel are so far implemented.

Object representation
^^^^^^^^^^^^^^^^^^^^^
What should be printed out when typing `print(object)` (with object being a
SFML object).

Enumeration
^^^^^^^^^^^
So far, a C++ enumeration is translated to a set of Python integer constants
but while I was porting Thor I noticed we're having a issue with that. A Thor
action (thor::Action) can be created from these enumeration but as it has
become integer constants we can't know from what C++ enumeration they are from;
an information is lost.

This only regards the implementation, not the interface, so don't worry, I'm
just considering subclassing the integer type.

Add information about copyable classes to the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How do people find out if one object is copyable via the copy module or not ?
Currently you can't find that in the documentation.

String conversion handling
^^^^^^^^^^^^^^^^^^^^^^^^^^
To have the same interface in both Python2 and Python3, I used a trick but now
there seems to have support for that in newer Cython version. I need to find
out the best code for that.

sf.Text constructor
^^^^^^^^^^^^^^^^^^^
I remember it was a mess when implementing this constructor.

How well the bindings work on Python3.3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Meantime a new release of Python is out (Python 3.3) which re-introduces
unicode string. I need to check if it runs fine (string/unicode/bytes coercion).

Consider using C++ smart pointer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Instead of maintaining a boolean to know if we can destroy the object or if it
is shared.

Use const keyword
^^^^^^^^^^^^^^^^^
The latest Cython version support const keyword in its language, I should make
use of it.

Lack of information about operator in the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I noticed that.

SocketSelector, Ftp and Http still need to be implemented
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pass

Remove import__module__name() in C++ code
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I need to find out how to use them properly instead of redeclaring them
everywhere I had a crash.


