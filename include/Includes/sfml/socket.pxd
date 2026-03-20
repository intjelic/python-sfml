# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Network.hpp" namespace "sf::Socket":
    cdef enum Status "sf::Socket::Status":
        Done "sf::Socket::Status::Done"
        NotReady "sf::Socket::Status::NotReady"
        Partial "sf::Socket::Status::Partial"
        Disconnected "sf::Socket::Status::Disconnected"
        Error "sf::Socket::Status::Error"

    cdef enum:
        AnyPort
