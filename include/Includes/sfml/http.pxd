# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

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
