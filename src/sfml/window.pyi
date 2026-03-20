from __future__ import annotations

from collections.abc import Generator
from enum import IntEnum
from typing import Any, ClassVar, NoReturn, TypeAlias

from .system import Time, Vector2, Vector3

Vector2Like: TypeAlias = Vector2 | tuple[int | float, int | float]
Vector3Like: TypeAlias = Vector3 | tuple[int | float, int | float, int | float]


def __getattr__(name: str) -> Any: ...


class Style:
    NONE: ClassVar[int]
    TITLEBAR: ClassVar[int]
    RESIZE: ClassVar[int]
    CLOSE: ClassVar[int]
    DEFAULT: ClassVar[int]


class State(IntEnum):
    WINDOWED = 0
    FULLSCREEN = 1


class Attribute(IntEnum):
    DEFAULT = 0
    CORE = 1
    DEBUG = 4


class EventType(IntEnum):
    CLOSED = 0
    RESIZED = 1
    LOST_FOCUS = 2
    GAINED_FOCUS = 3
    TEXT_ENTERED = 4
    KEY_PRESSED = 5
    KEY_RELEASED = 6
    MOUSE_WHEEL_SCROLLED = 8
    MOUSE_BUTTON_PRESSED = 9
    MOUSE_BUTTON_RELEASED = 10
    MOUSE_MOVED = 11
    MOUSE_MOVED_RAW = 12
    MOUSE_ENTERED = 13
    MOUSE_LEFT = 14
    JOYSTICK_BUTTON_PRESSED = 15
    JOYSTICK_BUTTON_RELEASED = 16
    JOYSTICK_MOVED = 17
    JOYSTICK_CONNECTED = 18
    JOYSTICK_DISCONNECTED = 19
    TOUCH_BEGAN = 20
    TOUCH_MOVED = 21
    TOUCH_ENDED = 22
    SENSOR_CHANGED = 23
    COUNT = 24


class Event:
    CLOSED: ClassVar[EventType]
    RESIZED: ClassVar[EventType]
    LOST_FOCUS: ClassVar[EventType]
    GAINED_FOCUS: ClassVar[EventType]
    TEXT_ENTERED: ClassVar[EventType]
    KEY_PRESSED: ClassVar[EventType]
    KEY_RELEASED: ClassVar[EventType]
    MOUSE_WHEEL_SCROLLED: ClassVar[EventType]
    MOUSE_BUTTON_PRESSED: ClassVar[EventType]
    MOUSE_BUTTON_RELEASED: ClassVar[EventType]
    MOUSE_MOVED: ClassVar[EventType]
    MOUSE_MOVED_RAW: ClassVar[EventType]
    MOUSE_ENTERED: ClassVar[EventType]
    MOUSE_LEFT: ClassVar[EventType]
    JOYSTICK_BUTTON_PRESSED: ClassVar[EventType]
    JOYSTICK_BUTTON_RELEASED: ClassVar[EventType]
    JOYSTICK_MOVED: ClassVar[EventType]
    JOYSTICK_CONNECTED: ClassVar[EventType]
    JOYSTICK_DISCONNECTED: ClassVar[EventType]
    TOUCH_BEGAN: ClassVar[EventType]
    TOUCH_MOVED: ClassVar[EventType]
    TOUCH_ENDED: ClassVar[EventType]
    SENSOR_CHANGED: ClassVar[EventType]
    COUNT: ClassVar[EventType]

    def __init__(self, type: EventType = EventType.CLOSED) -> None: ...
    @property
    def type(self) -> EventType: ...


class ClosedEvent(Event): ...


class ResizedEvent(Event):
    @property
    def size(self) -> Vector2: ...
    @size.setter
    def size(self, value: Vector2Like) -> None: ...


class FocusLostEvent(Event): ...


class FocusGainedEvent(Event): ...


class TextEnteredEvent(Event):
    @property
    def unicode(self) -> str: ...
    @unicode.setter
    def unicode(self, value: str) -> None: ...


class KeyPressedEvent(Event):
    @property
    def code(self) -> int: ...
    @code.setter
    def code(self, code: int) -> None: ...
    @property
    def scancode(self) -> int: ...
    @scancode.setter
    def scancode(self, scancode: int) -> None: ...
    @property
    def alt(self) -> bool: ...
    @alt.setter
    def alt(self, alt: bool) -> None: ...
    @property
    def control(self) -> bool: ...
    @control.setter
    def control(self, control: bool) -> None: ...
    @property
    def shift(self) -> bool: ...
    @shift.setter
    def shift(self, shift: bool) -> None: ...
    @property
    def system(self) -> bool: ...
    @system.setter
    def system(self, system: bool) -> None: ...


class KeyReleasedEvent(KeyPressedEvent): ...


class MouseWheelScrolledEvent(Event):
    @property
    def wheel(self) -> int: ...
    @wheel.setter
    def wheel(self, wheel: int) -> None: ...
    @property
    def delta(self) -> float: ...
    @delta.setter
    def delta(self, delta: float) -> None: ...
    @property
    def position(self) -> Vector2: ...
    @position.setter
    def position(self, value: Vector2Like) -> None: ...


class MouseButtonPressedEvent(Event):
    @property
    def button(self) -> int: ...
    @button.setter
    def button(self, button: int) -> None: ...
    @property
    def position(self) -> Vector2: ...
    @position.setter
    def position(self, value: Vector2Like) -> None: ...


class MouseButtonReleasedEvent(MouseButtonPressedEvent): ...


class MouseMovedEvent(Event):
    @property
    def position(self) -> Vector2: ...
    @position.setter
    def position(self, value: Vector2Like) -> None: ...


class MouseMovedRawEvent(Event):
    @property
    def delta(self) -> Vector2: ...
    @delta.setter
    def delta(self, value: Vector2Like) -> None: ...


class MouseEnteredEvent(Event): ...


class MouseLeftEvent(Event): ...


class JoystickButtonPressedEvent(Event):
    @property
    def joystick_id(self) -> int: ...
    @joystick_id.setter
    def joystick_id(self, joystick_id: int) -> None: ...
    @property
    def button(self) -> int: ...
    @button.setter
    def button(self, button: int) -> None: ...


class JoystickButtonReleasedEvent(JoystickButtonPressedEvent): ...


class JoystickMovedEvent(Event):
    @property
    def joystick_id(self) -> int: ...
    @joystick_id.setter
    def joystick_id(self, joystick_id: int) -> None: ...
    @property
    def axis(self) -> int: ...
    @axis.setter
    def axis(self, axis: int) -> None: ...
    @property
    def position(self) -> float: ...
    @position.setter
    def position(self, position: float) -> None: ...


class JoystickConnectedEvent(Event):
    @property
    def joystick_id(self) -> int: ...
    @joystick_id.setter
    def joystick_id(self, joystick_id: int) -> None: ...


class JoystickDisconnectedEvent(JoystickConnectedEvent): ...


class TouchBeganEvent(Event):
    @property
    def finger(self) -> int: ...
    @finger.setter
    def finger(self, finger: int) -> None: ...
    @property
    def position(self) -> Vector2: ...
    @position.setter
    def position(self, value: Vector2Like) -> None: ...


class TouchMovedEvent(TouchBeganEvent): ...


class TouchEndedEvent(TouchBeganEvent): ...


class SensorChangedEvent(Event):
    @property
    def type(self) -> int: ...
    @type.setter
    def type(self, sensor_type: int) -> None: ...
    @property
    def value(self) -> Vector3: ...
    @value.setter
    def value(self, value: Vector3Like) -> None: ...


class VideoMode:
    def __init__(self, width: int = 0, height: int = 0, bits_per_pixel: int = 32) -> None: ...
    @property
    def width(self) -> int: ...
    @width.setter
    def width(self, width: int) -> None: ...
    @property
    def height(self) -> int: ...
    @height.setter
    def height(self, height: int) -> None: ...
    @property
    def bits_per_pixel(self) -> int: ...
    @bits_per_pixel.setter
    def bits_per_pixel(self, bits_per_pixel: int) -> None: ...
    @classmethod
    def get_desktop_mode(cls) -> VideoMode: ...
    @classmethod
    def get_fullscreen_modes(cls) -> list[VideoMode]: ...
    def is_valid(self) -> bool: ...


class ContextSettings:
    def __init__(
        self,
        depth: int = 0,
        stencil: int = 0,
        antialiasing: int = 0,
        major: int = 1,
        minor: int = 1,
        attributes: int = Attribute.DEFAULT,
    ) -> None: ...
    @property
    def depth_bits(self) -> int: ...
    @depth_bits.setter
    def depth_bits(self, depth_bits: int) -> None: ...
    @property
    def stencil_bits(self) -> int: ...
    @stencil_bits.setter
    def stencil_bits(self, stencil_bits: int) -> None: ...
    @property
    def antialiasing_level(self) -> int: ...
    @antialiasing_level.setter
    def antialiasing_level(self, antialiasing_level: int) -> None: ...
    @property
    def major_version(self) -> int: ...
    @major_version.setter
    def major_version(self, major_version: int) -> None: ...
    @property
    def minor_version(self) -> int: ...
    @minor_version.setter
    def minor_version(self, minor_version: int) -> None: ...
    @property
    def attribute_flags(self) -> int: ...
    @attribute_flags.setter
    def attribute_flags(self, attribute_flags: int) -> None: ...
    @property
    def srgb_capable(self) -> bool: ...
    @srgb_capable.setter
    def srgb_capable(self, srgb_capable: bool) -> None: ...


class Window:
    def __init__(
        self,
        mode: VideoMode | None = None,
        title: str | None = None,
        style: int = ...,
        state: State | ContextSettings = ...,
        settings: ContextSettings | None = None,
    ) -> None: ...
    def create(
        self,
        mode: VideoMode,
        title: str,
        style: int = ...,
        state: State | ContextSettings = ...,
        settings: ContextSettings | None = None,
    ) -> None: ...
    def close(self) -> None: ...
    @property
    def is_open(self) -> bool: ...
    @property
    def settings(self) -> ContextSettings: ...
    @property
    def events(self) -> Generator[Event, None, None]: ...
    def poll_event(self) -> Event | None: ...
    def wait_event(self, timeout: Time | None = None) -> Event | None: ...
    @property
    def position(self) -> Vector2: ...
    @position.setter
    def position(self, position: Vector2Like) -> None: ...
    @property
    def size(self) -> Vector2: ...
    @size.setter
    def size(self, size: Vector2Like) -> None: ...
    @property
    def minimum_size(self) -> Vector2 | None: ...
    @minimum_size.setter
    def minimum_size(self, size: Vector2Like | None) -> None: ...
    @property
    def maximum_size(self) -> Vector2 | None: ...
    @maximum_size.setter
    def maximum_size(self, size: Vector2Like | None) -> None: ...
    def set_title(self, title: str) -> None: ...
    def set_icon(self, width: int, height: int, pixels: bytes) -> None: ...
    def set_visible(self, visible: bool) -> None: ...
    def show(self) -> None: ...
    def hide(self) -> None: ...
    def set_vertical_synchronization_enabled(self, enabled: bool) -> None: ...
    def set_mouse_cursor_visible(self, visible: bool) -> None: ...
    def set_mouse_cursor_grabbed(self, grabbed: bool) -> None: ...
    def set_mouse_cursor(self, cursor: Cursor) -> None: ...
    def set_key_repeat_enabled(self, enabled: bool) -> None: ...
    def set_framerate_limit(self, limit: int) -> None: ...
    def set_joystick_threshold(self, threshold: float) -> None: ...
    def set_active(self, active: bool = True) -> bool: ...
    def request_focus(self) -> None: ...
    def has_focus(self) -> bool: ...
    def display(self) -> None: ...
    @property
    def system_handle(self) -> int: ...
    def on_create(self) -> None: ...
    def on_resize(self) -> None: ...


class CursorType(IntEnum):
    ARROW = 0
    ARROW_WAIT = 1
    WAIT = 2
    TEXT = 3
    HAND = 4


class Cursor:
    @staticmethod
    def from_system(cursor_type: int) -> Cursor: ...
    @staticmethod
    def from_pixels(pixels: bytes, size: Vector2Like, hotspot: Vector2Like) -> Cursor: ...


class Clipboard:
    @staticmethod
    def get_string() -> str: ...
    @staticmethod
    def set_string(text: str) -> None: ...


class Key(IntEnum):
    UNKNOWN = -1
    A = 0
    SPACE = 57
    ESCAPE = 36
    KEY_COUNT = 101


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


class Keyboard:
    A: ClassVar[int]
    SPACE: ClassVar[int]
    ESCAPE: ClassVar[int]
    KEY_COUNT: ClassVar[int]

    @staticmethod
    def is_key_pressed(key: int) -> bool: ...
    @staticmethod
    def is_scancode_pressed(scancode: int) -> bool: ...
    @staticmethod
    def localize(scancode: int) -> int: ...
    @staticmethod
    def delocalize(key: int) -> int: ...
    @staticmethod
    def get_description(scancode: int) -> str: ...
    @staticmethod
    def set_virtual_keyboard_visible(visible: bool) -> None: ...
    def __getattr__(self, name: str) -> Any: ...


class Axis(IntEnum):
    X = 0


class Joystick:
    COUNT: ClassVar[int]
    BUTTON_COUNT: ClassVar[int]
    AXIS_COUNT: ClassVar[int]

    @staticmethod
    def is_connected(joystick: int) -> bool: ...
    @staticmethod
    def get_button_count(joystick: int) -> int: ...
    @staticmethod
    def has_axis(joystick: int, axis: int) -> bool: ...
    @staticmethod
    def is_button_pressed(joystick: int, button: int) -> bool: ...
    @staticmethod
    def get_axis_position(joystick: int, axis: int) -> float: ...
    @staticmethod
    def get_identification(joystick: int) -> tuple[str, int, int]: ...
    @staticmethod
    def update() -> None: ...


class Button(IntEnum):
    LEFT = 0
    RIGHT = 1
    MIDDLE = 2


class Wheel(IntEnum):
    VERTICAL_WHEEL = 0
    HORIZONTAL_WHEEL = 1


class Mouse:
    @staticmethod
    def is_button_pressed(button: int) -> bool: ...
    @staticmethod
    def get_position(window: Window | None = None) -> Vector2: ...
    @staticmethod
    def set_position(position: Vector2Like, window: Window | None = None) -> None: ...


class Touch:
    @staticmethod
    def is_down(finger: int) -> bool: ...
    @staticmethod
    def get_position(finger: int, window: Window | None = None) -> Vector2: ...


class Type(IntEnum):
    ACCELEROMETER = 0


class Sensor:
    @staticmethod
    def is_available(sensor: int) -> bool: ...
    @staticmethod
    def set_enabled(sensor: int, enabled: bool) -> None: ...
    @staticmethod
    def get_value(sensor: int) -> Vector3: ...


class Context:
    @property
    def settings(self) -> ContextSettings: ...
    def set_active(self, active: bool = True) -> bool: ...
    @staticmethod
    def is_extension_available(name: str) -> bool: ...
    @staticmethod
    def get_function(name: str) -> int: ...
    @staticmethod
    def get_active_context() -> Context | None: ...
    @staticmethod
    def get_active_context_id() -> int: ...
