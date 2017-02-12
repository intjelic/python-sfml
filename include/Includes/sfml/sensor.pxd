# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Vector3f
from sfml cimport Window

cdef extern from "SFML/Window.hpp" namespace "sf::Sensor":
    cdef enum Type:
        Accelerometer
        Gyroscope
        Magnetometer
        Gravity
        UserAcceleration
        Orientation
        Count

    bint isAvailable(Type)
    void setEnabled(Type, bint)
    Vector3f getValue(Type)
