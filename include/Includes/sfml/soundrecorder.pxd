# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from libcpp.string cimport string
from libcpp.vector cimport vector

cdef extern from "SFML/Audio.hpp" namespace "sf::SoundRecorder":
    cdef bint isAvailable()
    cdef vector[string] getAvailableDevices()
    cdef string getDefaultDevice()
