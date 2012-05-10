Window
======


.. module:: sf.window

.. class:: Style

   This class define the following constantes:
   
   +------------+--------------------------------------------------------------------------+
   | Style      | Description                                                              |
   +============+==========================================================================+
   | NONE       | No border / title bar (this flag and all others are mutually exclusive). |
   +------------+--------------------------------------------------------------------------+
   | TITLEEBAR  | Title bar + fixed border.                                                |
   +------------+--------------------------------------------------------------------------+
   | RESIZE     | Titlebar + close button.                                                 |
   +------------+--------------------------------------------------------------------------+
   | CLOSE      | Request a page's header only.                                            |
   +------------+--------------------------------------------------------------------------+
   | FULLSCREEN | Fullscreen mode (this flag and all others are mutually exclusive)        |
   +------------+--------------------------------------------------------------------------+
   | DEFAULT    | Default window style.                                                    |
   +------------+--------------------------------------------------------------------------+

.. class:: Event

   Defines a system event and its parameters.

   sf.Event holds all the informations about a system event that just 
   happened.

   Events are retrieved using the sf.Window.poll_event() and 
   sf.Window.wait_event() functions.

   A sf.Event instance contains the type of the event (mouse moved, key 
   pressed, window closed, ...) as well as the details about this 
   particular event.

   Usage example::

      for event in window.events:
         # request for closing the window
         if event.type == sf.Event.CLOSED:
            window.close()
            
         # the escape key was pressed
         if event.type == sf.Event.KEY_PRESSED and event.code == sf.Keyboard.ESCAPE:
            window.close()
            
         # the window was resized
         if event.type == sf.Event.RESIZED:
            do_something_with_the_new_size(event.size)
         
         # etc ...

   .. attribute:: NAMES

      A class attribute that maps event codes to a short description::

         >>> sf.Event.NAMES[sf.Event.CLOSED]
         'Closed'
         >>> sf.Event.NAMES[sf.Event.KEY_PRESSED]
         'Key pressed'

      If you want to print this information about a specific object,
      you can simply use ``print``; ``Event.__str__()`` will look up
      the description for you.


.. class:: Joystick

   Give access to the real-time state of the joysticks.

   sf.Joystick provides an interface to the state of the joysticks.

   It only contains static functions, so it's not meant to be 
   instanciated. Instead, each joystick is identified by an index that 
   is passed to the functions of this class.

   This class allows users to query the state of joysticks at any time 
   and directly, without having to deal with a window and its events. 
   Compared to the JOYSTICK_MOVED, JOYSTICK_BUTTON_PRESSED and 
   JOYSTICK_BUTTON_RELEASED events, sf.Joystick can retrieve the state 
   of axes and buttons of joysticks at any time (you don't need to store 
   and update a boolean on your side in order to know if a button is 
   pressed or released), and you always get the real state of 
   joysticks, even if they are moved, pressed or released when your 
   window is out of focus and no event is triggered.

   SFML supports:

       - 8 joysticks (sf.Joystick.COUNT)
       - 32 buttons per joystick (sf.Joystick.BUTTON_COUNT)
       - 8 axes per joystick (sf.Joystick.AXIS_COUNT)

   Unlike the keyboard or mouse, the state of joysticks is sometimes 
   not directly available (depending on the OS), therefore an update() 
   function must be called in order to update the current state of 
   joysticks. When you have a window with event handling, this is done 
   automatically, you don't need to call anything. But if you have no 
   window, or if you want to check joysticks state before creating 
   one, you must call sf.Joystick.update() explicitely.

   Usage example::

      # is joystick #0 connected ?
      connected = sf.Joystick.is_connected(0)

      # how many button does joystick #0 support ?
      buttons = sf.Joystick.get_button_count(0)

      # does joystick # define a X axis ?
      has_X = sf.Joystick.has_axis(0, sf.Joystick.X)

      # is button #2 pressed on joystick #0 ?
      pressed = sf.Joystick.is_button_pressed(0, 2)

      # what's the current position of the Y axis on joystick #0?
      position = sf.Joystick.get_axis_position(0, sf.Joystick.Y);

   .. attribute:: COUNT
   .. attribute:: BUTTON_COUNT
   .. attribute:: AXIS_COUNT
   .. attribute:: X
   .. attribute:: Y
   .. attribute:: Z
   .. attribute:: R
   .. attribute:: U
   .. attribute:: V
   .. attribute:: POV_X
   .. attribute:: POV_Y

   .. classmethod:: is_connected(joystick)
   
      Check if a joystick is connected.
      
      If the joystick is not connected, this function returns false.
      
      :param integer joystick: Index of the joystick to check
      :rtype: booléan
      
   .. classmethod:: get_button_count(joystick)
   
      Return the number of buttons supported by a joystick.

      If the joystick is not connected, this function returns 0.
      
      :param integer joystick: Index of the joystick
      :rtype: integer
      
   .. classmethod:: has_axis(joystick, axis)
      
      Check if a joystick supports a given axis.

      If the joystick is not connected, this function returns false.
      
      :param integer joystick: Index of the joystick 
      :param integer axis: Axis to check
      :rtype: booléan

   .. classmethod:: is_button_pressed(joystick, button)
   
      Check if a joystick button is pressed.

      If the joystick is not connected, this function returns false.
      
      :param integer joystick: Index of the joystick 
      :param integer axis: Button to check
      :rtype: booléan
       
   .. classmethod:: get_axis_position(joystick, axis)
         
      Get the current position of a joystick axis.

      If the joystick is not connected, this function returns 0.
      
      :param integer joystick: Index of the joystick 
      :param integer axis: Axis to check
      :rtype: booléan
      
   .. classmethod:: update()
         
      Update the states of all joysticks.

      This function is used internally by SFML, so you normally don't 
      have to call it explicitely. However, you may need to call it if 
      you have no window yet (or no window at all): in this case the 
      joysticks states are not updated automatically.

.. class:: Keyboard

   +------------+-----------------------------------------------------------------------------+
   | Key        | Description                                                                 |
   +============+=============================================================================+
   | A          | The A key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | B          | The B key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | C          | The C key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | D          | The D key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | E          | The E key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | F          | The F key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | G          | The G key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | H          | The H key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | I          | The I key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | J          | The J key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | K          | The K key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | L          | The L key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | M          | The M key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | N          | The N key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | O          | The O key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | P          | The P key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | Q          | The Q key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | R          | The R key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | S          | The S key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | T          | The T key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | U          | The U key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | V          | The V key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | W          | The W key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | X          | The X key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | Y          | The Y key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | Z          | The Z key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM0       | The 0 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM1       | The 1 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM2       | The 2 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM3       | The 3 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM4       | The 4 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM5       | The 5 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM6       | The 6 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM7       | The 7 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM8       | The 8 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | NUM9       | The 9 key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | ESCAPE     | The Escape key.                                                             |
   +------------+-----------------------------------------------------------------------------+
   | L_CONTROL  | The left Control key.                                                       |
   +------------+-----------------------------------------------------------------------------+
   | L_SHIFT    | The left Shift key.                                                         |
   +------------+-----------------------------------------------------------------------------+
   | L_ALT      | The left Alt key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | L_SYSTEM   | The left OS specific key: window (Windows and Linux), apple (MacOS X), ...  |
   +------------+-----------------------------------------------------------------------------+
   | R_CONTROL  | The right Control key.                                                      |
   +------------+-----------------------------------------------------------------------------+
   | R_SHIFT    | The right Shift key.                                                        |
   +------------+-----------------------------------------------------------------------------+
   | R_ALT      | The right Alt key.                                                          |
   +------------+-----------------------------------------------------------------------------+
   | R_SYSTEM   | The right OS specific key: window (Windows and Linux), apple (MacOS X), ... |
   +------------+-----------------------------------------------------------------------------+
   | MENU       | The Menu key.                                                               |
   +------------+-----------------------------------------------------------------------------+
   | L_BRACKET  | The [ key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | R_BRACKET  | The ] key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | SEMI_COLON | The ; key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | COMMA      | The , key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | PERIOD     | The . key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | QUOTE      | The ' key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | SLASH      | The / key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | BACK_SLASH | The \ key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | TILDE      | The ~ key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | EQUAL      | The = key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | DASH       | The - key.                                                                  |
   +------------+-----------------------------------------------------------------------------+
   | SPACE      | The Space key.                                                              |
   +------------+-----------------------------------------------------------------------------+
   | RETURN     | The Return key.                                                             |
   +------------+-----------------------------------------------------------------------------+
   | BACK       | The Backspace key.                                                          |
   +------------+-----------------------------------------------------------------------------+
   | TAB        | The Tabulation key.                                                         |
   +------------+-----------------------------------------------------------------------------+
   | PAGE_UP    | The Page up key.                                                            |
   +------------+-----------------------------------------------------------------------------+
   | PAGE_DOWN  | The Page down key.                                                          |
   +------------+-----------------------------------------------------------------------------+
   | END        | The End key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | HOME       | The Home key.                                                               |
   +------------+-----------------------------------------------------------------------------+
   | INSERT     | The Insert key.                                                             |
   +------------+-----------------------------------------------------------------------------+
   | DELETE     | The Delete key.                                                             |
   +------------+-----------------------------------------------------------------------------+
   | ADD        | \+                                                                          |
   +------------+-----------------------------------------------------------------------------+
   | SUBTRACT   | \-                                                                          |
   +------------+-----------------------------------------------------------------------------+
   | MULTIPLY   | \*                                                                          |
   +------------+-----------------------------------------------------------------------------+
   | DIVIDE     | /                                                                           |
   +------------+-----------------------------------------------------------------------------+
   | LEFT       | Left arrow.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | RIGHT      | Right arrow.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | UP         | Up arrow.                                                                   |
   +------------+-----------------------------------------------------------------------------+
   | DOWN       | Down arrow.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD0    | The numpad 0 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD1    | The numpad 1 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD2    | The numpad 2 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD3    | The numpad 3 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD4    | The numpad 4 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD5    | The numpad 5 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD6    | The numpad 6 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD7    | The numpad 7 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD8    | The numpad 8 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | NUMPAD9    | The numpad 9 key.                                                           |
   +------------+-----------------------------------------------------------------------------+
   | F1         | The F1 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F2         | The F2 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F3         | The F3 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F4         | The F4 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F5         | The F5 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F6         | The F6 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F7         | The F7 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F8         | The F8 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F9         | The F9 key.                                                                 |
   +------------+-----------------------------------------------------------------------------+
   | F10        | The F10 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | F11        | The F11 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | F12        | The F12 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | F13        | The F13 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | F14        | The F14 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | F15        | The F15 key.                                                                |
   +------------+-----------------------------------------------------------------------------+
   | PAUSE      | The Pause key.                                                              |
   +------------+-----------------------------------------------------------------------------+

   .. attribute:: KEY_COUNT

   .. classmethod:: is_key_pressed(int key)

.. class:: Mouse

   Give access to the real-time state of the mouse.

   sf.Mouse provides an interface to the state of the mouse.

   It only contains static functions (a single mouse is assumed), so 
   it's not meant to be instanciated.

   This class allows users to query the mouse state at any time and 
   directly, without having to deal with a window and its events. 
   Compared to the MOUSE_MOVED, MOUSE_BUTTON_PRESSED and 
   MOUSE_BUTTON_RELEASED events, sf.Mouse can retrieve the state of the 
   cursor and the buttons at any time (you don't need to store and 
   update a boolean on your side in order to know if a button is 
   pressed or released), and you always get the real state of the 
   mouse, even if it is moved, pressed or released when your window is 
   out of focus and no event is triggered.
   
   The set_position() and get_position() functions can be used to 
   change or retrieve the current position of the mouse pointer. There 
   are two versions: one that operates in global coordinates (relative 
   to the desktop) and one that operates in window coordinates 
   (relative to a specific window).

   Usage example::

      if sf.Mouse.is_button_pressed(sf.Mouse.LEFT):
         pass # left click ...
         
      # get global mouse position
      position = sf.Mouse.get_position()

      # set mouse position relative to a window
      sf.Mouse.set_position(sf.Position(100, 200), window)

   .. attribute:: LEFT
   .. attribute:: RIGHT
   .. attribute:: MIDDLE
   .. attribute:: X_BUTTON1
   .. attribute:: X_BUTTON2
   .. attribute:: BUTTON_COUNT

   .. classmethod:: is_button_pressed(int button)
   
      Check if a mouse button is pressed. 
      
      :param integer button: Button to check
      :rtype: booléan
      
   .. classmethod:: get_position([window])
      
      Get the current position of the mouse in window coordinates.

      This function returns the current position of the mouse cursor, relative to the given window.
      
      :param sf.window.Window window: Reference window
      :rtype: booléan
         
   .. classmethod:: set_position(position[, window])

      Set the current position of the mouse in window coordinates.
      
      This function sets the current position of the mouse cursor, 
      relative to the given window.

      :param sf.system.Position position: New position of the mouse 
      :param sf.window.Window window: Reference window
