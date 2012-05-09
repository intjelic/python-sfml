#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#from cpp cimport Vector2i, RenderWindow
#cdef cppclass Vector2i
#cdef cppclass RenderWindow

cdef extern from "SFML/Window.hpp" namespace "sf":
    cppclass Window
    
cdef extern from "SFML/System.hpp" namespace "sf":
    cppclass Vector2i
    
cdef extern from "SFML/Window.hpp" namespace "sf::Mouse":
    cdef cppclass Button
    int Left
    int Right
    int Middle
    int XButton1
    int XButton2
    int ButtonCount

    bint isButtonPressed(Button)
    Vector2i getPosition()
    Vector2i getPosition(Window&)
    void setPosition(Vector2i&)
    void setPosition(Vector2i&, Window&)
