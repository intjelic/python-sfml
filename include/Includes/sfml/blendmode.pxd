
# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cdef extern from "SFML/Graphics.hpp" namespace "sf::BlendMode":
    cdef enum Factor:
        Zero
        One
        SrcColor
        OneMinusSrcColor
        DstColor
        OneMinusDstColor
        SrcAlpha
        OneMinusSrcAlpha
        DstAlpha
        OneMinusDstAlpha

    cdef enum Equation:
        Add
        Subtract
