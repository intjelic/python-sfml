#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
		Response(response.Status, string&)
		bint isOk()
		response.Status getStatus()
		string& getMessage()

	cdef cppclass DirectoryResponse:
		DirectoryResponse()
		DirectoryResponse(Response&)
		string& getDirectory()
		bint isOk()
		
	cdef cppclass ListingResponse:
		ListingResponse()
		ListingResponse(Response&, vector[char]&)
		vector[string]&	getFilenames()
		bint isOk()
