# -*- python -*-
# -*- coding: utf-8 -*-

# Copyright 2011 Bastien Léonard. All rights reserved.

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


"""Python wrapper for the C++ library SFML 2 (Simple and Fast
Multimedia Library)."""


from libcpp.vector cimport vector
from cython.operator cimport preincrement as preinc, dereference as deref

cimport decl
cimport declblendmode
cimport declevent
cimport decljoy
cimport declkey
cimport declmouse
cimport declstyle



# Forward declarations
cdef class RenderWindow




class PySFMLException(Exception):
    """Base class for the exceptions raised by PySFML."""


class FileLoadingException(PySFMLException):
    """Raised when a file can't be loaded."""




cdef class Mouse:
    LEFT = declmouse.Left
    RIGHT = declmouse.Right
    MIDDLE = declmouse.Middle
    X_BUTTON1 = declmouse.XButton1
    X_BUTTON2 = declmouse.XButton2
    BUTTON_COUNT = declmouse.ButtonCount



cdef class Joy:
    AXIS_X = decljoy.AxisX
    AXIS_Y = decljoy.AxisY
    AXIS_Z = decljoy.AxisZ
    AXIS_R = decljoy.AxisR
    AXIS_U = decljoy.AxisU
    AXIS_V = decljoy.AxisV
    AXIS_POV = decljoy.AxisPOV
    AXIS_COUNT = decljoy.AxisCount

    COUNT = decljoy.Count
    BUTTON_COUNT = decljoy.ButtonCount



cdef class Key:
    A = declkey.A
    B = declkey.B
    C = declkey.C
    D = declkey.D
    E = declkey.E
    F = declkey.F
    G = declkey.G
    H = declkey.H
    I = declkey.I
    J = declkey.J
    K = declkey.K
    L = declkey.L
    M = declkey.M
    N = declkey.N
    O = declkey.O
    P = declkey.P
    Q = declkey.Q
    R = declkey.R
    S = declkey.S
    T = declkey.T
    U = declkey.U
    V = declkey.V
    W = declkey.W
    X = declkey.X
    Y = declkey.Y
    Z = declkey.Z
    NUM0 = declkey.Num0
    NUM1 = declkey.Num1
    NUM2 = declkey.Num2
    NUM3 = declkey.Num3
    NUM4 = declkey.Num4
    NUM5 = declkey.Num5
    NUM6 = declkey.Num6
    NUM7 = declkey.Num7
    NUM8 = declkey.Num8
    NUM9 = declkey.Num9
    ESCAPE = declkey.Escape
    L_CONTROL = declkey.LControl
    L_SHIFT = declkey.LShift
    L_ALT = declkey.LAlt
    L_SYSTEM = declkey.LSystem
    R_CONTROL = declkey.RControl
    R_SHIFT = declkey.RShift
    R_ALT = declkey.RAlt
    R_SYSTEM = declkey.RSystem
    MENU = declkey.Menu
    L_BRACKET = declkey.LBracket
    R_BRACKET = declkey.RBracket
    SEMI_COLON = declkey.SemiColon
    COMMA = declkey.Comma
    PERIOD = declkey.Period
    QUOTE = declkey.Quote
    SLASH = declkey.Slash
    BACK_SLASH = declkey.BackSlash
    TILDE = declkey.Tilde
    EQUAL = declkey.Equal
    DASH = declkey.Dash
    SPACE = declkey.Space
    RETURN = declkey.Return
    BACK = declkey.Back
    TAB = declkey.Tab
    PAGE_UP = declkey.PageUp
    PAGE_DOWN = declkey.PageDown
    END = declkey.End
    HOME = declkey.Home
    INSERT = declkey.Insert
    DELETE = declkey.Delete
    ADD = declkey.Add
    SUBTRACT = declkey.Subtract
    MULTIPLY = declkey.Multiply
    DIVIDE = declkey.Divide
    LEFT = declkey.Left
    RIGHT = declkey.Right
    UP = declkey.Up
    DOWN = declkey.Down
    NUMPAD0 = declkey.Numpad0
    NUMPAD1 = declkey.Numpad1
    NUMPAD2 = declkey.Numpad2
    NUMPAD3 = declkey.Numpad3
    NUMPAD4 = declkey.Numpad4
    NUMPAD5 = declkey.Numpad5
    NUMPAD6 = declkey.Numpad6
    NUMPAD7 = declkey.Numpad7
    NUMPAD8 = declkey.Numpad8
    NUMPAD9 = declkey.Numpad9
    F1 = declkey.F1
    F2 = declkey.F2
    F3 = declkey.F3
    F4 = declkey.F4
    F5 = declkey.F5
    F6 = declkey.F6
    F7 = declkey.F7
    F8 = declkey.F8
    F9 = declkey.F9
    F10 = declkey.F10
    F11 = declkey.F11
    F12 = declkey.F12
    F13 = declkey.F13
    F14 = declkey.F14
    F15 = declkey.F15
    PAUSE = declkey.Pause
    COUNT = declkey.Count



cdef class BlendMode:
    ALPHA = declblendmode.Alpha
    ADD = declblendmode.Add
    MULTIPLY = declblendmode.Multiply
    NONE = declblendmode.None


cdef class IntRect:
    cdef decl.IntRect *p_this

    def __cinit__(self, int left=0, int top=0, int width=0, int height=0):
        self.p_this = new decl.IntRect(left, top, width, height)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return ('IntRect(left={0.left!r}, top={0.top!r}, '
                'width={0.width!r}, height={0.height!r})'.format(self))

    property left:
        def __get__(self):
            return self.p_this.Left

        def __set__(self, int value):
            self.p_this.Left = value

    property top:
        def __get__(self):
            return self.p_this.Top

        def __set__(self, int value):
            self.p_this.Top = value

    property width:
        def __get__(self):
            return self.p_this.Width

        def __set__(self, int value):
            self.p_this.Width = value

    property height:
        def __get__(self):
            return self.p_this.Height

        def __set__(self, int value):
            self.p_this.Height = value

    def contains(self, int x, int y):
        return self.p_this.Contains(x, y)

    def intersects(self, IntRect rect, IntRect intersection=None):
        if intersection is None:
            return self.p_this.Intersects(rect.p_this[0])
        else:
            return self.p_this.Intersects(rect.p_this[0],
                                          intersection.p_this[0])


cdef decl.IntRect convert_to_int_rect(value):
    if isinstance(value, IntRect):
        return (<IntRect>value).p_this[0]

    if isinstance(value, tuple):
        return decl.IntRect(value[0], value[1], value[2], value[3])
    
    raise TypeError("Required IntRect or tuple, found {0}".format(type(value)))


cdef class FloatRect:
    cdef decl.FloatRect *p_this

    def __init__(self, float left=0, float top=0, float width=0,
                  float height=0):
        self.p_this = new decl.FloatRect(left, top, width, height)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return ('FloatRect(left={0.left!r}, top={0.top!r}, '
                'width={0.width!r}, height={0.height!r})'.format(self))

    property left:
        def __get__(self):
            return self.p_this.Left

        def __set__(self, float value):
            self.p_this.Left = value

    property top:
        def __get__(self):
            return self.p_this.Top

        def __set__(self, float value):
            self.p_this.Top = value

    property width:
        def __get__(self):
            return self.p_this.Width

        def __set__(self, float value):
            self.p_this.Width = value

    property height:
        def __get__(self):
            return self.p_this.Height

        def __set__(self, float value):
            self.p_this.Height = value

    def contains(self, int x, int y):
        return self.p_this.Contains(x, y)

    def intersects(self, FloatRect rect, FloatRect intersection=None):
        if intersection is None:
            return self.p_this.Intersects(rect.p_this[0])
        else:
            return self.p_this.Intersects(rect.p_this[0],
                                          intersection.p_this[0])


cdef FloatRect wrap_float_rect_instance(decl.FloatRect *p_cpp_instance):
    cdef FloatRect ret = FloatRect.__new__(FloatRect)
    ret.p_this = p_cpp_instance

    return ret




cdef class Matrix3:
    cdef decl.Matrix3 *p_this

    IDENTITY = wrap_matrix_instance(<decl.Matrix3*>&decl.Identity)

    def __init__(self, float a00, float a01, float a02,
                  float a10, float a11, float a12,
                  float a20, float a21, float a22):
        self.p_this = new decl.Matrix3(a00, a01, a02,
                                       a10, a11, a12,
                                       a20, a21, a22)

    def __dealloc__(self):
        del self.p_this

    def __str__(self):
        cdef float *p

        p = <float*>self.p_this.Get4x4Elements()

        return ('[{0} {4} {8} {12}]\n'
                '[{1} {5} {9} {13}]\n'
                '[{2} {6} {10} {14}]\n'
                '[{3} {7} {11} {15}]'
                .format(p[0], p[1], p[2], p[3],
                        p[4], p[5], p[6], p[7],
                        p[8], p[9], p[10], p[11],
                        p[12], p[13], p[14], p[15]))

    def __mul__(Matrix3 self, Matrix3 other):
        cdef decl.Matrix3 *p = new decl.Matrix3()

        p[0] = self.p_this[0] * other.p_this[0]

        return wrap_matrix_instance(p)

    @classmethod
    def projection(cls, tuple center, tuple size, float rotation):
        cdef decl.Vector2f cpp_center
        cdef decl.Vector2f cpp_size
        cdef decl.Matrix3 *p

        cpp_center.x, cpp_center.y = center
        cpp_size.x, cpp_size.y = size
        p[0] = decl.Projection(cpp_center, cpp_size, rotation)

        return wrap_matrix_instance(p)
        

    @classmethod
    def transformation(cls, tuple origin, tuple translation, float rotation,
                       tuple scale):
        cdef decl.Vector2f cpp_origin
        cdef decl.Vector2f cpp_translation
        cdef decl.Vector2f cpp_scale
        cdef decl.Matrix3 *p = new decl.Matrix3()

        cpp_origin.x, cpp_origin.y = origin
        cpp_translation.x, cpp_translation.y = translation
        cpp_scale.x, cpp_scale.y = scale

        p[0] = decl.Transformation(cpp_origin, cpp_translation, rotation,
                                   cpp_scale)

        return wrap_matrix_instance(p)

    def get_inverse(self):
        cdef decl.Matrix3 m = self.p_this.GetInverse()
        cdef decl.Matrix3 *p = new decl.Matrix3()

        p[0] = m

        return wrap_matrix_instance(p)

    def transform(self, tuple point):
        cdef decl.Vector2f cpp_point
        cdef decl.Vector2f res

        cpp_point.x = point.x
        cpp_point.y = point.y
        res = self.p_this.Transform(cpp_point)

        return (res.x, res.y)


cdef Matrix3 wrap_matrix_instance(decl.Matrix3 *p_cpp_instance):
    cdef Matrix3 ret = Matrix3.__new__(Matrix3)

    ret.p_this = p_cpp_instance

    return ret



cdef class Color:
    BLACK = Color(0, 0, 0)
    WHITE = Color(255, 255, 255)
    RED = Color(255, 0, 0)
    GREEN = Color(0, 255, 0)
    BLUE = Color(0, 0, 255)
    YELLOW = Color(255, 255, 0)
    MAGENTA = Color(255, 0, 255)
    CYAN = Color(0, 255, 255)

    cdef decl.Color *p_this

    def __init__(self, int r, int g, int b, int a=255):
        self.p_this = new decl.Color(r, g, b, a)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return 'Color({0.r}, {0.g}, {0.b}, {0.a})'.format(self)

    def __richcmp__(Color x, Color y, int op):
        # ==
        if op == 2:
            return (x.r == y.r and
                    x.g == y.g and
                    x.b == y.b and
                    x.a == y.a)
        # !=
        elif op == 3:
            return not x == y

        return NotImplemented

    def __add__(Color x, Color y):
        return Color(min(x.r + y.r, 255),
                     min(x.g + y.g, 255),
                     min(x.b + y.b, 255),
                     min(x.a + y.a, 255))

    def __mul__(Color x, Color y):
        return Color(x.r * y.r / 255,
                     x.g * y.g / 255,
                     x.b * y.b / 255,
                     x.a * y.a / 255)

    property r:
        def __get__(self):
            return self.p_this.r

    property g:
        def __get__(self):
            return self.p_this.g

    property b:
        def __get__(self):
            return self.p_this.b

    property a:
        def __get__(self):
            return self.p_this.a


cdef wrap_color_instance(decl.Color *p_cpp_instance):
    cdef Color ret = Color.__new__(Color)
    ret.p_this = p_cpp_instance

    return ret



class Event:
    CLOSED = declevent.Closed
    RESIZED = declevent.Resized
    LOST_FOCUS = declevent.LostFocus
    GAINED_FOCUS = declevent.GainedFocus
    TEXT_ENTERED = declevent.TextEntered
    KEY_PRESSED = declevent.KeyPressed
    KEY_RELEASED = declevent.KeyReleased
    MOUSE_WHEEL_MOVED = declevent.MouseWheelMoved
    MOUSE_BUTTON_PRESSED = declevent.MouseButtonPressed
    MOUSE_BUTTON_RELEASED = declevent.MouseButtonReleased
    MOUSE_MOVED = declevent.MouseMoved
    MOUSE_ENTERED = declevent.MouseEntered
    MOUSE_LEFT = declevent.MouseLeft
    JOY_BUTTON_PRESSED = declevent.JoyButtonPressed
    JOY_BUTTON_RELEASED = declevent.JoyButtonReleased
    JOY_MOVED = declevent.JoyMoved
    COUNT = declevent.Count

    NAMES = {
        CLOSED: 'Closed',
        RESIZED: 'Resized',
        LOST_FOCUS: 'Lost focus',
        GAINED_FOCUS: 'Gained focus',
        TEXT_ENTERED: 'Text entered',
        KEY_PRESSED: 'Key pressed',
        KEY_RELEASED: 'Key released',
        MOUSE_WHEEL_MOVED: 'Mouse wheel moved',
        MOUSE_BUTTON_PRESSED: 'Mouse button pressed',
        MOUSE_BUTTON_RELEASED: 'Mouse button released',
        MOUSE_MOVED: 'Mouse moved',
        MOUSE_ENTERED: 'Mouse entered',
        MOUSE_LEFT: 'Mouse left',
        JOY_BUTTON_PRESSED: 'Joystick button pressed',
        JOY_BUTTON_RELEASED: 'Joystick button released',
        JOY_MOVED: 'Joystick moved'
        }

    def __str__(self):
        """Return a short description of the event."""

        return self.NAMES[self.type]


# Create an Python Event object that matches the C++ object
# by dynamically setting the corresponding attributes.
cdef wrap_event_instance(decl.Event *p_cpp_instance):
    cdef ret = Event()

    # Set the type
    if p_cpp_instance.Type == declevent.Closed:
        ret.type = Event.CLOSED
    elif p_cpp_instance.Type == declevent.KeyPressed:
        ret.type = Event.KEY_PRESSED
    elif p_cpp_instance.Type == declevent.KeyReleased:
        ret.type = Event.KEY_RELEASED
    elif p_cpp_instance.Type == declevent.Resized:
        ret.type = Event.RESIZED
    elif p_cpp_instance.Type == declevent.TextEntered:
        ret.type = Event.TEXT_ENTERED
    elif p_cpp_instance.Type == declevent.MouseButtonPressed:
        ret.type = Event.MOUSE_BUTTON_PRESSED
    elif p_cpp_instance.Type == declevent.MouseButtonReleased:
        ret.type = Event.MOUSE_BUTTON_RELEASED
    elif p_cpp_instance.Type == declevent.MouseMoved:
        ret.type = Event.MOUSE_MOVED
    elif p_cpp_instance.Type == declevent.LostFocus:
        ret.type = Event.LOST_FOCUS
    elif p_cpp_instance.Type == declevent.GainedFocus:
        ret.type = Event.GAINED_FOCUS
    elif p_cpp_instance.Type == declevent.MouseWheelMoved:
        ret.type = Event.MOUSE_WHEEL_MOVED
    elif p_cpp_instance.Type == declevent.MouseMoved:
        ret.type = Event.MOUSE_MOVED
    elif p_cpp_instance.Type == declevent.MouseEntered:
        ret.type = Event.MOUSE_ENTERED
    elif p_cpp_instance.Type == declevent.MouseLeft:
        ret.type = Event.MOUSE_LEFT
    elif p_cpp_instance.Type == declevent.JoyButtonPressed:
        ret.type = Event.JOY_BUTTON_PRESSED
    elif p_cpp_instance.Type == declevent.JoyButtonReleased:
        ret.type = Event.JOY_BUTTON_RELEASED
    elif p_cpp_instance.Type == declevent.JoyMoved:
        ret.type = Event.JOY_MOVED

    # Set other attributes if needed
    if p_cpp_instance.Type == declevent.Resized:
        ret.width = p_cpp_instance.Size.Width
        ret.height = p_cpp_instance.Size.Height
    elif (p_cpp_instance.Type == declevent.KeyPressed or
          p_cpp_instance.Type == declevent.KeyReleased):
        ret.code = p_cpp_instance.Key.Code
        ret.alt = p_cpp_instance.Key.Alt
        ret.control = p_cpp_instance.Key.Control
        ret.shift = p_cpp_instance.Key.Shift
    elif (p_cpp_instance.Type == declevent.MouseButtonPressed or
          p_cpp_instance.Type == declevent.MouseButtonReleased):
        ret.button = p_cpp_instance.MouseButton.Button
        ret.x = p_cpp_instance.MouseButton.X
        ret.y = p_cpp_instance.MouseButton.Y
    elif p_cpp_instance.Type == declevent.MouseMoved:
        ret.x = p_cpp_instance.MouseMove.X
        ret.y = p_cpp_instance.MouseMove.Y
    elif p_cpp_instance.Type == declevent.MouseWheelMoved:
        ret.delta = p_cpp_instance.MouseWheel.Delta
        ret.x = p_cpp_instance.MouseWheel.X
        ret.y = p_cpp_instance.MouseWheel.Y
    elif (p_cpp_instance.Type == declevent.JoyButtonPressed or
          p_cpp_instance.Type == declevent.JoyButtonReleased):
        ret.joystick_id = p_cpp_instance.JoyButton.JoystickId
        ret.button = p_cpp_instance.JoyButton.Button
    elif p_cpp_instance.Type == declevent.JoyMoved:
        ret.joystick_id = p_cpp_instance.JoyMove.JoystickId
        ret.axis = p_cpp_instance.JoyMove.Axis
        ret.position = p_cpp_instance.JoyMove.Position

    return ret




cdef class Font:
    cdef decl.Font *p_this
    cdef bint delete_this

    DEFAULT_FONT = wrap_font_instance(<decl.Font*>&decl.GetDefaultFont(), False)

    def __cinit__(self):
        self.p_this = new decl.Font()
        self.delete_this = True

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    @classmethod
    def load_from_file(cls, char* filename):
        cdef decl.Font *p = new decl.Font()

        if p.LoadFromFile(filename):
            return wrap_font_instance(p, True)

        raise PySFMLException("Couldn't load font from file " + filename)


cdef Font wrap_font_instance(decl.Font *p_cpp_instance, bint delete_this):
    cdef Font ret = Font.__new__(Font)

    ret.p_this = p_cpp_instance
    ret.delete_this = delete_this

    return ret



cdef class Image:
    cdef decl.Image *p_this
    cdef bint delete_this

    def __init__(self, int width, int height, Color color=None):
        self.p_this = new decl.Image()
        self.delete_this = True

        if color is None:
            self.p_this.Create(width, height)
        else:
            self.p_this.Create(width, height, color.p_this[0])

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __getitem__(self, tuple coords):
        x, y = coords

        return self.get_pixel(x, y)

    def __setitem__(self, tuple coords, Color color):
        x, y = coords

        self.set_pixel(x, y, color)

    property height:
        def __get__(self):
            return self.p_this.GetHeight()

    property smooth:
        def __get__(self):
            return self.p_this.IsSmooth()

        def __set__(self, bint value):
            self.p_this.SetSmooth(value)

    property width:
        def __get__(self):
            return self.p_this.GetWidth()

    @classmethod
    def load_from_file(cls, char *filename):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromFile(filename):
            return wrap_image_instance(p_cpp_instance, True)

        raise FileLoadingException()

    @classmethod
    def load_from_screen(cls, RenderWindow window, IntRect source_rect=None):
        """Return a new image with the screen content."""

        cdef decl.Image *p_cpp_instance = new decl.Image()
        cdef bint result = False

        if source_rect is None:
            result = p_cpp_instance.CopyScreen(window.p_this[0])
        else:
            result = p_cpp_instance.CopyScreen(window.p_this[0],
                                               source_rect.p_this[0])

        if result:
            return wrap_image_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't copy screen")

    @classmethod
    def load_from_memory(cls, char* mem):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromMemory(mem, len(mem)):
            return wrap_image_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't create image from memory")

    @classmethod
    def load_from_pixels(cls, int width, int height, char *pixels):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromPixels(width, height, <unsigned char*>pixels):
            return wrap_image_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't create image from pixels")

    @classmethod
    def get_maximum_size(cls):
        return decl.GetMaximumSize()

    def bind(self):
        self.p_this.Bind()

    def copy(self, Image source, int dest_x, int dest_y,
             source_rect=None, bint apply_alpha=None):
        cdef decl.IntRect cpp_source_rect

        if source_rect is None:
            self.p_this.Copy(source.p_this[0], dest_x, dest_y)
        else:
            if isinstance(source_rect, tuple):
                cpp_source_rect = decl.IntRect(source_rect[0],
                                               source_rect[1],
                                               source_rect[2],
                                               source_rect[3])
            elif isinstance(source_rect, IntRect):
                cpp_source_rect = (<IntRect>source_rect).p_this[0]
            else:
                raise TypeError('source_rect must be tuple or IntRect')

            if apply_alpha is None:
                self.p_this.Copy(source.p_this[0], dest_x, dest_y,
                                 cpp_source_rect)
            else:
                self.p_this.Copy(source.p_this[0], dest_x, dest_y,
                                 cpp_source_rect, apply_alpha)

    def create_mask_from_color(self, Color color, int alpha=0):
        self.p_this.CreateMaskFromColor(color.p_this[0], alpha)

    def get_pixel(self, int x, int y):
        cdef decl.Color *p_color = new decl.Color()
        cdef decl.Color temp = self.p_this.GetPixel(x, y)

        p_color[0] = temp

        return wrap_color_instance(p_color)

    def get_pixels(self):
        """Return a string containing the pixels of the image in RGBA fomat."""

        cdef char* p = <char*>self.p_this.GetPixelsPtr()
        cdef int length = self.width * self.height * 4
        cdef bytes ret = p[:length]

        return ret

    def get_tex_coords(self, rect):
        cdef decl.IntRect cpp_rect = convert_to_int_rect(rect)
        cdef decl.FloatRect res = self.p_this.GetTexCoords(cpp_rect)
        cdef decl.FloatRect *p

        p[0] = res

        return wrap_float_rect_instance(p)

    def save_to_file(self, char* filename):
        self.p_this.SaveToFile(filename)

    def set_pixel(self, int x, int y, Color color):
        self.p_this.SetPixel(x, y, color.p_this[0])

    def update_pixels(self, char *pixels, rect=None):
        cdef decl.IntRect cpp_rect

        if rect is None:
            self.p_this.UpdatePixels(<unsigned char*>pixels)
        else:
            cpp_rect = convert_to_int_rect(rect)
            self.p_this.UpdatePixels(<unsigned char*>pixels, cpp_rect)


cdef Image wrap_image_instance(decl.Image *p_cpp_instance, bint delete_this):
    cdef Image ret = Image.__new__(Image)
    ret.p_this = p_cpp_instance
    ret.delete_this = delete_this

    return ret




cdef class Drawable:
    cdef decl.Drawable *p_this

    def __cinit__(self, *args, **kwargs):
        pass

    def __init__(self, *args, **kwargs):
        if self.__class__ == Drawable:
            raise NotImplementedError('Drawable is abstact')



cdef class Text(Drawable):
    REGULAR = declstyle.Regular
    BOLD = declstyle.Bold
    ITALIC = declstyle.Italic
    UNDERLINED = declstyle.Underlined

    def __cinit__(self, string=None, Font font=None, int character_size=0):
        if string is None:
            self.p_this = <decl.Drawable*>new decl.Text()
        elif font is None:
            self.p_this = <decl.Drawable*>new decl.Text(string)
        elif character_size == 0:
            self.p_this = <decl.Drawable*>new decl.Text(string, font.p_this[0])
        else:
            self.p_this = <decl.Drawable*>new decl.Text(string, font.p_this[0],
                                                        character_size)

    def __dealloc__(self):
        del self.p_this

    property blend_mode:
        def __get__(self):
            return <int>(<decl.Text*>self.p_this).GetBlendMode()

        def __set__(self, int value):
            (<decl.Text*>self.p_this).SetBlendMode(<declblendmode.Mode>value)

    property character_size:
        def __get__(self):
            return (<decl.Text*>self.p_this).GetCharacterSize()

        def __set__(self, int value):
            (<decl.Text*>self.p_this).SetCharacterSize(value)

    property color:
        def __get__(self):
            cdef decl.Color *p = new decl.Color()

            p[0] = (<decl.Text*>self.p_this).GetColor()

            return wrap_color_instance(p)

        def __set__(self, Color value):
            (<decl.Text*>self.p_this).SetColor(value.p_this[0])

    property font:
        def __get__(self):
            cdef decl.Font *p = <decl.Font*>&(<decl.Text*>self.p_this).GetFont()

            return wrap_font_instance(p, False)

    property origin:
        def __get__(self):
            cdef decl.Vector2f origin = (<decl.Text*>self.p_this).GetOrigin()

            return (origin.x, origin.y)

        def __set__(self, tuple value):
            x, y = value
            (<decl.Text*>self.p_this).SetOrigin(x, y)

    property position:
        def __get__(self):
            cdef decl.Vector2f pos = (<decl.Text*>self.p_this).GetPosition()

            return (pos.x, pos.y)

        def __set__(self, tuple value):
            x, y = value
            (<decl.Text*>self.p_this).SetPosition(x, y)

    property rect:
        def __get__(self):
            cdef decl.FloatRect *p = new decl.FloatRect()

            p[0] = (<decl.Text*>self.p_this).GetRect()

            return wrap_float_rect_instance(p)

    property rotation:
        def __get__(self):
            return (<decl.Text*>self.p_this).GetRotation()

        def __set__(self, float value):
            (<decl.Text*>self.p_this).SetRotation(value)

    property scale:
        def __get__(self):
            cdef decl.Vector2f scale = (<decl.Text*>self.p_this).GetScale()

            return (scale.x, scale.y)

        def __set__(self, tuple value):
            x, y = value
            (<decl.Text*>self.p_this).SetScale(x, y)

    property string:
        def __get__(self):
            cdef decl.string res = ((<decl.Text*>self.p_this).GetString()
                                    .ToAnsiString())

            return res.c_str()

    property style:
        def __get__(self):
            return (<decl.Text*>self.p_this).GetStyle()

        def __set__(self, int value):
            (<decl.Text*>self.p_this).SetStyle(value)

    property x:
        def __get__(self):
            return self.position[0]

        def __set__(self, float value):
            (<decl.Text*>self.p_this).SetX(value)

    property y:
        def __get__(self):
            return self.position[1]

        def __set__(self, float value):
            (<decl.Text*>self.p_this).SetY(value)

    def tranform_to_local(self, float x, float y):
        cdef decl.Vector2f cpp_point
        cdef decl.Vector2f res

        cpp_point.x = x
        cpp_point.y = y
        res = (<decl.Text*>self.p_this).TransformToLocal(cpp_point)

        return (res.x, res.y)

    def transform_to_global(self, float x, float y):
        cdef decl.Vector2f cpp_point
        cdef decl.Vector2f res

        cpp_point.x = x
        cpp_point.y = y
        res = (<decl.Text*>self.p_this).TransformToGlobal(cpp_point)

        return (res.x, res.y)

    def get_character_pos(self, int index):
        cdef decl.Vector2f res = (<decl.Text*>self.p_this).GetCharacterPos(
            index)

        return (res.x, res.y)

    def move(self, float x, float y):
        (<decl.Text*>self.p_this).Move(x, y)

    def rotate(self, float angle):
        (<decl.Text*>self.p_this).Rotate(angle)

    def scale(self, float x, float y):
        (<decl.Text*>self.p_this).Scale(x, y)






cdef class Sprite(Drawable):
    def __cinit__(self, Image image=None, tuple position=(0,0),
                  tuple scale=(1,1), float rotation=0.0,
                  Color color=Color.WHITE):
        cdef decl.Vector2f cpp_position
        cdef decl.Vector2f cpp_scale

        if image is None:
            self.p_this = <decl.Drawable*>new decl.Sprite()
        else:
            cpp_position.x = position[0]
            cpp_position.y = position[1]
            cpp_scale.x = scale[0]
            cpp_scale.y = scale[1]
            self.p_this = <decl.Drawable*>new decl.Sprite(image.p_this[0],
                                                          cpp_position,
                                                          cpp_scale,
                                                          rotation,
                                                          color.p_this[0])

    def __dealloc__(self):
        del self.p_this

    def __getitem__(self, tuple coords):
        x, y = coords

        return self.get_pixel(x, y)

    property blend_mode:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetBlendMode()

        def __set__(self, int value):
            (<decl.Sprite*>self.p_this).SetBlendMode(<declblendmode.Mode>value)

    property color:
        def __get__(self):
            cdef decl.Color *p
            cdef decl.Color c

            c = (<decl.Sprite*>self.p_this).GetColor()
            p = new decl.Color(c.r, c.g, c.b, c.a)

            return wrap_color_instance(p)

        def __set__(self, Color value):
            (<decl.Sprite*>self.p_this).SetColor(value.p_this[0])

    property height:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetSize().x

    property image:
        def __get__(self):
            return wrap_image_instance(
                <decl.Image*>((<decl.Sprite*>self.p_this).GetImage()),
                False)

        def __set__(self, Image value):
            (<decl.Sprite*>self.p_this).SetImage(value.p_this[0])

    property origin:
        def __get__(self):
            cdef decl.Vector2f o = (<decl.Sprite*>self.p_this).GetOrigin()

            return (o.x, o.y)

        def __set__(self, tuple value):
            x, y = value

            (<decl.Sprite*>self.p_this).SetOrigin(x, y)

    property position:
        def __get__(self):
            return (self.x, self.y)

        def __set__(self, tuple value):
            x, y = value
            self.x = x
            self.y = y

    property rotation:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetRotation()

        def __set__(self, float value):
            (<decl.Sprite*>self.p_this).SetRotation(value)

    property scale:
        def __get__(self):
            cdef decl.Vector2f scale = (<decl.Sprite*>self.p_this).GetScale()

            return (scale.x, scale.y)

        def __set__(self, tuple value):
            x, y = value

            (<decl.Sprite*>self.p_this).SetScale(x, y)

    property size:
        def __get__(self):
            return (self.width, self.height)

    property sub_rect:
        def __get__(self):
            cdef decl.IntRect r = (<decl.Sprite*>self.p_this).GetSubRect()

            return IntRect(r.Left, r.Top, r.Width, r.Height)

        def __set__(self, value):
            cdef decl.IntRect r = convert_to_int_rect(value)

            (<decl.Sprite*>self.p_this).SetSubRect(r)

    property width:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetSize().y

    property x:
        def __get__(self):
            cdef decl.Vector2f pos = (<decl.Sprite*>self.p_this).GetPosition()

            return pos.x

        def __set__(self, float value):
            (<decl.Sprite*>self.p_this).SetX(value)

    property y:
        def __get__(self):
            cdef decl.Vector2f pos = (<decl.Sprite*>self.p_this).GetPosition()

            return pos.y

        def __set__(self, float value):
            (<decl.Sprite*>self.p_this).SetY(value)

    def get_pixel(self, unsigned int x, unsigned int y):
        cdef decl.Color *p
        cdef decl.Color c

        c = (<decl.Sprite*>self.p_this).GetPixel(x, y)
        p = new decl.Color(c.r, c.g, c.b, c.a)

        return wrap_color_instance(p)

    def flip_x(self, bint flipped):
        (<decl.Sprite*>self.p_this).FlipX(flipped)

    def flip_y(self, bint flipped):
        (<decl.Sprite*>self.p_this).FlipY(flipped)

    def move(self, float x, float y):
        (<decl.Sprite*>self.p_this).Move(x, y)

    def resize(self, float width, float height):
        (<decl.Sprite*>self.p_this).Resize(width, height)

    def rotate(self, float angle):
        (<decl.Sprite*>self.p_this).Rotate(angle)

    def scale(self, float x, float y):
        (<decl.Sprite*>self.p_this).Scale(x, y)

    def set_image(self, Image image, bint adjust_to_new_size=False):
        (<decl.Sprite*>self.p_this).SetImage(image.p_this[0],
                                             adjust_to_new_size)

    def transform_to_global(self, float x, float y):
        cdef decl.Vector2f v
        cdef decl.Vector2f res

        v.x = x
        v.y = y
        res = (<decl.Sprite*>self.p_this).TransformToGlobal(v)

        return (res.x, res.y)

    def transform_to_local(self, float x, float y):
        cdef decl.Vector2f v
        cdef decl.Vector2f res

        v.x = x
        v.y = y
        res = (<decl.Sprite*>self.p_this).TransformToLocal(v)

        return (res.x, res.y)


cdef class VideoMode:
    cdef decl.VideoMode *p_this
    cdef bint delete_this

    def __cinit__(self, width=None, height=None, bits_per_pixel=32):
        if width is None or height is None:
            self.p_this = new decl.VideoMode()
        else:
            self.p_this = new decl.VideoMode(width, height, bits_per_pixel)

        self.delete_this = True

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __str__(self):
        """Return a string about the mode in this format: WIDTHxHEIGHTxBPP.

        For example, '1024x768x32'."""

        return '{0.width}x{0.height}x{0.bits_per_pixel}'.format(self)

    def __repr__(self):
        return ('VideoMode({0.width}, {0.height}, {0.bits_per_pixel})'
                .format(self))

    def __richcmp__(VideoMode x, VideoMode y, int op):
        # ==
        if op == 2:
            return (x.width == y.width and
                    x.height == y.height and
                    x.bits_per_pixel == y.bits_per_pixel)
        # !=
        elif op == 3:
            return not x == y

        # <
        elif op == 0:
            if x.bits_per_pixel == y.bits_per_pixel:
                if x.width == y.width:
                    return x.height < y.height
                else:
                    return x.width < y.width
            else:
                return x.bits_per_pixel < y.bits_per_pixel
        # >
        elif op == 4:
            return y < x

        # <=
        elif op == 1:
            return not y < x
        # >=
        elif op == 5:
            return not x < y

        return NotImplemented

    property width:
        def __get__(self):
            return self.p_this.Width

    property height:
        def __get__(self):
            return self.p_this.Height

    property bits_per_pixel:
        def __get__(self):
            return self.p_this.BitsPerPixel

    @classmethod
    def get_desktop_mode(cls):
        cdef decl.VideoMode *p = new decl.VideoMode()
        p[0] = decl.GetDesktopMode()

        return wrap_video_mode_instance(p, True)

    @classmethod
    def get_fullscreen_modes(cls):
        cdef list ret = []
        cdef vector[decl.VideoMode] v = decl.GetFullscreenModes()
        cdef vector[decl.VideoMode].iterator it = v.begin()
        cdef decl.VideoMode current
        cdef decl.VideoMode *p_temp

        while it != v.end():
            current = deref(it)
            p_temp = new decl.VideoMode(current.Width, current.Height,
                                        current.BitsPerPixel)
            ret.append(wrap_video_mode_instance(p_temp, True))
            preinc(it)

        return ret

    def is_valid(self):
        return self.p_this.IsValid()


cdef VideoMode wrap_video_mode_instance(decl.VideoMode *p_cpp_instance,
                                        bint delete_this):
    cdef VideoMode ret = VideoMode.__new__(VideoMode)
    ret.p_this = p_cpp_instance
    ret.delete_this = delete_this

    return ret





cdef class View:
    cdef decl.View *p_this

    def __cinit__(self):
        self.p_this = new decl.View()

    def __dealloc__(self):
        del self.p_this

    property center:
        def __get__(self):
            cdef decl.Vector2f center = self.p_this.GetCenter()

            return (center.x, center.y)

        def __set__(self, tuple value):
            cdef float x
            cdef float y

            x, y = value
            self.p_this.SetCenter(x, y)

    property rotation:
        def __get__(self):
            return self.p_this.GetRotation()

        def __set__(self, float value):
            self.p_this.SetRotation(value)

    property size:
        def __get__(self):
            cdef decl.Vector2f size = self.p_this.GetSize()

            return (size.x, size.y)

        def __set__(self, tuple value):
            cdef float x
            cdef float y

            x, y = value
            self.p_this.SetSize(x, y)

    property viewport:
        def __get__(self):
            cdef decl.FloatRect *p = new decl.FloatRect()

            p[0] = self.p_this.GetViewport()

            return wrap_float_rect_instance(p)

        def __set__(self, FloatRect value):
            self.p_this.SetViewport(value.p_this[0])

    @classmethod
    def from_center_and_size(cls, tuple center, tuple size):
        cdef decl.Vector2f cpp_center
        cdef decl.Vector2f cpp_size
        cdef decl.View *p

        cpp_center.x, cpp_center.y = center
        cpp_size.x, cpp_size.y = size
        p = new decl.View(cpp_center, cpp_size)

        return wrap_view_instance(p)
        

    @classmethod
    def from_rect(cls, FloatRect rect):
        cdef decl.View *p = new decl.View(rect.p_this[0])

        return wrap_view_instance(p)

    def move(self, float x, float y):
        self.p_this.Move(x, y)

    def reset(self, FloatRect rect):
        self.p_this.Reset(rect.p_this[0])

    def rotate(self, float angle):
        self.p_this.Rotate(angle)

    def zoom(self, float factor):
        self.p_this.Zoom(factor)


cdef View wrap_view_instance(decl.View *p_cpp_view):
    cdef View ret = View.__new__(View)

    ret.p_this = p_cpp_view

    return ret



cdef class RenderWindow:
    cdef decl.RenderWindow *p_this

    # Event returned when iterating on iter_events()
    cdef decl.Event *p_event

    def __cinit__(self, VideoMode mode, char* title):
        self.p_this = new decl.RenderWindow(mode.p_this[0], title)
        self.p_event = new decl.Event()

    def __dealloc__(self):
        del self.p_this

    def __iter__(self):
        return self

    def __next__(self):
        if self.p_this.GetEvent(self.p_event[0]):
            return wrap_event_instance(self.p_event)

        raise StopIteration

    property framerate_limit:
        def __set__(self, int value):
            self.p_this.SetFramerateLimit(value)

    property height:
        def __get__(self):
            return self.p_this.GetHeight()

        def __set__(self, unsigned int value):
            self.size = (self.width, value)

    property size:
        def __get__(self):
            return (self.width, self.height)

        def __set__(self, tuple value):
            x, y = value
            self.p_this.SetSize(x, y)

    property width:
        def __get__(self):
            return self.p_this.GetWidth()

        def __set__(self, unsigned int value):
            self.size = (value, self.height)

    def clear(self, Color color=None):
        if color is None:
            self.p_this.Clear()
        else:
            self.p_this.Clear(color.p_this[0])

    def close(self):
        self.p_this.Close()

    def display(self):
        self.p_this.Display()

    def draw(self, Drawable drawable):
        self.p_this.Draw(drawable.p_this[0])

    def iter_events(self):
        """Return an iterator which yields the current pending events.

        Warning: to avoid consistency problems, you should never
        modify the events obtained by this method. This is because it
        actually always gives the same Event instance, which is stored
        internally.

        Example::
        
            for event in window.iter_events():
                if event.type == sf.Event.CLOSED:
                    # ..."""

        return self
