Handling time
=============

Introduction
------------
Time is usually not a big thing, but in a real-time application, it is 
important to handle it properly, as we will see in this new tutorial.


Measuring time
--------------
In SFML, you measure time with sf.Clock class. It defines one function: 
`reset()`, to restart the clock, and an property `elapsed_time`, to get 
the time elapsed since the last call to `reset()`. Time is defined in 
miliseconds, as all durations that you will find in SFML.

As you can see, this class is far from being complicated. ::

   clock = sf.Clock()

   running = True
   while running:
      # process events...
      
      # get elapsed time since last loop
      time = clock.elapsed_time
      clock.reset()
      
      # display window...

Getting elapsed time can be very useful if you have to increment a 
variable at each loop (a position, an orientation, ...). If you don't 
take in account the time factor, your simulation won't produce the same 
results whether the application runs at 60 frames per seconds or at 
1000 frames per seconds. For example, this piece of code will make 
movement dependant on framerate ::

   sleep = 50
   left = 0
   top = 0

   while running:
      if sf.Keyboard.is_key_pressed(sf.Keyboard.LEFT):  left -= speed
      if sf.Keyboard.is_key_pressed(sf.Keyboard.RIGHT): left += speed
      if sf.Keyboard.is_key_pressed(sf.Keyboard.UP):    top  -= speed
      if sf.Keyboard.is_key_pressed(sf.Keyboard.DOWN):  top  -= speed

Whereas this one will ensure constant speed on every hardware ::

   clock = sf.Clock()

   speed = 50
   left = 0
   top = 0

   while running:
      elapsed_time = clock.elapsed_time
      clock.reset()

      if sf.Keyboard.is_key_pressed(sf.Keyboard.LEFT):  left -= speed * elapsed_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.RIGHT): left += speed * elapsed_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.UP):    top  -= speed * elapsed_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.DOWN):  top  -= speed * elapsed_time

Most of time, you will have to measure the time elapsed since last 
frame. sf.Window provides a useful property for getting this time 
without having to manage a clock : `frame_time`. So we could rewrite 
our code like this ::

   speed = 50
   left = 0
   top = 0
   
   while running:
      elapsed_time = clock.elapsed_time
      clock.reset()

      if sf.Keyboard.is_key_pressed(sf.Keyboard.LEFT):  left -= speed * window.frame_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.RIGHT): left += speed * window.frame_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.UP):    top  -= speed * window.frame_time
      if sf.Keyboard.is_key_pressed(sf.Keyboard.DOWN):  top  -= speed * window.frame_time
      

Measuring framerate
-------------------
As framerate is the inverse of the duration of one frame, you can 
easily deduce it from elapsed time between frames ::

   clock = sf.Clock()

   while running:
      frame_rate = 1000 / clock.elapsed_time
      clock.reset()
      
   # or ...

   while running:
      frame_rate = 1000 / window.frame_time

If your framerate gets stuck around 60 fps don't worry : it just means 
that vertical synchronization (v-sync) is enabled. Basically, when 
v-sync is on, display will be synchronized with the monitor refresh 
rate. It means you won't be able to display more frames than the 
monitor can do. And this is a good thing, as it ensures your 
application won't run at incredible framerates like 2000 fps, and 
produce bad visual artifacts or unpredicted behaviors.

However, you sometimes want to do some benchmark for optimizations, and 
you want maximum framerate. SFML allows you to disable vertical 
synchronization if you want, with the `vertical_synchronization' 
property ::

   window.vertical_synchronization = False

Note that vertical synchronization is disabled by default.

You can also set the framerate to a fixed limit ::

   window.framerate_limit = 60 # limit to 60 frames per second
   window.framerate_limit = 0  # no limit


Conclusion
----------
Time handling has no more secret for you now, and you can start to 
write robust real-time applications. In the next tutorial, we'll play a 
bit with OpenGL, to finally get something to display in our window.
However, if you're not interested in using OpenGL with SFML, you can 
jump directly to the next section about the graphics package.
