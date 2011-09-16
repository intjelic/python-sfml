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


from libc.stdlib cimport malloc, free
from libcpp.vector cimport vector
from cython.operator cimport preincrement as preinc, dereference as deref

cimport decl
cimport declaudio
cimport declblendmode
cimport declevent
cimport decljoy
cimport declkey
cimport declmouse
cimport declstyle



# Forward declarations
cdef class RenderWindow




class PySFMLException(Exception):
    pass



cdef class Mouse:
    LEFT = declmouse.Left
    RIGHT = declmouse.Right
    MIDDLE = declmouse.Middle
    X_BUTTON1 = declmouse.XButton1
    X_BUTTON2 = declmouse.XButton2
    BUTTON_COUNT = declmouse.ButtonCount

    @classmethod
    def is_button_pressed(cls, int button):
        return declmouse.IsButtonPressed(<declmouse.Button>button)

    @classmethod
    def get_position(cls, RenderWindow window=None):
        cdef decl.Vector2i pos

        if window is None:
            pos = declmouse.GetPosition()
        else:
            pos = declmouse.GetPosition(window.p_this[0])

        return (pos.x, pos.y)

    @classmethod
    def set_position(cls, tuple position, RenderWindow window=None):
        cdef decl.Vector2i cpp_pos

        cpp_pos.x, cpp_pos.y = position

        if window is None:
            declmouse.SetPosition(cpp_pos)
        else:
            declmouse.SetPosition(cpp_pos, window.p_this[0])



cdef class Joystick:
    COUNT = decljoy.Count
    BUTTON_COUNT = decljoy.ButtonCount
    AXIS_COUNT = decljoy.AxisCount
    X = decljoy.X
    Y = decljoy.Y
    Z = decljoy.Z
    R = decljoy.R
    U = decljoy.U
    V = decljoy.V
    POV_X = decljoy.PovX
    POV_Y = decljoy.PovY

    @classmethod
    def is_connected(cls, unsigned int joystick):
        return decljoy.IsConnected(joystick)

    @classmethod
    def get_button_count(cls, unsigned int joystick):
        return decljoy.GetButtonCount(joystick)

    @classmethod
    def has_axis(cls, unsigned int joystick, int axis):
        return decljoy.HasAxis(joystick, <decljoy.Axis>axis)

    @classmethod
    def is_button_pressed(cls, unsigned int joystick, unsigned int button):
        return decljoy.IsButtonPressed(joystick, button)

    @classmethod
    def get_axis_position(cls, unsigned int joystick, int axis):
        return decljoy.GetAxisPosition(joystick, <decljoy.Axis> axis)

    


cdef class Keyboard:
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
    KEY_COUNT = declkey.KeyCount

    @classmethod
    def is_key_pressed(cls, int key):
        return declkey.IsKeyPressed(<declkey.Key>key)


cdef class BlendMode:
    ALPHA = declblendmode.Alpha
    ADD = declblendmode.Add
    MULTIPLY = declblendmode.Multiply
    NONE = declblendmode.None



cdef class Style:
    NONE = declstyle.None
    TITLEBAR = declstyle.Titlebar
    RESIZE = declstyle.Resize
    CLOSE = declstyle.Close
    FULLSCREEN = declstyle.Fullscreen
    DEFAULT = declstyle.Default



cdef class IntRect:
    cdef decl.IntRect *p_this

    def __init__(self, int left=0, int top=0, int width=0, int height=0):
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


cdef IntRect wrap_int_rect_instance(decl.IntRect *p_cpp_instance):
    cdef IntRect ret = IntRect.__new__(IntRect)
    ret.p_this = p_cpp_instance

    return ret


cdef decl.IntRect convert_to_int_rect(value):
    if isinstance(value, IntRect):
        return (<IntRect>value).p_this[0]

    if isinstance(value, tuple):
        return decl.IntRect(value[0], value[1], value[2], value[3])
    
    raise TypeError("Expected IntRect or tuple, found {0}".format(type(value)))





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




cdef class Vector2f:
    cdef decl.Vector2f *p_this

    def __cinit__(self, float x=0.0, float y=0.0):
        self.p_this = new decl.Vector2f(x, y)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return 'Vector2f({0}, {1})'.format(self.x, self.y)

    def __richcmp__(Vector2f a, Vector2f b, int op):
        # ==
        if op == 2:
            return a.x == b.x and a.y == b.y
        # !=
        elif op == 3:
            return a.x != b.x or a.y != b.y

        return NotImplemented

    def __add__(a, b):
        if isinstance(a, Vector2f) and isinstance(b, Vector2f):
            return Vector2f(a.x + b.x, a.y + b.y)

        return NotImplemented

    def __iadd__(self, b):
        if isinstance(b, Vector2f):
            self.p_this.x += b.x
            self.p_this.y += b.y
            return self
        return NotImplemented

    def __sub__(a, b):
        if isinstance(a, Vector2f) and isinstance(b, Vector2f):
            return Vector2f(a.x - b.x, a.y - b.y)

    def __isub__(self, b):
        if isinstance(b, Vector2f):
            self.p_this.x -= b.x
            self.p_this.y -= b.y
            return self
        return NotImplemented

    def __mul__(a, b):
        if isinstance(a, Vector2f) and isinstance(b, (int, float)):
            return Vector2f(a.x * b, a.y * b)
        elif isinstance(a, (int, float)) and isinstance(b, Vector2f):
            return Vector2f(b.x * a, b.y * a)

        return NotImplemented

    def __imul__(self, b):
        if isinstance(b, (int, float)):
            self.p_this.x *= b
            self.p_this.y *= b
            return self
        return NotImplemented

    def __div__(a, b):
        if isinstance(a, Vector2f) and isinstance(b, (int, float)):
            return Vector2f(a.x / <float>b, a.y / <float>b)

        return NotImplemented

    def __idiv__(self, b):
        if isinstance(b, (int, float)):
            self.p_this.x /= <float>b
            self.p_this.y /= <float>b
            return self
        return NotImplemented

    def copy(self):
        return Vector2f(self.p_this.x, self.p_this.y)

    property x:
        def __get__(self):
            return self.p_this.x

        def __set__(self, float value):
            self.p_this.x = value

    property y:
        def __get__(self):
            return self.p_this.y

        def __set__(self, float value):
            self.p_this.y = value

    @classmethod
    def from_tuple(cls, tuple t):
        return Vector2f(t[0], t[1])


cdef decl.Vector2f convert_to_vector2f(value):
    if isinstance(value, Vector2f):
        return (<Vector2f>value).p_this[0]

    if isinstance(value, tuple):
        return decl.Vector2f(value[0], value[1])
    
    raise TypeError("Expected Vector2f or tuple, found {0}".format(type(value)))






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
    def projection(cls, center, size, float rotation):
        cdef decl.Vector2f cpp_center = convert_to_vector2f(center)
        cdef decl.Vector2f cpp_size = convert_to_vector2f(size)
        cdef decl.Matrix3 *p = new decl.Matrix3()

        p[0] = decl.Projection(cpp_center, cpp_size, rotation)

        return wrap_matrix_instance(p)
        
    @classmethod
    def transformation(cls, origin, translation, float rotation, scale):
        cdef decl.Vector2f cpp_origin = convert_to_vector2f(origin)
        cdef decl.Vector2f cpp_translation = convert_to_vector2f(translation)
        cdef decl.Vector2f cpp_scale = convert_to_vector2f(scale)
        cdef decl.Matrix3 *p = new decl.Matrix3()

        p[0] = decl.Transformation(cpp_origin, cpp_translation, rotation,
                                   cpp_scale)

        return wrap_matrix_instance(p)

    def get_inverse(self):
        cdef decl.Matrix3 m = self.p_this.GetInverse()
        cdef decl.Matrix3 *p = new decl.Matrix3()

        p[0] = m

        return wrap_matrix_instance(p)

    def transform(self, point):
        cdef decl.Vector2f cpp_point = convert_to_vector2f(point)
        cdef decl.Vector2f res

        res = self.p_this.Transform(cpp_point)

        return (res.x, res.y)


cdef Matrix3 wrap_matrix_instance(decl.Matrix3 *p_cpp_instance):
    cdef Matrix3 ret = Matrix3.__new__(Matrix3)

    ret.p_this = p_cpp_instance

    return ret





cdef class Clock:
    cdef decl.Clock *p_this

    def __cinit__(self):
        self.p_this = new decl.Clock()

    def __dealloc__(self):
        del self.p_this

    property elapsed_time:
        def __get__(self):
            return self.p_this.GetElapsedTime()

    def reset(self):
        self.p_this.Reset()



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

        def __set__(self, unsigned int value):
            self.p_this.r = value

    property g:
        def __get__(self):
            return self.p_this.g

        def __set__(self, unsigned int value):
            self.p_this.g = value

    property b:
        def __get__(self):
            return self.p_this.b

        def __set__(self, unsigned int value):
            self.p_this.b = value

    property a:
        def __get__(self):
            return self.p_this.a

        def __set__(self, unsigned int value):
            self.p_this.a = value


cdef wrap_color_instance(decl.Color *p_cpp_instance):
    cdef Color ret = Color.__new__(Color)
    ret.p_this = p_cpp_instance

    return ret




cdef class SoundBuffer:
    cdef declaudio.SoundBuffer *p_this
    cdef bint delete_this

    def __init__(self):
        # self.delete_this = True
        raise NotImplementedError("Use static methods like load_from_file "
                                  "to create SoundBuffer instances")

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    property channels_count:
        def __get__(self):
            return self.p_this.GetChannelsCount()

    property duration:
        def __get__(self):
            return self.p_this.GetDuration()

    property sample_rate:
        def __get__(self):
            return self.p_this.GetSampleRate()

    property samples:
        def __get__(self):
            cdef decl.Int16 *p = <decl.Int16*>self.p_this.GetSamples()
            ret = []

            for i from 0 <= i < self.p_this.GetSamplesCount():
                ret.append(int(p[i]))

            return ret

    property samples_count:
        def __get__(self):
            return self.p_this.GetSamplesCount()

    @classmethod
    def load_from_file(cls, char* filename):
        cdef declaudio.SoundBuffer *p = new declaudio.SoundBuffer()

        if p.LoadFromFile(filename):
            return wrap_sound_buffer_instance(p, True)

        raise PySFMLException("Couldn't load sound buffer from " + filename)

    @classmethod
    def load_from_memory(cls, char* data):
        cdef declaudio.SoundBuffer *p = new declaudio.SoundBuffer()

        if p.LoadFromMemory(data, len(data)):
            return wrap_sound_buffer_instance(p, True)

        raise PySFMLException("Couldn't load sound buffer from memory")

    @classmethod
    def load_from_samples(cls, list samples, unsigned int channels_count,
                          unsigned int sample_rate):
        cdef declaudio.SoundBuffer *p_sb = new declaudio.SoundBuffer()
        cdef decl.Int16 *p_samples = <decl.Int16*>malloc(
            len(samples) * sizeof(decl.Int16))
        cdef decl.Int16 *p_temp = NULL

        if p_samples == NULL:
            raise PySFMLException("Couldn't allocate memory for samples")
        else:
            p_temp = p_samples

            for sample in samples:
                p_temp[0] = <int>sample
                preinc(p_temp)

            if p_sb.LoadFromSamples(p_samples, len(samples), channels_count,
                                    sample_rate):
                free(p_samples)
                return wrap_sound_buffer_instance(p_sb, True)
            else:
                free(p_samples)
                raise PySFMLException("Couldn't load samples")

    def save_to_file(self, char* filename):
        self.p_this.SaveToFile(filename)


cdef SoundBuffer wrap_sound_buffer_instance(
    declaudio.SoundBuffer *p_cpp_instance, bint delete_this):
    cdef SoundBuffer ret = SoundBuffer.__new__(SoundBuffer)

    ret.p_this = p_cpp_instance
    ret.delete_this = delete_this

    return ret




cdef class Sound:
    cdef declaudio.Sound *p_this

    STOPPED = declaudio.Stopped
    PAUSED = declaudio.Paused
    PLAYING = declaudio.Playing

    def __cinit__(self, SoundBuffer buffer=None):
        if buffer is None:
            self.p_this = new declaudio.Sound()
        else:
            self.p_this = new declaudio.Sound(buffer.p_this[0])

    def __dealloc__(self):
        del self.p_this

    property attenuation:
        def __get__(self):
            return self.p_this.GetAttenuation()

        def __set__(self, float value):
            self.p_this.SetAttenuation(value)

    property buffer:
        def __get__(self):
            return wrap_sound_buffer_instance(
                <declaudio.SoundBuffer*>self.p_this.GetBuffer(), False)

        def __set__(self, SoundBuffer value):
            self.p_this.SetBuffer(value.p_this[0])

    property loop:
        def __get__(self):
            return self.p_this.GetLoop()

        def __set__(self, bint value):
            self.p_this.SetLoop(value)

    property min_distance:
        def __get__(self):
            return self.p_this.GetMinDistance()

        def __set__(self, float value):
            self.p_this.SetMinDistance(value)

    property pitch:
        def __get__(self):
            return self.p_this.GetPitch()

        def __set__(self, float value):
            self.p_this.SetPitch(value)

    property playing_offset:
        def __get__(self):
            return self.p_this.GetPlayingOffset()

        def __set__(self, int value):
            self.p_this.SetPlayingOffset(value)

    property position:
        def __get__(self):
            cdef decl.Vector3f pos = self.p_this.GetPosition()

            return (pos.x, pos.y, pos.z)

        def __set__(self, tuple value):
            x, y, z = value
            self.p_this.SetPosition(x, y, z)

    property relative_to_listener:
        def __get__(self):
            return self.p_this.IsRelativeToListener()

        def __set__(self, bint value):
            self.p_this.SetRelativeToListener(value)

    property status:
        def __get__(self):
            return <int>self.p_this.GetStatus()

    property volume:
        def __get__(self):
            return self.p_this.GetVolume()

        def __set__(self, float value):
            self.p_this.SetVolume(value)

    def pause(self):
        self.p_this.Pause()

    def play(self):
        self.p_this.Play()

    def stop(self):
        self.p_this.Stop()




cdef class Music:
    cdef declaudio.Music *p_this

    STOPPED = declaudio.Stopped
    PAUSED = declaudio.Paused
    PLAYING = declaudio.Playing

    def __init__(self):
        raise NotImplementedError(
            "Use class methods like open_from_file() or open_from_memory() "
            "to create Music objects")

    def __dealloc__(self):
        del self.p_this

    property attenuation:
        def __get__(self):
            return self.p_this.GetAttenuation()

        def __set__(self, float value):
            self.p_this.SetAttenuation(value)

    property channels_count:
        def __get__(self):
            return self.p_this.GetChannelsCount()

    property duration:
        def __get__(self):
            return self.p_this.GetDuration()

    property loop:
        def __get__(self):
            return self.p_this.GetLoop()

        def __set__(self, bint value):
            self.p_this.SetLoop(value)

    property min_distance:
        def __get__(self):
            return self.p_this.GetMinDistance()

        def __set__(self, float value):
            self.p_this.SetMinDistance(value)

    property pitch:
        def __get__(self):
            return self.p_this.GetPitch()

        def __set__(self, float value):
            self.p_this.SetPitch(value)

    property playing_offset:
        def __get__(self):
            return self.p_this.GetPlayingOffset()

        def __set__(self, float value):
            self.p_this.SetPlayingOffset(value)

    property position:
        def __get__(self):
            cdef decl.Vector3f pos = self.p_this.GetPosition()

            return (pos.x, pos.y, pos.z)

        def __set__(self, tuple value):
            x, y, z = value
            self.p_this.SetPosition(x, y, z)

    property relative_to_listener:
        def __get__(self):
            return self.p_this.IsRelativeToListener()

        def __set__(self, bint value):
            self.p_this.SetRelativeToListener(value)

    property sample_rate:
        def __get__(self):
            return self.p_this.GetSampleRate()

    property status:
        def __get__(self):
            return <int>self.p_this.GetStatus()

    property volume:
        def __get__(self):
            return self.p_this.GetVolume()

        def __set__(self, float value):
            self.p_this.SetVolume(value)

    @classmethod
    def open_from_file(cls, char* filename):
        cdef declaudio.Music *p = new declaudio.Music()

        if p.OpenFromFile(filename):
            return wrap_music_instance(p)

        raise PySFMLException("Couldn't open music in file " + filename)

    @classmethod
    def open_from_memory(cls, bytes data):
        cdef declaudio.Music *p = new declaudio.Music()

        if p.OpenFromMemory(<char*>data, len(data)):
            return wrap_music_instance(p)

        raise PySFMLException("Couldn't open music from memory")

    def pause(self):
        self.p_this.Pause()

    def play(self):
        self.p_this.Play()

    def stop(self):
        self.p_this.Stop()

cdef Music wrap_music_instance(declaudio.Music *p_cpp_instance):
    cdef Music ret = Music.__new__(Music)

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
    JOYSTICK_BUTTON_PRESSED = declevent.JoystickButtonPressed
    JOYSTICK_BUTTON_RELEASED = declevent.JoystickButtonReleased
    JOYSTICK_MOVED = declevent.JoystickMoved
    JOYSTICK_CONNECTED = declevent.JoystickConnected
    JOYSTICK_DISCONNECTED = declevent.JoystickDisconnected
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
        JOYSTICK_BUTTON_PRESSED: 'Joystick button pressed',
        JOYSTICK_BUTTON_RELEASED: 'Joystick button released',
        JOYSTICK_MOVED: 'Joystick moved',
        JOYSTICK_CONNECTED: 'Joystick connected',
        JOYSTICK_DISCONNECTED: 'Joystick disconnected'
        }

    def __str__(self):
        """Return a short description of the event."""

        return self.NAMES[self.type]


# Create an Python Event object that matches the C++ object
# by dynamically setting the corresponding attributes.
cdef wrap_event_instance(decl.Event *p_cpp_instance):
    cdef ret = Event()
    cdef decl.Uint32 code

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
    elif p_cpp_instance.Type == declevent.JoystickButtonPressed:
        ret.type = Event.JOYSTICK_BUTTON_PRESSED
    elif p_cpp_instance.Type == declevent.JoystickButtonReleased:
        ret.type = Event.JOYSTICK_BUTTON_RELEASED
    elif p_cpp_instance.Type == declevent.JoystickMoved:
        ret.type = Event.JOYSTICK_MOVED
    elif p_cpp_instance.Type == declevent.JoystickConnected:
        ret.type = Event.JOYSTICK_CONNECTED
    elif p_cpp_instance.Type == declevent.JoystickDisconnected:
        ret.type = Event.JOYSTICK_DISCONNECTED

    # Set other attributes if needed
    if p_cpp_instance.Type == declevent.Resized:
        ret.width = p_cpp_instance.Size.Width
        ret.height = p_cpp_instance.Size.Height
    elif p_cpp_instance.Type == declevent.TextEntered:
        code = p_cpp_instance.Text.Unicode
        ret.unicode = ((<char*>&code)[:4]).decode('utf-32-le')
    elif (p_cpp_instance.Type == declevent.KeyPressed or
          p_cpp_instance.Type == declevent.KeyReleased):
        ret.code = p_cpp_instance.Key.Code
        ret.alt = p_cpp_instance.Key.Alt
        ret.control = p_cpp_instance.Key.Control
        ret.shift = p_cpp_instance.Key.Shift
        ret.system = p_cpp_instance.Key.System
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
    elif (p_cpp_instance.Type == declevent.JoystickButtonPressed or
          p_cpp_instance.Type == declevent.JoystickButtonReleased):
        ret.joystick_id = p_cpp_instance.JoystickButton.JoystickId
        ret.button = p_cpp_instance.JoystickButton.Button
    elif p_cpp_instance.Type == declevent.JoystickMoved:
        ret.joystick_id = p_cpp_instance.JoystickMove.JoystickId
        ret.axis = p_cpp_instance.JoystickMove.Axis
        ret.position = p_cpp_instance.JoystickMove.Position
    elif p_cpp_instance.Type == declevent.JoystickConnected:
        ret.joystick_id = p_cpp_instance.JoystickConnect.JoystickId
    elif p_cpp_instance.Type == declevent.JoystickDisconnected:
        ret.joystick_id = p_cpp_instance.JoystickConnect.JoystickId

    return ret



cdef class Glyph:
    cdef decl.Glyph *p_this

    def __init__(self):
        self.p_this = new decl.Glyph()

    def __dealloc__(self):
        del self.p_this

    property advance:
        def __get__(self):
            return self.p_this.Advance

    property bounds:
        def __get__(self):
            cdef decl.IntRect *p = new decl.IntRect()

            p[0] = self.p_this.Bounds

            return wrap_int_rect_instance(p)

    property sub_rect:
        def __get__(self):
            cdef decl.IntRect *p = new decl.IntRect()

            p[0] = self.p_this.SubRect

            return wrap_int_rect_instance(p)


cdef Glyph wrap_glyph_instance(decl.Glyph *p_cpp_instance):
    cdef Glyph ret = Glyph.__new__(Glyph)

    ret.p_this = p_cpp_instance

    return ret





cdef class Font:
    cdef decl.Font *p_this
    cdef bint delete_this

    DEFAULT_FONT = wrap_font_instance(<decl.Font*>&decl.GetDefaultFont(), False)

    def __init__(self):
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

    @classmethod
    def load_from_memory(cls, char* data):
        cdef decl.Font *p = new decl.Font()

        if p.LoadFromMemory(data, len(data)):
            return wrap_font_instance(p, True)

        raise PySFMLException("Couldn't load font from memory")

    def get_glyph(self, unsigned int code_point, unsigned int character_size,
                  bint bold):
        cdef decl.Glyph *p = new decl.Glyph()

        p[0] = self.p_this.GetGlyph(code_point, character_size, bold)

        return wrap_glyph_instance(p)

    def get_texture(self, unsigned int character_size):
        cdef decl.Texture *p = <decl.Texture*>&self.p_this.GetTexture(
            character_size)

        return wrap_texture_instance(p, False)

    def get_kerning(self, unsigned int first, unsigned int second,
                    unsigned int character_size):
        return self.p_this.GetKerning(first, second, character_size)

    def get_line_spacing(self, unsigned int character_size):
        return self.p_this.GetLineSpacing(character_size)


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

    def __getitem__(self, coords):
        cdef decl.Vector2f v = convert_to_vector2f(coords)

        return self.get_pixel(v.x, v.y)

    def __setitem__(self, coords, Color color):
        cdef decl.Vector2f v = convert_to_vector2f(coords)

        self.set_pixel(v.x, v.y, color)

    property height:
        def __get__(self):
            return self.p_this.GetHeight()

    property width:
        def __get__(self):
            return self.p_this.GetWidth()

    @classmethod
    def load_from_file(cls, char *filename):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromFile(filename):
            return wrap_image_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't load file {0}".format(filename))

    @classmethod
    def load_from_memory(cls, char* mem):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromMemory(mem, len(mem)):
            return wrap_image_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't create image from memory")

    # TODO: maybe this should be moved to the constructor, since the method
    # was renamed from LoadFromPixels() to Create()
    @classmethod
    def load_from_pixels(cls, int width, int height, char *pixels):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        p_cpp_instance.Create(width, height, <unsigned char*>pixels)

        return wrap_image_instance(p_cpp_instance, True)

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

    def save_to_file(self, char* filename):
        self.p_this.SaveToFile(filename)

    def set_pixel(self, int x, int y, Color color):
        self.p_this.SetPixel(x, y, color.p_this[0])


cdef Image wrap_image_instance(decl.Image *p_cpp_instance, bint delete_this):
    cdef Image ret = Image.__new__(Image)
    ret.p_this = p_cpp_instance
    ret.delete_this = delete_this

    return ret





cdef class Texture:
    cdef decl.Texture *p_this
    cdef bint delete_this

    MAXIMUM_SIZE = decl.Texture_GetMaximumSize()

    def __init__(self, unsigned int width=0, unsigned int height=0):
        self.p_this = new decl.Texture()
        self.delete_this = True

        if width > 0 and height > 0:
            if self.p_this.Create(width, height) != True:
                raise PySFMLException("Error while creating texture "
                                      "(with={0}, height={1})"
                                      .format(width, height))

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

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
    def load_from_file(cls, char *filename, object area=None):
        cdef decl.IntRect cpp_rect
        cdef decl.Texture *p_cpp_instance = new decl.Texture()

        if area is None:
            if p_cpp_instance.LoadFromFile(filename):
                return wrap_texture_instance(p_cpp_instance, True)
        else:
            cpp_rect = convert_to_int_rect(area)

            if p_cpp_instance.LoadFromFile(filename, cpp_rect):
                return wrap_texture_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't load texture from file {0}"
                              .format(filename))

    @classmethod
    def load_from_image(cls, Image image, object area=None):
        cdef decl.IntRect cpp_rect
        cdef decl.Texture *p_cpp_instance = new decl.Texture()

        if area is None:
            if p_cpp_instance.LoadFromImage(image.p_this[0]):
                return wrap_texture_instance(p_cpp_instance, True)
        else:
            cpp_rect = convert_to_int_rect(area)

            if p_cpp_instance.LoadFromImage(image.p_this[0], cpp_rect):
                return wrap_texture_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't load texture from image {0}"
                              .format(image))

    @classmethod
    def load_from_memory(cls, bytes data, area=None):
        cdef decl.IntRect cpp_rect
        cdef decl.Texture *p_cpp_instance = new decl.Texture()

        if area is None:
            if p_cpp_instance.LoadFromMemory(<char*>data, len(data)):
                return wrap_texture_instance(p_cpp_instance, True)
        else:
            cpp_rect = convert_to_int_rect(area)

            if p_cpp_instance.LoadFromMemory(<char*>data, len(data), cpp_rect):
                return wrap_texture_instance(p_cpp_instance, True)

        raise PySFMLException("Couldn't create texture from memory")

    def bind(self):
        self.p_this.Bind()

    def get_tex_coords(self, rect):
        cdef decl.IntRect cpp_rect = convert_to_int_rect(rect)
        cdef decl.FloatRect res = self.p_this.GetTexCoords(cpp_rect)
        cdef decl.FloatRect *p = new decl.FloatRect()

        p[0] = res

        return wrap_float_rect_instance(p)

    def update(self, object source, int p1=-1, int p2=-1, int p3=-1, int p4=-1):
        if isinstance(source, bytes):
            if p1 == -1:
                self.p_this.Update(<decl.Uint8*>(<char*>source))
            else:
                self.p_this.Update(<decl.Uint8*>(<char*>source),
                                   p1, p2, p3, p4)
        elif isinstance(source, Image):
            if p1 == -1:
                self.p_this.Update((<Image>source).p_this[0])
            else:
                self.p_this.Update((<Image>source).p_this[0], p1, p2)
        elif isinstance(source, RenderWindow):
            if p1 == -1:
                self.p_this.Update((<RenderWindow>source).p_this[0])
            else:
                self.p_this.Update((<RenderWindow>source).p_this[0], p1, p2)
        else:
            raise TypeError(
                "The source argument should be of type str / bytes(py3k), "
                "Image or RenderWindow (found {0})".format(type(source)))


cdef Texture wrap_texture_instance(decl.Texture *p_cpp_instance,
                                   bint delete_this):
    cdef Texture ret = Texture.__new__(Texture)
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
    
    property blend_mode:
        def __get__(self):
            return <int>self.p_this.GetBlendMode()

        def __set__(self, int value):
            self.p_this.SetBlendMode(<declblendmode.Mode>value)

    property color:
        def __get__(self):
            cdef decl.Color *p = new decl.Color()

            p[0] = self.p_this.GetColor()

            return wrap_color_instance(p)

        def __set__(self, Color value):
            self.p_this.SetColor(value.p_this[0])

    property origin:
        def __get__(self):
            cdef decl.Vector2f origin = self.p_this.GetOrigin()

            return (origin.x, origin.y)

        def __set__(self, value):
            cdef decl.Vector2f v = convert_to_vector2f(value)

            self.p_this.SetOrigin(v.x, v.y)

    property position:
        def __get__(self):
            cdef decl.Vector2f pos = self.p_this.GetPosition()

            return (pos.x, pos.y)

        def __set__(self, value):
            cdef decl.Vector2f v = convert_to_vector2f(value)

            self.p_this.SetPosition(v.x, v.y)

    property rotation:
        def __get__(self):
            return self.p_this.GetRotation()

        def __set__(self, float value):
            self.p_this.SetRotation(value)

    property scale:
        def __get__(self):
            cdef decl.Vector2f scale = self.p_this.GetScale()

            return ScaleWrapper(self, scale.x, scale.y)

        def __set__(self, value):
            cdef decl.Vector2f v = convert_to_vector2f(value)

            self.p_this.SetScale(v.x, v.y)

    property x:
        def __get__(self):
            return self.position[0]

        def __set__(self, float value):
            self.p_this.SetX(value)

    property y:
        def __get__(self):
            return self.position[1]

        def __set__(self, float value):
            self.p_this.SetY(value)

    def transform_to_local(self, float x, float y):
        cdef decl.Vector2f cpp_point
        cdef decl.Vector2f res

        cpp_point.x = x
        cpp_point.y = y
        res = self.p_this.TransformToLocal(cpp_point)

        return (res.x, res.y)

    def transform_to_global(self, float x, float y):
        cdef decl.Vector2f cpp_point
        cdef decl.Vector2f res

        cpp_point.x = x
        cpp_point.y = y
        res = self.p_this.TransformToGlobal(cpp_point)

        return (res.x, res.y)

    def move(self, float x, float y):
        self.p_this.Move(x, y)

    def rotate(self, float angle):
        self.p_this.Rotate(angle)

    def _scale(self, float x, float y):
        self.p_this.Scale(x, y)



# This class allows the user to use the Drawable.scale attribute both
# for GetScale()/SetScale() property and the Scale() method.  When the
# user calls the getter for Drawable.scale, the object returned is an
# instance of this class. It will behave like a tuple, except that the
# call overrides __call__() so that the C++ Scale() method is called
# when the user types some_drawable.scale().
class ScaleWrapper(tuple):
    def __new__(cls, Drawable drawable, float x, float y):
        return tuple.__new__(cls, (x, y))

    def __init__(self, Drawable drawable, float x, float y):
        self.drawable = drawable

    def __call__(self, float x, float y):
        self.drawable._scale(x, y)




cdef class Text(Drawable):
    cdef bint is_unicode

    REGULAR = declstyle.Regular
    BOLD = declstyle.Bold
    ITALIC = declstyle.Italic
    UNDERLINED = declstyle.Underlined

    def __cinit__(self, string=None, Font font=None, int character_size=0):
        cdef decl.String cpp_string
        cdef char* c_string = NULL

        self.is_unicode = False

        if string is None:
            self.p_this = <decl.Drawable*>new decl.Text()
        elif isinstance(string, bytes):
            if font is None:
                self.p_this = <decl.Drawable*>new decl.Text(<char*>string)
            elif character_size == 0:
                self.p_this = <decl.Drawable*>new decl.Text(
                    <char*>string, font.p_this[0])
            else:
                self.p_this = <decl.Drawable*>new decl.Text(
                    <char*>string, font.p_this[0], character_size)
        elif isinstance(string, unicode):
            self.is_unicode = True
            string += '\x00'
            py_byte_string = string.encode('utf-32-le')
            c_string = py_byte_string
            cpp_string = decl.String(<decl.Uint32*>c_string)

            if font is None:
                self.p_this = <decl.Drawable*>new decl.Text(cpp_string)
            elif character_size == 0:
                self.p_this = <decl.Drawable*>new decl.Text(
                    cpp_string, font.p_this[0])
            else:
                self.p_this = <decl.Drawable*>new decl.Text(
                    cpp_string, font.p_this[0], character_size)
        else:
            raise TypeError("Expected bytes/str or unicode for string, got {0}"
                            .format(type(string)))

    def __dealloc__(self):
        del self.p_this

    property character_size:
        def __get__(self):
            return (<decl.Text*>self.p_this).GetCharacterSize()

        def __set__(self, int value):
            (<decl.Text*>self.p_this).SetCharacterSize(value)

    property font:
        def __get__(self):
            cdef decl.Font *p = <decl.Font*>&(<decl.Text*>self.p_this).GetFont()

            return wrap_font_instance(p, False)

        def __set__(self, Font value):
            (<decl.Text*>self.p_this).SetFont(value.p_this[0])

    property rect:
        def __get__(self):
            cdef decl.FloatRect *p = new decl.FloatRect()

            p[0] = (<decl.Text*>self.p_this).GetRect()

            return wrap_float_rect_instance(p)

    property string:
        def __get__(self):
            cdef decl.string res
            cdef char *p = NULL
            cdef bytes data

            if not self.is_unicode:
                res = ((<decl.Text*>self.p_this).GetString()
                       .ToAnsiString())
                ret = res.c_str()
            else:
                p = <char*>(<decl.Text*>self.p_this).GetString().GetData()
                data = p[:(<decl.Text*>self.p_this).GetString().GetSize() * 4]
                ret = data.decode('utf-32-le')

            return ret

        def __set__(self, value):
            cdef char* c_string = NULL

            if isinstance(value, bytes):
                (<decl.Text*>self.p_this).SetString(<char*>value)
                self.is_unicode = False
            elif isinstance(value, unicode):
                value += '\x00'
                py_byte_string = value.encode('utf-32-le')
                c_string = py_byte_string
                (<decl.Text*>self.p_this).SetString(
                    decl.String(<decl.Uint32*>c_string))
                self.is_unicode = True
            else:
                raise TypeError(
                    "Expected bytes/str or unicode for string, got {0}"
                    .format(type(value)))

    property style:
        def __get__(self):
            return (<decl.Text*>self.p_this).GetStyle()

        def __set__(self, int value):
            (<decl.Text*>self.p_this).SetStyle(value)

    def get_character_pos(self, int index):
        cdef decl.Vector2f res = (<decl.Text*>self.p_this).GetCharacterPos(
            index)

        return (res.x, res.y)





cdef class Sprite(Drawable):
    def __cinit__(self, Texture texture=None):
        if texture is None:
            self.p_this = <decl.Drawable*>new decl.Sprite()
        else:
            self.p_this = <decl.Drawable*>new decl.Sprite(texture.p_this[0])

    def __dealloc__(self):
        del self.p_this

    def __getitem__(self, coords):
        cdef decl.Vector2f v = convert_to_vector2f(coords)

        return self.get_pixel(v.x, v.y)

    property height:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetSize().y

    property size:
        def __get__(self):
            return (self.width, self.height)

    property texture:
        def __get__(self):
            return wrap_texture_instance(
                <decl.Texture*>((<decl.Sprite*>self.p_this).GetTexture()),
                False)

        def __set__(self, Texture value):
            (<decl.Sprite*>self.p_this).SetTexture(value.p_this[0])

    property width:
        def __get__(self):
            return (<decl.Sprite*>self.p_this).GetSize().x

    def get_sub_rect(self):
        cdef decl.IntRect r = (<decl.Sprite*>self.p_this).GetSubRect()

        return IntRect(r.Left, r.Top, r.Width, r.Height)

    def flip_x(self, bint flipped):
        (<decl.Sprite*>self.p_this).FlipX(flipped)

    def flip_y(self, bint flipped):
        (<decl.Sprite*>self.p_this).FlipY(flipped)

    def resize(self, float width, float height):
        (<decl.Sprite*>self.p_this).Resize(width, height)

    def set_sub_rect(self, object rect):
        cdef decl.IntRect r = convert_to_int_rect(rect)

        (<decl.Sprite*>self.p_this).SetSubRect(r)

    def set_texture(self, Texture texture, bint adjust_to_new_size=False):
        (<decl.Sprite*>self.p_this).SetTexture(texture.p_this[0],
                                               adjust_to_new_size)




cdef class Shape(Drawable):
    def __init__(self):
        self.p_this = <decl.Drawable*>new decl.Shape()
    
    def __dealloc__(self):
        del self.p_this
    
    property fill_enabled:
        def __set__(self, bint value):
            (<decl.Shape*>self.p_this).EnableFill(value)

    property outline_enabled:
        def __set__(self, bint value):
            (<decl.Shape*>self.p_this).EnableOutline(value)

    property outline_thickness:
        def __get__(self):
            return (<decl.Shape*>self.p_this).GetOutlineThickness()

        def __set__(self, float value):
            (<decl.Shape*>self.p_this).SetOutlineThickness(value)

    property points_count:
        def __get__(self):
            return (<decl.Shape*>self.p_this).GetPointsCount()

    @classmethod
    def line(cls, float p1x, float p1y, float p2x, float p2y, float thickness,
             Color color, float outline=0.0, Color outline_color=None):
        cdef decl.Shape *p = new decl.Shape()

        if outline_color is None:
            p[0] = decl.Line(p1x, p1y, p2x, p2y, thickness, color.p_this[0],
                             outline)
        else:
            p[0] = decl.Line(p1x, p1y, p2x, p2y, thickness, color.p_this[0],
                             outline, outline_color.p_this[0])

        return wrap_shape_instance(p)

    @classmethod
    def rectangle(cls, float left, float top, float width, float height,
                  Color color, float outline=0.0, Color outline_color=None):
        cdef decl.Shape *p = new decl.Shape()

        if outline_color is None:
            p[0] = decl.Rectangle(left, top, width, height, color.p_this[0],
                                  outline)
        else:
            p[0] = decl.Rectangle(left, top, width, height, color.p_this[0],
                                  outline, outline_color.p_this[0])

        return wrap_shape_instance(p)

    @classmethod
    def circle(cls, float x, float y, float radius, Color color,
               float outline=0.0, Color outline_color=None):
        cdef decl.Shape *p = new decl.Shape()

        if outline_color is None:
            p[0] = decl.Circle(x, y, radius, color.p_this[0], outline)
        else:
            p[0] = decl.Circle(x, y, radius, color.p_this[0], outline,
                               outline_color.p_this[0])

        return wrap_shape_instance(p)

    def add_point(self, float x, float y, Color color=None,
                  Color outline_color=None):
        if color is None:
            (<decl.Shape*>self.p_this).AddPoint(x, y)
        elif outline_color is None:
            (<decl.Shape*>self.p_this).AddPoint(x, y, color.p_this[0])
        else:
            (<decl.Shape*>self.p_this).AddPoint(x, y, color.p_this[0],
                                                outline_color.p_this[0])

    def get_point_color(self, unsigned int index):
        cdef decl.Color *p = new decl.Color()

        p[0] = (<decl.Shape*>self.p_this).GetPointColor(index)

        return wrap_color_instance(p)

    def get_point_outline_color(self, unsigned int index):
        cdef decl.Color *p = new decl.Color()

        p[0] = (<decl.Shape*>self.p_this).GetPointOutlineColor(index)

        return wrap_color_instance(p)

    def get_point_position(self, unsigned int index):
        cdef decl.Vector2f pos

        pos = (<decl.Shape*>self.p_this).GetPointPosition(index)

        return (pos.x, pos.y)

    def set_point_color(self, unsigned int index, Color color):
        (<decl.Shape*>self.p_this).SetPointColor(index, color.p_this[0])

    def set_point_outline_color(self, unsigned int index, Color color):
        (<decl.Shape*>self.p_this).SetPointOutlineColor(index, color.p_this[0])

    def set_point_position(self, unsigned int index, float x, float y):
        (<decl.Shape*>self.p_this).SetPointPosition(index, x, y)
    

cdef Shape wrap_shape_instance(decl.Shape *p_cpp_instance):
    cdef Shape ret = Shape.__new__(Shape)

    ret.p_this = <decl.Drawable*>p_cpp_instance
    
    return ret




cdef class VideoMode:
    cdef decl.VideoMode *p_this
    cdef bint delete_this

    def __init__(self, width=None, height=None, bits_per_pixel=32):
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

        def __set__(self, unsigned int value):
            self.p_this.Width = value

    property height:
        def __get__(self):
            return self.p_this.Height

        def __set__(self, unsigned value):
            self.p_this.Height = value

    property bits_per_pixel:
        def __get__(self):
            return self.p_this.BitsPerPixel

        def __set__(self, unsigned int value):
            self.p_this.BitsPerPixel = value

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
    # A RenderTarget (e.g., a RenderWindow or a RenderImage) can be
    # bound to the view. Every time the view is changed, the target
    # will be automatically updated. The target object must have a
    # view property.  This is used so that code like
    # window.view.mode(10, 10) works as expected.
    cdef object render_target

    def __init__(self):
        self.p_this = new decl.View()
        self.window = None

    def __dealloc__(self):
        del self.p_this

    property center:
        def __get__(self):
            cdef decl.Vector2f center = self.p_this.GetCenter()

            return (center.x, center.y)

        def __set__(self, value):
            cdef decl.Vector2f v = convert_to_vector2f(value)

            self.p_this.SetCenter(v.x, v.y)
            self._update_target()

    property height:
        def __get__(self):
            return self.size[1]

        def __set__(self, float value):
            self.size = (self.width, value)
            self._update_target()

    property rotation:
        def __get__(self):
            return self.p_this.GetRotation()

        def __set__(self, float value):
            self.p_this.SetRotation(value)
            self._update_target()

    property size:
        def __get__(self):
            cdef decl.Vector2f size = self.p_this.GetSize()

            return (size.x, size.y)

        def __set__(self, value):
            cdef decl.Vector2f v = convert_to_vector2f(value)

            self.p_this.SetSize(v.x, v.y)
            self._update_target()

    property viewport:
        def __get__(self):
            cdef decl.FloatRect *p = new decl.FloatRect()

            p[0] = self.p_this.GetViewport()

            return wrap_float_rect_instance(p)

        def __set__(self, FloatRect value):
            self.p_this.SetViewport(value.p_this[0])
            self._update_target()

    property width:
        def __get__(self):
            return self.size[0]

        def __set__(self, float value):
            self.size = (value, self.height)
            self._update_target()

    @classmethod
    def from_center_and_size(cls, center, size):
        cdef decl.Vector2f cpp_center = convert_to_vector2f(center)
        cdef decl.Vector2f cpp_size = convert_to_vector2f(size)
        cdef decl.View *p

        p = new decl.View(cpp_center, cpp_size)

        return wrap_view_instance(p, None)
        
    @classmethod
    def from_rect(cls, FloatRect rect):
        cdef decl.View *p = new decl.View(rect.p_this[0])

        return wrap_view_instance(p, None)

    def _update_target(self):
        if self.render_target is not None:
            self.render_target.view = self

    def move(self, float x, float y):
        self.p_this.Move(x, y)
        self._update_target()

    def reset(self, FloatRect rect):
        self.p_this.Reset(rect.p_this[0])
        self._update_target()

    def rotate(self, float angle):
        self.p_this.Rotate(angle)
        self._update_target()

    def zoom(self, float factor):
        self.p_this.Zoom(factor)
        self._update_target()


cdef View wrap_view_instance(decl.View *p_cpp_view, object window):
    cdef View ret = View.__new__(View)

    ret.p_this = p_cpp_view
    ret.render_target = window

    return ret





cdef class Shader:
    cdef decl.Shader *p_this

    IS_AVAILABLE = decl.IsAvailable()

    def __init__(self):
        raise NotImplementedError(
            "Use class methods like Shader.load_from_file() "
            "to create Shader objects")

    def __dealloc__(self):
        del self.p_this

    property current_texture:
        def __set__(self, char* value):
            self.p_this.SetCurrentTexture(value)

    @classmethod
    def load_from_file(cls, char *filename):
        cdef decl.Shader *p = new decl.Shader()

        if p.LoadFromFile(filename):
            return wrap_shader_instance(p)
        else:
            raise PySFMLException("Couldn't load shader from file " + filename)

    @classmethod
    def load_from_memory(cls, char* shader):
        cdef decl.Shader *p = new decl.Shader()

        if p.LoadFromMemory(shader):
            return wrap_shader_instance(p)
        else:
            raise PySFMLException("Couldn't load shader from memory")

    def bind(self):
        self.p_this.Bind()

    def set_parameter(self, char *name, float x, y=None, z=None, w=None):
        if y is None:
            self.p_this.SetParameter(name, x)
        elif z is None:
            self.p_this.SetParameter(name, x, y)
        elif w is None:
            self.p_this.SetParameter(name, x, y, z)
        else:
            self.p_this.SetParameter(name, x, y, z, w)
    
    def set_texture(self, char *name, Texture texture):
        self.p_this.SetTexture(name, texture.p_this[0])

    def set_current_texture(self, char* name):
        self.p_this.SetCurrentTexture(name)

    def unbind(self):
        self.p_this.Unbind()


cdef Shader wrap_shader_instance(decl.Shader *p_cpp_instance):
    cdef Shader ret = Shader.__new__(Shader)

    ret.p_this = p_cpp_instance

    return ret





cdef class ContextSettings:
    cdef decl.ContextSettings *p_this

    def __init__(self, unsigned int depth=24, unsigned int stencil=8,
                 unsigned int antialiasing=0, unsigned int major=2,
                 unsigned int minor=0):
        self.p_this = new decl.ContextSettings(depth, stencil, antialiasing,
                                               major, minor)

    def __dealloc__(self):
        del self.p_this

    property antialiasing_level:
        def __get__(self):
            return self.p_this.AntialiasingLevel

        def __set__(self, unsigned int value):
            self.p_this.AntialiasingLevel = value

    property depth_bits:
        def __get__(self):
            return self.p_this.DepthBits

        def __set__(self, unsigned int value):
            self.p_this.DepthBits = value

    property major_version:
        def __get__(self):
            return self.p_this.MajorVersion

        def __set__(self, unsigned int value):
            self.p_this.MajorVersion = value

    property minor_version:
        def __get__(self):
            return self.p_this.MinorVersion

        def __set__(self, unsigned int value):
            self.p_this.MinorVersion = value

    property stencil_bits:
        def __get__(self):
            return self.p_this.StencilBits

        def __set__(self, unsigned int value):
            self.p_this.StencilBits = value


cdef ContextSettings wrap_context_settings_instance(
    decl.ContextSettings *p_cpp_instance):
    cdef ContextSettings ret = ContextSettings.__new__(ContextSettings)

    ret.p_this = p_cpp_instance

    return ret





cdef class RenderWindow:
    cdef decl.RenderWindow *p_this

    def __cinit__(self, VideoMode mode, char* title, int style=Style.DEFAULT,
                  ContextSettings settings=None):
        if settings is None:
            self.p_this = new decl.RenderWindow(mode.p_this[0], title, style)
        else:
            self.p_this = new decl.RenderWindow(mode.p_this[0], title, style,
                                                settings.p_this[0])

    def __dealloc__(self):
        del self.p_this

    def __iter__(self):
        return self

    def __next__(self):
        cdef decl.Event p

        if self.p_this.PollEvent(p):
            return wrap_event_instance(&p)

        raise StopIteration

    property active:
        def __set__(self, bint value):
            self.p_this.SetActive(value)

    property default_view:
        def __get__(self):
            cdef decl.View *p = new decl.View()

            p[0] = self.p_this.GetDefaultView()

            return wrap_view_instance(p, None)

    property framerate_limit:
        def __set__(self, int value):
            self.p_this.SetFramerateLimit(value)

    property frame_time:
        def __get__(self):
            return self.p_this.GetFrameTime()

    property height:
        def __get__(self):
            return self.p_this.GetHeight()

        def __set__(self, unsigned int value):
            self.size = (self.width, value)

    property joystick_threshold:
        def __set__(self, bint value):
            self.p_this.SetJoystickThreshold(value)

    property key_repeat_enabled:
        def __set__(self, bint value):
            self.p_this.EnableKeyRepeat(value)

    property opened:
        def __get__(self):
            return self.p_this.IsOpened()

    property position:
        def __set__(self, tuple value):
            x, y = value
            self.p_this.SetPosition(x, y)

    property settings:
        def __get__(self):
            cdef decl.ContextSettings *p = new decl.ContextSettings()

            p[0] = self.p_this.GetSettings()

            return wrap_context_settings_instance(p)

    property show_mouse_cursor:
        def __set__(self, bint value):
            self.p_this.ShowMouseCursor(value)

    property size:
        def __get__(self):
            return (self.width, self.height)

        def __set__(self, tuple value):
            x, y = value
            self.p_this.SetSize(x, y)

    property system_handle:
        def __get__(self):
            raise NotImplementedError(
                "The WindowHandle class isn't available yet")

    property title:
        def __set__(self, char* value):
            self.p_this.SetTitle(value)

    property view:
        def __get__(self):
            cdef decl.View *p = new decl.View()

            p[0] = self.p_this.GetView()

            return wrap_view_instance(p, self)

        def __set__(self, View value):
            self.p_this.SetView(value.p_this[0])

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

    def convert_coords(self, unsigned int x, unsigned int y, View view=None):
        cdef decl.Vector2f res

        if view is None:
            res = self.p_this.ConvertCoords(x, y)
        else:
            res = self.p_this.ConvertCoords(x, y, view.p_this[0])

        return (res.x, res.y)

    def create(self, VideoMode mode, char* title, int style=Style.DEFAULT,
               ContextSettings settings=None):
        if settings is None:
            self.p_this.Create(mode.p_this[0], title, style)
        else:
            self.p_this.Create(mode.p_this[0], title, style, settings.p_this[0])

    def display(self):
        self.p_this.Display()

    def draw(self, Drawable drawable, Shader shader=None):
        if shader is None:
            self.p_this.Draw(drawable.p_this[0])
        else:
            self.p_this.Draw(drawable.p_this[0], shader.p_this[0])

    def get_viewport(self, View view):
        cdef decl.IntRect *p = new decl.IntRect()

        p[0] = self.p_this.GetViewport(view.p_this[0])

        return wrap_int_rect_instance(p)

    def iter_events(self):
        """Return an iterator which yields the current pending events.

        Example::
        
            for event in window.iter_events():
                if event.type == sf.Event.CLOSED:
                    # ..."""

        return self

    def poll_event(self):
        cdef decl.Event *p = new decl.Event()

        if self.p_this.PollEvent(p[0]):
            return wrap_event_instance(p)

    def restore_gl_states(self):
        self.p_this.RestoreGLStates()

    def save_gl_states(self):
        self.p_this.SaveGLStates()

    def set_icon(self, unsigned int width, unsigned int height, char* pixels):
        self.p_this.SetIcon(width, height, <decl.Uint8*>pixels)

    def show(self, bint show):
        self.p_this.Show(show)

    def wait_event(self):
        cdef decl.Event *p = new decl.Event()

        if self.p_this.WaitEvent(p[0]):
            return wrap_event_instance(p)



cdef class RenderTexture:
    cdef decl.RenderTexture *p_this
    
    def __cinit__(self):
        self.p_this = new decl.RenderTexture()
    
    def __init__(self, unsigned int width, unsigned int height,
                 bint depth=False):
        self.create(width, height, depth)
    
    def __dealloc__(self):
        del self.p_this
    
    property active:
        def __set__(self, bint active):
            self.p_this.SetActive(active)
    
    property default_view:
        def __get__(self):
            cdef decl.View *p = new decl.View()

            p[0] = self.p_this.GetDefaultView()

            return wrap_view_instance(p, None)

    property height:
        def __get__(self):
            return self.p_this.GetHeight()
    
    property texture:
        def __get__(self):
            return wrap_texture_instance(
                <decl.Texture*>&self.p_this.GetTexture(), False)
    
    property smooth:
        def __get__(self):
            return self.p_this.IsSmooth()
        
        def __set__(self, bint smooth):
            self.p_this.SetSmooth(smooth)
    
    property view:
        def __get__(self):
            cdef decl.View *p = new decl.View()

            p[0] = self.p_this.GetView()

            return wrap_view_instance(p, self)

        def __set__(self, View value):
            self.p_this.SetView(value.p_this[0])

    property width:
        def __get__(self):
            return self.p_this.GetWidth()
    
    def clear(self, Color color=None):
        if color is None:
            self.p_this.Clear()
        else:
            self.p_this.Clear(color.p_this[0])

    def convert_coords(self, unsigned int x, unsigned int y, View view=None):
        cdef decl.Vector2f res

        if view is None:
            res = self.p_this.ConvertCoords(x, y)
        else:
            res = self.p_this.ConvertCoords(x, y, view.p_this[0])

        return (res.x, res.y)

    def create(self, unsigned int width, unsigned int height, bint depth=False):
        self.p_this.Create(width, height, depth)

    def display(self):
        self.p_this.Display()
    
    def draw(self, Drawable drawable, Shader shader=None):
        if shader is None:
            self.p_this.Draw(drawable.p_this[0])
        else:
            raise NotImplementedError("The Shader class isn't available yet")

    def get_viewport(self, View view):
        cdef decl.IntRect *p = new decl.IntRect()

        p[0] = self.p_this.GetViewport(view.p_this[0])

        return wrap_int_rect_instance(p)

    def restore_gl_states(self):
        self.p_this.RestoreGLStates()

    def save_gl_states(self):
        self.p_this.SaveGLStates()
