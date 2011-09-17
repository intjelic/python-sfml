Tutorial
========

This tutorial is based on the official SFML tutorials at
http://sfml-dev.org/tutorials.

Creating a window
-----------------

Windows in PySFML are created with the :py:class:`sf.RenderWindow`
class. This class provides some useful constructors to create directly
our window. The interesting one here is the following::

    window = sf.RenderWindow(sf.VideoMode(800, 600, 32), 'SFML Window')

Here we create a new variable named ``window`` that will represent our
new window. Let's explain the parameters:

* The first parameter is a :py:class:`sf.VideoMode`, which represents
  the chosen video mode for the window. Here, size is 800x600 pixels,
  with a depth of 32 bits per pixel. Note that the specified size will
  be the internal area of the window, excluding the titlebar and the
  borders.
* The second parameter is the window title.

If you want to create your window later, or recreate it with different
parameters, you can use its :py:meth:`sf.RenderWindow.create()`
method::

    window.create(sf.VideoMode(800, 600, 32), 'SFML Window');

The constructor and the :py:meth:`sf.RenderWindow.create()` method
also accept two optional additionnal parameters: the first one to have
more control over the window's style, and the second one to set more
advanced graphics options; we'll come back to this one in another
tutorial, beginners usually don't have to care about it.  The style
parameter can be a combination of the ``sf.Style`` flags, which are
``None``, ``Titlebar``, ``Resize``, ``Close`` and ``Fullscreen``. The
default style is ``Resize | Close``. ::

    # This creates a fullscreen window
    window.create(sf.VideoMode(800, 600, 32), 'SFML Window', sf.Style.FULLSCREEN);


Video modes
-----------

In the example above, we don't bother about the video mode because we
run in windowed mode; any size will work. But if we want to run in
fullscreen mode, we have to choose one of allowed modes.  The
:py:meth:`sf.VideoMode.get_fullscreen_modes()` class method returns a
list of all the valid fullscreen modes. They are sorted from best to
worst, so ``sf.VideoMode.get_fullscreen_modes()[0]`` will always be
the highest-quality mode available::

    window = sf.RenderWindow(sf.VideoMode.get_fullscreen_modes[0], 'SFML Window', sf.Style.FULLSCREEN)

If you are getting the video mode from the user, you should check its
validity before applying it.  This is done with
:py:meth:`sf.VideoMode.is_valid()`::

    mode = get_mode_from_somewhere()

    if not mode.is_valid():
        # Error...

The current desktop mode can be obtained with the
:py:meth:`sf.VideoMode.get_desktop_mode()` class method.



Main loop
---------

Let's write a skeleton of our game loop::

    # Setup code
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'SFML window')
    # ...

    while True:
        # Handle events
        # ...

        window.clear(sf.Color.WHITE)
                
        # Draw our stuff
        # ...       

        window.display()

:py:meth:`sf.RenderWindow.clear()` fills the window with the specified
color.  You can create "custom" color objects with the
:py:class:`sf.Color` constructor.  For example, if you wanted to a
pink background you could write ``window.clear(sf.Color(255, 192,
203))``.  The call to :py:meth:`sf.RenderWindow.display()` simply
updates the content of the window.

This code doesn't look right currently, because we have a loop that
doesn't really do anything: it just draws the same background over and
over.  Don't worry, it will make more sense once we will actually draw
stuff.

If you run this program and look at your process manager, you'll see
that it is using 100% of one of your processor's time.  This isn't
surprising, given the busy loop we wrote.  A simple fix is to set the
:py:attr:`sf.RenderWindow.framerate_limit` attribute::

    window.framerate_limit = 60

This line tells SFML to ensure that the window isn't updated more than
60 times per second.  It has to go in the setup code.



Handling events
---------------





Drawing images
--------------

This simple example will give you an idea what the API looks like.  It
performs a common task: displaying an image. ::

   import sf


   def main():
       window = sf.RenderWindow(sf.VideoMode(640, 480),
                                'Drawing an image with SFML')
       window.framerate_limit = 60
       running = True
       texture = sf.Texture.load_from_file('python-logo.png')
       sprite = sf.Sprite(texture)

       while running:
           for event in window.iter_events():
               if event.type == sf.Event.CLOSED:
                   running = False

           window.clear(sf.Color.WHITE)
           window.draw(sprite)
           window.display()
       window.close()


   if __name__ == '__main__':
       main()
