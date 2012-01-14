Handling events
===============

Introduction
------------

Processing events
-----------------

Closing a window
----------------

Getting real-time inputs
------------------------

Conclusion
----------

..
        In the previous tutorial, we learned how to open a window but we had no way to stop the application. Here, we'll learn how to catch window events and handle them properly.
        Getting events

        Basically, there are two ways of receiving events in a windowing system :

            You can ask the window for waiting events at each loop ; this is called "polling"
            You can give to the window a pointer to a function and then wait for the window to call it when it receives an event ; this is called, hum... "using callback functions"

        SFML uses a polling system for getting events. That is, you must ask events to the window at each loop. The function to use is GetEvent, which fills an instance of sf::Event and returns true if there was an event waiting, or returns false if events stack was empty.

        // Remember that App is an instance of sf::Window

        sf::Event Event;
        if (App.GetEvent(Event))
        {
            // Process event
        }

        But there can be more than one event to get at each frame (events are stored in a stack at each frame, and getting an event pops the top of this stack), and if you only get one, events may accumulate and never get processed.
        The proper way to get all waiting events at each frame is to loop until we have all of them :

        sf::Event Event;
        while (App.GetEvent(Event))
        {
            // Process event
        }

        "Hey, but wait a minute... where should I put this piece of code, by the way ?".
        As events should be processed at each frame, you should put event handling on top of the main loop :

        while (Running)
        {
            sf::Event Event;
            while (App.GetEvent(Event))
            {
                // Process event
            }

            App.Display();
        }

        Processing events

        The first thing to do when you get an event is to check its type, in its Type member. SFML defines the following types of events, all in the scope of the sf::Event structure :

            Closed
            Resized
            LostFocus
            GainedFocus
            TextEntered
            KeyPressed
            KeyReleased
            MouseWheelMoved
            MouseButtonPressed
            MouseButtonReleased
            MouseMoved
            MouseEntered
            MouseLeft
            JoyButtonPressed
            JoyButtonReleased
            JoyMoved

        Depending on the type of event, the event instance will be filled with different parameters :

            Size events (Resized)
                Event.Size.Width contains the new window width, in pixels
                Event.Size.Height contains the new window height, in pixels
            Text events (TextEntered)
                Event.Text.Unicode contains the UTF-32 code of the character that has been entered
            Key events (KeyPressed, KeyReleased)
                Event.Key.Code contains the code of the key that was pressed / released
                Event.Key.Alt tells whether or not Alt key is pressed
                Event.Key.Control tells whether or not Control key is pressed
                Event.Key.Shift tells whether or not Shift key is pressed
            Mouse buttons events (MouseButtonPressed, MouseButtonReleased)
                Event.MouseButton.Button contains the buttons that is pressed / released
                Event.MouseButton.X contains the current X position of the mouse cursor, in local coordinates
                Event.MouseButton.Y contains the current Y position of the mouse cursor, in local coordinates
            Mouse move events (MouseMoved)
                Event.MouseMove.X contains the new X position of the mouse cursor, in local coordinates
                Event.MouseMove.Y contains the new Y position of the mouse cursor, in local coordinates
            Mouse wheel events (MouseWheelMoved)
                Event.MouseWheel.Delta contains the mouse wheel move (positive if forward, negative if backward)
            Joystick buttons events (JoyButtonPressed, JoyButtonReleased)
                Event.JoyButton.JoystickId contains the index of the joystick (can be 0 or 1)
                Event.JoyButton.Button contains the index of the button that is pressed / released, in the range [0, 15]
            Joystick move events (JoyMoved)
                Event.JoyMove.JoystickId contains the index of the joystick (can be 0 or 1)
                Event.JoyMove.Axis contains the moved axis
                Event.JoyMove.Position contains the current position on the axis, in the range [-100, 100] (except POV which is in [0, 360])

        Key codes are specific to SFML. Every keyboard key is associated to a constant, defined in Events.hpp. For example, key F5 is defined by the sf::Key::F5 constant. For characters and numbers, the constant match the ASCII code, this means that both 'a' and sf::Key::A map to the 'A' key.

        The mouse buttons codes follow the same rule. Five constants are defined : sf::Mouse::Left, sf::Mouse::Right, sf::Mouse::Middle (the wheel button), sf::Mouse::XButton1 and sf::Mouse::XButton2.

        Finally, joystick axes are defined as follows : sf::Joy::AxisX, sf::Joy::AxisY, sf::Joy::AxisZ, sf::Joy::AxisR, sf::Joy::AxisU, sf::Joy::AxisV, and sf::Joy::AxisPOV.

        So... let's go back to our application, and add some code to handle events. We will add something to stop the application when the user closes the window, or when he presses the escape key :

        sf::Event Event;
        while (App.GetEvent(Event))
        {
            // Window closed
            if (Event.Type == sf::Event::Closed)
                Running = false;

            // Escape key pressed
            if ((Event.Type == sf::Event::KeyPressed) && (Event.Key.Code == sf::Key::Escape))
                Running = false;
        }

        Closing a window

        If you have played around a bit with SFML windows, you have probably noticed that clicking the close box will generate a Closed event, but won't destroy the window. This is to allow users to add custom code before doing it (asking for save, etc.), or cancel it. To actually close a window, you must either destroy the sf::Window instance or call its Close() function.
        To know if a window is opened (ie. has been created), you can call the IsOpened() function.

        Now, our main loop can look much better :

        while (App.IsOpened())
        {
            sf::Event Event;
            while (App.GetEvent(Event))
            {
                // Window closed
                if (Event.Type == sf::Event::Closed)
                    App.Close();

                // Escape key pressed
                if ((Event.Type == sf::Event::KeyPressed) && (Event.Key.Code == sf::Key::Escape))
                    App.Close();
            }
        }

        Getting real-time inputs

        This event system is good enough for reacting to events like window closing, or a single key press. But if you want to handle, for example, the continous motion of a character when you press an arrow key, then you will soon see that there is a problem : there will be a delay between each movement, the delay defined by the operating system when you keep on pressing a key.

        A better strategy for this is to set a boolean variable to true when the key is pressed, and clear it when the key is released. Then at each loop, if the boolean is set, you move your character. However it can become annoying to use extra variables for this, especially when you have a lot of them. That's why SFML provides easy access to real-time input, with the sf::Input class.

        sf::Input instances cannot live by themselves, they must be attached to a window. In fact, each sf::Window manages its own sf::Input instance, and you just have to get it when you want. Getting a reference to the input associated to a window is done by the function GetInput :

        const sf::Input& Input = App.GetInput();

        Then, you can use the sf::Input instance to get mouse, keyboard and joysticks state at any time :

        bool         LeftKeyDown     = Input.IsKeyDown(sf::Key::Left);
        bool         RightButtonDown = Input.IsMouseButtonDown(sf::Mouse::Right);
        bool         Joy0Button1Down = Input.IsJoystickButtonDown(0, 1);
        unsigned int MouseX          = Input.GetMouseX();
        unsigned int MouseY          = Input.GetMouseY();
        float        Joystick1X      = Input.GetJoystickAxis(1, sf::Joy::AxisX);
        float        Joystick1Y      = Input.GetJoystickAxis(1, sf::Joy::AxisY);
        float        Joystick1POV    = Input.GetJoystickAxis(1, sf::Joy::AxisPOV);

        Conclusion

        In this tutorial you have learned how to handle windows inputs, and how to get real-time keyboard and mouse state. But to build a real-time application, you need to handle properly something else : time. So let's have a look at a quick tutorial about time handling with SFML ! 
