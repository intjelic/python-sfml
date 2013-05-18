.. warning::

   Page under construction...

Cython/C API
============
This section is new and will explain how to embed or extend Python
using the C/Cython API.

.. contents:: :local:

Introduction
------------
The C/Cython API has been introduced in version 1.3, the first release
entirely based on the final release of SFML 2.0.

When building large software/games, that's often good to mix two or three
languages to solve specific problems with what they've been designed
for. A common case is the graphical user interface. Each game needs an
interface but we all know C and C++ aren't very flexible when using
callbacks. Also, if later you want your interface to be customizable,
it will be more pain in the ass. Why not letting Python take care of
this, and still use the SFML. And in the other way round, why not using
C++ to optimize some part of our Python code. This section is all about
that, mixing Python and C++.

The C/Cython API allows to manipulate pySFML objects and retrieve their
C++ instance.

How it works
------------
So, what's a C++ instance ? You have to keep in mind that pySFML isn't
a Python re-implementation of SFML but instead wrap the actual
implementation to provide a Python library. Therefore, every class
you meet wraps a C++ object and manipulate it trought its methods.

Let's take an example, :class:`.Texture` and its matching C++ class
**sf::Texture**. When you create a :class:`.Texture`::

    texture = sf.Texture()

you actually create two objects, the C++ object, and a Python object.
When you call its method :meth:`create`, you call the Python object's
create method which itself call the create method from the C++ object. ::

    texture.create(50, 30)

These instance are usually named **p_this**, remember it because you'll
see it later in code.

Now, we have now two possibilities:

    * Embed Python code into C++ application
    * Extend Python code with C++ code

Embedding
----------
Embedding is explained in the official Python documentation in the
section *Extending and Embedding the Python Interpreter*, here:
http://docs.python.org/2/extending/index.html.

Nothing changes except the need to access to our C++ instance which
simply requires a type cast. So, assume you just got a reference to
a **PyObject\*** which actually is an object from one of the pySFML
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

There's nothing else to explain as the explainations are the same as in
the embedding section but in the other way round. So, instead I'll
teach you how to use Cython to speed up the extension writing using the
**Cython API** provided by pySFML.

Before you start, things should be clear in your head: Cython is a
language on its own. It accepts both syntax: C++ and Python syntax.
Once the code is compiled, it results a Python extension (which is a
standard shared library - almost).

I won't teach you Cython but instead I will give you a working example
which might be the starting point to your Cython learning process as it
comes with explainations.

Let's say you're writing a Python application using SFML and for some
reason, you need to use a library that only exists in C++: Thor library.
The last statement isn't true since Thor library is ported to these
bindings, see `thor.python-sfml.org` for details but let's assume it
isn't. Thor library provides many interesting tools.

We're going to use the BigTexture and BigSprite classes. To do so,
you'll need to write the Thor funciton you need in a .pxd file. ::

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
You're meant to declare C/C++ functions in a .pxd file before using
them but of course, to write these bindings, we had to write them too
so... why not reusing them ?

We provide them and can be imported in your code with the following: ::

    cimport libcpp.sfml

    # an alias might be useful in that case
    cimport libcpp.sfml as sf

To use an existing pySFML class and access its Cython API, import what
you need: ::

    from pysfml.system cimport Vector2
    from pysfml.graphics cimport Color, wrap_color


The API:
^^^^^^^^

.. py:module:: pysfml

.. class:: ClassName

   .. py:attribute:: p_this
   .. py:attribute:: delete_this

.. py:function:: wrap_classname(ClassName* p)

+-----------------------------+-----+-----+-----+
| Class                       | Cla | Del | Wra |
+-----------------------------+-----+-----+-----+
| sfml.system.Time            | Yes | No  | Yes |
+-----------------------------+-----+-----+-----+
| sfml.system.Vector2         | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.system.Vector3         | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.window.VideoMode       | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.window.ContextSettings | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.window.Pixels          | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.window.Event           | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
| sfml.window.Window          | Yes | Yes | Yes |
+-----------------------------+-----+-----+-----+
