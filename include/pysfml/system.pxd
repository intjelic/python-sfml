#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml cimport dsystem

cdef extern from "pysfml/system.h":
	cdef class sfml.system.Time [object PyTimeObject]:
		cdef dsystem.Time *p_this

cdef inline object wrap_time(dsystem.Time* p):
	cdef Time r = Time.__new__(Time)
	r.p_this = p
	return r
