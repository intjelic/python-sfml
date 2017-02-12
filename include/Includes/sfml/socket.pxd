# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cdef extern from "SFML/Network.hpp" namespace "sf::Socket":
    cdef enum Status:
        Done
        NotReady
        Disconnected
        Error

    cdef enum:
        AnyPort
