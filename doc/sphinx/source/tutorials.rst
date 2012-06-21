.. highlight:: python
   :linenothreshold: 1

.. _tutorials-reference:

Tutorials
=========
Some knowledge is required to help understand the binding from an SFML2 
background. After reading this tutorial you should be able to start 
coding serious projects.

.. contents:: :local:

System
------
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
   
   
Event
-----
The way you handle events in pySFML2 is slightly different from how 
you do it in SFML2 or the official binding.

Here, rather than checking that the `type` property matches an event type, you
check that event is an instance of a particular event class. While you could do
this using python's builtin `type` or `isinstance` functions, The Event class
implements rich comparison operators to make things simpler::

  for event in window.events:
      if event == ...: # provide an event class name

Available event classes and their pysfml2-cython equivalents are shown below:

========================= ===================================
python-sfml2              pysfml2-cython                     
========================= ===================================
sfml.CloseEvent           sfml.Event.CLOSED
sfml.ResizeEvent          sfml.Event.RESIZED
sfml.FocusEvent           sfml.Event.LOST_FOCUS
                          sfml.Event.GAINED_FOCUS
sfml.TextEvent            sfml.Event.TEXT_ENTERED
sfml.KeyEvent             sfml.Event.KEY_PRESSED
                          sfml.Event.KEY_RELEASED
sfml.MouseWheelEvent      sfml.Event.MOUSE_WHEEL_MOVED
sfml.MouseButtonEvent     sfml.Event.MOUSE_BUTTON_PRESSED
                          sfml.Event.MOUSE_BUTTON_RELEASED
sfml.MouseMoveEvent       sfml.Event.MOUSE_MOVED
sfml.MouseEvent           sfml.Event.MOUSE_ENTERED   
                          sfml.Event.MOUSE_LEFT
sfml.JoystickButtonEvent  sfml.Event.JOYSTICK_BUTTON_PRESSED
                          sfml.Event.JOYSTICK_BUTTON_RELEASED
sfml.JoystickMoveEvent    sfml.Event.JOYSTICK_MOVED
sfml.JoystickConnectEvent sfml.Event.JOYSTICK_CONNECTED
                          sfml.Event.JOYSTICK_DISCONNECTED
========================= ===================================

Once you know the type of the event you can get the data inside.::

   if event == sfml.window.MouseMoveEvent:
       x, y = event.position

For events like sfml.window.KeyEvent, sfml.window.MouseButtonEvent, etc. which can have 
two "states", you'll have to check it via their properties.::

   if event == sfml.window.KeyEvent:
       if event.pressed: 
           ...
       elif event.released: 
           ...

   if event == sfml.window.KeyEvent and event.pressed:
       ...
       
   if event == sfml.window.FocusEvent:
       if event.gained: 
           ...
       if event.lost: 
           ...

Read the :doc:`documentation/window` for information about events.

Exception
---------
There's a main exception defined for all pySFML2 methods/functions that 
may fail: `sfml.system.SFMLException`. If you use one of these method and if you 
want to do a specific task in case of failure, you can handle them 

with a **try... except** statement. ::

   try:
       # huge texture, will fail for sure 
       # (except maybe if you read that in 2075 and if your processor works with light speed)
       texture = sfml.graphics.Texture.create(987654321, 987654321)
   except sfml.system.SFMLException as error:
       print(error) # print the error
       exit(1) # maybe quit ?
       
Note that load/open methods DO NOT raise a :exc:`sfml.system.SFMLException` but a 
traditional **IOError**::

   try: music = sfml.audio.Music.open_from_file("song.ogg")
   except IOError: exit(1)


Rectangle
---------
Although unpacking a rectangle will give you four integers/floats 
(respectively its left, its top, its width and its height) its 
constructor takes two :class:`sfml.system.Vector2`; its position and its size. ::

   rectangle = mytext.local_bounds
   left, top, width, height = rectangle
   
::
   
   position, size = sfml.system.Vector2(5, 10), sfml.system.Vector2(150, 160)
   rectangle = sfml.graphics.Rectangle(position, size)
   

This has been implemented as such because you may want to create a 
rectangle at any time and the variable you have in hand can either be 
four variables representing the top, the left, the width or two 
variables representing the position and the size. In both cases you can 
create a rectangle in one line! ::

   left, top, width, height = 5, 10, 150, 160
   rectangle = sfml.graphics.Rectangle((left, top), (width, height))
   # or
   rectangle = sfml.graphics.Rectangle(sfml.system.Vector2(left, top), sfml.system.Vector2(width, height))
   
::

   position, size = (5, 10), (150, 160)
   rectangle = sfml.graphics.Rectangle(position, size)
   
Making the rectangle require four numeric values in its constructor 
would have involved writing more lines if you had only a position and a 
size in hand ::

    x, y = position
    w, h = size
    rectangle = sfml.graphics.Rectangle(x, y, w, h) # two more lines for that... BAD
    

Drawable
--------
To create your own drawable just inherit a class from 
:class:`sfml.graphics.Drawable`. ::

   class MyDrawable(sfml.graphics.Drawable):
       def __init__(self):
           sfml.graphics.Drawable.__init__(self)
           
       def draw(self, target, states):
           target.draw(body)
           target.draw(clothes)
           
As Python doesn't allow you to subclass from two built-in types at the 
same time, pySFML2 provides `sfml.graphics.TransformableDrawable` which is both 
an :class:`sfml.graphics.Drawable` and :class:`sfml.graphics.Transformable`. That way your 
class inherits from properties such `position`, `rotation` etc and their 
methods `move()`, `rotate()` etc. ::

   class MyDrawable(sfml.graphics.TransformableDrawable):
       def __init__(self):
           sfml.graphics.Drawable.__init__(self)
           
       def draw(self, target, states):
           target.draw(body)
           target.draw(clothes)

   mydrawable = MyDrawable()
   mydrawable.position = (20, 30) # we have properties \o/
   
.. note::
   You can choose between inheriting from sfml.graphics.TransformableDrawable and 
   having an :class:`sfml.graphics.Transformable` in its internal attribute, and 
   just before drawing, combine the transformable with the current 
   state ::
      
      states.transform.combine(self.transformable.transform)
      target.draw(body, states)
      
Audio
-----
Using the audio module should be very simple since there's no 
differences with the original API. Just note that the class 
:class:`Chunk` allows you to manipulate an array of sf::Int16 which 
represents the audio samples. So far this class is pretty basic and 
offers access to each sample via the operator [] and you can get 
the data in a `string` for Python 2 or in `bytes` for Python 3 via 
:attr:`sfml.audio.Chunk.data`.

HandledWindow
-------------
This extra class allows you to have a window handled by an external API 
such as PyQt4. This class is pretty straight forward and you should just 
follow the cookbook for integrating.

Socket
------
There's no systematic STATUS to check. When something goes wrong an 
error is raised and you just have to handle it. ::

   try:
       socket.send(b'hello world')
       
   except sfml.network.SocketError:
       socket.close()
       exit(1)
