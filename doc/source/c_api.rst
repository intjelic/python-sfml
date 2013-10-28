Cython/C API
============
This section explains how to embed or extend Python using the new C/Cython
API.

.. warning::

   This page is under construction but already provides enough information to
   get you started.

.. contents:: :local:

Introduction
------------
The C/Cython API, introduced in version 1.3 was created to allow developers to
seamlessly mix python code with C++ code and vice versa. While it is often more
convenient to write entire programs in a single program language, for one
reason or another, we may have the need or desire to switch languages. For
instance, python's beauty lends itself to writing code such as user interface code,
which would otherwise be tedious to do in C++. Likewise, we might be compelled to
write certain parts of a Python program in C++ in order to yield performance
gains.

How it works
------------
.. note::

    When browsing pySFML's source code, keep in mind that these instances are
    usually named :attr:`p_this`.

The C/Cython API works by allowing you to manipulate pySFML objects and
retrieve their C++ instance.

PySFML is not a pure python library. Rather, it is a set of extensions that
provide a Pythonic API around a C++ library. As such, every PySFML object is
really a wrapped C++ object which can be manipulated through Python methods.


Let's take an example, :class:`.Texture` and its matching C++ class
**sf::Texture**. When you create a :class:`.Texture`::

    texture = sf.Texture()

you actually create two objects, the C++ object, and the Python object that
wraps it. Furthermore, when you call the method :meth:`create`, you are in fact
calling the Python object's create method, which itself is wrapped around the
C++ object's create method::

    texture.create(50, 30)

Now that we know what an instance *is*, we can discuss what can be *done* with them:

    * Embed Python code into C++ application
    * Extend Python code with C++ code

Embedding
----------
Embedding is explained in the official Python documentation in the
section *Extending and Embedding the Python Interpreter*, here:
http://docs.python.org/2/extending/index.html.

Nothing changes except the need to access our C++ instance which
simply requires a type cast. So, assume you just got a reference to
a **PyObject\** which actually is an object from one of the pySFML
bindings. You'll need to cast it into the type you think it is and then
retrieve the internal instance generally named *p_this* but you'll find
that in the API described below (section **API**).

If your instance was a :class:`.Texture`, here would be the code ::

    // Get a typeless texture from Python code using pySFML (sf.Texture)
    PyObject* _texture = getTexture();

    // We need to convert to a typeful Python object
    PyTextureObject *texture = (PyTextureObject*)_texture;

    // Now you can access the C++ instance via the 'p_this' attribute
    sf::Texture* cppTexture = *texture->p_this;

Extending
---------
Again, extending Python is explained in the official Python
documentation in the section *Extending and Embedding the Python
Interpreter*, here: http://docs.python.org/2/extending/index.html.

There's nothing else to explain as the explanations are the same as in
the embedding section but in the other way round. So, instead I'll
teach you how to use Cython to speed up the extension writing using the
**Cython API** provided by pySFML.

Before you start, things should be clear in your head: Cython is a
language on its own. It accepts both syntax: C++ and Python syntax.
Once the code is compiled, it results a Python extension (which is a
standard shared library - almost).

I won't teach you Cython but instead I will give you a working example
which might be the starting point to your Cython learning process as it
comes with explanations.

Let's say you're writing a Python application using SFML and for some
reason, you need to use a library that only exists in C++: Thor library.
The last statement isn't true since Thor library is ported to these
bindings, see `thor.python-sfml.org` for details but let's assume it
isn't. Thor library provides many interesting tools.

We're going to use the BigTexture and BigSprite classes. To do so,
you'll need to write the Thor function you need in a .pxd file. ::

    cdef extern from "Thor/Graphics.hpp" namespace "thor":

        cdef cppclass BigTexture:
            BigTexture()
            bint loadFromImage(Image&)


Write a class that wraps a big texture. ::

    cimport thor

    cdef class BigTexture:
        cdef th.BigTexture *p_this

        def __cinit__(self):
            self.p_this = new th.BigTexture()

        def __dealloc__(self):
            del self.p_this

        @classmethod
        def from_image(cls, Image image):
            cdef BigTexture r = BigTexture.__new__(BigTexture)

            if r.loadFromImage(image.p_this[0]):
                return r

And a function which takes care of declaring a BigSprite, put the
instance inside, then draw using the regular SFML mechanism. ::

    def draw_bigtexture(BigTexture texture, RenderTarget target, RenderStates states):
        target.p_rendertarget.draw((<sf.Drawable*>self.p_this)[0])

C API
-----
TODO: write the sub-section

Cython API
----------
It is customary to declare C/C++ functions in a .pxd file before using them.
In the interest of saving time, following examples use the .pxd files that we
wrote when developing these bindings. For the curious, these .pxd files can be
found in the include/libcpp subdirectory of the source archive.

Once pySFML and Cython are successfully installed, these .pxd files may be
imported as follows ::

    cimport libcpp.sfml

    # an alias might be useful in that case
    cimport libcpp.sfml as sf

To use an existing pySFML class and access its Cython API, import what
you need ::

    from pysfml.system cimport Vector2
    from pysfml.graphics cimport Color, wrap_color


For each class, you'll find a similar API:

.. py:module:: pysfml

.. class:: ClassName

   .. py:attribute:: p_this
   .. py:attribute:: delete_this

.. py:function:: wrap_classname(ClassName* p)

