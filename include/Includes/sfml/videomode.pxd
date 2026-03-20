# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

from libcpp.vector cimport vector

cdef extern from "SFML/Window/VideoMode.hpp" namespace "sf":
    cdef cppclass VideoMode:
        pass

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::window_compat":
    cdef VideoMode getDesktopMode()
    cdef const vector[VideoMode]& getFullscreenModes()
