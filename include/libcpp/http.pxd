#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from libcpp.string cimport string

from http cimport request, response

cdef extern from "SFML/Network.hpp" namespace "sf::Http":
	cdef cppclass Request:
		Request(const string&)
		Request(const string&, request.Method)
		Request(const string&, request.Method, const string&)
		void setField(const string&, const string&)
		void setMethod(request.Method)
		void setUri(const string&)
		void setHttpVersion(unsigned int, unsigned int)
		void setBody(const string&)

	cdef cppclass Response:
		Response()
		const string& getField(const string&) const
		response.Status getStatus() const
		unsigned int getMajorHttpVersion() const
		unsigned int getMinorHttpVersion() const
		const string& getBody() const
