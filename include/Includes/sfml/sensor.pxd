# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/System/Vector3.hpp" namespace "sf":
    cdef cppclass Vector3f "sf::Vector3<float>":
        float x
        float y
        float z

cdef extern from "SFML/Window.hpp" namespace "sf::Sensor":
    cdef enum Type "sf::Sensor::Type":
        Accelerometer "sf::Sensor::Type::Accelerometer"
        Gyroscope "sf::Sensor::Type::Gyroscope"
        Magnetometer "sf::Sensor::Type::Magnetometer"
        Gravity "sf::Sensor::Type::Gravity"
        UserAcceleration "sf::Sensor::Type::UserAcceleration"
        Orientation "sf::Sensor::Type::Orientation"

    cdef const unsigned int Count

    bint isAvailable(Type)
    void setEnabled(Type, bint)
    Vector3f getValue(Type)
