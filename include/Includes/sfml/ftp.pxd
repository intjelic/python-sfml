# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

from libcpp.string cimport string
from libcpp.vector cimport vector

from sfml.ftp cimport response

cdef extern from "<filesystem>" namespace "std::filesystem":
    cdef cppclass path:
        path() except +
        string u8string() const

cdef extern from "SFML/Network.hpp" namespace "sf::Ftp":
    cdef enum TransferMode "sf::Ftp::TransferMode":
        Binary "sf::Ftp::TransferMode::Binary"
        Ascii "sf::Ftp::TransferMode::Ascii"
        Ebcdic "sf::Ftp::TransferMode::Ebcdic"

    cdef cppclass Response:
        Response()
        Response(response.Status)
        Response(response.Status, const string&)
        bint isOk() const
        response.Status getStatus() const
        const string& getMessage() const

    cdef cppclass DirectoryResponse:
        DirectoryResponse(const Response&)
        const path& getDirectory() const

    cdef cppclass ListingResponse:
        ListingResponse(const Response&, const string&)
        const vector[string]& getListing() const
