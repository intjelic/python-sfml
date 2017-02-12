# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Vector2i
from sfml cimport Window

cdef extern from "SFML/Window.hpp" namespace "sf::Mouse":
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
