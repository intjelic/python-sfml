# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Network.hpp" namespace "sf::Http::Request":
    cdef enum Method "sf::Http::Request::Method":
        Get "sf::Http::Request::Method::Get"
        Post "sf::Http::Request::Method::Post"
        Head "sf::Http::Request::Method::Head"
        Put "sf::Http::Request::Method::Put"
        Delete "sf::Http::Request::Method::Delete"
