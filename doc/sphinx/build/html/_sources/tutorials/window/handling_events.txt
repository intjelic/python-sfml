Handling events
===============

Introduction
------------
In the previous tutorial, we learned how to open a window but we had no 
way to stop the application. Here, we'll learn how to catch window 
events and handle them properly.

Getting events
--------------
Basically, there are two ways of receiving events in a windowing 
system:

   - You can ask the window for waiting events at each loop ; this is called "polling"
   - You can give to the window a "pointer" to a function and then wait for the window to call it when it receives an event ; this is called, hum... "using callback functions"

SFML uses a polling system for getting events. That is, you must ask 
events to the window at each loop. The function to use is 
`poll_event()`, which returns an instance of sf.Event if there was an 
event waiting, or returns None if events stack was empty. ::


   # 'window' is an instance of sf.Window
   event = window.poll_event()
   if event:
      # process event

But there can be more than one event to get at each frame (events are 
stored in a stack at each frame, and getting an event pops the top of 
this stack), and if you only get one, events may accumulate and never 
get processed.

The proper way to get all waiting events at each frame is to loop until 
we have all of them. The stack can be accessed via the property 
`events` and you can iterate over it using a simple `for ... in` ::

   for event in window.events:
      pass # process event

"Hey, but wait a minute... where should I put this piece of code, by 
the way ?".

As events should be processed at each frame, you should put event 
handling on top of the main loop ::

   while running:
      for event in events:
         pass # process event
         
      window.display()

Processing events
-----------------
The first thing to do when you get an event is to check its type, in 
its `type` member. SFML defines the following types of events, all in 
the scope of the sf.Event structure :

   - CLOSED
   - RESIZED
   - LOST_FOCUS
   - GAINED_FOCUS
   - TEXT_ENTERED
   - KEY_PRESSED
   - KEY_RELEASED
   - MOUSE_WHEEL_MOVED
   - MOUSE_BUTTON_PRESSED
   - MOUSE_BUTTON_RELEASED
   - MOUSE_MOVED
   - MOUSE_ENTERED
   - MOUSE_LEFT
   - JOYSTICK_BUTTON_PRESSED
   - JOYSTICK_BUTTON_RELEASED
   - JOYSTICK_MOVED
   - JOYSTICK_CONNECTED
   - JOYSTICK_DISCONNECTED


Depending on the type of event, the event instance will be filled with 
different parameters:

.. 

   - Size events (RESIZED)
        `event.size.width` contains the new window width, in pixels
        `event.size.height` contains the new window height, in pixels
        
   - Text events (TEXT_ENTERED)
        `Event.Text.Unicode` contains the UTF-32 code of the character 
        that has been entered
        
   - Key events (KEY_PRESSED, KEY_RELEASED)
        Event.Key.Code contains the code of the key that was pressed / released
        Event.Key.Alt tells whether or not Alt key is pressed
        Event.Key.Control tells whether or not Control key is pressed
        Event.Key.Shift tells whether or not Shift key is pressed
   - Mouse buttons events (MouseButtonPressed, MouseButtonReleased)
        Event.MouseButton.Button contains the buttons that is pressed / released
        Event.MouseButton.X contains the current X position of the mouse cursor, in local coordinates
        Event.MouseButton.Y contains the current Y position of the mouse cursor, in local coordinates
   - Mouse move events (MouseMoved)
        Event.MouseMove.X contains the new X position of the mouse cursor, in local coordinates
        Event.MouseMove.Y contains the new Y position of the mouse cursor, in local coordinates
   - Mouse wheel events (MouseWheelMoved)
        Event.MouseWheel.Delta contains the mouse wheel move (positive if forward, negative if backward)
   - Joystick buttons events (JoyButtonPressed, JoyButtonReleased)
        Event.JoyButton.JoystickId contains the index of the joystick (can be 0 or 1)
        Event.JoyButton.Button contains the index of the button that is pressed / released, in the range [0, 15]
   - Joystick move events (JoyMoved)
        Event.JoyMove.JoystickId contains the index of the joystick (can be 0 or 1)
        Event.JoyMove.Axis contains the moved axis
        Event.JoyMove.Position contains the current position on the axis, in the range [-100, 100] (except POV which is in [0, 360])


Key codes are specific to SFML. Every keyboard key is associated to a 
constant. For example, key F5 is defined by the sf.Keyboard.F5 
constant. For characters and numbers, the constant match the ASCII 
code, this means that both 'a' and sf.Key.A map to the 'A' key.

The mouse buttons codes follow the same rule. Five constants are 
defined: sf.Mouse.LEFT, sf.Mouse.RIGHT, sf.Mouse.MIDDLE 
(the wheel button), sf.Mouse.X_BUTTON1 and sf.Mouse.X_BUTTON2.

cdef class Joystick:
    COUNT = declwindow.joystick.Count
    BUTTON_COUNT = declwindow.joystick.ButtonCount
    AXIS_COUNT = declwindow.joystick.AxisCount
    X = declwindow.joystick.X
    Y = declwindow.joystick.Y
    Z = declwindow.joystick.Z
    R = declwindow.joystick.R
    U = declwindow.joystick.U
    V = declwindow.joystick.V
    POV_X = declwindow.joystick.PovX
    POV_Y = declwindow.joystick.PovY
    
Finally, joystick axes are defined as follows: sf.Joystick.X, 
sf.Joystick.Y, sf.Joystick.Z, sf.Joystick.R, sf.Joystick.U, 
sf.Joystick.V, sf.Joystick.POV_X and sf.Joystick.POV_Y.

So... let's go back to our application, and add some code to handle 
events. We will add something to stop the application when the user 
closes the window, or when he presses the escape key ::

   for event in window.events:
      # window closed
      if event.type == sf.Event.CLOSED:
         running == False
      
      # escape key pressed
      if event.type == sf.Event.KEY_PRESSED and event.key.code == sf.Keyboard.ESCAPE:
         running = False


Closing a window
----------------
If you have played around a bit with SFML windows, you have probably 
noticed that clicking the close box will generate a `CLOSED` event, but 
won't destroy the window. This is to allow users to add custom code 
before doing it (asking for save, etc.), or cancel it. To actually 
close a window, you must either destroy the sf.Window instance or call 
its `close()` function.

To know if a window is opened (ie. has been created), you can call the 
`is_opened()` function.

Now, our main loop can look much better ::

   running = True
   while running:
      for event in window.events:
         # window closed
         if event.type == sf.Event.CLOSED:
            running == False
         
         # escape key pressed
         if event.type == sf.Event.KEY_PRESSED and event.key.code == sf.Keyboard.ESCAPE:
            running = False
            
   window.close()


Getting real-time inputs
------------------------
This event system is good enough for reacting to events like window 
closing, or a single key press. But if you want to handle, for example, 
the continous motion of a character when you press an arrow key, then 
you will soon see that there is a problem : there will be a delay 
between each movement, the delay defined by the operating system when 
you keep on pressing a key.

A better strategy for this is to set a boolean variable to true when t
he key is pressed, and clear it when the key is released. Then at each 
loop, if the boolean is set, you move your character. However it can 
become annoying to use extra variables for this, especially when you 
have a lot of them. That's why SFML provides easy access to real-time 
input. ::

   # keyboard
   isLeftKeyPressed = sf.Keyboard.is_key_pressed(sf.Keyboard.LEFT)

   # mouse
   isRightButtonPressed = sf.Mouse.is_button_pressed(sf.Mouse.RIGHT)
   mousePosition = sf.Mouse.GetPosition()

   # joystick
   isJoystick0Button1Down = sf.Joystick.is_button_pressed(0, 1)
   joystickX = sf.Joystick.get_axis_position(1, sf.Joystick.X
   joystickY = sf.Joystick.get_axis_position(1, sf.Joystick.Y)
   joystickPOV = sf.Joystick.get_axis_position(1, sf.Joystick.POV)


Conclusion
----------
In this tutorial you have learned how to handle windows inputs, and how 
to get real-time keyboard and mouse state. But to build a real-time 
application, you need to handle properly something else : time. So 
let's have a look at a quick tutorial about time handling with SFML ! 
