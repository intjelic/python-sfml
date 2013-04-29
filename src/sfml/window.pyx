#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport cython
from cython.operator cimport dereference as deref, preincrement as inc

from libcpp.vector cimport vector

cimport libcpp.sfml as sf
from libcpp.sfml cimport Int8, Int16, Int32, Int64
from libcpp.sfml cimport Uint8, Uint16, Uint32, Uint64

cdef extern from "DerivableWindow.hpp":
	cdef cppclass DerivableWindow:
		DerivableWindow()
		DerivableWindow(sf.VideoMode, char*)
		DerivableWindow(sf.VideoMode, char*, unsigned long)
		DerivableWindow(sf.VideoMode, char*, unsigned long, sf.ContextSettings&)
		DerivableWindow(sf.WindowHandle window_handle)
		DerivableWindow(sf.WindowHandle window_handle, sf.ContextSettings&)
		void set_pyobj(void*)

__all__ = ['Style', 'VideoMode', 'ContextSettings', 'Event',
			'CloseEvent', 'ResizeEvent', 'FocusEvent', 'TextEvent',
			'KeyEvent', 'MouseWheelEvent', 'MouseButtonEvent',
			'MouseMoveEvent', 'MouseEvent', 'JoystickButtonEvent',
			'JoystickMoveEvent', 'JoystickConnectEvent', 'Pixels',
			'Window', 'Keyboard', 'Joystick', 'Mouse', 'Context']


from pysfml.system cimport Vector2, Vector3
from pysfml.system cimport to_vector2i, to_vector2u


cdef class Style:
	NONE = sf.style.None
	TITLEBAR = sf.style.Titlebar
	RESIZE = sf.style.Resize
	CLOSE = sf.style.Close
	FULLSCREEN = sf.style.Fullscreen
	DEFAULT = sf.style.Default


cdef public class Event[type PyEventType, object PyEventObject]:
	PRESSED = True
	RELEASED = False
	GAINED = True
	LOST = False
	ENTERED = True
	LEFT = False
	CONNECTED = True
	DISCONNECTED = False

	cdef sf.Event *p_this

	def __init__(self):
		self.p_this = new sf.Event()

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return ("sf.Event({0})".format(self))

	def __richcmp__(self, other, int op):
		if op == 2:
			return isinstance(self, other)
		elif op == 3:
			return not isinstance(self, other)
		else:
			return NotImplemented

	property type:
		def __get__(self):
			return self.p_this.type

		def __set__(self, sf.event.EventType type):
			self.p_this.type = type


cdef Event wrap_event(sf.Event *p):
	cdef Event event

	if p.type == sf.event.Closed:
		event = CloseEvent.__new__(CloseEvent)
	elif p.type == sf.event.Resized:
		event = ResizeEvent.__new__(ResizeEvent)
	elif p.type == sf.event.LostFocus:
		event = wrap_focusevent(p, Event.LOST)
	elif p.type == sf.event.GainedFocus:
		event = wrap_focusevent(p, Event.GAINED)
	elif p.type == sf.event.TextEntered:
		event = TextEvent.__new__(TextEvent)
	elif p.type == sf.event.KeyPressed:
		event = wrap_keyevent(p, Event.PRESSED)
	elif p.type == sf.event.KeyReleased:
		event = wrap_keyevent(p, Event.RELEASED)
	elif p.type == sf.event.MouseWheelMoved:
		event = MouseWheelEvent.__new__(MouseWheelEvent)
	elif p.type == sf.event.MouseButtonPressed:
		event = wrap_mousebuttonevent(p, Event.PRESSED)
	elif p.type == sf.event.MouseButtonReleased:
		event = wrap_mousebuttonevent(p, Event.RELEASED)
	elif p.type == sf.event.MouseMoved:
		event = MouseMoveEvent.__new__(MouseMoveEvent)
	elif p.type == sf.event.MouseEntered:
		event = wrap_mouseevent(p, Event.ENTERED)
	elif p.type == sf.event.MouseLeft:
		event = wrap_mouseevent(p, Event.LEFT)
	elif p.type == sf.event.JoystickButtonPressed:
		event = wrap_joystickbuttonevent(p, Event.PRESSED)
	elif p.type == sf.event.JoystickButtonReleased:
		event = wrap_joystickbuttonevent(p, Event.RELEASED)
	elif p.type == sf.event.JoystickMoved:
		event = JoystickMoveEvent.__new__(JoystickMoveEvent)
	elif p.type == sf.event.JoystickConnected:
		event = wrap_joystickconnectevent(p, Event.CONNECTED)
	elif p.type == sf.event.JoystickDisconnected:
		event = wrap_joystickconnectevent(p, Event.DISCONNECTED)

	event.p_this = p
	return event

cdef class CloseEvent(Event):
	def __str__(self):
		return "The window requested to be closed"

cdef class ResizeEvent(Event):
	def __str__(self):
		return "The window was resized"

	property size:
		def __get__(self):
			return Vector2(self.width, self.height)

		def __set__(self, size):
			self.width, self.height = size

	property width:
		def __get__(self):
			return self.p_this.size.width

		def __set__(self, unsigned int  width):
			self.p_this.size.width = width

	property height:
		def __get__(self):
			return self.p_this.size.height

		def __set__(self, unsigned int  height):
			self.p_this.size.height = height

cdef class FocusEvent(Event):
	cdef bint state

	def __str__(self):
		if self.gained: return "The window gained the focus"
		if self.lost: return "The window lost the focus"

	property gained:
		def __get__(self):
			return self.state

		def __set__(self, bint gained):
			self.state = gained

	property lost:
		def __get__(self):
			return not self.state

		def __set__(self, bint lost):
			self.state = not lost

cdef FocusEvent wrap_focusevent(sf.Event *p, bint state):
	cdef FocusEvent r = FocusEvent.__new__(FocusEvent)
	r.p_this = p
	r.state = state
	return r


cdef class TextEvent(Event):
	def __str__(self):
		return "A character was entered"

	property unicode:
		def __get__(self):
			return self.p_this.text.unicode

		def __set__(self, Uint32 unicode):
			self.p_this.text.unicode = unicode


cdef class KeyEvent(Event):
	cdef bint state

	def __str__(self):
		if self.pressed: return "A key was pressed"
		if self.released: return "A key was released"

	property pressed:
		def __get__(self):
			return self.state

		def __set__(self, bint pressed):
			self.state = pressed

	property released:
		def __get__(self):
			return not self.state

		def __set__(self, bint released):
			self.state = not released

	property code:
		def __get__(self):
			return self.p_this.key.code

		def __set__(self, sf.keyboard.Key code):
			self.p_this.key.code = code

	property alt:
		def __get__(self):
			return self.p_this.key.alt

		def __set__(self, bint alt):
			self.p_this.key.alt = alt

	property control:
		def __get__(self):
			return self.p_this.key.control

		def __set__(self, bint control):
			self.p_this.key.control = control

	property shift:
		def __get__(self):
			return self.p_this.key.shift

		def __set__(self, bint shift):
			self.p_this.key.shift = shift

	property system:
		def __get__(self):
			return self.p_this.key.system

		def __set__(self, bint system):
			self.p_this.key.system = system

cdef KeyEvent wrap_keyevent(sf.Event *p, bint state):
	cdef KeyEvent r = KeyEvent.__new__(KeyEvent)
	r.p_this = p
	r.state = state
	return r


cdef class MouseWheelEvent(Event):
	def __str__(self):
		return "The mouse wheel was scrolled"

	property delta:
		def __get__(self):
			return self.p_this.mouseWheel.delta

		def __set__(self, int delta):
			self.p_this.mouseWheel.delta = delta

	property position:
		def __get__(self):
			return Vector2(self.p_this.mouseWheel.x, self.p_this.mouseWheel.y)

		def __set__(self, position):
			self.p_this.mouseWheel.x, self.p_this.mouseWheel.y = position

cdef class MouseButtonEvent(Event):
	cdef bint state

	def __str__(self):
		if self.pressed: return "A mouse button was pressed"
		if self.released: return "A mouse button was released"

	property pressed:
		def __get__(self):
			return self.state

		def __set__(self, bint pressed):
			self.state = pressed

	property released:
		def __get__(self):
			return not self.state

		def __set__(self, bint released):
			self.state = not released

	property position:
		def __get__(self):
			return Vector2(self.p_this.mouseButton.x, self.p_this.mouseButton.y)

		def __set__(self, position):
			self.p_this.mouseButton.x, self.p_this.mouseButton.y = position

	property button:
		def __get__(self):
			return self.p_this.mouseButton.button

		def __set__(self, sf.mouse.Button button):
			self.p_this.mouseButton.button = button

cdef MouseButtonEvent wrap_mousebuttonevent(sf.Event *p, bint state):
	cdef MouseButtonEvent r = MouseButtonEvent.__new__(MouseButtonEvent)
	r.p_this = p
	r.state = state
	return r


cdef class MouseMoveEvent(Event):
	def __str__(self):
		return "The mouse cursor moved"

	property position:
		def __get__(self):
			return Vector2(self.p_this.mouseMove.x, self.p_this.mouseMove.y)

		def __set__(self, position):
			self.p_this.mouseMove.x, self.p_this.mouseMove.y = position


cdef class MouseEvent(Event):
	cdef bint state

	def __str__(self):
		if self.entered: return "The mouse cursor entered the area of the window"
		if self.left: return "The mouse cursor left the area of the window"

	property entered:
		def __get__(self):
			return self.state

		def __set__(self, bint entered):
			self.state = entered

	property left:
		def __get__(self):
			return not self.state

		def __set__(self, bint left):
			self.state = not left

cdef MouseEvent wrap_mouseevent(sf.Event *p, bint state):
	cdef MouseEvent r = MouseEvent.__new__(MouseEvent)
	r.p_this = p
	r.state = state
	return r


cdef class JoystickButtonEvent(Event):
	cdef bint state

	def __str__(self):
		if self.pressed: return "A joystick button was pressed"
		if self.released: return "A joystick button was released"

	property pressed:
		def __get__(self):
			return self.state

		def __set__(self, bint pressed):
			self.state = pressed

	property released:
		def __get__(self):
			return not self.state

		def __set__(self, bint released):
			self.state = not released

	property joystick_id:
		def __get__(self):
			return self.p_this.joystickButton.joystickId

		def __set__(self, unsigned int joystick_id):
			self.p_this.joystickButton.joystickId = joystick_id

	property button:
		def __get__(self):
			return self.p_this.joystickButton.button

		def __set__(self, unsigned int button):
			self.p_this.joystickButton.button = button

cdef JoystickButtonEvent wrap_joystickbuttonevent(sf.Event *p, bint state):
	cdef JoystickButtonEvent r = JoystickButtonEvent.__new__(JoystickButtonEvent)
	r.p_this = p
	r.state = state
	return r


cdef class JoystickMoveEvent(Event):
	def __str__(self):
		return "The joystick moved along an axis"

	property joystick_id:
		def __get__(self):
			return self.p_this.joystickMove.joystickId

		def __set__(self, unsigned int joystick_id):
			self.p_this.joystickMove.joystickId = joystick_id

	property axis:
		def __get__(self):
			return self.p_this.joystickMove.axis

		def __set__(self, sf.joystick.Axis axis):
			self.p_this.joystickMove.axis = axis

	property position:
		def __get__(self):
			return self.p_this.joystickMove.position

		def __set__(self, float position):
			self.p_this.joystickMove.position = position


cdef class JoystickConnectEvent(Event):
	cdef bint state

	def __str__(self):
		if self.connected: return "A joystick was connected"
		if self.disconnected: return "A joystick was disconnected"

	property connected:
		def __get__(self):
			return self.state

		def __set__(self, bint connected):
			self.state = connected

	property disconnected:
		def __get__(self):
			return not self.state

		def __set__(self, bint disconnected):
			self.state = not disconnected

	property joystick_id:
		def __get__(self):
			return self.p_this.joystickConnect.joystickId

		def __set__(self, unsigned int joystick_id):
			self.p_this.joystickConnect.joystickId = joystick_id

cdef JoystickConnectEvent wrap_joystickconnectevent(sf.Event *p, bint state):
	cdef JoystickConnectEvent r = JoystickConnectEvent.__new__(JoystickConnectEvent)
	r.p_this = p
	r.state = state
	return r


cdef public class VideoMode[type PyVideoModeType, object PyVideoModeObject]:
	cdef sf.VideoMode *p_this
	cdef bint delete_this

	def __init__(self, unsigned int width, unsigned int height, unsigned int bpp=32):
		self.p_this = new sf.VideoMode(width, height, bpp)
		self.delete_this = True

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	def __repr__(self):
		return ("VideoMode({0})".format(self))

	def __str__(self):
		return "{0}x{1}x{2}".format(self.width, self.height, self.bpp)

	def __richcmp__(VideoMode x, VideoMode y, int op):
		if op == 0:   return x.p_this[0] <	y.p_this[0]
		elif op == 2: return x.p_this[0] == y.p_this[0]
		elif op == 4: return x.p_this[0] >	y.p_this[0]
		elif op == 1: return x.p_this[0] <= y.p_this[0]
		elif op == 3: return x.p_this[0] != y.p_this[0]
		elif op == 5: return x.p_this[0] >= y.p_this[0]

	def __iter__(self):
		return iter((self.size, self.bpp))

	property width:
		def __get__(self):
			return self.p_this.width

		def __set__(self, unsigned int width):
			self.p_this.width = width

	property height:
		def __get__(self):
			return self.p_this.height

		def __set__(self, unsigned int height):
			self.p_this.height = height

	property size:
		def __get__(self):
			return Vector2(self.p_this.width, self.p_this.height)

		def __set__(self, value):
			width, height = value
			self.p_this.width = width
			self.p_this.height = height

	property bpp:
		def __get__(self):
			return self.p_this.bitsPerPixel

		def __set__(self, unsigned int bpp):
			self.p_this.bitsPerPixel = bpp

	@classmethod
	def get_desktop_mode(cls):
		cdef sf.VideoMode *p = new sf.VideoMode()
		p[0] = sf.videomode.getDesktopMode()

		return wrap_videomode(p, True)

	@classmethod
	def get_fullscreen_modes(cls):
		cdef list modes = []
		cdef vector[sf.VideoMode] *v = new vector[sf.VideoMode]()
		v[0] = sf.videomode.getFullscreenModes()

		cdef vector[sf.VideoMode].iterator it = v.begin()
		cdef sf.VideoMode vm

		while it != v.end():
			vm = deref(it)
			modes.append(VideoMode(vm.width, vm.height, vm.bitsPerPixel))
			inc(it)

		return modes

	def is_valid(self):
		return self.p_this.isValid()

cdef VideoMode wrap_videomode(sf.VideoMode *p, bint d):
	cdef VideoMode r = VideoMode.__new__(VideoMode, 640, 480, 32)
	r.p_this = p
	r.delete_this = d
	return r


cdef public class ContextSettings[type PyContextSettingsType, object PyContextSettingsObject]:
	cdef sf.ContextSettings *p_this

	def __init__(self, unsigned int depth=0, unsigned int stencil=0, unsigned int antialiasing=0, unsigned int major=2, unsigned int minor=0):
		self.p_this = new sf.ContextSettings(depth, stencil, antialiasing, major, minor)

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return ("ContextSettings({0})".format(self))

	def __str__(self):
		return "{0}db, {1}sb, {2}al, version {3}.{4}".format(self.depth_bits, self.stencil_bits, self.antialiasing_level, self.major_version, self.minor_version)

	def __iter__(self):
		return iter((self.depth_bits, self.stencil_bits, self.antialiasing_level, self.major_version, self.minor_version))

	property depth_bits:
		def __get__(self):
			return self.p_this.depthBits

		def __set__(self, unsigned int depth_bits):
			self.p_this.depthBits = depth_bits

	property stencil_bits:
		def __get__(self):
			return self.p_this.stencilBits

		def __set__(self, unsigned int stencil_bits):
			self.p_this.stencilBits = stencil_bits

	property antialiasing_level:
		def __get__(self):
			return self.p_this.antialiasingLevel

		def __set__(self, unsigned int antialiasing_level):
			self.p_this.antialiasingLevel = antialiasing_level

	property major_version:
		def __get__(self):
			return self.p_this.majorVersion

		def __set__(self, unsigned int major_version):
			self.p_this.majorVersion = major_version

	property minor_version:
		def __get__(self):
			return self.p_this.minorVersion

		def __set__(self, unsigned int minor_version):
			self.p_this.minorVersion = minor_version

cdef ContextSettings wrap_contextsettings(sf.ContextSettings *v):
	cdef ContextSettings r = ContextSettings.__new__(ContextSettings)
	r.p_this = v
	return r


cdef public class Pixels[type PyPixelsType, object PyPixelsObject]:
	cdef Uint8*			 p_array
	cdef unsigned int	 m_width
	cdef unsigned int	 m_height

	def __init__(self):
		raise UserWarning("This class is not meant to be used directly")

	def __getitem__(self, unsigned int index):
		return self.p_this[index]

	property width:
		def __get__(self):
			return self.m_width

	property height:
		def __get__(self):
			return self.m_height

	property data:
		def __get__(self):
			return (<char*>self.p_array)[:self.width*self.height*4]

cdef public Pixels wrap_pixels(Uint8 *p, unsigned int w, unsigned int h):
	cdef Pixels r = Pixels.__new__(Pixels)
	r.p_array, r.m_width, r.m_height = p, w, h
	return r


cdef public class Window[type PyWindowType, object PyWindowObject]:
	cdef sf.Window *p_window

	def __init__(self, VideoMode mode, title, Uint32 style=sf.style.Default, ContextSettings settings=None):
		cdef char* encoded_title

		if self.__class__.__name__ != 'RenderWindow':
			encoded_title_temporary = title.encode(u"ISO-8859-1")
			encoded_title = encoded_title_temporary

			if self.__class__ is Window:
				if not settings: self.p_window = new sf.Window(mode.p_this[0], encoded_title, style)
				else: self.p_window = new sf.Window(mode.p_this[0], encoded_title, style, settings.p_this[0])

			else:
				if not settings: self.p_window = <sf.Window*>new DerivableWindow(mode.p_this[0], encoded_title, style)
				else: self.p_window = <sf.Window*>new DerivableWindow(mode.p_this[0], encoded_title, style, settings.p_this[0])
				(<DerivableWindow*>self.p_window).set_pyobj(<void*>self)

	def __dealloc__(self):
		if self.__class__.__name__ == 'Window':
			del self.p_window

	def recreate(self, VideoMode mode, title, Uint32 style=sf.style.Default, ContextSettings settings=None):
		cdef char* encoded_title

		encoded_title_temporary = title.encode(u"ISO-8859-1")
		encoded_title = encoded_title_temporary

		if not settings: self.p_window.create(mode.p_this[0], encoded_title, style)
		else: self.p_window.create(mode.p_this[0], encoded_title, style, settings.p_this[0])

	def close(self):
		self.p_window.close()

	property is_open:
		def __get__(self):
			return self.p_window.isOpen()

	property settings:
		def __get__(self):
			cdef sf.ContextSettings *p = new sf.ContextSettings()
			p[0] = self.p_window.getSettings()
			return wrap_contextsettings(p)

		def __set__(self, settings):
			raise NotImplemented

	property events:
		def __get__(self):
			return Window.events_generator(self)

	def events_generator(window):
		cdef sf.Event *p = new sf.Event()

		while window.p_window.pollEvent(p[0]):
			yield wrap_event(p)
			p = new sf.Event()

		del p

	def poll_event(self):
		cdef sf.Event *p = new sf.Event()

		if self.p_window.pollEvent(p[0]):
			return wrap_event(p)

	def wait_event(self):
		cdef sf.Event *p = new sf.Event()

		if self.p_window.waitEvent(p[0]):
			return wrap_event(p)

	property position:
		def __get__(self):
			return Vector2(self.p_window.getPosition().x, self.p_window.getPosition().y)

		def __set__(self, position):
			self.p_window.setPosition(to_vector2i(position))

	property size:
		def __get__(self):
			return Vector2(self.p_window.getSize().x, self.p_window.getSize().y)

		def __set__(self, size):
			self.p_window.setSize(to_vector2u(size))

	property title:
		def __set__(self, title):
			encoded_title = title.encode(u"ISO-8859-1")
			self.p_window.setTitle(encoded_title)

	property icon:
		def __set__(self, Pixels icon):
			self.p_window.setIcon(icon.m_width, icon.m_height, icon.p_array)

	property visible:
		def __set__(self, bint visible):
			self.p_window.setVisible(visible)

	def show(self):
		self.visible = True

	def hide(self):
		self.visible = False

	property vertical_synchronization:
		def __set__(self, bint vertical_synchronization):
			self.p_window.setVerticalSyncEnabled(vertical_synchronization)

	property mouse_cursor_visible:
		def __set__(self, bint mouse_cursor_visible):
			self.p_window.setMouseCursorVisible(mouse_cursor_visible)

	property key_repeat_enabled:
		def __set__(self, bint key_repeat_enabled):
			self.p_window.setKeyRepeatEnabled(key_repeat_enabled)

	property framerate_limit:
		def __set__(self, unsigned int framerate_limit):
			self.p_window.setFramerateLimit(framerate_limit)

	property joystick_threshold:
		def __set__(self, float joystick_threshold):
			self.p_window.setJoystickThreshold(joystick_threshold)

	property active:
		def __set__(self, bint active):
			self.p_window.setActive(active)

	def display(self):
		self.p_window.display()

	property system_handle:
		def __get__(self):
			return <unsigned long>self.p_window.getSystemHandle()

	def on_create(self): pass
	def on_resize(self): pass


cdef class Keyboard:
	A = sf.keyboard.A
	B = sf.keyboard.B
	C = sf.keyboard.C
	D = sf.keyboard.D
	E = sf.keyboard.E
	F = sf.keyboard.F
	G = sf.keyboard.G
	H = sf.keyboard.H
	I = sf.keyboard.I
	J = sf.keyboard.J
	K = sf.keyboard.K
	L = sf.keyboard.L
	M = sf.keyboard.M
	N = sf.keyboard.N
	O = sf.keyboard.O
	P = sf.keyboard.P
	Q = sf.keyboard.Q
	R = sf.keyboard.R
	S = sf.keyboard.S
	T = sf.keyboard.T
	U = sf.keyboard.U
	V = sf.keyboard.V
	W = sf.keyboard.W
	X = sf.keyboard.X
	Y = sf.keyboard.Y
	Z = sf.keyboard.Z
	NUM0 = sf.keyboard.Num0
	NUM1 = sf.keyboard.Num1
	NUM2 = sf.keyboard.Num2
	NUM3 = sf.keyboard.Num3
	NUM4 = sf.keyboard.Num4
	NUM5 = sf.keyboard.Num5
	NUM6 = sf.keyboard.Num6
	NUM7 = sf.keyboard.Num7
	NUM8 = sf.keyboard.Num8
	NUM9 = sf.keyboard.Num9
	ESCAPE = sf.keyboard.Escape
	L_CONTROL = sf.keyboard.LControl
	L_SHIFT = sf.keyboard.LShift
	L_ALT = sf.keyboard.LAlt
	L_SYSTEM = sf.keyboard.LSystem
	R_CONTROL = sf.keyboard.RControl
	R_SHIFT = sf.keyboard.RShift
	R_ALT = sf.keyboard.RAlt
	R_SYSTEM = sf.keyboard.RSystem
	MENU = sf.keyboard.Menu
	L_BRACKET = sf.keyboard.LBracket
	R_BRACKET = sf.keyboard.RBracket
	SEMI_COLON = sf.keyboard.SemiColon
	COMMA = sf.keyboard.Comma
	PERIOD = sf.keyboard.Period
	QUOTE = sf.keyboard.Quote
	SLASH = sf.keyboard.Slash
	BACK_SLASH = sf.keyboard.BackSlash
	TILDE = sf.keyboard.Tilde
	EQUAL = sf.keyboard.Equal
	DASH = sf.keyboard.Dash
	SPACE = sf.keyboard.Space
	RETURN = sf.keyboard.Return
	BACK_SPACE = sf.keyboard.BackSpace
	TAB = sf.keyboard.Tab
	PAGE_UP = sf.keyboard.PageUp
	PAGE_DOWN = sf.keyboard.PageDown
	END = sf.keyboard.End
	HOME = sf.keyboard.Home
	INSERT = sf.keyboard.Insert
	DELETE = sf.keyboard.Delete
	ADD = sf.keyboard.Add
	SUBTRACT = sf.keyboard.Subtract
	MULTIPLY = sf.keyboard.Multiply
	DIVIDE = sf.keyboard.Divide
	LEFT = sf.keyboard.Left
	RIGHT = sf.keyboard.Right
	UP = sf.keyboard.Up
	DOWN = sf.keyboard.Down
	NUMPAD0 = sf.keyboard.Numpad0
	NUMPAD1 = sf.keyboard.Numpad1
	NUMPAD2 = sf.keyboard.Numpad2
	NUMPAD3 = sf.keyboard.Numpad3
	NUMPAD4 = sf.keyboard.Numpad4
	NUMPAD5 = sf.keyboard.Numpad5
	NUMPAD6 = sf.keyboard.Numpad6
	NUMPAD7 = sf.keyboard.Numpad7
	NUMPAD8 = sf.keyboard.Numpad8
	NUMPAD9 = sf.keyboard.Numpad9
	F1 = sf.keyboard.F1
	F2 = sf.keyboard.F2
	F3 = sf.keyboard.F3
	F4 = sf.keyboard.F4
	F5 = sf.keyboard.F5
	F6 = sf.keyboard.F6
	F7 = sf.keyboard.F7
	F8 = sf.keyboard.F8
	F9 = sf.keyboard.F9
	F10 = sf.keyboard.F10
	F11 = sf.keyboard.F11
	F12 = sf.keyboard.F12
	F13 = sf.keyboard.F13
	F14 = sf.keyboard.F14
	F15 = sf.keyboard.F15
	PAUSE = sf.keyboard.Pause
	KEY_COUNT = sf.keyboard.KeyCount

	def __init__(self):
		raise NotImplementedError("This class is not meant to be instantiated!")

	@classmethod
	def is_key_pressed(cls, int key):
		return sf.keyboard.isKeyPressed(<sf.keyboard.Key>key)


cdef class Joystick:
	COUNT = sf.joystick.Count
	BUTTON_COUNT = sf.joystick.ButtonCount
	AXIS_COUNT = sf.joystick.AxisCount

	X = sf.joystick.X
	Y = sf.joystick.Y
	Z = sf.joystick.Z
	R = sf.joystick.R
	U = sf.joystick.U
	V = sf.joystick.V
	POV_X = sf.joystick.PovX
	POV_Y = sf.joystick.PovY

	def __init__(self):
		raise NotImplementedError("This class is not meant to be instantiated!")

	@classmethod
	def is_connected(cls, unsigned int joystick):
		return sf.joystick.isConnected(joystick)

	@classmethod
	def get_button_count(cls, unsigned int joystick):
		return sf.joystick.getButtonCount(joystick)

	@classmethod
	def has_axis(cls, unsigned int joystick, int axis):
		return sf.joystick.hasAxis(joystick, <sf.joystick.Axis>axis)

	@classmethod
	def is_button_pressed(cls, unsigned int joystick, unsigned int button):
		return sf.joystick.isButtonPressed(joystick, button)

	@classmethod
	def get_axis_position(cls, unsigned int joystick, int axis):
		return sf.joystick.getAxisPosition(joystick, <sf.joystick.Axis> axis)

	@classmethod
	def update(cls):
		sf.joystick.update()


cdef class Mouse:
	LEFT = sf.mouse.Left
	RIGHT = sf.mouse.Right
	MIDDLE = sf.mouse.Middle
	X_BUTTON1 = sf.mouse.XButton1
	X_BUTTON2 = sf.mouse.XButton2
	BUTTON_COUNT = sf.mouse.ButtonCount

	def __init__(self):
		raise NotImplementedError("This class is not meant to be instantiated!")

	@classmethod
	def is_button_pressed(cls, int button):
		return sf.mouse.isButtonPressed(<sf.mouse.Button>button)

	@classmethod
	def get_position(cls, Window window=None):
		cdef sf.Vector2i p

		if window is None: p = sf.mouse.getPosition()
		else: p = sf.mouse.getPosition(window.p_window[0])

		return Vector2(p.x, p.y)

	@classmethod
	def set_position(cls, position, Window window=None):
		cdef sf.Vector2i p
		p.x, p.y = position

		if window is None: sf.mouse.setPosition(p)
		else: sf.mouse.setPosition(p, window.p_window[0])


cdef class Context:
	cdef sf.Context *p_this

	def __init__(self):
		self.p_this = new sf.Context()

	def __dealloc__(self):
		del self.p_this

	property active:
		def __set__(self, bint active):
			self.p_this.setActive(active)
