Opening a window
================

Introduction
------------
In this tutorial, we will learn how to use SFML window module as a 
minimal windowing system, like SDL or GLUT.

Preparing the code
------------------
First, you have to import the window module. Generaly we import all 
modules at the same time::

   import sfml as sf
   
But when we use SFML only for windowing (what we are about to do), 
you may write::
   
   import sfml.window as sf
   
This module is the only one needed so far, as it includes all other 
module needed. This is the case for other modules too: if you want to 
use module xxx, you just have to import this one.


Then, you have to define the well known main function ::

   def main():
       # our code will go here

Opening the window
------------------
The next step is to open a window. Windows in SFML are defined by the 
sf.Window class. This class provides some useful constructors to create 
directly our window. The interesting one here is the following ::

app = sf.Window(sf.VideoMode(800, 600, 32), "SFML Window")

Here we create a new variable named app, that will represent our new 
window. Let's explain the parameters :

   - The first parameter is a sf.VideoMode, which represents the chosen video mode for the window. Here, size is 800x600 pixels, with a depth of 32 bits per pixel. Note that the specified size will be the internal area of the window, excluding the titlebar and the borders.
   - The second parameter is the window title

If you want to create your window later, or recreate it with different 
parameters, you can use its Create function ::

   app.create(sf.VideoMode(800, 600, 32), "SFML Window")

The constructors and create functions also accept two optional 
additionnal parameters : the first one to have more control over the 
window's style, and the second to set more advanced graphics options; 
we'll come back to this one in another tutorial, beginners usually 
don't have to care about it.

The style parameter can be a combination of the sf.Style flags, which 
are NONE, TITLEBAR, RESIZE, CLOSE, DEFAULT and FULLSCREEN. The default 
style is RESIZE | CLOSE. ::

   # this creates a fullscreen window
   app.create(sf.VideoMode(800, 600, 32), "SFML Window", sf.Style.FULLSCREEN)

.. NOTE::
   
   You can combine styles using "|". E.g: sf.Style.TITLEBAR | 
   sf.Style.RESIZE will create a resizable window with a titlebar 
   without any button for closing it.
    
Video modes
-----------

In the example above, we don't care about the video mode because we run 
in windowed mode ; any size will be ok. But if we'd like to run in 
fullscreen mode, only a few modes would be allowed. sf.VideoMode 
provides an interface for getting all supported video modes, with the
static method sf.VideoMode.get_fullscreen_modes() ::

   # this script will print all video mode available
   for videomode in sf.VideoMode.get_fullscreen_modes():
      print(videomode)

Note that video modes are ordered from highest to lowest, so that 
sf.VideoMode.get_fullscreen_modes()[0] will always return the best 
video mode supported. ::

   # creating a fullscreen window with the best video mode supported
   app.create(sf.VideoMode.get_fullscreen_modes()[0], "SFML Window", sf.Style.FULLSCREEN)

If you get video modes with the code above then they will all be valid, 
but there are cases where you get a video mode from somewhere else, a 
configuration file for example. In such case, you can check the 
validity of a mode with its function is_valid() ::

   mode = read_mode_from_configfile()
   if not mode.is_valid():
      # error...

You can also get the current desktop video mode, with the 
get_desktop_mode function ::

   desktop_mode = sf.VideoMode.get_desktop_mode()

The main loop
-------------
Once our window has been created, we can enter the main loop ::

   running = True
   while (running):
       app.display()

To end the main loop and then close the application, you just have to 
set the variable `running` to false. Typically this is done when the 
window is closed, or when the user presses a special key like escape; 
we'll see how to catch these events in the next tutorial.

So far, our main loop only calls `app.display()`. This is actually the 
only call needed to display the contents of our window to the screen. 
Call to `display` should always happen once in the main loop, and be 
the last instruction, once everything else has been updated and drawn.
At this point, you may see anything on the screen (maybe black color, 
maybe not) as we don't draw anything into our window.

As you can see, there is no more code after the main loop : our window 
is correctly destroyed automatically when main function ends (clean-up 
is done in its destructor).

Conclusion
----------
And that's it, with this code you have a complete minimal program that 
opens an SFML window. But we cannot stop our program yet... so let's 
jump to the next tutorial, to see how to catch events !
