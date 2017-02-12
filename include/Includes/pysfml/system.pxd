# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cimport sfml as sf

cdef extern from "pysfml/system/NumericObject.hpp":
    cdef cppclass NumericObject:
        NumericObject()
        NumericObject(object)

        object get()
        void set(object)

cdef extern from "pysfml/system/system.h":
    cdef class sfml.system.Vector2 [object PyVector2Object]:
        cdef sf.Vector2[NumericObject] *p_this

    cdef class sfml.system.Vector3 [object PyVector3Object]:
        cdef sf.Vector3[NumericObject] *p_this

    cdef class sfml.system.Time [object PyTimeObject]:
        cdef sf.Time *p_this

cdef extern from "pysfml/system/system_api.h":
    int import_sfml__system()

    object popLastErrorMessage()

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
