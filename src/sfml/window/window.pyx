# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cimport cython
from cython.operator cimport dereference as deref, preincrement as inc
from cpython.version cimport PY_VERSION_HEX

from libcpp.vector cimport vector

from enum import IntEnum
import weakref

cimport sfml as sf
from sfml cimport Int8, Int16, Int32, Int64
from sfml cimport Uint8, Uint16, Uint32, Uint64

from pysfml.system cimport Vector2, Vector3, Time
from pysfml.system cimport to_vector2i, to_vector2u
from pysfml.system cimport wrap_vector2i
from pysfml.system cimport to_string, wrap_string, wrap_time
from pysfml.system cimport popLastErrorMessage, import_sfml__system

import_sfml__system()

cdef extern from "pysfml/window/DerivableWindow.hpp":
    cdef cppclass DerivableWindow:
        DerivableWindow(object)

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::window_compat":
    sf.ContextSettings makeContextSettings(unsigned int depth, unsigned int stencil, unsigned int antialiasing, unsigned int major, unsigned int minor, Uint32 attributes)
    sf.VideoMode makeVideoMode(unsigned int width, unsigned int height, unsigned int bits_per_pixel)
    void createWindow(sf.Window& window, sf.VideoMode mode, const sf.String& title, Uint32 style, const sf.ContextSettings& settings)
    void createWindowWithState(sf.Window& window, sf.VideoMode mode, const sf.String& title, Uint32 style, Uint32 state, const sf.ContextSettings& settings)
    bint pollEvent(sf.Window& window, sf.Event& event)
    bint waitEvent(sf.Window& window, sf.Event& event)
    bint waitEventWithTimeout(sf.Window& window, sf.Event& event, const sf.Time& timeout)
    void setIcon(sf.Window& window, unsigned int width, unsigned int height, const Uint8* pixels)
    void setMinimumSize(sf.Window& window, bint hasValue, unsigned int width, unsigned int height)
    void setMaximumSize(sf.Window& window, bint hasValue, unsigned int width, unsigned int height)
    void setMouseCursorGrabbed(sf.Window& window, bint grabbed)

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::context_compat":
    sf.ContextSettings getContextSettings "pysfml::context_compat::getSettings"(const sf.Context& context)
    bint isContextExtensionAvailable "pysfml::context_compat::isExtensionAvailable"(const char* name)
    Uint64 getContextFunction "pysfml::context_compat::getFunction"(const char* name)
    Uint64 getActiveContextId "pysfml::context_compat::getActiveContextId"()

cdef extern from "pysfml/window/compat.hpp":
    bint isScancodePressed "pysfml::keyboard_compat::isScancodePressed"(int scancode)
    int localizeScancode "pysfml::keyboard_compat::localize"(int scancode)
    int delocalizeKey "pysfml::keyboard_compat::delocalize"(sf.keyboard.Key key)
    sf.String getScancodeDescription "pysfml::keyboard_compat::getDescription"(int scancode)

cdef extern from "SFML/Window/Cursor.hpp":
    cdef cppclass SfCursor "sf::Cursor":
        SfCursor()

cdef extern from "pysfml/window/compat.hpp":
    sf.String getClipboardString "pysfml::clipboard_compat::getString"()
    void setClipboardString "pysfml::clipboard_compat::setString"(const sf.String& text)
    SfCursor* createCursorFromSystem "pysfml::cursor_compat::createFromSystem"(int type)
    SfCursor* createCursorFromPixels "pysfml::cursor_compat::createFromPixels"(const Uint8* pixels, unsigned int width, unsigned int height, unsigned int hotspotX, unsigned int hotspotY)
    void applyMouseCursor "pysfml::cursor_compat::setMouseCursor"(sf.Window& window, const SfCursor& cursor)

from libc.stdlib cimport malloc, free

__all__ = ['Style', 'State', 'VideoMode', 'ContextSettings', 'EventType', 'Event', 'ClosedEvent', 'ResizedEvent',
            'FocusLostEvent', 'FocusGainedEvent', 'TextEnteredEvent',
            'KeyPressedEvent', 'KeyReleasedEvent', 'MouseWheelScrolledEvent',
            'MouseButtonPressedEvent', 'MouseButtonReleasedEvent',
            'MouseMovedEvent', 'MouseMovedRawEvent', 'MouseEnteredEvent',
            'MouseLeftEvent', 'JoystickButtonPressedEvent',
            'JoystickButtonReleasedEvent', 'JoystickMovedEvent',
            'JoystickConnectedEvent', 'JoystickDisconnectedEvent',
            'TouchBeganEvent', 'TouchMovedEvent', 'TouchEndedEvent',
            'SensorChangedEvent', 'Clipboard', 'Cursor', 'CursorType',
            'Window', 'Keyboard', 'Scancode', 'Joystick',
            'Mouse', 'Touch', 'Sensor', 'Context']

if PY_VERSION_HEX >= 0x03000000:
    unichr = chr


_context_registry = weakref.WeakValueDictionary()


def _register_context(context):
    active_context_id = getActiveContextId()

    if active_context_id:
        _context_registry[active_context_id] = context

class Style(IntEnum):
    NONE = sf.style.None
    TITLEBAR = sf.style.Titlebar
    RESIZE = sf.style.Resize
    CLOSE = sf.style.Close
    DEFAULT = sf.style.Default


class State(IntEnum):
    WINDOWED = 0
    FULLSCREEN = 1


class EventType(IntEnum):
    CLOSED = sf.event.Closed
    RESIZED = sf.event.Resized
    LOST_FOCUS = sf.event.LostFocus
    GAINED_FOCUS = sf.event.GainedFocus
    TEXT_ENTERED = sf.event.TextEntered
    KEY_PRESSED = sf.event.KeyPressed
    KEY_RELEASED = sf.event.KeyReleased
    MOUSE_WHEEL_SCROLLED = sf.event.MouseWheelScrolled
    MOUSE_BUTTON_PRESSED = sf.event.MouseButtonPressed
    MOUSE_BUTTON_RELEASED = sf.event.MouseButtonReleased
    MOUSE_MOVED = sf.event.MouseMoved
    MOUSE_MOVED_RAW = sf.event.MouseMovedRaw
    MOUSE_ENTERED = sf.event.MouseEntered
    MOUSE_LEFT = sf.event.MouseLeft
    JOYSTICK_BUTTON_PRESSED = sf.event.JoystickButtonPressed
    JOYSTICK_BUTTON_RELEASED = sf.event.JoystickButtonReleased
    JOYSTICK_MOVED = sf.event.JoystickMoved
    JOYSTICK_CONNECTED = sf.event.JoystickConnected
    JOYSTICK_DISCONNECTED = sf.event.JoystickDisconnected
    TOUCH_BEGAN = sf.event.TouchBegan
    TOUCH_MOVED = sf.event.TouchMoved
    TOUCH_ENDED = sf.event.TouchEnded
    SENSOR_CHANGED = sf.event.SensorChanged
    COUNT = sf.event.Count


cdef public class Event[type PyEventType, object PyEventObject]:
    cdef sf.Event *p_this

    CLOSED = EventType.CLOSED
    RESIZED = EventType.RESIZED
    LOST_FOCUS = EventType.LOST_FOCUS
    GAINED_FOCUS = EventType.GAINED_FOCUS
    TEXT_ENTERED = EventType.TEXT_ENTERED
    KEY_PRESSED = EventType.KEY_PRESSED
    KEY_RELEASED = EventType.KEY_RELEASED
    MOUSE_WHEEL_SCROLLED = EventType.MOUSE_WHEEL_SCROLLED
    MOUSE_BUTTON_PRESSED = EventType.MOUSE_BUTTON_PRESSED
    MOUSE_BUTTON_RELEASED = EventType.MOUSE_BUTTON_RELEASED
    MOUSE_MOVED = EventType.MOUSE_MOVED
    MOUSE_MOVED_RAW = EventType.MOUSE_MOVED_RAW
    MOUSE_ENTERED = EventType.MOUSE_ENTERED
    MOUSE_LEFT = EventType.MOUSE_LEFT
    JOYSTICK_BUTTON_PRESSED = EventType.JOYSTICK_BUTTON_PRESSED
    JOYSTICK_BUTTON_RELEASED = EventType.JOYSTICK_BUTTON_RELEASED
    JOYSTICK_MOVED = EventType.JOYSTICK_MOVED
    JOYSTICK_CONNECTED = EventType.JOYSTICK_CONNECTED
    JOYSTICK_DISCONNECTED = EventType.JOYSTICK_DISCONNECTED
    TOUCH_BEGAN = EventType.TOUCH_BEGAN
    TOUCH_MOVED = EventType.TOUCH_MOVED
    TOUCH_ENDED = EventType.TOUCH_ENDED
    SENSOR_CHANGED = EventType.SENSOR_CHANGED
    COUNT = EventType.COUNT

    def __cinit__(self):
        self.p_this = NULL

    def __init__(self, type=EventType.CLOSED):
        if self.p_this == NULL:
            self.p_this = new sf.Event()
        self._set_type(type)

    def __dealloc__(self):
        if self.p_this != NULL:
            del self.p_this

    def __repr__(self):
        return "{0}(type={1})".format(self.__class__.__name__, self.type)

    def __richcmp__(self, other, int op):
        if op == 2:
            return self.type == other
        elif op == 3:
            return self.type != other
        else:
            return NotImplemented

    property type:
        def __get__(self):
            return EventType(self.p_this.type)

    cdef void _set_type(self, int type):
        self.p_this.type = <sf.event.EventType>type


cdef class ClosedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.CLOSED)


cdef class ResizedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.RESIZED)

    property size:
        def __get__(self):
            return Vector2(self.p_this.size.width, self.p_this.size.height)

        def __set__(self, value):
            cdef sf.Vector2u size = to_vector2u(value)
            self.p_this.size.width = size.x
            self.p_this.size.height = size.y


cdef class FocusLostEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.LOST_FOCUS)


cdef class FocusGainedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.GAINED_FOCUS)


cdef class TextEnteredEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.TEXT_ENTERED)

    property unicode:
        def __get__(self):
            return unichr(self.p_this.text.unicode)

        def __set__(self, Py_UNICODE value):
            self.p_this.text.unicode = value


cdef class KeyPressedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.KEY_PRESSED)

    property code:
        def __get__(self):
            return self.p_this.key.code

        def __set__(self, sf.keyboard.Key code):
            self.p_this.key.code = code

    property scancode:
        def __get__(self):
            return self.p_this.key.scancode

        def __set__(self, int scancode):
            self.p_this.key.scancode = scancode

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


cdef class KeyReleasedEvent(KeyPressedEvent):
    def __init__(self):
        Event.__init__(self, EventType.KEY_RELEASED)


cdef class MouseWheelScrolledEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_WHEEL_SCROLLED)

    property wheel:
        def __get__(self):
            return self.p_this.mouseWheelScroll.wheel

        def __set__(self, sf.mouse.Wheel wheel):
            self.p_this.mouseWheelScroll.wheel = wheel

    property delta:
        def __get__(self):
            return self.p_this.mouseWheelScroll.delta

        def __set__(self, float delta):
            self.p_this.mouseWheelScroll.delta = delta

    property position:
        def __get__(self):
            return Vector2(self.p_this.mouseWheelScroll.x, self.p_this.mouseWheelScroll.y)

        def __set__(self, value):
            cdef sf.Vector2i position = to_vector2i(value)
            self.p_this.mouseWheelScroll.x = position.x
            self.p_this.mouseWheelScroll.y = position.y


cdef class MouseButtonPressedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_BUTTON_PRESSED)

    property button:
        def __get__(self):
            return self.p_this.mouseButton.button

        def __set__(self, sf.mouse.Button button):
            self.p_this.mouseButton.button = button

    property position:
        def __get__(self):
            return Vector2(self.p_this.mouseButton.x, self.p_this.mouseButton.y)

        def __set__(self, value):
            cdef sf.Vector2i position = to_vector2i(value)
            self.p_this.mouseButton.x = position.x
            self.p_this.mouseButton.y = position.y


cdef class MouseButtonReleasedEvent(MouseButtonPressedEvent):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_BUTTON_RELEASED)


cdef class MouseMovedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_MOVED)

    property position:
        def __get__(self):
            return Vector2(self.p_this.mouseMove.x, self.p_this.mouseMove.y)

        def __set__(self, value):
            cdef sf.Vector2i position = to_vector2i(value)
            self.p_this.mouseMove.x = position.x
            self.p_this.mouseMove.y = position.y


cdef class MouseMovedRawEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_MOVED_RAW)

    property delta:
        def __get__(self):
            return Vector2(self.p_this.mouseMoveRaw.deltaX, self.p_this.mouseMoveRaw.deltaY)

        def __set__(self, value):
            cdef sf.Vector2i delta = to_vector2i(value)
            self.p_this.mouseMoveRaw.deltaX = delta.x
            self.p_this.mouseMoveRaw.deltaY = delta.y


cdef class MouseEnteredEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_ENTERED)


cdef class MouseLeftEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.MOUSE_LEFT)


cdef class JoystickButtonPressedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.JOYSTICK_BUTTON_PRESSED)

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


cdef class JoystickButtonReleasedEvent(JoystickButtonPressedEvent):
    def __init__(self):
        Event.__init__(self, EventType.JOYSTICK_BUTTON_RELEASED)


cdef class JoystickMovedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.JOYSTICK_MOVED)

    property joystick_id:
        def __get__(self):
            return self.p_this.joystickMove.joystickId

        def __set__(self, unsigned int joystick_id):
            self.p_this.joystickMove.joystickId = joystick_id

    property axis:
        def __get__(self):
            return self.p_this.joystickMove.axis

        def __set__(self, axis):
            cdef int axis_value = axis
            self.p_this.joystickMove.axis = <sf.joystick.Axis>axis_value

    property position:
        def __get__(self):
            return self.p_this.joystickMove.position

        def __set__(self, float position):
            self.p_this.joystickMove.position = position


cdef class JoystickConnectedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.JOYSTICK_CONNECTED)

    property joystick_id:
        def __get__(self):
            return self.p_this.joystickConnect.joystickId

        def __set__(self, unsigned int joystick_id):
            self.p_this.joystickConnect.joystickId = joystick_id


cdef class JoystickDisconnectedEvent(JoystickConnectedEvent):
    def __init__(self):
        Event.__init__(self, EventType.JOYSTICK_DISCONNECTED)


cdef class TouchBeganEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.TOUCH_BEGAN)

    property finger:
        def __get__(self):
            return self.p_this.touch.finger

        def __set__(self, int finger):
            self.p_this.touch.finger = finger

    property position:
        def __get__(self):
            return Vector2(self.p_this.touch.x, self.p_this.touch.y)

        def __set__(self, value):
            cdef sf.Vector2i position = to_vector2i(value)
            self.p_this.touch.x = position.x
            self.p_this.touch.y = position.y


cdef class TouchMovedEvent(TouchBeganEvent):
    def __init__(self):
        Event.__init__(self, EventType.TOUCH_MOVED)


cdef class TouchEndedEvent(TouchBeganEvent):
    def __init__(self):
        Event.__init__(self, EventType.TOUCH_ENDED)


cdef class SensorChangedEvent(Event):
    def __init__(self):
        Event.__init__(self, EventType.SENSOR_CHANGED)

    property type:
        def __get__(self):
            return self.p_this.sensor.type

        def __set__(self, type):
            cdef int sensor_type = type
            self.p_this.sensor.type = <sf.sensor.Type>sensor_type

    property value:
        def __get__(self):
            return Vector3(self.p_this.sensor.x, self.p_this.sensor.y, self.p_this.sensor.z)

        def __set__(self, value):
            cdef sf.Vector3f sensor_value = sf.Vector3f(value[0], value[1], value[2])
            self.p_this.sensor.x = sensor_value.x
            self.p_this.sensor.y = sensor_value.y
            self.p_this.sensor.z = sensor_value.z


cdef Event _event_instance_for_type(int type):
    if type == EventType.CLOSED:
        return ClosedEvent.__new__(ClosedEvent)
    if type == EventType.RESIZED:
        return ResizedEvent.__new__(ResizedEvent)
    if type == EventType.LOST_FOCUS:
        return FocusLostEvent.__new__(FocusLostEvent)
    if type == EventType.GAINED_FOCUS:
        return FocusGainedEvent.__new__(FocusGainedEvent)
    if type == EventType.TEXT_ENTERED:
        return TextEnteredEvent.__new__(TextEnteredEvent)
    if type == EventType.KEY_PRESSED:
        return KeyPressedEvent.__new__(KeyPressedEvent)
    if type == EventType.KEY_RELEASED:
        return KeyReleasedEvent.__new__(KeyReleasedEvent)
    if type == EventType.MOUSE_WHEEL_SCROLLED:
        return MouseWheelScrolledEvent.__new__(MouseWheelScrolledEvent)
    if type == EventType.MOUSE_BUTTON_PRESSED:
        return MouseButtonPressedEvent.__new__(MouseButtonPressedEvent)
    if type == EventType.MOUSE_BUTTON_RELEASED:
        return MouseButtonReleasedEvent.__new__(MouseButtonReleasedEvent)
    if type == EventType.MOUSE_MOVED:
        return MouseMovedEvent.__new__(MouseMovedEvent)
    if type == EventType.MOUSE_MOVED_RAW:
        return MouseMovedRawEvent.__new__(MouseMovedRawEvent)
    if type == EventType.MOUSE_ENTERED:
        return MouseEnteredEvent.__new__(MouseEnteredEvent)
    if type == EventType.MOUSE_LEFT:
        return MouseLeftEvent.__new__(MouseLeftEvent)
    if type == EventType.JOYSTICK_BUTTON_PRESSED:
        return JoystickButtonPressedEvent.__new__(JoystickButtonPressedEvent)
    if type == EventType.JOYSTICK_BUTTON_RELEASED:
        return JoystickButtonReleasedEvent.__new__(JoystickButtonReleasedEvent)
    if type == EventType.JOYSTICK_MOVED:
        return JoystickMovedEvent.__new__(JoystickMovedEvent)
    if type == EventType.JOYSTICK_CONNECTED:
        return JoystickConnectedEvent.__new__(JoystickConnectedEvent)
    if type == EventType.JOYSTICK_DISCONNECTED:
        return JoystickDisconnectedEvent.__new__(JoystickDisconnectedEvent)
    if type == EventType.TOUCH_BEGAN:
        return TouchBeganEvent.__new__(TouchBeganEvent)
    if type == EventType.TOUCH_MOVED:
        return TouchMovedEvent.__new__(TouchMovedEvent)
    if type == EventType.TOUCH_ENDED:
        return TouchEndedEvent.__new__(TouchEndedEvent)
    if type == EventType.SENSOR_CHANGED:
        return SensorChangedEvent.__new__(SensorChangedEvent)
    return Event.__new__(Event)

cdef api Event wrap_event(sf.Event *p):
    cdef Event event = _event_instance_for_type(p.type)
    event.p_this = p
    return event

cdef public class VideoMode[type PyVideoModeType, object PyVideoModeObject]:
    cdef sf.VideoMode *p_this
    cdef bint delete_this

    def __init__(self, unsigned int mode_width, unsigned int mode_height, unsigned int mode_bits_per_pixel=32):
        self.p_this = new sf.VideoMode()
        self.p_this[0] = makeVideoMode(mode_width, mode_height, mode_bits_per_pixel)
        self.delete_this = True

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        return "VideoMode(size={0}, size={1}, bits_per_pixel={2})".format(self.width, self.height, self.bits_per_pixel)

    def __str__(self):
        return "{0}x{1}x{2}".format(self.width, self.height, self.bits_per_pixel)

    def __richcmp__(VideoMode x, VideoMode y, int op):
        if op == 0:
            return x.p_this[0] <  y.p_this[0]
        elif op == 2:
            return x.p_this[0] == y.p_this[0]
        elif op == 4:
            return x.p_this[0] >  y.p_this[0]
        elif op == 1:
            return x.p_this[0] <= y.p_this[0]
        elif op == 3:
            return x.p_this[0] != y.p_this[0]
        elif op == 5:
            return x.p_this[0] >= y.p_this[0]

    def __iter__(self):
        return iter((self.width, self.height, self.bits_per_pixel))

    property width:
        def __get__(self):
            return self.p_this.size.x

        def __set__(self, unsigned int width):
            self.p_this.size.x = width

    property height:
        def __get__(self):
            return self.p_this.size.y

        def __set__(self, unsigned int height):
            self.p_this.size.y = height

    property bits_per_pixel:
        def __get__(self):
            return self.p_this.bitsPerPixel

        def __set__(self, unsigned int bits_per_pixel):
            self.p_this.bitsPerPixel = bits_per_pixel

    @staticmethod
    def get_desktop_mode():
        cdef sf.VideoMode *p = new sf.VideoMode()
        p[0] = sf.videomode.getDesktopMode()

        return wrap_videomode(p, True)

    @staticmethod
    def get_fullscreen_modes():
        cdef list modes = []
        cdef const vector[sf.VideoMode]* v = &sf.videomode.getFullscreenModes()

        cdef vector[sf.VideoMode].const_iterator it = deref(v).begin()
        cdef sf.VideoMode vm

        while it != deref(v).end():
            vm = deref(it)
            modes.append(VideoMode(vm.size.x, vm.size.y, vm.bitsPerPixel))
            inc(it)

        return modes

    def is_valid(self):
        return self.p_this.isValid()

cdef VideoMode wrap_videomode(sf.VideoMode *p, bint d):
    cdef VideoMode r = VideoMode.__new__(VideoMode, 640, 480, 32)
    r.p_this = p
    r.delete_this = d
    return r


class Attribute(IntEnum):
    DEFAULT = sf.contextsettings.Default
    CORE = sf.contextsettings.Core
    DEBUG = sf.contextsettings.Debug

cdef public class ContextSettings[type PyContextSettingsType, object PyContextSettingsObject]:
    cdef sf.ContextSettings *p_this

    def __init__(self, unsigned int depth=0, unsigned int stencil=0, unsigned int antialiasing=0, unsigned int major=1, unsigned int minor=1, int attributes=Attribute.DEFAULT):
        self.p_this = new sf.ContextSettings()
        self.p_this.depthBits = depth
        self.p_this.stencilBits = stencil
        self.p_this.antiAliasingLevel = antialiasing
        self.p_this.majorVersion = major
        self.p_this.minorVersion = minor
        self.p_this.attributeFlags = attributes

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "ContextSettings(depth_bits={0}, stencil_bits={1}, antialiasing_level={2}, major_version={3}, minor_version={4})".format(self.depth_bits, self.stencil_bits, self.antialiasing_level, self.major_version, self.minor_version)

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
            return self.p_this.antiAliasingLevel

        def __set__(self, unsigned int antialiasing_level):
            self.p_this.antiAliasingLevel = antialiasing_level

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

    property attribute_flags:
        def __get__(self):
            return self.p_this.attributeFlags

        def __set__(self, int attribute_flags):
            self.p_this.attributeFlags = attribute_flags

    property srgb_capable:
        def __get__(self):
            return self.p_this.sRgbCapable

        def __set__(self, bint srgb_capable):
            self.p_this.sRgbCapable = srgb_capable

cdef ContextSettings wrap_contextsettings(sf.ContextSettings *v):
    cdef ContextSettings r = ContextSettings.__new__(ContextSettings)
    r.p_this = v
    return r


cdef public class Window[type PyWindowType, object PyWindowObject]:
    cdef sf.Window *p_window
    cdef object p_minimum_size
    cdef object p_maximum_size

    def __cinit__(self):
        self.p_window = NULL
        self.p_minimum_size = None
        self.p_maximum_size = None

    def __init__(self, VideoMode mode=None, unicode title=None, Uint32 style=sf.style.Default, state=State.WINDOWED, ContextSettings settings=None):
        cdef ContextSettings resolved_settings
        cdef Uint32 resolved_state = <Uint32>State.WINDOWED

        if self.p_window == NULL:
            self.p_window = <sf.Window*>new DerivableWindow(self)

        if settings is None and isinstance(state, ContextSettings):
            settings = state
            resolved_state = <Uint32>State.WINDOWED
        else:
            resolved_state = <Uint32>state

        if settings is None:
            resolved_settings = ContextSettings()
        else:
            resolved_settings = settings

        if mode is not None and title is not None:
            createWindowWithState(self.p_window[0], mode.p_this[0], to_string(title), style, resolved_state, resolved_settings.p_this[0])
            if self.p_minimum_size is not None:
                setMinimumSize(self.p_window[0], True, self.p_minimum_size[0], self.p_minimum_size[1])
            if self.p_maximum_size is not None:
                setMaximumSize(self.p_window[0], True, self.p_maximum_size[0], self.p_maximum_size[1])

    def __dealloc__(self):
        if self.p_window != NULL:
            del self.p_window

    def __repr__(self):
        return "Window(position={0}, size={1}, is_open={2})".format(self.position, self.size, self.is_open)

    def create(self, VideoMode mode, title, Uint32 style=sf.style.Default, state=State.WINDOWED, ContextSettings settings=None):
        cdef ContextSettings resolved_settings
        cdef Uint32 resolved_state = <Uint32>State.WINDOWED

        if settings is None and isinstance(state, ContextSettings):
            settings = state
            resolved_state = <Uint32>State.WINDOWED
        else:
            resolved_state = <Uint32>state

        if settings is None:
            resolved_settings = ContextSettings()
        else:
            resolved_settings = settings

        createWindowWithState(self.p_window[0], mode.p_this[0], to_string(title), style, resolved_state, resolved_settings.p_this[0])
        if self.p_minimum_size is not None:
            setMinimumSize(self.p_window[0], True, self.p_minimum_size[0], self.p_minimum_size[1])
        if self.p_maximum_size is not None:
            setMaximumSize(self.p_window[0], True, self.p_maximum_size[0], self.p_maximum_size[1])

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
        cdef sf.Event  event
        cdef sf.Event* p

        while pollEvent(window.p_window[0], event):
            p = new sf.Event()
            p[0] = event
            yield wrap_event(p)


    def poll_event(self):
        cdef sf.Event *p = new sf.Event()

        if pollEvent(self.p_window[0], p[0]):
            return wrap_event(p)

        del p

    def wait_event(self, timeout=None):
        cdef sf.Event *p = new sf.Event()
        cdef Time duration

        if timeout is None:
            if waitEvent(self.p_window[0], p[0]):
                return wrap_event(p)
        else:
            duration = timeout
            if waitEventWithTimeout(self.p_window[0], p[0], duration.p_this[0]):
                return wrap_event(p)

        del p

    property position:
        def __get__(self):
            return wrap_vector2i(self.p_window.getPosition())

        def __set__(self, position):
            self.p_window.setPosition(to_vector2i(position))

    property size:
        def __get__(self):
            return Vector2(self.p_window.getSize().x, self.p_window.getSize().y)

        def __set__(self, size):
            self.p_window.setSize(to_vector2u(size))

    property minimum_size:
        def __get__(self):
            if self.p_minimum_size is None:
                return None

            return Vector2(self.p_minimum_size[0], self.p_minimum_size[1])

        def __set__(self, value):
            cdef sf.Vector2u minimum_size

            if value is None:
                self.p_minimum_size = None
                if self.p_window != NULL and self.p_window.isOpen():
                    setMinimumSize(self.p_window[0], False, 0, 0)
                return

            minimum_size = to_vector2u(value)
            self.p_minimum_size = (minimum_size.x, minimum_size.y)

            if self.p_window != NULL and self.p_window.isOpen():
                setMinimumSize(self.p_window[0], True, minimum_size.x, minimum_size.y)

    property maximum_size:
        def __get__(self):
            if self.p_maximum_size is None:
                return None

            return Vector2(self.p_maximum_size[0], self.p_maximum_size[1])

        def __set__(self, value):
            cdef sf.Vector2u maximum_size

            if value is None:
                self.p_maximum_size = None
                if self.p_window != NULL and self.p_window.isOpen():
                    setMaximumSize(self.p_window[0], False, 0, 0)
                return

            maximum_size = to_vector2u(value)
            self.p_maximum_size = (maximum_size.x, maximum_size.y)

            if self.p_window != NULL and self.p_window.isOpen():
                setMaximumSize(self.p_window[0], True, maximum_size.x, maximum_size.y)

    def set_title(self, unicode title):
        self.p_window.setTitle(to_string(title))

    def set_icon(self, int width, int height, bytes pixels):
        setIcon(self.p_window[0], width, height, <sf.Uint8*>pixels)

    def set_visible(self, bint visible):
        self.p_window.setVisible(visible)

    def show(self):
        self.set_visible(True)

    def hide(self):
        self.set_visible(False)

    def set_vertical_synchronization_enabled(self, bint enabled):
        self.p_window.setVerticalSyncEnabled(enabled)

    def set_mouse_cursor_visible(self, bint visible):
        self.p_window.setMouseCursorVisible(visible)

    def set_mouse_cursor_grabbed(self, bint grabbed):
        setMouseCursorGrabbed(self.p_window[0], grabbed)

    def set_key_repeat_enabled(self, bint enabled):
        self.p_window.setKeyRepeatEnabled(enabled)

    def set_framerate_limit(self, unsigned int limit):
        self.p_window.setFramerateLimit(limit)

    def set_joystick_threshold(self, float threshold):
        self.p_window.setJoystickThreshold(threshold)

    def set_active(self, bint active=True):
        return self.p_window.setActive(active)

    def request_focus(self):
        self.p_window.requestFocus()

    def has_focus(self):
        return self.p_window.hasFocus()

    def display(self):
        self.p_window.display()

    def set_mouse_cursor(self, Cursor cursor):
        applyMouseCursor(self.p_window[0], cursor.p_this[0])

    property system_handle:
        def __get__(self):
            return <unsigned long>self.p_window.getNativeHandle()

    def on_create(self):
        pass

    def on_resize(self):
        pass


class Clipboard:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def get_string():
        cdef sf.String text = getClipboardString()
        return wrap_string(&text)

    @staticmethod
    def set_string(text):
        setClipboardString(to_string(text))


class CursorType(IntEnum):
    ARROW = 0
    ARROW_WAIT = 1
    WAIT = 2
    TEXT = 3
    HAND = 4
    SIZE_HORIZONTAL = 5
    SIZE_VERTICAL = 6
    SIZE_TOP_LEFT_BOTTOM_RIGHT = 7
    SIZE_BOTTOM_LEFT_TOP_RIGHT = 8
    SIZE_LEFT = 9
    SIZE_RIGHT = 10
    SIZE_TOP = 11
    SIZE_BOTTOM = 12
    SIZE_TOP_LEFT = 13
    SIZE_BOTTOM_RIGHT = 14
    SIZE_BOTTOM_LEFT = 15
    SIZE_TOP_RIGHT = 16
    SIZE_ALL = 17
    CROSS = 18
    HELP = 19
    NOT_ALLOWED = 20


cdef class Cursor:
    cdef SfCursor *p_this

    def __cinit__(self):
        self.p_this = NULL

    def __dealloc__(self):
        if self.p_this != NULL:
            del self.p_this

    def __repr__(self):
        return "Cursor()"

    @staticmethod
    def from_system(cursor_type):
        cdef Cursor cursor = Cursor.__new__(Cursor)
        cdef int cursor_value = cursor_type

        cursor.p_this = createCursorFromSystem(cursor_value)
        if cursor.p_this == NULL:
            raise RuntimeError("system cursor type is not available on this platform")

        return cursor

    @staticmethod
    def from_pixels(bytes pixels, size, hotspot):
        cdef Cursor cursor = Cursor.__new__(Cursor)
        cdef sf.Vector2u size_value = to_vector2u(size)
        cdef sf.Vector2u hotspot_value = to_vector2u(hotspot)
        cdef char* pixel_data = pixels

        cursor.p_this = createCursorFromPixels(<sf.Uint8*>pixel_data, size_value.x, size_value.y, hotspot_value.x, hotspot_value.y)
        if cursor.p_this == NULL:
            raise RuntimeError("cursor could not be created from the provided pixels")

        return cursor


class Scancode(IntEnum):
    UNKNOWN = -1
    A = 0
    B = 1
    C = 2
    D = 3
    E = 4
    F = 5
    G = 6
    H = 7
    I = 8
    J = 9
    K = 10
    L = 11
    M = 12
    N = 13
    O = 14
    P = 15
    Q = 16
    R = 17
    S = 18
    T = 19
    U = 20
    V = 21
    W = 22
    X = 23
    Y = 24
    Z = 25
    NUM1 = 26
    NUM2 = 27
    NUM3 = 28
    NUM4 = 29
    NUM5 = 30
    NUM6 = 31
    NUM7 = 32
    NUM8 = 33
    NUM9 = 34
    NUM0 = 35
    ENTER = 36
    ESCAPE = 37
    BACKSPACE = 38
    TAB = 39
    SPACE = 40
    HYPHEN = 41
    EQUAL = 42
    L_BRACKET = 43
    R_BRACKET = 44
    BACKSLASH = 45
    SEMICOLON = 46
    APOSTROPHE = 47
    GRAVE = 48
    COMMA = 49
    PERIOD = 50
    SLASH = 51
    F1 = 52
    F2 = 53
    F3 = 54
    F4 = 55
    F5 = 56
    F6 = 57
    F7 = 58
    F8 = 59
    F9 = 60
    F10 = 61
    F11 = 62
    F12 = 63
    F13 = 64
    F14 = 65
    F15 = 66
    F16 = 67
    F17 = 68
    F18 = 69
    F19 = 70
    F20 = 71
    F21 = 72
    F22 = 73
    F23 = 74
    F24 = 75
    CAPS_LOCK = 76
    PRINT_SCREEN = 77
    SCROLL_LOCK = 78
    PAUSE = 79
    INSERT = 80
    HOME = 81
    PAGE_UP = 82
    DELETE = 83
    END = 84
    PAGE_DOWN = 85
    RIGHT = 86
    LEFT = 87
    DOWN = 88
    UP = 89
    NUM_LOCK = 90
    NUMPAD_DIVIDE = 91
    NUMPAD_MULTIPLY = 92
    NUMPAD_MINUS = 93
    NUMPAD_PLUS = 94
    NUMPAD_EQUAL = 95
    NUMPAD_ENTER = 96
    NUMPAD_DECIMAL = 97
    NUMPAD1 = 98
    NUMPAD2 = 99
    NUMPAD3 = 100
    NUMPAD4 = 101
    NUMPAD5 = 102
    NUMPAD6 = 103
    NUMPAD7 = 104
    NUMPAD8 = 105
    NUMPAD9 = 106
    NUMPAD0 = 107
    NON_US_BACKSLASH = 108
    APPLICATION = 109
    EXECUTE = 110
    MODE_CHANGE = 111
    HELP = 112
    MENU = 113
    SELECT = 114
    REDO = 115
    UNDO = 116
    CUT = 117
    COPY = 118
    PASTE = 119
    VOLUME_MUTE = 120
    VOLUME_UP = 121
    VOLUME_DOWN = 122
    MEDIA_PLAY_PAUSE = 123
    MEDIA_STOP = 124
    MEDIA_NEXT_TRACK = 125
    MEDIA_PREVIOUS_TRACK = 126
    L_CONTROL = 127
    L_SHIFT = 128
    L_ALT = 129
    L_SYSTEM = 130
    R_CONTROL = 131
    R_SHIFT = 132
    R_ALT = 133
    R_SYSTEM = 134
    BACK = 135
    FORWARD = 136
    REFRESH = 137
    STOP = 138
    SEARCH = 139
    FAVORITES = 140
    HOME_PAGE = 141
    LAUNCH_APPLICATION1 = 142
    LAUNCH_APPLICATION2 = 143
    LAUNCH_MAIL = 144
    LAUNCH_MEDIA_SELECT = 145


class Key(IntEnum):
    UNKNOWN = sf.keyboard.Unknown
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


cdef class Keyboard:
    A = Key.A
    B = Key.B
    C = Key.C
    D = Key.D
    E = Key.E
    F = Key.F
    G = Key.G
    H = Key.H
    I = Key.I
    J = Key.J
    K = Key.K
    L = Key.L
    M = Key.M
    N = Key.N
    O = Key.O
    P = Key.P
    Q = Key.Q
    R = Key.R
    S = Key.S
    T = Key.T
    U = Key.U
    V = Key.V
    W = Key.W
    X = Key.X
    Y = Key.Y
    Z = Key.Z
    NUM0 = Key.NUM0
    NUM1 = Key.NUM1
    NUM2 = Key.NUM2
    NUM3 = Key.NUM3
    NUM4 = Key.NUM4
    NUM5 = Key.NUM5
    NUM6 = Key.NUM6
    NUM7 = Key.NUM7
    NUM8 = Key.NUM8
    NUM9 = Key.NUM9
    ESCAPE = Key.ESCAPE
    L_CONTROL = Key.L_CONTROL
    L_SHIFT = Key.L_SHIFT
    L_ALT = Key.L_ALT
    L_SYSTEM = Key.L_SYSTEM
    R_CONTROL = Key.R_CONTROL
    R_SHIFT = Key.R_SHIFT
    R_ALT = Key.R_ALT
    R_SYSTEM = Key.R_SYSTEM
    MENU = Key.MENU
    L_BRACKET = Key.L_BRACKET
    R_BRACKET = Key.R_BRACKET
    SEMI_COLON = Key.SEMI_COLON
    COMMA = Key.COMMA
    PERIOD = Key.PERIOD
    QUOTE = Key.QUOTE
    SLASH = Key.SLASH
    BACK_SLASH = Key.BACK_SLASH
    TILDE = Key.TILDE
    EQUAL = Key.EQUAL
    DASH = Key.DASH
    SPACE = Key.SPACE
    RETURN = Key.RETURN
    BACK_SPACE = Key.BACK_SPACE
    TAB = Key.TAB
    PAGE_UP = Key.PAGE_UP
    PAGE_DOWN = Key.PAGE_DOWN
    END = Key.END
    HOME = Key.HOME
    INSERT = Key.INSERT
    DELETE = Key.DELETE
    ADD = Key.ADD
    SUBTRACT = Key.SUBTRACT
    MULTIPLY = Key.MULTIPLY
    DIVIDE = Key.DIVIDE
    LEFT = Key.LEFT
    RIGHT = Key.RIGHT
    UP = Key.UP
    DOWN = Key.DOWN
    NUMPAD0 = Key.NUMPAD0
    NUMPAD1 = Key.NUMPAD1
    NUMPAD2 = Key.NUMPAD2
    NUMPAD3 = Key.NUMPAD3
    NUMPAD4 = Key.NUMPAD4
    NUMPAD5 = Key.NUMPAD5
    NUMPAD6 = Key.NUMPAD6
    NUMPAD7 = Key.NUMPAD7
    NUMPAD8 = Key.NUMPAD8
    NUMPAD9 = Key.NUMPAD9
    F1 = Key.F1
    F2 = Key.F2
    F3 = Key.F3
    F4 = Key.F4
    F5 = Key.F5
    F6 = Key.F6
    F7 = Key.F7
    F8 = Key.F8
    F9 = Key.F9
    F10 = Key.F10
    F11 = Key.F11
    F12 = Key.F12
    F13 = Key.F13
    F14 = Key.F14
    F15 = Key.F15
    PAUSE = Key.PAUSE
    KEY_COUNT = Key.KEY_COUNT

    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def is_key_pressed(int key):
        return sf.keyboard.isKeyPressed(<sf.keyboard.Key>key)

    @staticmethod
    def is_scancode_pressed(int scancode):
        return isScancodePressed(scancode)

    @staticmethod
    def localize(int scancode):
        return Key(localizeScancode(scancode))

    @staticmethod
    def delocalize(int key):
        return delocalizeKey(<sf.keyboard.Key>key)

    @staticmethod
    def get_description(int scancode):
        cdef sf.String description = getScancodeDescription(scancode)
        return wrap_string(&description)

    @staticmethod
    def set_virtual_keyboard_visible(bint visible):
        sf.keyboard.setVirtualKeyboardVisible(visible)

class Axis(IntEnum):
    X = sf.joystick.X
    Y = sf.joystick.Y
    Z = sf.joystick.Z
    R = sf.joystick.R
    U = sf.joystick.U
    V = sf.joystick.V
    POV_X = sf.joystick.PovX
    POV_Y = sf.joystick.PovY

cdef class Joystick:
    COUNT = sf.joystick.Count
    BUTTON_COUNT = sf.joystick.ButtonCount
    AXIS_COUNT = sf.joystick.AxisCount

    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def is_connected(unsigned int joystick):
        return sf.joystick.isConnected(joystick)

    @staticmethod
    def get_button_count(unsigned int joystick):
        return sf.joystick.getButtonCount(joystick)

    @staticmethod
    def has_axis(unsigned int joystick, int axis):
        cdef int axis_value = axis
        return sf.joystick.hasAxis(joystick, <sf.joystick.Axis>axis_value)

    @staticmethod
    def is_button_pressed(unsigned int joystick, unsigned int button):
        return sf.joystick.isButtonPressed(joystick, button)

    @staticmethod
    def get_axis_position(unsigned int joystick, int axis):
        cdef int axis_value = axis
        return sf.joystick.getAxisPosition(joystick, <sf.joystick.Axis>axis_value)

    @staticmethod
    def get_identification(unsigned int joystick):
        cdef sf.joystick.Identification identification
        identification = sf.joystick.getIdentification(joystick)
        return (wrap_string(<const sf.String*>&identification.name), identification.vendorId, identification.productId)

    @staticmethod
    def update():
        sf.joystick.update()

class Button(IntEnum):
    LEFT = sf.mouse.Left
    RIGHT = sf.mouse.Right
    MIDDLE = sf.mouse.Middle
    X_BUTTON1 = sf.mouse.XButton1
    X_BUTTON2 = sf.mouse.XButton2
    BUTTON_COUNT = sf.mouse.ButtonCount

class Wheel(IntEnum):
    VERTICAL_WHEEL = sf.mouse.VerticalWheel
    HORIZONTAL_WHEEL = sf.mouse.HorizontalWheel

cdef class Mouse:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def is_button_pressed(int button):
        return sf.mouse.isButtonPressed(<sf.mouse.Button>button)

    @staticmethod
    def get_position(Window window=None):
        cdef sf.Vector2i p

        if window is None:
            p = sf.mouse.getPosition()
        else:
            p = sf.mouse.getPosition(<sf.mouse.Window&>window.p_window[0])

        return Vector2(p.x, p.y)

    @staticmethod
    def set_position(position, Window window=None):
        cdef sf.Vector2i p
        p.x, p.y = position

        if window is None:
            sf.mouse.setPosition(<sf.mouse.Vector2i>p)
        else:
            sf.mouse.setPosition(<sf.mouse.Vector2i>p, <sf.mouse.Window&>window.p_window[0])


cdef class Touch:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def is_down(int finger):
        return sf.touch.isDown(finger)

    @staticmethod
    def get_position(int finger, Window window=None):
        cdef sf.Vector2i p

        if window is None:
            p = sf.touch.getPosition(finger)
        else:
            p = sf.touch.getPosition(finger, <sf.touch.Window&>window.p_window[0])

        return Vector2(p.x, p.y)


class Type(IntEnum):
    ACCELEROMETER = sf.sensor.Accelerometer
    GYROSCOPE = sf.sensor.Gyroscope
    MAGNETOMETER = sf.sensor.Magnetometer
    GRAVITY = sf.sensor.Gravity
    USER_ACCELERATION = sf.sensor.UserAcceleration
    ORIENTATION = sf.sensor.Orientation
    SENSOR_COUNT = sf.sensor.Count

cdef class Sensor:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated!")

    @staticmethod
    def is_available(int sensor):
        cdef int sensor_type = sensor
        return sf.sensor.isAvailable(<sf.sensor.Type>sensor_type)

    @staticmethod
    def set_enabled(int sensor, bint enabled):
        cdef int sensor_type = sensor
        sf.sensor.setEnabled(<sf.sensor.Type>sensor_type, enabled)

    @staticmethod
    def get_value(int sensor):
        cdef sf.Vector3f value
        cdef int sensor_type = sensor
        value = sf.sensor.getValue(<sf.sensor.Type>sensor_type)
        return Vector3(value.x, value.y, value.z)


cdef class Context:
    cdef sf.Context *p_this
    cdef object __weakref__

    def __init__(self):
        self.p_this = new sf.Context()
        _register_context(self)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "Context()"

    property settings:
        def __get__(self):
            cdef sf.ContextSettings *p = new sf.ContextSettings()
            p[0] = getContextSettings(self.p_this[0])
            return wrap_contextsettings(p)

    def set_active(self, bint active=True):
        cdef bint result = self.p_this.setActive(active)

        if result and active:
            _register_context(self)

        return result

    @staticmethod
    def is_extension_available(name):
        cdef bytes encoded_name = name.encode('utf-8')
        return isContextExtensionAvailable(<const char*>encoded_name)

    @staticmethod
    def get_function(name):
        cdef bytes encoded_name = name.encode('utf-8')
        return getContextFunction(<const char*>encoded_name)

    @staticmethod
    def get_active_context():
        cdef Uint64 active_context_id = getActiveContextId()

        if not active_context_id:
            return None

        return _context_registry.get(active_context_id)

    @staticmethod
    def get_active_context_id():
        return getActiveContextId()
