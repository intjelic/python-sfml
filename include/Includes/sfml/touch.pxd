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

cdef extern from "SFML/Window.hpp" namespace "sf::Touch":
    bint isDown(unsigned int)
    Vector2i getPosition(unsigned int)
    Vector2i getPosition(unsigned int, const Window&)
