.. _tutorials-reference:

Tutorials
=========
A few knowledge is required to aprehend the binding from a SFML2 
background. After reading this tutorial, you should be able to start 
coding serious project.

.. contents:: :local:

System
------
To manipulate vectors, you use sf.Vector2 or sf.Vector3 and unlike in 
C++ they have no specific type. It means you can set a float, an 
integer or whatever inside. ::

   vector = sf.Vector3()
   vector.x = 5.56 # set a float
   vector.y = -4 # set an integer
   vector.z = Decimal(0.333333333)
   x, y, z = vector # you can unpack the vector
   
To manipulate time, there's no major difference. Instead of getting 
the seconds, milliseconds or microseconds via a method named 
*asSomething*, you do it via a property ::

   t1 = sf.milliseconds(500)
   print(t1.seconds)
   print(t1.microseconds)
   
   clock = sf.Clock()
   print(clock.elapsed_time)
   t2 = clock.restart()
   
   time = t1 + t2
   time *= t2
   time -= t1
   
   sf.sleep(time)
   
Events
------
The way you handle events in pySFML2 is far different from how 
you do it in SFML2 or even from how you do it in the official binding.

Here, instead of having a property type, you must check it with the 
integrated function `type`  ::

   for event in window.events:
       if type(event) is ...: # do something

Checking the type that way will return the event class. You can compare 
it to the 12 events that pySFML2 define.::

   sf.Event
   + sf.CloseEvent
   + sf.ResizeEvent
   + sf.FocusEvent
   + sf.TextEvent
   + sf.KeyEvent
   + sf.MouseWheelEvent	
   + sf.MouseButtonEvent 
   + sf.MouseMoveEvent
   + sf.MouseEvent
   + sf.JoystickButtonEvent
   + sf.JoystickMoveEvent
   + sf.JoystickConnectEvent

Once you know the type of the event, you can get the data inside.::

   if type(event) is sf.MouseMoveEvent:
       x, y = event.position

For events like sf.KeyEvent, sf.MouseButtonEvent, etc which can have 
two "states", you'll have to check it via their properties.::

   if type(event) is sf.KeyEvent:
       if event.pressed: ...
       if event.released: ...

   if type(event) is sf.KeyEvent and event.pressed:
       ...
       
   if type(event) is sf.FocusEvent:
       if event.gained: ...
       if event.lost: ...

Look up the doc to know more about events.

Exception
---------
There's a main exception defined for all pySFML2 methods/functions that 
may fail: `sf.SFMLException`. If you use one of these method and if you 
want to do a specific job in case they really fail, you can handle them 

with a **try... except** statement. ::

   try:
       # huge texture, will fail for sure 
       # (except maybe if you read that in 2075 and if your processor works with light speed)
       texture = sf.Texture.create(987654321, 987654321)
   except sf.SFMLException as error:
       print(error) # print the error
       exit(1) # maybe quit ?
       
Note that load/open methods DO NOT raise a :exc:`sf.SFMLException` but a 
traditional **IOError**::

   try: music = sf.Music.open_from_file("song.ogg")
   except IOError: exit(1)


Rectangle
---------
Altought unpacking a rectangle will give you four integer/float 
(respectively its left, its top, its width and its height), its 
constructor takes two :class:`sf.Vector2`; its position and its size. ::

   rectangle = mytext.local_bounds
   left, top, width, height = rectangle
   
::
   
   position, size = sf.Vector2(5, 10), sf.Vector2(150, 160)
   rectangle = sf.Rectangle(position, size)
   

This has been implemented like that because you may want to create a 
rectangle at any time and the variable you have in hand can be either 
four variables representing the top, the left, the width or two 
variables representing the position and the size. In both case you can 
create a rectangle in one line! ::

   left, top, width, height = 5, 10, 150, 160
   rectangle = sf.Rectangle((left, top), (width, height))
   # or
   rectangle = sf.Rectangle(sf.Vector2(left, top), sf.Vector2(width, height))
   
::

   position, size = (5, 10), (150, 160)
   rectangle = sf.Rectangle(position, size)
   
Making the rectangle to require four numeric values in its constructor 
would have involved more lines to write if you had only a position and a 
size in hand ::

    x, y = position
    w, h = size
    rectangle = sf.Rectangle(x, y, w, h) # two more lines for that... BAD
    

Drawable
--------
To create your own drawable, just inherit a class from 
:class:`sf.Drawable`. ::

   class MyDrawable(sf.Drawable):
       def __init__(self):
           sf.Drawable.__init__(self)
           
       def draw(self, target, states):
           target.draw(body)
           target.draw(clothes)
           
As Python does not allow to subclass from two built-in types at the 
same time, pySFML2 provides `sf.TransformableDrawable` which is both 
a :class:`sf.Drawable` and :class:`sf.Transformable`. That way, your 
class inherit from properties such `position`, `rotation`, etc and their 
methods `move()`, `rotate()`, etc. ::

   class MyDrawable(sf.TransformableDrawable):
       def __init__(self):
           sf.Drawable.__init__(self)
           
       def draw(self, target, states):
           target.draw(body)
           target.draw(clothes)

   mydrawable = MyDrawable()
   mydrawable.position = (20, 30) # we have properties \o/
   
.. note::
   You can choose between inheriting from sf.TransformableDrawable and 
   having a :class:`sf.Transformable` in its internal attribute, and 
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
offers an access to each sample via the operator [] and you can get 
the data in a `string` for Python 2 or in a `bytes` for Python 3 via 
:attr:`sf.Chunk.data`.

HandledWindow
-------------
This extra class allows you to have a window handled by an external API 
such PyQt4. This class is pretty straight forward and you should just 
follow the cookbook for integrating.

Socket
------
There's no systematic STATUS to check. When something goes wrong, an 
error is raised and you just have to handle it. ::

   try:
       socket.send(b'hello world')
       
   except sf.SocketError:
       socket.close()
       exit(1)
       

