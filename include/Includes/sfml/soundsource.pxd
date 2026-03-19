# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Audio.hpp" namespace "sf::SoundSource":
    cdef enum Status:
        Stopped
        Paused
        Playing
