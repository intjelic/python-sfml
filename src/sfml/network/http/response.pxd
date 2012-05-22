#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
