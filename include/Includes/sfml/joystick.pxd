# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

from libcpp.string cimport string

cdef extern from "SFML/System/String.hpp" namespace "sf":
    cdef cppclass String:
        String()
        string toAnsiString()

cdef extern from "SFML/Window.hpp" namespace "sf::Joystick":

    cdef const unsigned int Count
    cdef const unsigned int ButtonCount
    cdef const unsigned int AxisCount

    cdef enum Axis "sf::Joystick::Axis":
        X "sf::Joystick::Axis::X"
        Y "sf::Joystick::Axis::Y"
        Z "sf::Joystick::Axis::Z"
        R "sf::Joystick::Axis::R"
        U "sf::Joystick::Axis::U"
        V "sf::Joystick::Axis::V"
        PovX "sf::Joystick::Axis::PovX"
        PovY "sf::Joystick::Axis::PovY"

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
