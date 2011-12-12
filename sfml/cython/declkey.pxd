# -*- python -*-
# -*- coding: utf-8 -*-

# Copyright 2010, 2011 Bastien Léonard. All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:

#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.

#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.

# THIS SOFTWARE IS PROVIDED BY BASTIEN LÉONARD ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BASTIEN LÉONARD OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.


# This file declares the key constants, in order to avoid clashes with
# other enums which have the same members




# Hack for static methods and attributes
cdef extern from "SFML/Graphics.hpp" namespace "sf::Keyboard":
    cdef cppclass Key:
        pass

    bint IsKeyPressed(Key)

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
