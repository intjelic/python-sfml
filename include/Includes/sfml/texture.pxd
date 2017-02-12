# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Texture


cdef extern from "SFML/Graphics.hpp" namespace "sf::Texture":
    cdef unsigned int getMaximumSize()

    cdef enum CoordinateType:
        Normalized
        Pixels

    cdef void bind(const Texture*)
    cdef void bind(const Texture*, CoordinateType)
