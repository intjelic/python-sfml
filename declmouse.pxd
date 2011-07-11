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


# This file declares the mouse constants, in order to avoid clashes
# with other enums which have the same members


cimport decl


# Alias for the sf::Mouse::Button enum
cdef extern from "SFML/Graphics.hpp" namespace "sf::Mouse":
    cdef cppclass Button:
        pass


cdef extern from "SFML/Graphics.hpp" namespace "sf::Mouse":
    int Left
    int Right
    int Middle
    int XButton1
    int XButton2
    int ButtonCount

    cdef bint IsButtonPressed(Button)
    cdef decl.Vector2i GetPosition()
    cdef decl.Vector2i GetPosition(decl.RenderWindow&)
    cdef void SetPosition(decl.Vector2i&)
    cdef void SetPosition(decl.Vector2i&, decl.RenderWindow&)
