# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cimport http_request
cimport http_response

cdef extern from "SFML/Network.hpp" namespace "sf::Http":
    cdef cppclass Request:
        Request(char* &uri, http_request.Method method, char* &body)
        void SetField(char* &field, char* &value)
        void SetMethod(http_request.Method method)
        void SetUri(char* &uri)
        void SetHttpVersion(unsigned int major, unsigned int minor)
        void SetBody(char* &body)
        
    cdef cppclass Response:
        Response()
        char* & GetField(char* &field)
        http_response.Status GetStatus()
        unsigned int GetMajorHttpVersion()
        unsigned int GetMinorHttpVersion()
        char* & GetBody()
