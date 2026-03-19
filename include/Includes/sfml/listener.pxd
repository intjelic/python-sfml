# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/System/Vector3.hpp" namespace "sf":
    cdef cppclass Vector3f "sf::Vector3<float>":
        float x
        float y
        float z

cdef extern from "SFML/Audio.hpp" namespace "sf::Listener":
    cdef void setGlobalVolume(float)
    cdef float getGlobalVolume()
    cdef void setPosition(float, float, float)
    cdef void setPosition(const Vector3f&)
    cdef Vector3f getPosition()
    cdef void setDirection(float, float, float)
    cdef void setDirection(const Vector3f&)
    cdef Vector3f getDirection()
    cdef void setUpVector(float, float, float)
    cdef void setUpVector(const Vector3f&)
    cdef Vector3f getUpVector()
