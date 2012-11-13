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

# declare and create a new window
window = sf.Window(sf.VideoMode(800, 600), "pySFML Window")

# limit the framerate to 60 frames per second (this step is optional)
window.framerate_limit = 60

# the main loop - ends as soon as the window is closed
while window.is_open:
	# event processing
	for event in window.events:
		# request for closing the window
		if event.type == sf.Event.CLOSED:
			window.close()

		# activate the window for OpenGL rendering
		window.active = True

		# openGL drawing commands go here...

		# end the current frame and display its contents on screen
		window.display()
