# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cimport sfml as sf

cdef extern from "SFML/System/Time.hpp" namespace "sf":
    cdef cppclass Time:
        pass

cdef extern from "SFML/Network/IpAddress.hpp" namespace "sf":
    cdef cppclass IpAddress:
        pass

cdef extern from "SFML/Network.hpp" namespace "sf::IpAddress":
    cdef IpAddress getLocalAddress()
    cdef IpAddress getPublicAddress()
    cdef IpAddress getPublicAddress(Time)

    IpAddress None
    IpAddress LocalHost
    IpAddress Broadcast
