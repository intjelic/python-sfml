########################################################################
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>   #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################


########################################################################
# Copyright 2011 Bastien Léonard. All rights reserved.                 #
#                                                                      #
# Redistribution and use in source and binary forms, with or without   #
# modification, are permitted provided that the following conditions   #
# are met:                                                             #
#                                                                      #
#    1. Redistributions of source code must retain the above copyright #
#    notice, this list of conditions and the following disclaimer.     #
#                                                                      #
#    2. Redistributions in binary form must reproduce the above        #
#    copyright notice, this list of conditions and the following       #
#    disclaimer in the documentation and/or other materials provided   #
#    with the distribution.                                            #
#                                                                      #
# THIS SOFTWARE IS PROVIDED BY BASTIEN LÉONARD ``AS IS'' AND ANY       #
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR   #
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BASTIEN LÉONARD OR         #
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,         #
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT     #
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF     #
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND  #
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   #
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT   #
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF   #
# SUCH DAMAGE.                                                         #
########################################################################


from declsystem cimport Int16, Uint8, Uint32

cimport style
cimport event
cimport mouse
cimport keyboard
cimport joystick
cimport videomode


cdef extern from "SFML/Window.hpp" namespace "sf::Event":
    cdef struct SizeEvent:
        unsigned int Width
        unsigned int Height


    cdef struct KeyEvent:
        int Code
        bint Alt
        bint Control
        bint Shift
        bint System


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


    cdef struct JoystickMoveEvent:
        unsigned int JoystickId
        int Axis
        float Position


    cdef struct JoystickButtonEvent:
        unsigned int JoystickId
        unsigned int Button


    cdef struct JoystickConnectEvent:
        unsigned int JoystickId


cdef extern from "SFML/Window.hpp" namespace "sf":
    cdef cppclass Event:
        Event()
        int Type
        SizeEvent Size
        KeyEvent Key
        MouseMoveEvent MouseMove
        MouseButtonEvent MouseButton
        TextEvent Text
        MouseWheelEvent MouseWheel
        JoystickMoveEvent JoystickMove
        JoystickButtonEvent JoystickButton
        JoystickConnectEvent JoystickConnect
        
        
    cdef cppclass ContextSettings:
        ContextSettings()
        ContextSettings(unsigned int)
        ContextSettings(unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int)
        unsigned int AntialiasingLevel
        unsigned int DepthBits
        unsigned int MajorVersion
        unsigned int MinorVersion
        unsigned int StencilBits


    cdef cppclass VideoMode:
        VideoMode()
        VideoMode(unsigned int width, unsigned int height)
        VideoMode(unsigned int width, unsigned int height,
                  unsigned int bits_per_pixel)
        bint IsValid()
        unsigned int Width
        unsigned int Height
        unsigned int BitsPerPixel
        
        
    cdef cppclass WindowHandle:
        pass
        
        
    cdef cppclass Window:
        Window()
        Window(VideoMode, char*)
        Window(VideoMode, char*, unsigned long)
        Window(VideoMode, char*, unsigned long, ContextSettings&)
        Window(WindowHandle window_handle)
        Window(WindowHandle window_handle, ContextSettings&)
        void Close()
        void Create(VideoMode, char*)
        void Create(VideoMode, char*, unsigned long)
        void Create(VideoMode, char*, unsigned long, ContextSettings&)
        void Display()
        void EnableKeyRepeat(bint)
        void EnableVerticalSync(bint)
        Uint32 GetFrameTime()
        ContextSettings& GetSettings()
        unsigned long GetSystemHandle()
        bint IsOpened()
        bint PollEvent(Event&)
        void SetActive()
        void SetActive(bint)
        void SetIcon(unsigned int, unsigned int, Uint8*)
        void SetJoystickThreshold(float)
        void SetFramerateLimit(unsigned int)
        void SetPosition(int, int)
        void SetSize(unsigned int, unsigned int)
        void SetTitle(char*)
        void Show(bint)
        void ShowMouseCursor(bint)
        void UseVerticalSync(bint)
        bint WaitEvent(Event&)
        unsigned int GetHeight()
        unsigned int GetWidth()
