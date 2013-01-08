#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from pysfml cimport dx11

# This function is needed to flush the screen when we integrate pySFML 
# to PyQt
def flush_screen(int d):
	# cdef declx11.Display* myDisplay = declx11.XOpenDisplay(":0")
	cdef dx11.Display* myDisplay = <dx11.Display*>d
	dx11.XFlush(myDisplay)
