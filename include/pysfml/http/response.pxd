#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cdef extern from "SFML/Graphics.hpp" namespace "sf::Http::Response":
	cdef enum Status:
		Ok
		Created
		Accepted
		NoContent
		ResetContent
		PartialContent
		MultipleChoices
		MovedPermanently
		MovedTemporarily
		NotModified
		BadRequest
		Unauthorized
		Forbidden
		NotFound
		RangeNotSatisfiable
		InternalServerError
		NotImplemented
		BadGateway
		ServiceNotAvailable
		GatewayTimeout
		VersionNotSupported
		InvalidResponse
		ConnectionFailed
