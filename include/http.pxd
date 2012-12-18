#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from libcpp.string cimport string

from http cimport request, response

cdef extern from "SFML/Network.hpp" namespace "sf::Http":
	cdef cppclass Request:
		Request(string&, request.Method, string&)
		void setField(string&, string&)
		void setMethod(request.Method)
		void setUri(string&)
		void setHttpVersion(unsigned int, unsigned int)
		void setBody(string&)

	cdef cppclass Response:
		Response()
		string& getField(string&)
		response.Status getStatus()
		unsigned int getMajorHttpVersion()
		unsigned int getMinorHttpVersion()
		string& getBody()
