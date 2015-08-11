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

cimport sfml as sf

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
