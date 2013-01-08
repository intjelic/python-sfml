#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64
from dsystem cimport Vector2i, Vector2u, Vector2f

cimport style, event, videomode, keyboard, joystick, mouse

cdef extern from "SFML/Window.hpp" namespace "sf::Event":
	cdef struct SizeEvent:
		unsigned int width
		unsigned int height

	cdef struct KeyEvent:
		int code
		bint alt
		bint control
		bint shift
		bint system
		
	cdef struct TextEvent:
		Uint32 unicode

	cdef struct MouseMoveEvent:
		int x
		int y

	cdef struct MouseButtonEvent:
		int button
		int x
		int y

	cdef struct MouseWheelEvent:
		int delta
		int x
		int y

	cdef struct JoystickConnectEvent:
		unsigned int joystickId

	cdef struct JoystickMoveEvent:
		unsigned int joystickId
		int axis
		float position

	cdef struct JoystickButtonEvent:
		unsigned int joystickId
		unsigned int button

cdef extern from "SFML/Window.hpp" namespace "sf":
	cdef cppclass Event:
		event.EventType type
		SizeEvent size
		KeyEvent key
		TextEvent text		
		MouseMoveEvent mouseMove
		MouseButtonEvent mouseButton
		MouseWheelEvent mouseWheel		
		JoystickMoveEvent joystickMove
		JoystickButtonEvent joystickButton
		JoystickConnectEvent joystickConnect

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
		bint operator==(VideoMode&)
		bint operator!=(VideoMode&)
		bint operator<(VideoMode&)
		bint operator>(VideoMode&)
		bint operator<=(VideoMode&)
		bint operator>=(VideoMode&)

	cdef cppclass WindowHandle

	cdef cppclass Window:
		Window()
		Window(VideoMode, char*)
		Window(VideoMode, char*, unsigned long)
		Window(VideoMode, char*, unsigned long, ContextSettings&)
		Window(WindowHandle window_handle)
		Window(WindowHandle window_handle, ContextSettings&)
		void create(VideoMode, char*)
		void create(VideoMode, char*, unsigned long)
		void create(VideoMode, char*, unsigned long, ContextSettings&)
		void create(WindowHandle, ContextSettings&)
		void close()
		bint isOpen()
		ContextSettings& getSettings()
		bint pollEvent(Event&)
		bint waitEvent(Event&)
		Vector2i getPosition()
		void setPosition(Vector2i&)
		Vector2u getSize()
		void setSize(Vector2u)
		void setTitle(char*)
		void setIcon(unsigned int, unsigned int, Uint8*)
		void setVisible(bint)
		void setVerticalSyncEnabled(bint)
		void setMouseCursorVisible(bint)
		void setKeyRepeatEnabled(bint)
		void setFramerateLimit(unsigned int)
		void setJoystickThreshold(float)
		bint setActive()
		bint setActive(bint)
		void display()
		WindowHandle getSystemHandle()
		void onCreate()
		void onResize()

	cdef cppclass Context:
		Context()
		bint setActive(bint)

cdef extern from "pysfml/derivablewindow.hpp":
	cdef cppclass DerivableWindow:
		DerivableWindow()
		DerivableWindow(VideoMode, char*)
		DerivableWindow(VideoMode, char*, unsigned long)
		DerivableWindow(VideoMode, char*, unsigned long, ContextSettings&)
		DerivableWindow(WindowHandle window_handle)
		DerivableWindow(WindowHandle window_handle, ContextSettings&)
		void set_pyobj(void*)
		
