# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/System/Vector2.hpp" namespace "sf":
    cdef cppclass Vector2i "sf::Vector2<int>":
        int x
        int y

cdef extern from "SFML/Window/Window.hpp" namespace "sf":
    cdef cppclass Window:
        pass

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::mouse_compat":
    cdef enum Button:
        Left
        Right
        Middle
        XButton1
        XButton2
        ButtonCount

    cdef enum Wheel:
        VerticalWheel
        HorizontalWheel

    bint isButtonPressed(Button)
    Vector2i getPosition()
    Vector2i getPosition(const Window&)
    void setPosition(const Vector2i&)
    void setPosition(const Vector2i&, const Window&)
