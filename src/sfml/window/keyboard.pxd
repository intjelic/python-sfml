#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cdef extern from "SFML/Window.hpp" namespace "sf::Keyboard":
    cdef cppclass Key
    int A
    int B
    int C
    int D
    int E
    int F
    int G
    int H
    int I
    int J
    int K
    int L
    int M
    int N
    int O
    int P
    int Q
    int R
    int S
    int T
    int U
    int V
    int W
    int X
    int Y
    int Z
    int Num0
    int Num1
    int Num2
    int Num3
    int Num4
    int Num5
    int Num6
    int Num7
    int Num8
    int Num9
    int Escape
    int LControl
    int LShift
    int LAlt
    int LSystem
    int RControl
    int RShift
    int RAlt
    int RSystem
    int Menu
    int LBracket
    int RBracket
    int SemiColon
    int Comma
    int Period
    int Quote
    int Slash
    int BackSlash
    int Tilde
    int Equal
    int Dash
    int Space
    int Return
    int Back
    int Tab
    int PageUp
    int PageDown
    int End
    int Home
    int Insert
    int Delete
    int Add
    int Subtract
    int Multiply
    int Divide
    int Left
    int Right
    int Up
    int Down
    int Numpad0
    int Numpad1
    int Numpad2
    int Numpad3
    int Numpad4
    int Numpad5
    int Numpad6
    int Numpad7
    int Numpad8
    int Numpad9
    int F1
    int F2
    int F3
    int F4
    int F5
    int F6
    int F7
    int F8
    int F9
    int F10
    int F11
    int F12
    int F13
    int F14
    int F15
    int Pause
    int KeyCount
    
    bint IsKeyPressed(Key)
