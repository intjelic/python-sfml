#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cimport declx11

# This function is needed to flush the screen when we integrate pySFML to PyQt
def flush_screen(int d):
	cdef declx11.Display* myDisplay = <declx11.Display*>d
	declx11.XFlush(myDisplay)
