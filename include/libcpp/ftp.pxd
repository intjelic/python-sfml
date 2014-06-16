#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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
        ListingResponse(const Response&, const vector[char]&)
        const vector[string]& getListing() const
