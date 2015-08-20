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

cdef extern from "pysfml/NumericObject.hpp":
    cdef cppclass NumericObject:
        NumericObject()
        NumericObject(object)

        object get()
        void set(object)

cdef extern from "pysfml/system.h":
    cdef class sfml.system.Vector2 [object PyVector2Object]:
        cdef sf.Vector2[NumericObject] *p_this

    cdef class sfml.system.Vector3 [object PyVector3Object]:
        cdef sf.Vector3[NumericObject] *p_this

    cdef class sfml.system.Time [object PyTimeObject]:
        cdef sf.Time *p_this

cdef extern from "pysfml/system_api.h":
    object wrap_string(const sf.String*)
    sf.String to_string(object string)

    cdef object wrap_vector2(sf.Vector2[NumericObject]*)
    cdef object wrap_vector2i(sf.Vector2i)
    cdef object wrap_vector2u(sf.Vector2u)
    cdef object wrap_vector2f(sf.Vector2f)

    cdef sf.Vector2i to_vector2i(object)
    cdef sf.Vector2u to_vector2u(object)
    cdef sf.Vector2f to_vector2f(object)

    cdef object wrap_vector3(sf.Vector3[NumericObject]*)
    cdef object wrap_vector3i(sf.Vector3i)
    cdef object wrap_vector3f(sf.Vector3f)

    cdef sf.Vector3i to_vector3i(object)
    cdef sf.Vector3f to_vector3f(object)

    cdef object wrap_time(sf.Time*)
