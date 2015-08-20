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
from sfml cimport Uint8

cdef extern from "pysfml/window.h":
    cdef class sfml.window.VideoMode [object PyVideoModeObject]:
        cdef sf.VideoMode *p_this
        cdef bint delete_this

    cdef class sfml.window.ContextSettings [object PyContextSettingsObject]:
        cdef sf.ContextSettings *p_this

    cdef class sfml.window.Pixels [object PyPixelsObject]:
        cdef Uint8          *p_array
        cdef unsigned int    m_width
        cdef unsigned int    m_height

    cdef class sfml.window.Event [object PyEventObject]:
        cdef sf.Event *p_this

    cdef class sfml.window.Window [object PyWindowObject]:
        cdef sf.Window       *p_window
        cdef bint            m_visible
        cdef bint            m_vertical_synchronization

cdef extern from "pysfml/window_api.h":
    cdef void import_sfml__audio()

    cdef VideoMode wrap_videomode(sf.VideoMode *p, bint d)
    cdef ContextSettings wrap_contextsettings(sf.ContextSettings *v)
    cdef Pixels wrap_pixels(Uint8 *p, unsigned int w, unsigned int h)
