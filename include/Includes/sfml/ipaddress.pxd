# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from sfml cimport Time
from sfml cimport IpAddress

cdef extern from "SFML/Network.hpp" namespace "sf::IpAddress":
    cdef IpAddress getLocalAddress()
    cdef IpAddress getPublicAddress()
    cdef IpAddress getPublicAddress(Time)

    IpAddress None
    IpAddress LocalHost
    IpAddress Broadcast
