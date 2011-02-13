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


cimport declkey
cimport declmouse


# Useful sometimes to print values for debugging
cdef extern from "stdio.h":
    void printf(char*, ...)


# Declaration of the standard std::string class.  This is useful
# e.g. when you get a std::string and want to return a Python string,
# use c_str() and it will be converted to a Python object
# automatically if needed.
# Do not confuse with String, which is sf::String!
cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()


cdef extern from "SFML/Graphics.hpp" namespace "sf::Style":
    int None
    int Titlebar
    int Resize
    int Close
    int Fullscreen


cdef extern from "SFML/Graphics.hpp" namespace "sf::Event":
    cdef struct KeyEvent:
        int Code
        bint Alt
        bint Control
        bint Shift

    cdef struct MouseMoveEvent:
        int X
        int Y

    cdef struct MouseButtonEvent:
        int Button
        int X
        int Y

    cdef struct TextEvent:
        int Unicode

    cdef struct MouseWheelEvent:
        int Delta
        int X
        int Y

    cdef struct JoyMoveEvent:
        unsigned int JoystickId
        int Axis
        float Position

    cdef struct JoyButtonEvent:
        unsigned int JoystickId
        unsigned int Button

    cdef struct SizeEvent:
        unsigned int Width
        unsigned int Height



cdef extern from "SFML/Graphics.hpp" namespace "sf::Unicode":
    cdef cppclass Text:
        Text()


cdef extern from "SFML/Graphics.hpp" namespace "sf":
    # You normally shouldn't use Vector2f in pure Python, use tuples
    # instead
    cdef cppclass Vector2f:
        Vector2f()
        Vector2f(float x, float y)
        float x
        float y

    cdef cppclass IntRect:
        IntRect()
        IntRect(int LeftCoord, int TopCoord, int RightCoord, int BottomCoord)
        int Left
        int Top
        int Right
        int Bottom

    cdef cppclass FloatRect:
        FloatRect()
        FloatRect(float LeftCoord, float TopCoord, float RightCoord,
                  float BottomCoord)
        float Left
        float Top
        float Right
        float Bottom

    cdef cppclass Color:
        Color()
        Color(unsigned int r, unsigned int g, unsigned b)
        Color(unsigned int r, unsigned int g, unsigned b, unsigned int a)
        unsigned int r
        unsigned int g
        unsigned int b
        unsigned int a

    cdef cppclass Event:
        Event()
        int Type
        KeyEvent Key
        MouseMoveEvent MouseMove
        MouseButtonEvent MouseButton
        TextEvent Text
        MouseWheelEvent MouseWheel
        JoyMoveEvent JoyMove
        JoyButtonEvent JoyButton
        SizeEvent Size

    cdef cppclass Input:
        Input()
        bint IsKeyDown(declkey.Code KeyCode)
        bint IsMouseButtonDown(declmouse.Button Button)
        bint IsJoystickButtonDown(unsigned int JoyId, unsigned int Button)
        int GetMouseX()
        int GetMouseY()
        float GetJoystickAxis(unsigned int JoyId, int Axis)


    cdef cppclass WindowSettings:
        WindowSettings(unsigned int depth, unsigned int stencil,
                       unsigned int antialiasing)
        unsigned int DepthBits
        unsigned int StencilBits
        unsigned int AntialiasingLevel

    cdef cppclass VideoMode:
        VideoMode()
        VideoMode(unsigned int width, unsigned int height,
                  unsigned int bits_per_pixel)
        bint IsValid()
        bint operator==(VideoMode& other)
        bint operator!=(VideoMode& other)
        unsigned int Width
        unsigned int Height
        unsigned int BitsPerPixel


    cdef cppclass Image:
        Image()
        unsigned int GetHeight()
        Color& GetPixel(unsigned int, unsigned int)
        unsigned int GetWidth() 
        bint IsSmooth()
        bint LoadFromFile(char*)
        void SetSmooth(bint)

    cdef cppclass Drawable:
        Drawable()

    cdef cppclass String:
        String()

        # The real C++ class doesn't take a char*, but it does work
        # to call it with char* (via implicit constructors), that's
        # all we need
        String(char*)
        Vector2f& GetPosition()
        FloatRect GetRect()
        Text& GetText()
        void SetPosition(float, float)
        void SetText(char*)
        void SetX(float)
        void SetY(float)

    cdef cppclass Sprite:
        Sprite()
        Sprite(Image&)
        Image* GetImage()
        Vector2f& GetPosition()
        Vector2f GetSize()
        IntRect& GetSubRect()
        void SetImage(Image&)
        void SetPosition(float X, float Y)
        void SetSubRect(IntRect&)
        void SetX(float)
        void SetY(float)

    cdef cppclass View:
        View()
        void Move(float, float)
        void SetFromRect(FloatRect&)
        void Zoom(float)

    cdef cppclass RenderWindow:
        RenderWindow()
        RenderWindow(VideoMode mode, char* title)
        RenderWindow(VideoMode mode, char* title, unsigned long window_style,
                     WindowSettings& window_settings)
        void Clear()
        void Clear(Color&)
        void Close()

        # Cython doesn't seem to support optional parameters (should
        # be View*=NULL), but it does support method overloading
        Vector2f ConvertCoords(unsigned int, unsigned int)
        Vector2f ConvertCoords(unsigned int, unsigned int, View*)
        void Display()
        void Draw(Drawable&)
        View& GetDefaultView()
        bint GetEvent(Event&)
        float GetFrameTime()
        Input& GetInput()
        unsigned int GetHeight()
        View& GetView()
        unsigned int GetWidth()
        void SetCursorPosition(unsigned int, unsigned int)
        void SetFramerateLimit(unsigned int)
        void SetSize(unsigned int, unsigned int)
        void SetView(View&)
