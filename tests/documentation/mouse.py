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

if sf.Mouse.is_button_pressed(sf.Mouse.LEFT):
	# left click...
	
# get global mouse position
position = sf.Mouse.position
# or: position = sf.Mouse.get_position()

# set mouse position relative to a window
sf.Mouse.set_position(sf.Position(100, 200), window)
