# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cdef extern from "SFML/Window.hpp" namespace "sf::Event":
    cdef enum EventType:
        Closed
        Resized
        LostFocus
        GainedFocus
        TextEntered
        KeyPressed
        KeyReleased
        MouseWheelMoved
        MouseWheelScrolled
        MouseButtonPressed
        MouseButtonReleased
        MouseMoved
        MouseEntered
        MouseLeft
        JoystickButtonPressed
        JoystickButtonReleased
        JoystickMoved
        JoystickConnected
        JoystickDisconnected
        TouchBegan
        TouchMoved
        TouchEnded
        SensorChanged
        Count
