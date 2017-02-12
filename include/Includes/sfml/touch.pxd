# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Vector2i
from sfml cimport Window

cdef extern from "SFML/Window.hpp" namespace "sf::Touch":
    bint isDown(unsigned int)
    Vector2i getPosition(unsigned int)
    Vector2i getPosition(unsigned int, const Window&)
