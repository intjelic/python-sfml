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

window = sf.Window(sf.VideoMode(640, 480), "pySFML - Events")

loop = True
while loop:
	for event in window.events:
		
		if event.type is not sf.Event.MOUSE_MOVED:
			print(event)
		
		if event.type == sf.Event.CLOSED:
			assert type(event) == sf.Event
			loop = False
			
		elif event.type == sf.Event.RESIZED:
			assert type(event) == sf.SizeEvent
			assert type(event.size) == sf.Vector2
			print(event.size)
			print(event.width)
			print(event.height)
			
		elif event.type == sf.Event.LOST_FOCUS:
			assert type(event) == sf.Event
			
		elif event.type == sf.Event.GAINED_FOCUS:
			assert type(event) == sf.Event
			
		elif event.type == sf.Event.TEXT_ENTERED:
			assert type(event) == sf.TextEvent
			print(type(event.unicode))
			print(event.unicode)
			
		elif event.type == sf.Event.KEY_PRESSED:
			assert type(event) == sf.KeyEvent
			print(event.code)
			print(event.alt)
			print(event.control)
			print(event.shift)
			print(event.system)

		elif event.type == sf.Event.KEY_RELEASED:
			assert type(event) == sf.KeyEvent
			print(event.code)
			print(event.alt)
			print(event.control)
			print(event.shift)
			print(event.system)
			
		
			
			
			
			
