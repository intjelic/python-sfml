#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from pysfml cimport dwindow

cdef extern from "pysfml/window.h":
	
	cdef class sfml.window.Event [object PyEventObject]:
		cdef dwindow.Event *p_this
		
	cdef class sfml.window.Window [object PyWindowObject]:
		cdef dwindow.Window *p_window
		cdef bint			 m_visible
		cdef bint			 m_vertical_synchronization
