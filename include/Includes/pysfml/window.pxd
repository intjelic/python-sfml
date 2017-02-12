# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cimport sfml as sf
from sfml cimport Uint8

cdef extern from "pysfml/window/window.h":
    cdef class sfml.window.VideoMode [object PyVideoModeObject]:
        cdef sf.VideoMode *p_this
        cdef bint delete_this

    cdef class sfml.window.ContextSettings [object PyContextSettingsObject]:
        cdef sf.ContextSettings *p_this

    cdef class sfml.window.Event [object PyEventObject]:
        cdef sf.Event *p_this

    cdef class sfml.window.Window [object PyWindowObject]:
        cdef sf.Window       *p_window
        cdef bint            m_visible
        cdef bint            m_vertical_synchronization

cdef extern from "pysfml/window/window_api.h":
    cdef void import_sfml__window()

    cdef VideoMode wrap_videomode(sf.VideoMode *p, bint d)
    cdef ContextSettings wrap_contextsettings(sf.ContextSettings *v)
