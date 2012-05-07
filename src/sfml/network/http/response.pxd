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


cdef extern from "SFML/Graphics.hpp" namespace "sf::Http::Response":
    cdef cppclass Status:
        pass
        
cdef extern from "SFML/Network.hpp" namespace "sf::Http::Response":
    int Ok
    int Created
    int Accepted
    int NoContent
    int ResetContent
    int PartialContent
    int MultipleChoices
    int MovedPermanently
    int MovedTemporarily
    int NotModified
    int BadRequest
    int Unauthorized
    int Forbidden
    int NotFound
    int RangeNotSatisfiable
    int InternalServerError
    int NotImplemented
    int BadGateway
    int ServiceNotAvailable
    int GatewayTimeout
    int VersionNotSupported
    int InvalidResponse
    int ConnectionFailed
