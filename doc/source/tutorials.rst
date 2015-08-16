.. highlight:: python
   :linenothreshold: 5

.. _tutorials-reference:

Tutorials
=========
Some knowledge is required to help understand the binding from an SFML
background. After reading this tutorial you should be able to start
coding serious projects.

.. note::

   I started to translate the `official tutorials`_ and while there are only a
   few available, they will soon be finished. This page should be replaced with
   this :doc:`future page</future_tutorials>`.

.. contents:: :local:
   :depth: 1


System
------
Vectors
^^^^^^^
To manipulate vectors you use sfml.system.Vector2 or sfml.system.Vector3 and unlike in
C++ they have no specific type. It means you can set a float, an
integer or whatever inside. ::

   vector = sfml.system.Vector3()
   vector.x = 5.56 # set a float
   vector.y = -4 # set an integer
   vector.z = Decimal(0.333333333)
   x, y, z = vector # you can unpack the vector

To manipulate time there's no major difference. Instead of getting
the seconds, milliseconds or microseconds via a method named
*asSomething* you do it via a property ::

   t1 = sfml.milliseconds(500)
   print(t1.seconds)
   print(t1.microseconds)

   clock = sfml.system.Clock()
   print(clock.elapsed_time)
   t2 = clock.restart()

   time = t1 + t2
   time *= t2
   time -= t1

   sfml.sleep(time)

Exception
^^^^^^^^^
.. warning::

   **sf.SFMLException** has been removed and was replaced with standard
   exceptions.

SFML functions that may fail raise exception. If you use one of them and want
to give a specific task in case of failure, you can handle them with a **try...
except** statement. ::

   try:
       # huge texture, will fail for sure
       # (except maybe if you read that in 2075 and if your processor works with light speed)
       texture = sf.Texture.create(987654321, 987654321)
   except ValueError as error:
       print(error) # print the error
       exit(1)      # maybe quit ?

Note that load/open methods raise a traditional :exc:`IOError`::

   try:
      music = sf.Music.from_file("song.ogg")

   except IOError:
      exit(1)

Window
------
Event
^^^^^
The way you handle events in pySFML2 is slightly different from how
you do it in SFML2.

Here, rather than checking that the `type` property matches an event type, you
check that event is an instance of a particular event class. While you could do
this using python's builtin `type` or `isinstance` functions, The Event class
implements rich comparison operators to make things simpler::

   for event in window.events:
      if event == ...: # provide an event class name

Available event classes and their SFML2 equivalents are shown below:

+-------------------------------------------+-----------------------------------+
| pySFML                                    | SFML (C++)                        |
+===========================================+===================================+
| :class:`.CloseEvent`                      | sf::Event::Closed                 |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.ResizeEvent`          | sf::Event::Resized                |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.FocusEvent`           | sf::Event::LostFocus              |
|                                           | sf::Event::GainedFocus            |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.TextEvent`            | sf::Event::TextEntered            |
| :class:`sfml.window.KeyEvent`             | sf::Event::KeyPressed             |
|                                           | sf::Event::KeyReleased            |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.MouseWheelEvent`      | sf::Event::MouseWheelMoved        |
| :class:`sfml.window.MouseButtonEvent`     | sf::Event::MouseButtonPressed     |
|                                           | sf::Event::MouseButtonReleased    |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.MouseMoveEvent`       | sf::Event::MouseMoved             |
| :class:`sfml.window.MouseEvent`           | sf::Event::MouseEntered           |
|                                           | sf::Event::MouseLeft              |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.JoystickButtonEvent`  | sf::Event::JoystickButtonPressed  |
|                                           | sf::Event::JoystickButtonReleased |
+-------------------------------------------+-----------------------------------+
| :class:`sfml.window.JoystickMoveEvent`    | sf::Event::JoystickMoved          |
| :class:`sfml.window.JoystickConnectEvent` | sf::Event::JoystickConnected      |
|                                           | sf::Event::JoystickDisconnected   |
+-------------------------------------------+-----------------------------------+

Once you know the type of the event you can get the data inside.::

   if event == sf.MouseMoveEvent:
       x, y = event.position

For events like :class:`.KeyEvent`, :class:`.MouseButtonEvent`, etc. which can have
two "states", you'll have to check it via their properties.::

   if event == sf.KeyEvent:
       if event.pressed:
           ...
       elif event.released:
           ...

   if event == sf.KeyEvent and event.pressed:
       ...

   if event == sf.FocusEvent:
       if event.gained:
           ...
       if event.lost:
           ...

Read the :class:`.Window` class description for information about events.


Graphics
--------
Rectangle
^^^^^^^^^
Although unpacking a rectangle will give you four integers/floats
(respectively its left, its top, its width and its height) its
constructor takes two :class:`.Vector2` or tuple; its position and its
size. ::

   rectangle = mytext.local_bounds
   left, top, width, height = rectangle

::

   position, size = sf.Vector2(5, 10), sf.Vector2(150, 160)
   rectangle = sf.Rect(position, size)


This has been implemented as such because you may want to create a
rectangle at any time and the variable you have in hand can either be
four variables representing the top, the left, the width or two
variables representing the position and the size. In both cases you can
create a rectangle in one line! ::

   left, top, width, height = 5, 10, 150, 160
   rectangle = sf.Rect((left, top), (width, height))
   # or the ugly and verbose alternative
   rectangle = sf.Rect(sf.Vector2(left, top), sf.Vector2(width, height))

::

   position, size = (5, 10), (150, 160)
   rectangle = sf.Rect(position, size)

Making the rectangle require four numeric values in its constructor
would have involved writing more lines if you had only a position and a
size in hand ::

    x, y = position
    w, h = size
    rectangle = sf.Rect(x, y, w, h)


Drawable
^^^^^^^^
To create your own drawable just inherit your class from
:class:`.Drawable`. ::

   class MyDrawable(sf.Drawable):
       def __init__(self):
           sf.Drawable.__init__(self)

       def draw(self, target, states):
           target.draw(body)
           target.draw(clothes)

To have a **transformable drawable** you have two implementation choices. As
Like SFML in C++, you can either use a transformable internally and combine
your transformable at drawing time **or** inherit your drawable from
both :class:`.Drawable` and :class:`.Transformable`.

1) **sf.Transformable in an internal attribute**

   This consist of having a transformable in an attribute and combine
   with the states at drawing time. ::

      class MyDrawable(sf.Drawable):
          def __init__(self):
              sf.Drawable.__init__(self)
              self._transformable = sf.Transformable()

          def draw(self, target, states):
              states.transform.combine(self._transformable.transform)

              target.draw(body)
              target.draw(clothes)

          def _get_position(self):
              return self._transfomable.position

          def _set_position(self, position):
              self._transformable.position = position

          position = property(_get_position, _set_position)

   Only the position property has been implemented in this example but you
   can also implement **rotation**, **scale**, **origin**.


2) **Inheriting from sf.Drawable and sf.Transformable**

   There's a current issue concerning this way to do. As Python doesn't
   allow you to subclass from two built-in types at the same time, you
   can't technically do it. That's why pySFML2 provides :class:`.TransformableDrawable`
   which is both an :class:`.Drawable` and :class:`.Transformable`.
   That way your class inherits from properties such `position`, `rotation`
   etc and their methods `move()`, `rotate()` etc. ::

      class MyDrawable(sf.TransformableDrawable):
          def __init__(self):
              sf.Drawable.__init__(self)

          def draw(self, target, states):
              states.transform.combine(self.transformable.transform)
              target.draw(body)
              target.draw(clothes)

      mydrawable = MyDrawable()
      mydrawable.position = (20, 30) # we have properties \o/

HandledWindow
^^^^^^^^^^^^^
This extra class allows you to have a window handled by an external API
such as PyQt4. This class is pretty straight forward and you should just
follow the cookbook for integrating.

.. warning::

   This class exists because of an issue with constructors. I still need to
   justify it or figure out how I can replace it.

Audio
-----
Using the audio module should be very simple since there's no
differences with the original API. Just note that the class
:class:`.Chunk` allows you to manipulate an array of sf::Int16 which
represents the audio samples. So far this class is pretty basic and
offers access to each sample via the operator [] and you can get
the data in a `string` for Python 2 or in `bytes` for Python 3 via
:attr:`.Chunk.data`.


Socket
------
There's no systematic STATUS to check. When something goes wrong an
error is raised and you just have to handle it. ::

   try:
       socket.send(b'hello world')

   except sf.SocketError:
       socket.close()
       exit(1)


Miscellaneous & Tricks
----------------------

Once you know pySFML well you may be interested in knowing some
tricks.

Unpacking
^^^^^^^^^
Many classes are unpackable

.. code-block:: python
   :linenos:

	x, y = sf.Vector2(5, 10)
	x, y, z = sf.Vector3(5, 10, 15)

	size, bpp = sf.VideoMode(640, 480, 32)
	depth_bits, stencil_bits, antialiasing, minor_version, major_version = sf.ContextSettings()

	r, g, b, a = sf.Color.CYAN
	left, top, width, height = sf.Rect((5, 10), (15, 20))

If you need to discard a value, use _ ::

   # I'm not interested in the alpha value
   r, g, b, _ = get_color()

sfml.Image.show()
^^^^^^^^^^^^^^^^^

For debugging purpose pySFML provides a show() function. This allows
you to see how an image will look after modification. This is to be
sure all operations made on the picture were effective.

.. code-block:: python
   :linenos:

   image = sf.Image.from_image("image.png")
   image.create_mask_from_color(sf.Color.BLUE)
   image.show()

   texture = sf.Texture.from_image(image)
   texture.update(window, (50, 60))
   texture.to_image().show()

Attach an icon to a Window
^^^^^^^^^^^^^^^^^^^^^^^^^^

Easily attach an icon to your window ::

	icon = sf.Image.from_file("data/icon.bmp")
	window.icon = icon.pixels

.. _official tutorials: http://www.sfml-dev.org/tutorials/2.0/
