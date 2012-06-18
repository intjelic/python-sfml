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

		if event == sf.CloseEvent:
			print(event)
			loop = False

		elif event == sf.ResizeEvent:
			assert type(event.size) == sf.Vector2
			assert type(event.width) == int
			assert type(event.height) == int
			print(event)

		elif event == sf.FocusEvent:
			assert type(event.gained) == bool
			assert type(event.lost) == bool
			assert event.gained != event.lost
			print(event)

		elif event == sf.TextEvent:
			pass

		elif event == sf.KeyEvent:
			assert type(event.pressed) == bool
			assert type(event.released) == bool
			assert event.pressed != event.released
			print(event)

		elif event == sf.MouseWheelEvent:
			assert type(event.delta) == float
			assert type(event.x) == int
			assert type(event.y) == int
			assert type(event.position) == sf.Vector2

		elif event == sf.MouseButtonEvent:
			assert type(event.pressed) == bool
			assert type(event.released) == bool
			assert event.pressed != event.released
			print(event)

		elif event == sf.MouseMoveEvent:
			assert type(event.x) == int
			assert type(event.y) == int
			assert type(event.position) == sf.Vector2
			print(event)

		elif event == sf.MouseEvent:
			assert type(event.entered) == bool
			assert type(event.left) == bool
			assert event.entered != event.left
			print(event)

		elif event == sf.JoystickButtonEvent:
			assert type(event.connected) == bool
			assert type(event.disconnected) == bool
			assert event.connected != event.disconnected
			print(event)

		elif event == sf.JoystickMoveEvent:
			assert type(event.joystick_id) == int
			assert type(event.axis) == int
			assert type(event.position) == float
			print(event)

		elif event == sf.JoystickConnectEvent:
			assert type(event.connected) == bool
			assert type(event.disconnected) == bool
			assert event.connected != event.disconnected
			print(event)
