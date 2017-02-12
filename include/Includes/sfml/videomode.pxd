# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from libcpp.vector cimport vector
from sfml cimport VideoMode

cdef extern from "SFML/Graphics.hpp" namespace "sf::VideoMode":
    cdef VideoMode& getDesktopMode()
    cdef const vector[VideoMode]& getFullscreenModes()
