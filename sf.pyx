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


cimport decl
cimport declevent


class PySFMLException(Exception):
    """Base class for the exceptions raised by PySFML."""


class FileLoadingException(PySFMLException):
    """Raised when a file can't be loaded."""




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
        if op == 3:
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


cdef Color wrap_color_instance(decl.Color *p_cpp_instance):
    cdef Color ret = Color.__new__(Color)
    ret.p_this = p_cpp_instance

    return ret



cdef class Event:
    CLOSED = declevent.Closed
    RESIZED_ = declevent.Resized
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

    cdef decl.Event *p_this

    def __cinit__(self):
        self.p_this = new decl.Event()

    def __dealloc__(self):
        del self.p_this

    property type:
        def __get__(self):
            return self.p_this.Type




cdef class Image:
    cdef decl.Image *p_this

    def __init__(self):
        raise NotImplementedError('Use a classmethod like load_from_file() ' +
                                  'to create Image objects')

    def __dealloc__(self):
        del self.p_this

    @classmethod
    def load_from_file(cls, char *filename):
        cdef decl.Image *p_cpp_instance = new decl.Image()

        if p_cpp_instance.LoadFromFile(filename):
            return wrap_image_instance(p_cpp_instance)

        raise FileLoadingException()


cdef Image wrap_image_instance(decl.Image *p_cpp_instance):
    cdef Image ret = Image.__new__(Image)
    ret.p_this = p_cpp_instance

    return ret




cdef class Drawable:
    cdef decl.Drawable *p_this

    def __cinit__(self, *args, **kwargs):
        pass

    def __init__(self, *args, **kwargs):
        if self.__class__ == Drawable:
            raise NotImplementedError('Drawable is abstact')



cdef class Sprite(Drawable):
    def __cinit__(self, Image image):
        self.p_this = <decl.Drawable*>new decl.Sprite(image.p_this[0])

    def __dealloc__(self):
        del self.p_this




cdef class VideoMode:
    cdef decl.VideoMode *p_this

    def __cinit__(self, width=None, height=None, bits_per_pixel=32):
        if width is None or height is None:
            self.p_this = new decl.VideoMode()
        else:
            self.p_this = new decl.VideoMode(width, height, bits_per_pixel)

    def __dealloc__(self):
        del self.p_this


cdef class RenderWindow:
    cdef decl.RenderWindow *p_this

    # Event returned when iterating on iter_events()
    cdef Event event

    def __cinit__(self, VideoMode mode, char* title):
        self.p_this = new decl.RenderWindow(mode.p_this[0], title)
        self.event = Event()

    def __dealloc__(self):
        del self.p_this

    def __iter__(self):
        return self

    def __next__(self):
        if self.p_this.GetEvent(self.event.p_this[0]):
            return self.event

        raise StopIteration

    property framerate_limit:
        def __set__(self, int value):
            self.p_this.SetFramerateLimit(value)

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
