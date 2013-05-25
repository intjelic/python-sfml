#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


from libcpp.sfml cimport Vector2i
from libcpp.sfml cimport Window

cdef extern from "SFML/Window.hpp" namespace "sf::Mouse":
	cdef enum Button:
		Left
		Right
		Middle
		XButton1
		XButton2
		ButtonCount

	bint isButtonPressed(Button)
	Vector2i getPosition()
	Vector2i getPosition(const Window&)
	void setPosition(const Vector2i&)
	void setPosition(const Vector2i&, const Window&)
