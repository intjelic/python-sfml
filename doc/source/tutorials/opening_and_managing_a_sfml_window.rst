Opening and managing a SFML window
==================================

.. contents:: :local:

Introduction
------------
This tutorial only describes how to open and manage a window. Drawing stuff is
out of the scope of the window module: it is handled by the graphics module.
However, the window management remains exactly the same so reading this
tutorial is important in any case.

Opening a window
----------------
Windows in SFML are defined by the :class:`.Window` class. A window can be
created and opened directly upon construction: ::

   window = sf.Window(sf.VideoMode(800, 600), "My window")

The first argument, the video mode, defines the size of the window (the inner
size, without the titlebar and borders). Here, we create a window of 800x600
pixels.

The :class:`.VideoMode` class has some interesting static functions to get the
desktop resolution, or the list of valid video modes for fullscreen mode. Don't
hesitate to have a look at its documentation.

The second argument is simply the title of the window.

This constructor accepts a third optional argument: a style, which allows to
choose which decorations and features you want. You can use any combination of
the following styles:

+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.NONE`       | No decoration at all (useful for splash screens, for example); this style cannot be combined with others           |
+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.TITLEBAR`   | The window has a titlebar                                                                                          |
+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.RESIZE`     | The window can be resized and has a maximize button                                                                |
+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.CLOSE`      | The window has a close button                                                                                      |
+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.FULLSCREEN` | The window is shown in fullscreen mode; this style cannot be combined with others, and requires a valid video mode |
+---------------------+--------------------------------------------------------------------------------------------------------------------+
| :data:`.DEFAULT`    | The default style, which is a shortcut for Titlebar \| Resize \| Close                                             |
+---------------------+--------------------------------------------------------------------------------------------------------------------+

There's also a fourth optional argument, which defines OpenGL specific options
explained in the :doc:`related tutorial</tutorials/using_opengl_in_a_sfml_window>`.

If you want to create the window after the construction of the
:class:`Window` instance, or re-create it with a different video mode or title,
you can use the `create` function instead; it takes the exact same arguments as
the constructor. ::

   ... todo...

Bringing the window to life
---------------------------
If you try to execute the code above with nothing in place of the "...", you
will hardly see something. First, because the program ends immediately. Second,
because there's no event handling -- so even if you added an endless loop to
this code, you would see a dead window, unable to be moved, resized, or closed.

So let's add a little something to make this program more interesting: ::

   import sfml.window as sf

   window = sf.Window(sf.VideoMode(800, 600), "My window")

   # run the program as long as the window is open
   while(window.is_open):
      # check all the window's events that were triggered since the last iteration of the loop
      for event in window.events:
         # "close requested" event: we close the window
         if event == sf.CloseEvent:
            window.close()

The above code will open a window, and terminate when the user closes it. Let's
see how it works in detail.

First, we added a loop that ensures that the application will be
refreshed/updated until the window is closed. Most (if not all) SFML programs
will have this kind of loop, sometimes called the `main loop` or `game loop`.

Then, the first thing that we do inside our game loop is to check events that
were triggered. Note that `window.events` returns a generator which iterates on
all pending events (if any).

.. seealso::

   :meth:`.poll_event` and :meth:`.wait_event`.

Whenever we get an event, we must check its type (window closed? key pressed?
mouse moved? joystick connected? ...), and react accordingly if we are
interested in it. In this case, we only care about the :class:`.CloseEvent`
event, which is triggered when the user wants to close the window. At this
point, the window is still open and we have to close it explicitly with the
close function. This allows to do something before the window is closed, such
as saving the current state of the application, or displaying a message.

.. important::

   A mistake that people often do is to forget the event loop, because they don't
   care yet about handling events (they use real-time inputs instead). But without
   an event loop, the window won't be responsive; indeed, the event loop has two
   roles: in addition to provide events to the user, it gives the window a chance
   to process its internal events too, which is required so that it can react to
   move or resize user actions.

After the window has been closed, the main loop exits and the program
terminates.

At this point, you probably noticed that we haven't talked about drawing
something to the window yet. As stated in the introduction, this is not the job
of the window module, and you'll have to jump to the graphics tutorials if you
want to draw something such as sprites, texts or shapes.

To draw stuff, you can also use OpenGL directly and totally ignore the graphics
module. :class:`.Window` internally creates an OpenGL context and is ready to
accept your OpenGL calls. You can learn more about that in the
:doc:`corresponding tutorial</tutorials/using_opengl_in_a_sfml_window>`.

So, don't expect to see something interesting in this window: you may see a
uniform color (black or white), or the last contents of the previous
application that used OpenGL, or... anything else.

Playing with the window
-----------------------
Of course, SFML allows you to play a little bit with your windows. Basic window
operations such as changing the size, position, title or icon are supported,
but unlike dedicated GUI libraries (PyQt, wxPython), SFML doesn't provide
advanced features. SFML windows are only meant to provide a base for OpenGL or
SFML drawing. ::

   # change the position of the window (relatively to the desktop)
   window.position = (10, 50)

   # change the size of the window
   window.size = (640, 480)

   # change the title of the window
   window.title = "SFML window"

   # get the size of the window
   width, height = window.size

   # ...

You can refer to the API documentation for a complete list of :class:`.Window`'s
functions.

In case you really need advanced features for your window, you can create one
(or even a full GUI) with another library, and embed SFML into it. To do so,
you can use the other constructor, or `create` function, of :class:`Window`
which takes the OS-specific handle of an existing window. In this case, SFML
will create a drawing context inside the given window, and catch all its
events, without disturbing the initial window management. ::

   handle = getHandle() # specific to what you're doing and the library you're using
   window = sf.Window.from_handle(handle)

If you just want an additional, very specific feature, you can also do it the
other way round: create a SFML window, and get its OS-specific handle to
implement things that SFML doesn't support.

   window = sf.Window(sf.VideoMode(800, 600), "SFML window")
   handle = window.handle

Integrating SFML with other libraries requires some work and won't be described
here, but you can refer to the dedicated tutorials, examples or forum posts.


Controlling the framerate
-------------------------
Sometimes, when your application runs fast, you may notice visual artifacts
such as tearing. The reason is that your application's refresh rate is not
synchronized with the vertical frequency of the monitor, and as a result, the
bottom of the previous frame is mixed with the top of the next one.

The solution to this problem is to activate `vertical synchronization`. It is
automatically handled by the graphics card, and can easily be switched on and
off with the `vertical_synchronization` property: ::

   window.vertical_synchronization = True

After this call, your application will run at the same frequency as the
monitor, so approximately 60 frames per second.

.. important::

   Sometimes `vertical_synchronization` will have no effect: this is most likely
   because vertical synchronization is forced to "off" in your graphics driver's
   settings. It should be set to "controlled by application" instead.

In other situations, you may also want your application to run at a given
framerate, instead of the monitor's frequency. This can be done by using
`framerate_limit` property: ::

   window.framerate_limit = 30

Unlike `vertical_synchronization`, this feature is implemented by SFML itself,
using a combination of :class:`.Clock` and :func:`.sleep`. An important
consequence is that it is not 100% reliable, especially for high framerates:
:func:`.sleep`'s resolution depends on the underlying OS, and can be as high as
10 or 15 milliseconds. Don't rely on this feature to implement precise timing.

.. important::

   Never use both :attr:`vertical_synchronization` and
   :attr:`framerate_limit` at the same time! They would badly mix and make
   things worse.

Things to know about windows
----------------------------
Here is a brief list of what you can and cannot do with SFML windows.

You can create multiple windows
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
SFML allows you to create multiple windows, and to handle them either all in
the main thread, or each one in its own thread (but... see below). In this
case, don't forget to have an event loop for each window.

Multiple monitors are not correctly supported yet
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
SFML doesn't explicitly manage multiple monitors. As a consequence, you won't
be able to choose which monitor a window appears on, and you won't be able to
create more than one fullscreen window. This should be improved in a future
version.

Events must be polled in the window's thread
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is an important limitation of most OSes: the event loop (more precisely,
the :meth:`.poll_event`, :meth:`.wait_event` function or :attr:`.events`) must
be called in the same thread that created the window. This means that if you
want to create a dedicated thread for event handling, you'll have to make sure
that the window is created in this thread too. If you really want to split
things between threads, it is more convenient to keep event handling in the main
thread and move the rest (rendering, physics, logic, ...) to a separate thread
instead. This configuration will also be compatible with the other limitation
described below.

On OS X, windows and events must be managed in the main thread
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Yep, that's true. Mac OS X just won't agree if you try to create a window or
handle events in a thread other than the main one.

On Windows, a window which is bigger than the desktop will not behave correctly
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
For some reason, Windows doesn't like windows that are bigger than the desktop.
This includes windows created with :meth:`sfml.VideoMode.get_desktop_mode`: with
the window decorations (borders and titlebar) added, you end up with a window
which is slightly bigger than the desktop.

