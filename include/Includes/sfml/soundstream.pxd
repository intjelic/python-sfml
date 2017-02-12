# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Int16

cdef extern from "SFML/Audio.hpp" namespace "sf::SoundRecorder":

    cdef struct Chunk:
        const Int16* samples
        size_t sampleCount
