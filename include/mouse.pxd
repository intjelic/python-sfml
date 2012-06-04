#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from dwindow cimport Window
from dsystem cimport Vector2i

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
	Vector2i getPosition(Window&)
	void setPosition(Vector2i&)
	void setPosition(Vector2i&, Window&)