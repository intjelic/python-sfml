#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml as sf

for event in window.events:
	# request for closing the window
	if event.type == sf.Event.CLOSED:
		window.close()
	
	# the escape key was pressed
	if event.type == sf.Event.KEY_PRESSED and event.key.code == sf.Keyboard.ESCAPE:
		window.close()
		
	# the window was resized
	if event.type == sf.Event.RESIZED:
		do_something_with_the_new_size(event.size)
		
	# ...
