# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport String

cdef extern from "SFML/Window.hpp" namespace "sf::Joystick":

    cdef enum:
        Count
        ButtonCount
        AxisCount

    cdef enum Axis:
        X
        Y
        Z
        R
        U
        V
        PovX
        PovY

    cdef struct Identification:
        Identification()
        String name
        unsigned int vendorId
        unsigned int productId

    bint isConnected(unsigned int)
    unsigned int getButtonCount(unsigned int)
    bint hasAxis(unsigned int, Axis)
    bint isButtonPressed(unsigned int, unsigned int)
    float getAxisPosition(unsigned int, Axis)
    Identification getIdentification(unsigned int)
    void update()
