#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cimport libcpp.sfml as sf

# This function is needed to flush the screen when we integrate pySFML 
# to PyQt
def flush_screen(int d):
	# cdef declx11.Display* myDisplay = declx11.XOpenDisplay(":0")
	cdef sf.Display* myDisplay = <sf.Display*>d
	sf.XFlush(myDisplay)
