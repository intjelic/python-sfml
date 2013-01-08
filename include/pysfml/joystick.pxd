#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cdef extern from "SFML/Window.hpp" namespace "sf::Joystick":
	cdef enum Axis:
		Count
		ButtonCount
		AxisCount
		X
		Y
		Z
		R
		U
		V
		PovX
		PovY

	bint isConnected(unsigned int)
	unsigned int getButtonCount(unsigned int)
	bint hasAxis(unsigned int, Axis)
	bint isButtonPressed(unsigned int, unsigned int)
	float getAxisPosition(unsigned int, Axis)
	void update()
