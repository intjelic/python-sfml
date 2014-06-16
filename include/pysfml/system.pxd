#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.sfml as sf

cdef extern from "pysfml/system.h":
    cdef class sfml.system.Time [object PyTimeObject]:
        cdef sf.Time *p_this

cdef inline object wrap_time(sf.Time* p):
    cdef Time r = Time.__new__(Time)
    r.p_this = p
    return r

cdef extern from "pysfml/system.h":
    cdef class sfml.system.Vector2 [object PyVector2Object]:
        cdef public object x
        cdef public object y

    cdef class sfml.system.Vector3 [object PyVector3Object]:
        cdef public object x
        cdef public object y
        cdef public object z

cdef inline sf.Vector2i to_vector2i(vector):
    x, y = vector
    return sf.Vector2i(x, y)

cdef inline sf.Vector2u to_vector2u(vector):
    w, h = vector
    return sf.Vector2u(w, h)

cdef inline sf.Vector2f to_vector2f(vector):
    w, h = vector
    return sf.Vector2f(w, h)

cdef inline sf.Vector3f to_vector3f(vector):
    w, h, z = vector
    return sf.Vector3f(w, h, z)

cdef inline Vector3 to_vector3(sf.Vector3f* vector):
    return Vector3(vector.x, vector.y, vector.z)

cdef extern from "pysfml/system_api.h":
    object wrap_string(const sf.String* p)
    sf.String to_string(object string)
