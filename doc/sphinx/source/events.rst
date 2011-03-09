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
          event.Key.Code == sf::Key::Escape)
      {
          // ...
      }

   In Python, it becomes::

      if event.type == sf.Event.KEY_PRESSED and event.code == sf.Key.ESCAPE:
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


.. class:: Input

   Calling the constructor will raise ``NotImplementedError``. Use
   :meth:`sf.RenderWindow.get_input()` instead.

   This table explains how you deduce the various from the C++ documentation:

   ================== ============================== =================================
   Description        Python examples                C++ examples
   ================== ============================== =================================
   Mouse button codes sf.Mouse.LEFT, sf.Mouse.MIDDLE sf::Mouse::Left, sf::Mouse::Right
   Key codes          sf.Key.ESCAPE, sf.Key.SPACE    sf::Key::Escape, sf::Key::Space
   Joystick axises    sf.Joy.AXIS_X, sf.Joy.AXIS_R   sf::Joy::AxisX, sf::Joy::AxisR
   ================== ============================== =================================

   .. attribute:: mouse_x

      The same value as returned by :meth:`get_mouse_x()`. (I'm not
      really sure what choice between these two would make the most sense?)

   .. attribute:: mouse_y

      The same value as returned by :meth:`get_mouse_y()`.

   .. method:: get_joystick_axis(int joy_id, int axis)
   .. method:: get_mouse_x()
   .. method:: get_mouse_y()
   .. method:: is_key_down(int key_code)
   .. method:: is_mouse_button_down(int button)
   .. method:: is_joystick_button_down(int joy_id, int button)
