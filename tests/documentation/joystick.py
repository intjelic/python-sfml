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

# is joystick #0 connected ?
connected = sf.Joystick.is_connected(0)

# how many button does joystick #0 support ?
buttons = sf.Joystick.get_button_count(0)

# does joystick # define a X axis ?
has_X = sf.Joystick.has_axis(0, sf.Joystick.X)

# is button #2 pressed on joystick #0 ?
pressed = sf.Joystick.is_button_pressed(0, 2)

# what's the current position of the Y axis on joystick #0?
position = sf.Joystick.get_axis_position(0, sf.Joystick.Y)

