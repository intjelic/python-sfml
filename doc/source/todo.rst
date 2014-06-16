TODO list
=========

While this is the first version of pySFML based on an *official* release of
SFML, it is still incomplete. While the bindings are *feature* complete, and
the external interface is stable (i.e. not likely to change), there is yet some
optimizations we can do to the implementation itself. Furthermore, the newly
introduced C/Cython API can be improved to make life easier for extension
authors.

Furthermore, some supplemental documentation such as tutorials and how-to guides are
incomplete, and we'd like to expand unit test coverage.

Please read further to see which action items are highest on our agenda.

Justifying the differences
^^^^^^^^^^^^^^^^^^^^^^^^^^
We want to provide a comprehensive list of all the differences between the
original API and these Python bindings API. As Python isn't C++, language
differences make it impossible to duplicate the C++ API in some  cases, and
impractical in others We'd like to provide a document justifying all these differences.


Some unit tests still need to be implemented
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Only unit tests for the system module are so far implemented.

Object representation
^^^^^^^^^^^^^^^^^^^^^
What should be printed out when typing `print(object)` (with object being an
SFML object).

Enumeration
^^^^^^^^^^^
So far, a C++ enumeration is translated to a set of Python integer constants.
However, while porting Thor, we noticed some issues with this approach. A Thor
action (thor::Action) can be created from these enumerations but since they are
integer constants, we are unable to determine from which C++ enumeration they
came from; the type information has been lost.

Any solution to this will only affect the implementation and not the interface,
so users need not worry.

Add information about copyable classes to the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How do people find out if one object is copyable via the copy module or not ?
Currently you can't find that in the documentation.

String conversion handling
^^^^^^^^^^^^^^^^^^^^^^^^^^
To have the same interface in both Python2 and Python3, I used a Cython trick but now
there seems to have support for that in newer Cython version. I need to find
out the best code (and maybe the fastest) for this task.

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


