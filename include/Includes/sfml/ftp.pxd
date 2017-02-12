# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

from libcpp.string cimport string
from libcpp.vector cimport vector

from ftp cimport response

cdef extern from "SFML/Network.hpp" namespace "sf::Ftp":
    cdef enum TransferMode:
        Binary
        Ascii
        Ebcdic

    cdef cppclass Response:
        Response()
        Response(response.Status)
        Response(response.Status, const string&)
        bint isOk() const
        response.Status getStatus() const
        const string& getMessage() const

    cdef cppclass DirectoryResponse:
        DirectoryResponse(const Response&)
        const string& getDirectory() const

    cdef cppclass ListingResponse:
        ListingResponse(const Response&, const string&)
        const vector[string]& getListing() const
