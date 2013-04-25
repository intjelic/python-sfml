#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.sfml as sf
from libcpp.sfml cimport Uint8


cdef extern from "pysfml/window.h":

	cdef class sfml.window.VideoMode [object PyVideoModeObject]:
		cdef sf.VideoMode *p_this

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
		cdef bint			 m_visible
		cdef bint			 m_vertical_synchronization

