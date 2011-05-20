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


from libcpp.vector cimport vector

cimport declblendmode
cimport declkey
cimport decljoy
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


cdef extern from "SFML/Graphics.hpp" namespace "sf::Event":
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



cdef extern from "SFML/System.hpp" namespace "sf":
    ctypedef short Int16
    ctypedef unsigned char Uint8
    ctypedef unsigned int Uint32



cdef extern from "SFML/Graphics.hpp" namespace "sf":
    # Forward declarations
    cdef cppclass RenderWindow

    cdef cppclass Vector2f:
        Vector2f()
        Vector2f(float, float)
        float x
        float y

    cdef cppclass Vector3f:
        Vector3f()
        Vector3f(float, float, float)
        float x
        float y
        float z

    cdef cppclass IntRect:
        IntRect()
        IntRect(int, int, int, int)
        bint Contains(int, int)
        bint Intersects(IntRect&)
        bint Intersects(IntRect&, IntRect&)
        int Left
        int Top
        int Width
        int Height

    cdef cppclass FloatRect:
        FloatRect()
        FloatRect(float, float, float, float)
        bint Contains(int, int)
        bint Intersects(FloatRect&)
        bint Intersects(FloatRect&, FloatRect&)
        float Left
        float Top
        float Width
        float Height

    cdef cppclass Matrix3:
        Matrix3()
        Matrix3(float, float, float,
                float, float, float,
                float, float, float)
        Vector2f Transform(Vector2f&)
        Matrix3 GetInverse()
        float* Get4x4Elements()

        Matrix3 operator*(Matrix3&)

    cdef cppclass Clock:
        Clock()
        Uint32 GetElapsedTime()
        void Reset()

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
        float GetJoystickAxis(unsigned int JoyId, decljoy.Axis Axis)

    cdef cppclass VideoMode:
        VideoMode()
        VideoMode(unsigned int width, unsigned int height)
        VideoMode(unsigned int width, unsigned int height,
                  unsigned int bits_per_pixel)
        bint IsValid()
        unsigned int Width
        unsigned int Height
        unsigned int BitsPerPixel


    cdef cppclass Image:
        Image()
        Image(Image&)
        void Bind()
        void Copy(Image&, unsigned int, unsigned int)
        void Copy(Image&, unsigned int, unsigned int, IntRect&)
        void Copy(Image&, unsigned int, unsigned int, IntRect&, bint)
        bint CopyScreen(RenderWindow&)
        bint CopyScreen(RenderWindow&, IntRect&)
        bint Create(unsigned int, unsigned int)
        bint Create(unsigned int, unsigned int, Color&)
        void CreateMaskFromColor(Color&)
        void CreateMaskFromColor(Color&, unsigned char)
        unsigned int GetHeight()
        Color& GetPixel(unsigned int, unsigned int)
        unsigned char* GetPixelsPtr()
        FloatRect& GetTexCoords(IntRect&)
        unsigned int GetWidth() 
        bint IsSmooth()
        bint LoadFromFile(char*)
        bint LoadFromMemory(void*, size_t)
        bint LoadFromPixels(unsigned int, unsigned int, unsigned char*)
        bint SaveToFile(string&)
        bint SaveToFile(char*)
        void SetPixel(unsigned int, unsigned int, Color&)
        void SetSmooth(bint)
        void UpdatePixels(unsigned char*)
        void UpdatePixels(unsigned char*, IntRect&)

    cdef cppclass String:
        String()
        String(Uint32*)
        Uint32* GetData()
        size_t GetSize()
        string ToAnsiString()

    cdef cppclass Glyph:
        Glyph()
        int Advance
        IntRect Bounds
        IntRect SubRect

    cdef cppclass Font:
        Font()
        Font(Font&)
        Glyph& GetGlyph(Uint32, unsigned int, bint)
        Image& GetImage(unsigned int)
        int GetKerning(Uint32, Uint32, unsigned int)
        int GetLineSpacing(unsigned int)
        bint LoadFromFile(char*)
        bint LoadFromMemory(void*, size_t)

    cdef cppclass Drawable:
        Drawable()
        declblendmode.Mode GetBlendMode()
        Color& GetColor()
        Vector2f& GetOrigin()
        Vector2f& GetPosition()
        float GetRotation()
        Vector2f& GetScale()
        void Move(float, float)
        void Move(Vector2f&)
        void Rotate(float)
        void Scale(float, float)
        void Scale(Vector2f&)
        void SetBlendMode(declblendmode.Mode)
        void SetColor(Color&)
        void SetOrigin(float, float)
        void SetOrigin(Vector2f&)
        void SetPosition(float, float)
        void SetPosition(Vector2f&)
        void SetRotation(float)
        void SetScale(float, float)
        void SetScale(Vector2f&)
        void SetScaleX(float)
        void SetScaleY(float)
        void SetX(float)
        void SetY(float)
        Vector2f TransformToGlobal(Vector2f&)
        Vector2f TransformToLocal(Vector2f&)

    cdef cppclass Text:
        Text()
        Text(char*)
        Text(char*, Font&)
        Text(char*, Font&, unsigned int)
        Text(String&)
        Text(String&, Font&)
        Text(String&, Font&, unsigned int)
        Vector2f GetCharacterPos(size_t)
        unsigned int GetCharacterSize()
#        Color& GetColor()
        Font& GetFont()
        FloatRect GetRect()
        String& GetString()
        unsigned long GetStyle()
        void SetCharacterSize(unsigned int)
#        void SetColor(Color&)
        void SetFont(Font&)
        void SetString(char*)
        void SetString(String&)
        void SetStyle(unsigned long)

    cdef cppclass Sprite:
        Sprite()
        Sprite(Image&)
        Sprite(Image&, Vector2f&)
        Sprite(Image&, Vector2f&, Vector2f&)
        Sprite(Image&, Vector2f&, Vector2f&, float)
        Sprite(Image&, Vector2f&, Vector2f&, float, Color&)
        void FlipX(bint)
        void FlipY(bint)
#        Color& GetColor()
        Image* GetImage()
        Color GetPixel(unsigned int, unsigned int)
        Vector2f GetSize()
        IntRect& GetSubRect()
        void Resize(float, float)
        void Resize(Vector2f&)
#        void SetColor(Color&)
        void SetImage(Image&)
        void SetImage(Image&, bint)
        void SetSubRect(IntRect&)

    cdef cppclass View:
        View()
        View(FloatRect&)
        View(Vector2f&, Vector2f&)
        Vector2f& GetCenter()
        Matrix3& GetInverseMatrix()
        Matrix3& GetMatrix()
        float GetRotation()
        FloatRect& GetViewport()
        Vector2f& GetSize()
        void Move(float, float)
        void Move(Vector2f&)
        void Reset(FloatRect&)
        void Rotate(float)
        void SetCenter(float, float)
        void SetCenter(Vector2f&)
        void SetFromRect(FloatRect&)
        void SetRotation(float)
        void SetSize(float, float)
        void SetSize(Vector2f&)
        void SetViewport(FloatRect&)
        void Zoom(float)

    cdef cppclass Shader:
        Shader()
        void Bind()
        bint LoadFromFile(char*)
        bint LoadFromMemory(char*)
        void SetCurrentTexture(char*)
        void SetParameter(char*, float)
        void SetParameter(char*, float, float)
        void SetParameter(char*, float, float, float)
        void SetParameter(char*, float, float, float, float)
        void SetParameter(char*, Vector2f&)
        void SetParameter(char*, Vector3f&)
        void SetTexture(char*, Image&)
        void Unbind()

    cdef cppclass ContextSettings:
        ContextSettings()
        ContextSettings(unsigned int)
        ContextSettings(unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int)
        ContextSettings(unsigned int, unsigned int, unsigned int, unsigned int,
                        unsigned int)
        unsigned int AntialiasingLevel
        unsigned int DepthBits
        unsigned int MajorVersion
        unsigned int MinorVersion
        unsigned int StencilBits

    cdef cppclass WindowHandle:
        pass

    cdef cppclass RenderWindow:
        RenderWindow()
        RenderWindow(VideoMode, char*)
        RenderWindow(VideoMode, char*, unsigned long)
        RenderWindow(VideoMode, char*, unsigned long, ContextSettings&)
        RenderWindow(WindowHandle, ContextSettings&)
        void Clear()
        void Clear(Color&)
        void Close()
        Vector2f ConvertCoords(unsigned int, unsigned int)
        Vector2f ConvertCoords(unsigned int, unsigned int, View&)
        void Create(VideoMode, char*)
        void Create(VideoMode, char*, unsigned long)
        void Create(VideoMode, char*, unsigned long, ContextSettings&)
        void Display()
        void Draw(Drawable&)
        void Draw(Drawable&, Shader&)
        void EnableKeyRepeat(bint)
        View& GetDefaultView()
        Uint32 GetFrameTime()
        Input& GetInput()
        unsigned int GetHeight()
        ContextSettings& GetSettings()
        WindowHandle GetSystemHandle()
        View& GetView()
        IntRect GetViewport(View&)
        unsigned int GetWidth()
        bint IsOpened()
        bint PollEvent(Event&)
        void RestoreGLStates()
        void SaveGLStates()
        void SetActive()
        void SetActive(bint)
        void SetCursorPosition(unsigned int, unsigned int)
        void SetIcon(unsigned int, unsigned int, Uint8*)
        void SetJoystickThreshold(float)
        void SetFramerateLimit(unsigned int)
        void SetPosition(int, int)
        void SetSize(unsigned int, unsigned int)
        void SetTitle(char*)
        void SetView(View&)
        void Show(bint)
        void ShowMouseCursor(bint)
        void UseVerticalSync(bint)
        bint WaitEvent(Event&)


    cdef cppclass RenderImage:
        RenderImage()
        bint Create(unsigned int, unsigned int)
        bint Create(unsigned int, unsigned int, bint depth)
        void SetSmooth(bint)
        bint IsSmooth()
        bint SetActive()
        bint SetActive(bint)
        void Display()
        unsigned int GetWidth()
        unsigned int GetHeight()
        Image& GetImage()
        bint IsAvailable()
        void Draw(Drawable&)
        void Draw(Drawable&, Shader&)
        void Clear()
        void Clear(Color&)
        View& GetDefaultView()
        View& GetView()
        void SetView(View&)
        IntRect GetViewport(View&)
        Vector2f ConvertCoords(unsigned int, unsigned int)
        Vector2f ConvertCoords(unsigned int, unsigned int, View&)
        void RestoreGLStates()
        void SaveGLStates()
    
    
    cdef cppclass Shape:
        Shape()
        void AddPoint(float, float)
        void AddPoint(float, float, Color&)
        void AddPoint(float, float, Color&, Color&)
        void AddPoint(Vector2f&)
        void AddPoint(Vector2f&, Color&)
        void AddPoint(Vector2f&, Color&, Color&)
        void EnableFill(bint)
        void EnableOutline(bint)
        Image* GetImage()
        float GetOutlineThickness()
        Color GetPixel(unsigned int, unsigned int)
        Color& GetPointColor(unsigned int)
        unsigned int GetPointsCount()
        Color& GetPointOutlineColor(unsigned int)
        Vector2f& GetPointPosition(unsigned int)
        IntRect& GetSubRect()
        void SetOutlineThickness(float)
        void SetPointPosition(unsigned int, Vector2f&)
        void SetPointPosition(unsigned int, float, float)
        void SetPointColor(unsigned int, Color&)
        void SetPointOutlineColor(unsigned int, Color&)


# Hacks for static methods
cdef extern from "SFML/Graphics.hpp" namespace "sf::VideoMode":
    cdef VideoMode& GetDesktopMode()
    cdef vector[VideoMode]& GetFullscreenModes()

cdef extern from "SFML/Graphics.hpp" namespace "sf::Image":
    cdef unsigned int GetMaximumSize()

cdef extern from "SFML/Graphics.hpp" namespace "sf::Matrix3":
    cdef Matrix3 Transformation(Vector2f&, Vector2f&, float, Vector2f&)
    cdef Matrix3 Projection(Vector2f&, Vector2f&, float)
    cdef Matrix3 Identity

cdef extern from "SFML/Graphics.hpp" namespace "sf::Font":
    cdef Font& GetDefaultFont()

cdef extern from "SFML/Graphics.hpp" namespace "sf::Shader":
    cdef bint IsAvailable()

cdef extern from "SFML/Graphics.hpp" namespace "sf::Shape":
    cdef Shape Line(float, float, float, float, float, Color&, float)
    cdef Shape Line(float, float, float, float, float, Color&, float, Color&)
    cdef Shape Line(Vector2f&, Vector2f&, float, Color&, float, Color&)
    cdef Shape Rectangle(float, float, float, float, Color&, float)
    cdef Shape Rectangle(float, float, float, float, Color&, float, Color&)
    cdef Shape Rectangle(FloatRect&, Color&, float, Color&)
    cdef Shape Circle(float, float, float, Color&, float)
    cdef Shape Circle(float, float, float, Color&, float, Color&)
    cdef Shape Circle(Vector2f&, float, Color&, float, Color&)
