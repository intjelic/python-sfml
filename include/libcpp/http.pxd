#-------------------------------------------------------------------------------
# PySFML - Python bindings for SFML
# Copyright (c) 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#                          Edwin Marshall <emarshall85@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

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
