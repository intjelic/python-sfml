# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cimport sfml as sf

cdef extern from "SFML/System.hpp" namespace "sf::Angle":
    cdef sf.Angle Zero