# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Vector3f

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
