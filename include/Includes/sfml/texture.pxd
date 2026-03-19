# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Graphics/Texture.hpp" namespace "sf":
    cdef cppclass Texture:
        pass


cdef extern from "SFML/Graphics.hpp" namespace "sf::Texture":
    cdef unsigned int getMaximumSize()

    cdef enum CoordinateType:
        Normalized
        Pixels

    cdef void bind(const Texture*)
    cdef void bind(const Texture*, CoordinateType)
