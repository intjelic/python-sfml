# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cimport sfml as sf

cdef extern from "pysfml/network/network_api.h":
    cdef void import_sfml__network()
