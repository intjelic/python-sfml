Events
======


.. module:: sf


.. class:: Event

   This class behaves differently from the C++ ``sf::Event`` class.
   Every Event object will always only feature the attributes that
   actually make sense regarding the event type.  This means that
   there is no need for the C++ union; you just access whatever
   attribute you want.

   For example, this is the kind of code you'd write in C++::

      if (event.Type == sf::Event::KeyPressed &&
          event.Key.Code == sf::Keyboard::Escape)
      {
          // ...
      }

   In Python, it becomes::

      if event.type == sf.Event.KEY_PRESSED and event.code == sf.Keyboard.ESCAPE:
          # ...

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

   .. classmethod:: is_connected(int joystick)
   .. classmethod:: get_button_count(int joystick)
   .. classmethod:: has_axis(int joystick, int axis)
   .. classmethod:: is_button_pressed(int joystick, int button)
   .. classmethod:: get_axis_position(int joystick, int axis)

.. class:: Keyboard


   .. attribute:: A
   .. attribute:: B
   .. attribute:: C
   .. attribute:: D
   .. attribute:: E
   .. attribute:: F
   .. attribute:: G
   .. attribute:: H
   .. attribute:: I
   .. attribute:: J
   .. attribute:: K
   .. attribute:: L
   .. attribute:: M
   .. attribute:: N
   .. attribute:: O
   .. attribute:: P
   .. attribute:: Q
   .. attribute:: R
   .. attribute:: S
   .. attribute:: T
   .. attribute:: U
   .. attribute:: V
   .. attribute:: W
   .. attribute:: X
   .. attribute:: Y
   .. attribute:: Z
   .. attribute:: NUM0
   .. attribute:: NUM1
   .. attribute:: NUM2
   .. attribute:: NUM3
   .. attribute:: NUM4
   .. attribute:: NUM5
   .. attribute:: NUM6
   .. attribute:: NUM7
   .. attribute:: NUM8
   .. attribute:: NUM9
   .. attribute:: ESCAPE
   .. attribute:: L_CONTROL
   .. attribute:: L_SHIFT
   .. attribute:: L_ALT
   .. attribute:: L_SYSTEM
   .. attribute:: R_CONTROL
   .. attribute:: R_SHIFT
   .. attribute:: R_ALT
   .. attribute:: R_SYSTEM
   .. attribute:: MENU
   .. attribute:: L_BRACKET
   .. attribute:: R_BRACKET
   .. attribute:: SEMI_COLON
   .. attribute:: COMMA
   .. attribute:: PERIOD
   .. attribute:: QUOTE
   .. attribute:: SLASH
   .. attribute:: BACK_SLASH
   .. attribute:: TILDE
   .. attribute:: EQUAL
   .. attribute:: DASH
   .. attribute:: SPACE
   .. attribute:: RETURN
   .. attribute:: BACK
   .. attribute:: TAB
   .. attribute:: PAGE_UP
   .. attribute:: PAGE_DOWN
   .. attribute:: END
   .. attribute:: HOME
   .. attribute:: INSERT
   .. attribute:: DELETE
   .. attribute:: ADD
   .. attribute:: SUBTRACT
   .. attribute:: MULTIPLY
   .. attribute:: DIVIDE
   .. attribute:: LEFT
   .. attribute:: RIGHT
   .. attribute:: UP
   .. attribute:: DOWN
   .. attribute:: NUMPAD0
   .. attribute:: NUMPAD1
   .. attribute:: NUMPAD2
   .. attribute:: NUMPAD3
   .. attribute:: NUMPAD4
   .. attribute:: NUMPAD5
   .. attribute:: NUMPAD6
   .. attribute:: NUMPAD7
   .. attribute:: NUMPAD8
   .. attribute:: NUMPAD9
   .. attribute:: F1
   .. attribute:: F2
   .. attribute:: F3
   .. attribute:: F4
   .. attribute:: F5
   .. attribute:: F6
   .. attribute:: F7
   .. attribute:: F8
   .. attribute:: F9
   .. attribute:: F10
   .. attribute:: F11
   .. attribute:: F12
   .. attribute:: F13
   .. attribute:: F14
   .. attribute:: F15
   .. attribute:: PAUSE
   .. attribute:: KEY_COUNT

   .. classmethod:: is_key_pressed(int key)

.. class:: Mouse


   .. attribute:: LEFT
   .. attribute:: RIGHT
   .. attribute:: MIDDLE
   .. attribute:: X_BUTTON1
   .. attribute:: X_BUTTON2
   .. attribute:: BUTTON_COUNT

   .. classmethod:: is_button_pressed(int button)
   .. classmethod:: get_position([window])
   .. classmethod:: set_position(tuple position[, window])
