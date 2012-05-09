#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64

cimport style, event, keyboard, joystick, mouse

#cimport joystick
#cimport videomode


#cdef extern from "SFML/Window.hpp" namespace "sf::Event":
    #cdef struct SizeEvent:
        #unsigned int Width
        #unsigned int Height


    #cdef struct KeyEvent:
        #int Code
        #bint Alt
        #bint Control
        #bint Shift
        #bint System


    #cdef struct MouseMoveEvent:
        #int X
        #int Y


    #cdef struct MouseButtonEvent:
        #int Button
        #int X
        #int Y


    #cdef struct TextEvent:
        #int Unicode


    #cdef struct MouseWheelEvent:
        #int Delta
        #int X
        #int Y


    #cdef struct JoystickMoveEvent:
        #unsigned int JoystickId
        #int Axis
        #float Position


    #cdef struct JoystickButtonEvent:
        #unsigned int JoystickId
        #unsigned int Button


    #cdef struct JoystickConnectEvent:
        #unsigned int JoystickId


cdef extern from "SFML/Window.hpp" namespace "sf":
    #cdef cppclass Event:
        #Event()
        #int Type
        #SizeEvent Size
        #KeyEvent Key
        #MouseMoveEvent MouseMove
        #MouseButtonEvent MouseButton
        #TextEvent Text
        #MouseWheelEvent MouseWheel
        #JoystickMoveEvent JoystickMove
        #JoystickButtonEvent JoystickButton
        #JoystickConnectEvent JoystickConnect
        
        
    cdef cppclass ContextSettings:
        ContextSettings()
        ContextSettings(unsigned int)
        ContextSettings(unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int)
        unsigned int depthBits   
        unsigned int stencilBits            
        unsigned int antialiasingLevel
        unsigned int majorVersion
        unsigned int minorVersion

    cdef cppclass VideoMode:
        VideoMode()
        VideoMode(unsigned int width, unsigned int height)
        VideoMode(unsigned int width, unsigned int height, unsigned int bits_per_pixel)
        bint isValid()
        unsigned int width
        unsigned int height
        unsigned int bitsPerPixel
        
        
    #cdef cppclass WindowHandle:
        #pass
        
        
    cdef cppclass Window:
        Window()
        #Window(VideoMode, char*)
        #Window(VideoMode, char*, unsigned long)
        #Window(VideoMode, char*, unsigned long, ContextSettings&)
        #Window(WindowHandle window_handle)
        #Window(WindowHandle window_handle, ContextSettings&)
        #void Close()
        #void Create(VideoMode, char*)
        #void Create(VideoMode, char*, unsigned long)
        #void Create(VideoMode, char*, unsigned long, ContextSettings&)
        #void Display()
        #void EnableKeyRepeat(bint)
        #void EnableVerticalSync(bint)
        #Uint32 GetFrameTime()
        #ContextSettings& GetSettings()
        #unsigned long GetSystemHandle()
        #bint IsOpened()
        #bint PollEvent(Event&)
        #void SetActive()
        #void SetActive(bint)
        #void SetIcon(unsigned int, unsigned int, Uint8*)
        #void SetJoystickThreshold(float)
        #void SetFramerateLimit(unsigned int)
        #void SetPosition(int, int)
        #void SetSize(unsigned int, unsigned int)
        #void SetTitle(char*)
        #void Show(bint)
        #void ShowMouseCursor(bint)
        #void UseVerticalSync(bint)
        #bint WaitEvent(Event&)
        #unsigned int GetHeight()
        #unsigned int GetWidth()
