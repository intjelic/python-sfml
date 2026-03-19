# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Graphics/Shader.hpp" namespace "sf":
    cdef cppclass Shader:
        pass

cdef extern from "SFML/Graphics.hpp" namespace "sf::Shader":
    cdef struct CurrentTextureType:
        pass

    cdef CurrentTextureType CurrentTexture

    cdef enum Type:
        Vertex
        Fragment

    cdef bint isAvailable()
    cdef void bind(const Shader*)
