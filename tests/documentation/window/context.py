#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.window as sf

def thread_function():
	context = sf.Context()
	# from now on, you have a valid context
	
	# you can make OpenGL calls
	glClear(GL_DEPTH_BUFFER_BIT)

# the context is automatically deactivated and destroyed by the 
# sf.Context destructor

