# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

from libcpp.string cimport string
from libcpp.optional cimport optional
from libcpp.vector cimport vector
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t

cdef extern from "<filesystem>" namespace "std::filesystem":
    cdef cppclass path:
        path() except +
        string u8string() const

    path u8path(const string&) except +

ctypedef int8_t Int8
ctypedef uint8_t Uint8
ctypedef int16_t Int16
ctypedef uint16_t Uint16
ctypedef int32_t Int32
ctypedef uint32_t Uint32
ctypedef int64_t Int64
ctypedef uint64_t Uint64

cdef extern from "SFML/System.hpp" namespace "sf":
    cdef cppclass Angle:
        Angle()
        float asDegrees() const
        float asRadians() const
        Angle wrapSigned() const
        Angle wrapUnsigned() const
        Angle operator-()
        bint operator==(Angle)
        bint operator!=(Angle)
        bint operator<(Angle)
        bint operator>(Angle)
        bint operator<=(Angle)
        bint operator>=(Angle)
        Angle operator+(Angle)
        Angle operator-(Angle)
        Angle operator*(float)
        Angle operator/(float)
        float operator/(Angle)
        Angle operator%(Angle)

    cdef cppclass Time:
        Time()
        float asSeconds() const
        Int32 asMilliseconds() const
        Int64 asMicroseconds() const
        Time operator-()
        bint operator==(Time)
        bint operator!=(Time)
        bint operator<(Time)
        bint operator>(Time)
        bint operator<=(Time)
        bint operator>=(Time)
        Time operator+(Time)
        Time operator-(Time)
        Time operator*(float)
        Time operator*(Int64)
        Time operator/(float)
        Time operator/(Int64)
        float operator/(Time)
        Time operator%(Time)

    cdef void sleep(Time) nogil

    cdef cppclass Clock:
        Clock()
        Time getElapsedTime() const
        bint isRunning() const
        void start()
        void stop()
        Time restart()
        Time reset()

    cdef Angle degrees(float)
    cdef Angle radians(float)

    cdef Time seconds(float)
    cdef Time milliseconds(Int32)
    cdef Time microseconds(Int64)

    cdef cppclass String:
        String()
        String(const Uint32*)
        string toAnsiString()
        void clear()
        int getSize() const
        bint isEmpty() const
        const Uint32* getData() const

    cdef cppclass Vector2[T]:
        Vector2()
        Vector2(T, T)
        Vector2(const Vector2[T]&)
        T x
        T y

        Vector2[T] operator-() const
        Vector2[T] operator+(const Vector2[T]&) const
        Vector2[T] operator-(const Vector2[T]&) const
        Vector2[T] operator*(T) const
        Vector2[T] operator/(T) const
#        Vector2[T]& operator+=(const Vector2[T]&) const
#        Vector2[T]& operator-=(const Vector2[T]&) const
#        Vector2[T]& operator*=(T) const
#        Vector2[T]& operator/=(T) const
        bint operator==(const Vector2[T]&) const
        bint operator!=(const Vector2[T]&) const

    ctypedef Vector2[int] Vector2i
    ctypedef Vector2[unsigned int] Vector2u
    ctypedef Vector2[float] Vector2f

    cdef cppclass Vector3[T]:
        Vector3()
        Vector3(T, T, T)
        Vector3(const Vector3[T]&)
        T x
        T y
        T z

        Vector3[T] operator-() const
        Vector3[T] operator+(const Vector3[T]&) const
        Vector3[T] operator-(const Vector3[T]&) const
        Vector3[T] operator*(T) const
        Vector3[T] operator/(T) const
#        Vector3[T]& operator+=(const Vector3[T]&) const
#        Vector3[T]& operator-=(const Vector3[T]&) const
#        Vector3[T]& operator*=(T) const
#        Vector3[T]& operator/=(T) const
        bint operator==(const Vector3[T]&) const
        bint operator!=(const Vector3[T]&) const

    ctypedef Vector3[int] Vector3i
    ctypedef Vector3[float] Vector3f

    cdef cppclass Mutex:
        Mutex()
        void lock()
        void unlock()

    cdef cppclass Lock:
        Lock(Mutex&)

    cdef cppclass Thread[T, A]:
        Thread(F)
        Thread(F, A)
        void launch()
        void wait()
        void terminate()

    cdef cppclass ThreadLocal:
        ThreadLocal()
        ThreadLocal(void*)
        void setValue(void*)
        void* getValue() const

    cdef cppclass InputStream
    cdef cppclass Utf

from sfml cimport style, event, videomode, contextsettings, keyboard, joystick, mouse, touch, sensor

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::event_compat":
    cdef cppclass SizeEvent:
        unsigned int width
        unsigned int height

    cdef cppclass KeyEvent:
        keyboard.Key code
        int scancode
        bint alt
        bint control
        bint shift
        bint system

    cdef cppclass TextEvent:
        Uint32 unicode

    cdef cppclass MouseMoveEvent:
        int x
        int y

    cdef cppclass MouseMoveRawEvent:
        int deltaX
        int deltaY

    cdef cppclass MouseButtonEvent:
        mouse.Button button
        int x
        int y

    cdef cppclass MouseWheelEvent:
        int delta
        int x
        int y

    cdef cppclass MouseWheelScrollEvent:
        mouse.Wheel wheel
        float delta
        int x
        int y

    cdef cppclass JoystickConnectEvent:
        unsigned int joystickId

    cdef cppclass JoystickMoveEvent:
        unsigned int joystickId
        joystick.Axis axis
        float position

    cdef cppclass JoystickButtonEvent:
        unsigned int joystickId
        unsigned int button

    cdef cppclass TouchEvent:
        unsigned int finger
        int x
        int y

    cdef cppclass SensorEvent:
        sensor.Type type
        float x
        float y
        float z

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::event_compat":
    cdef cppclass Event:
        event.EventType type
        SizeEvent size
        KeyEvent key
        TextEvent text
        MouseMoveEvent mouseMove
        MouseMoveRawEvent mouseMoveRaw
        MouseButtonEvent mouseButton
        MouseWheelEvent mouseWheel
        MouseWheelScrollEvent mouseWheelScroll
        JoystickMoveEvent joystickMove
        JoystickButtonEvent joystickButton
        JoystickConnectEvent joystickConnect
        TouchEvent touch
        SensorEvent sensor

cdef extern from "SFML/Window.hpp" namespace "sf":

    cdef cppclass ContextSettings:
        unsigned int depthBits
        unsigned int stencilBits
        unsigned int antiAliasingLevel
        unsigned int majorVersion
        unsigned int minorVersion
        Uint32 attributeFlags
        bint sRgbCapable

    cdef cppclass VideoMode:
        VideoMode()
        VideoMode(Vector2u, unsigned int bits_per_pixel)
        bint isValid() const
        Vector2u size
        unsigned int bitsPerPixel
        bint operator==(const VideoMode&)
        bint operator!=(const VideoMode&)
        bint operator<(const VideoMode&)
        bint operator>(const VideoMode&)
        bint operator<=(const VideoMode&)
        bint operator>=(const VideoMode&)

    cdef cppclass WindowHandle

    cdef cppclass Window:
        Window()
        Window(VideoMode, const String&)
        Window(VideoMode, const String&, unsigned long)
        Window(WindowHandle)
        Window(WindowHandle, const ContextSettings&)
        void create(VideoMode, const String&)
        void create(VideoMode, const String&, unsigned long)
        void create(WindowHandle, const ContextSettings&)
        void close()
        bint isOpen() const
        const ContextSettings& getSettings() const
        Vector2i getPosition() const
        void setPosition(const Vector2i&)
        Vector2u getSize() const
        void setSize(const Vector2u)
        void setTitle(const String&)
        void setVisible(bint)
        void setVerticalSyncEnabled(bint)
        void setMouseCursorVisible(bint)
        void setKeyRepeatEnabled(bint)
        void setFramerateLimit(unsigned int)
        void setJoystickThreshold(float)
        bint setActive() const
        bint setActive(bint) const
        void requestFocus()
        bint hasFocus() const
        void display()
        WindowHandle getNativeHandle() const

    cdef cppclass Context:
        Context()
        bint setActive(bint)
        Context(const ContextSettings&, unsigned int, unsigned int height)

    cdef cppclass GlResource:
        GlResource()

from sfml cimport blendmode, primitivetype, texture, shader, font, text, renderstates, transform

cdef extern from "SFML/Graphics.hpp" namespace "sf":
    cdef enum VertexBufferUsage:
        Stream "sf::VertexBuffer::Usage::Stream"
        Dynamic "sf::VertexBuffer::Usage::Dynamic"
        Static "sf::VertexBuffer::Usage::Static"

    cdef cppclass Rect[T]:
        Rect()
        Rect(const Vector2[T]&, const Vector2[T]&)
        Rect(const Rect[T]&)
        bint contains(T, T) const
        bint contains(const Vector2[T]&) const
        optional[Rect[T]] findIntersection(const Rect[T]&) const
        bint intersects(const Rect[T]&) const
        bint intersects(const Rect[T]&, Rect[T]&) const
        Vector2[T] position
        Vector2[T] size

        bint operator==(const Rect[T]&) const
        bint operator!=(const Rect[T]&) const

    ctypedef Rect[int] IntRect
    ctypedef Rect[float] FloatRect

    cdef cppclass Color:
        Color()
        Color(Uint8 r, Uint8 g, Uint8 b)
        Color(Uint8 r, Uint8 g, Uint8, Uint8 a)
        Uint8 r
        Uint8 g
        Uint8 b
        Uint8 a
        bint operator==(const Color&)
        bint operator!=(const Color&)
        Color operator+(const Color&)
        Color operator*(const Color&)
        #Color operator+=(const Color&)
        #Color operator*=(const Color&)

    cdef cppclass Transform:
        Transform()
        Transform(float, float, float, float, float, float, float, float, float)
        const float* getMatrix() const
        Transform getInverse() const
        Vector2f transformPoint(float, float) const
        Vector2f transformPoint(const Vector2f) const
        FloatRect transformRect(const FloatRect&) const
        Transform& combine(const Transform&)
        Transform& translate(float, float)
        Transform& translate(const Vector2f)
        Transform& rotate(float)
        Transform& rotate(float, float, float)
        Transform& rotate(float, const Vector2f&)
        Transform& scale(float, float)
        Transform& scale(float, float, float, float)
        Transform& scale(const Vector2f&)
        Transform& scale(const Vector2f&, const Vector2f&)
        Transform operator*(const Transform&)
        #Transform operator*=(const Transform&)

    cdef cppclass BlendMode:
        BlendMode()
        BlendMode(blendmode.Factor, blendmode.Factor)
        BlendMode(blendmode.Factor, blendmode.Factor, blendmode.Equation)
        BlendMode(blendmode.Factor, blendmode.Factor, blendmode.Equation, blendmode.Factor, blendmode.Factor, blendmode.Equation)
        bint operator==(BlendMode&)
        bint operator!=(BlendMode&)
        blendmode.Factor colorSrcFactor
        blendmode.Factor colorDstFactor
        blendmode.Equation colorEquation
        blendmode.Factor alphaSrcFactor
        blendmode.Factor alphaDstFactor
        blendmode.Equation alphaEquation

    cdef BlendMode BlendAlpha
    cdef BlendMode BlendAdd
    cdef BlendMode BlendMultiply
    cdef BlendMode BlendNone

    cdef cppclass Image:
        Image()
        void create(unsigned int, unsigned int)
        void create(unsigned int, unsigned int, const Uint8*)
        void create(unsigned int, unsigned int, const Color)
        bint loadFromFile(const string&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        bint saveToFile(const string&) const
        Vector2u getSize() const
        void createMaskFromColor(const Color&)
        void createMaskFromColor(const Color&, Uint8)
        void copy(const Image&, unsigned int, unsigned int)
        void copy(const Image&, unsigned int, unsigned int, const IntRect&)
        void copy(const Image&, unsigned int, unsigned int, const IntRect&, bint)
        void setPixel(unsigned int, unsigned int, const Color&)
        Color getPixel(unsigned int, unsigned int) const
        const Uint8* getPixelsPtr() const
        void flipHorizontally()
        void flipVertically()

    cdef cppclass Texture:
        Texture()
        Texture(const Texture&)
        Texture(const Vector2u&, bint)
        bint loadFromFile(const string&)
        bint loadFromFile(const string&, bint)
        bint loadFromFile(const string&, bint, const IntRect&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromMemory(const void*, size_t, bint)
        bint loadFromMemory(const void*, size_t, bint, const IntRect&)
        bint loadFromStream(InputStream&)
        bint loadFromStream(InputStream&, const IntRect&)
        bint loadFromImage(const Image&)
        bint loadFromImage(const Image&, bint)
        bint loadFromImage(const Image&, bint, const IntRect&)
        Vector2u getSize() const
        Image copyToImage() const
        void update(const Uint8*)
        void update(const Uint8*, unsigned int, unsigned int, unsigned int, unsigned int)
        void update(const Image&)
        void update(const Image&, unsigned int, unsigned int)
        void update(const Window&)
        void update(const Window&, unsigned int, unsigned int)
        void setSmooth(bint)
        bint isSmooth() const
        void setRepeated(bint)
        bint isRepeated() const
        bint isSrgb() const
        bint generateMipmap()
        unsigned int getNativeHandle() const

    cdef cppclass Glyph:
        Glyph()
        int advance
        FloatRect bounds
        IntRect textureRect

    cdef cppclass Font:
        Font()
        Font(const Font&)
        bint loadFromFile(const string&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        Glyph& getGlyph(Uint32, unsigned int, bint) const
        int getKerning(Uint32, Uint32, unsigned int) const
        int getLineSpacing(unsigned int) const
        const Texture& getTexture(unsigned int) const
        font.Info& getInfo() const

    cdef cppclass Shader:
        Shader()
        bint loadFromFile(const string&, shader.Type)
        bint loadFromFile(const string&, const string&)
        bint loadFromMemory(const char*&, shader.Type)
        bint loadFromMemory(const char*&, const char*&)
        bint loadFromStream(InputStream&, shader.Type)
        bint loadFromStream(InputStream&, InputStream&)
        void setUniform(const char*, float)
        void setUniform(const char*, float, float)
        void setUniform(const char*, float, float, float)
        void setUniform(const char*, float, float, float, float)
        void setUniform(const char*, const Vector2f&)
        void setUniform(const char*, const Vector3f&)
        void setUniform(const char*, const Color&)
        void setUniform(const char*, const Transform&)
        void setUniform(const char*, const Texture&)
        void setUniform(const char*, shader.CurrentTextureType)

    cdef cppclass RenderStates:
        RenderStates()
        RenderStates(BlendMode)
        RenderStates(const Transform&)
        RenderStates(const Texture*)
        RenderStates(const Shader*)
        RenderStates(BlendMode, const Transform&, const Texture*, const Shader*)
        BlendMode blendMode
        Transform transform
        const Texture* texture
        const Shader* shader

    cdef cppclass Drawable:
        Drawable()

    cdef cppclass Transformable:
        Transformable()
        void setPosition(float, float)
        void setPosition(const Vector2f&)
        void setRotation(float)
        void setScale(float, float)
        void setScale(const Vector2f&)
        void setOrigin(float, float)
        void setOrigin(const Vector2f&)
        const Vector2f& getPosition() const
        float     getRotation() const
        const Vector2f& getScale() const
        const Vector2f& getOrigin() const
        Color&    getColor()
        void move(float, float)
        void move(const Vector2f&)
        void rotate(float)
        void scale(float, float)
        void scale(const Vector2f&)
        const Transform getTransform() const
        const Transform getInverseTransform() const

    cdef cppclass Sprite:
        Sprite()
        Sprite(const Texture&)
        Sprite(const Texture&, const IntRect&)
        void setTexture(const Texture&)
        void setTexture(const Texture&, bint)
        void setTextureRect(const IntRect&)
        void setColor(const Color&)
        const Texture* getTexture() const
        const IntRect& getTextureRect() const
        const Color& getColor() const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

    cdef cppclass Text:
        Text(const Font&, const String&, unsigned int)
        void setString(const String&)
        void setFont(const Font&)
        void setCharacterSize(unsigned int)
        void setLineSpacing(float)
        void setLetterSpacing(float)
        void setStyle(Uint32)
        void setFillColor(const Color&)
        void setOutlineColor(const Color&)
        void setOutlineThickness(float)
        const String& getString() const
        unsigned int getCharacterSize() const
        float getLetterSpacing() const
        float getLineSpacing() const
        Uint32 getStyle() const
        const Color& getFillColor() const
        const Color& getOutlineColor() const
        float getOutlineThickness() const
        Vector2f findCharacterPos(size_t) const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

    cdef cppclass Shape:
        Shape()
        void setTexture(const Texture*)
        void setTexture(const Texture*, bint)
        void setTextureRect(const IntRect&)
        void setFillColor(const Color&)
        void setOutlineColor(const Color&)
        void setOutlineThickness(float)
        const Texture* getTexture() const
        const IntRect& getTextureRect() const
        const Color& getFillColor() const
        const Color& getOutlineColor() const
        float getOutlineThickness() const
        unsigned int getPointCount() const
        Vector2f getPoint(unsigned int) const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

    cdef cppclass CircleShape:
        CircleShape()
        CircleShape(float)
        CircleShape(float, unsigned int)
        void setRadius(float)
        float getRadius() const
        void setPointCount(unsigned int)
        unsigned int getPointCount() const
        Vector2f getPoint(unsigned int) const

    cdef cppclass ConvexShape:
        ConvexShape()
        ConvexShape(unsigned int)
        void setPointCount(unsigned int)
        unsigned int getPointCount() const
        void setPoint(unsigned int, const Vector2f&)
        Vector2f getPoint(unsigned int) const

    cdef cppclass RectangleShape:
        RectangleShape()
        RectangleShape(const Vector2f&)
        void setSize(const Vector2f&)
        const Vector2f& getSize() const
        unsigned int getPointCount() const
        Vector2f getPoint(unsigned int) const

    cdef cppclass Vertex:
        Vertex()
        Vertex(const Vector2f&)
        Vertex(const Vector2f&, const Color&)
        Vertex(const Vector2f&, const Vector2f&)
        Vertex(const Vector2f&, const Color&, const Vector2f&)
        Vector2f position
        Color color
        Vector2f texCoords

    cdef cppclass VertexArray:
        VertexArray()
        VertexArray(primitivetype.PrimitiveType)
        VertexArray(primitivetype.PrimitiveType, unsigned int)
        unsigned int getVertexCount() const
        Vertex& operator[] (unsigned int)
        #const Vertex& operator[] (unsigned int) const
        void clear()
        void resize(unsigned int)
        void append(const Vertex)
        void setPrimitiveType(primitivetype.PrimitiveType)
        primitivetype.PrimitiveType getPrimitiveType() const
        FloatRect getBounds() const

    cdef cppclass VertexBuffer:
        VertexBuffer()
        VertexBuffer(primitivetype.PrimitiveType)
        VertexBuffer(VertexBufferUsage)
        VertexBuffer(primitivetype.PrimitiveType, VertexBufferUsage)
        VertexBuffer(const VertexBuffer&)
        bint create(unsigned int)
        unsigned int getVertexCount() const
        bint update(const Vertex*)
        bint update(const Vertex*, unsigned int, unsigned int)
        bint update(const VertexBuffer&)
        unsigned int getNativeHandle() const
        void setPrimitiveType(primitivetype.PrimitiveType)
        primitivetype.PrimitiveType getPrimitiveType() const
        void setUsage(VertexBufferUsage)
        VertexBufferUsage getUsage() const

    cdef cppclass View:
        View()
        View(const FloatRect&)
        View(const Vector2f&, const Vector2f&)
        void setCenter(float, float)
        void setCenter(const Vector2f&)
        void setSize(float, float)
        void setSize(const Vector2f&)
        void setRotation(float)
        void setViewport(const FloatRect&)
        void setScissor(const FloatRect&)
        void reset(const FloatRect&)
        const Vector2f& getCenter() const
        const Vector2f& getSize() const
        float getRotation() const
        const FloatRect& getViewport() const
        const FloatRect& getScissor() const
        void move(float, float)
        void move(const Vector2f&)
        void rotate(float)
        void zoom(float)
        const Transform& getTransform() const
        const Transform& getInverseTransform() const

    cdef cppclass RenderTarget:
        void clear()
        void clear(const Color&)
        void clear(const Color&, unsigned int)
        void clearStencil(unsigned int)
        void setView(const View&)
        const View& getView() const
        const View& getDefaultView() const
        IntRect getViewport(const View&) const
        IntRect getScissor(const View&) const
        Vector2f mapPixelToCoords(const Vector2i&) const
        Vector2f mapPixelToCoords(const Vector2i&, const View&) const
        Vector2i mapCoordsToPixel(const Vector2f&) const
        Vector2i mapCoordsToPixel(const Vector2f&, const View&) const
        void draw(const Drawable&)
        void draw(const Drawable&, const RenderStates&)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType, const RenderStates&)
        void draw(const VertexBuffer&)
        void draw(const VertexBuffer&, const RenderStates&)
        void draw(const VertexBuffer&, unsigned int, unsigned int, const RenderStates&)
        Vector2u getSize() const
        bint isSrgb() const
        bint setActive(bint)
        void pushGLStates()
        void popGLStates()
        void resetGLStates()

    cdef cppclass RenderWindow:
        RenderWindow()
        RenderWindow(VideoMode, const String&)
        RenderWindow(VideoMode, const String&, Uint32)
        RenderWindow(VideoMode, const String&, Uint32, const ContextSettings&)
        void create(VideoMode, const String&)
        void create(VideoMode, const String&, unsigned long)
        void create(VideoMode, const String&, unsigned long, const ContextSettings&)
        void create(WindowHandle)
        void create(WindowHandle, const ContextSettings&)
        void clear()
        void clear(const Color&)
        void clear(const Color&, unsigned int)
        void clearStencil(unsigned int)
        void setView(const View&)
        const View& getView() const
        const View& getDefaultView() const
        const IntRect getViewport(View&) const
        const IntRect getScissor(View&) const
        Vector2f mapPixelToCoords(const Vector2i&) const
        Vector2f mapPixelToCoords(const Vector2i&, const View&) const
        Vector2i mapCoordsToPixel(const Vector2f&) const
        Vector2i mapCoordsToPixel(const Vector2f&, const View&) const
        void draw(const Drawable&)
        void draw(const Drawable&, const RenderStates&)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType, const RenderStates&)
        void draw(const VertexBuffer&)
        void draw(const VertexBuffer&, const RenderStates&)
        void draw(const VertexBuffer&, unsigned int, unsigned int, const RenderStates&)
        Vector2u getSize() const
        bint isSrgb() const
        void pushGLStates()
        void popGLStates()
        void resetGLStates()

    cdef cppclass RenderTexture:
        RenderTexture()
        bint resize(const Vector2u&)
        bint resize(const Vector2u&, const ContextSettings&)
        void setSmooth(bint)
        bint isSmooth() const
        void setRepeated(bint)
        bint isRepeated() const
        bint setActive()
        bint setActive(bint)
        bint generateMipmap()
        bint isSrgb() const
        void display()
        const Texture& getTexture() const


from libcpp.string cimport string
from sfml cimport listener, soundsource, soundrecorder, soundstream

cdef extern from "SFML/Audio.hpp" namespace "sf":

    cdef enum SoundChannel "sf::SoundChannel":
        Unspecified "sf::SoundChannel::Unspecified"
        Mono "sf::SoundChannel::Mono"
        FrontLeft "sf::SoundChannel::FrontLeft"
        FrontRight "sf::SoundChannel::FrontRight"
        FrontCenter "sf::SoundChannel::FrontCenter"
        FrontLeftOfCenter "sf::SoundChannel::FrontLeftOfCenter"
        FrontRightOfCenter "sf::SoundChannel::FrontRightOfCenter"
        LowFrequencyEffects "sf::SoundChannel::LowFrequencyEffects"
        BackLeft "sf::SoundChannel::BackLeft"
        BackRight "sf::SoundChannel::BackRight"
        BackCenter "sf::SoundChannel::BackCenter"
        SideLeft "sf::SoundChannel::SideLeft"
        SideRight "sf::SoundChannel::SideRight"
        TopCenter "sf::SoundChannel::TopCenter"
        TopFrontLeft "sf::SoundChannel::TopFrontLeft"
        TopFrontRight "sf::SoundChannel::TopFrontRight"
        TopFrontCenter "sf::SoundChannel::TopFrontCenter"
        TopBackLeft "sf::SoundChannel::TopBackLeft"
        TopBackRight "sf::SoundChannel::TopBackRight"
        TopBackCenter "sf::SoundChannel::TopBackCenter"

    cdef cppclass ListenerCone "sf::Listener::Cone":
        Angle innerAngle
        Angle outerAngle
        float outerGain

    cdef cppclass SoundSourceCone "sf::SoundSource::Cone":
        Angle innerAngle
        Angle outerAngle
        float outerGain

    cdef cppclass SoundBuffer:
        SoundBuffer()
        SoundBuffer(const SoundBuffer&)
        bint loadFromFile(const string&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        bint loadFromSamples(const Int16*, Uint64, unsigned int, unsigned int, const vector[SoundChannel]&)
        bint saveToFile(const string&) const
        const Int16* getSamples() const
        size_t getSampleCount() const
        unsigned int getSampleRate() const
        unsigned int getChannelCount() const
        vector[SoundChannel] getChannelMap() const
        Time getDuration() const

    cdef cppclass SoundSource:
        SoundSource(const SoundSource&)
        void setPitch(float)
        void setPan(float)
        void setVolume(float)
        void setSpatializationEnabled(bint)
        void setPosition(float, float, float)
        void setPosition(const Vector3f&)
        void setDirection(const Vector3f&)
        void setCone(const SoundSourceCone&)
        void setVelocity(const Vector3f&)
        void setDopplerFactor(float)
        void setDirectionalAttenuationFactor(float)
        void setRelativeToListener(bint)
        void setMinDistance(float)
        void setMaxDistance(float)
        void setMinGain(float)
        void setMaxGain(float)
        void setAttenuation(float)
        float getPitch() const
        float getPan() const
        float getVolume() const
        bint isSpatializationEnabled() const
        Vector3f getPosition() const
        Vector3f getDirection() const
        SoundSourceCone getCone() const
        Vector3f getVelocity() const
        float getDopplerFactor() const
        float getDirectionalAttenuationFactor() const
        bint isRelativeToListener() const
        float getMinDistance() const
        float getMaxDistance() const
        float getMinGain() const
        float getMaxGain() const
        float getAttenuation() const

    cdef cppclass Sound:
        Sound(const SoundBuffer&)
        Sound(const Sound&)
        void play()
        void pause()
        void stop()
        void setBuffer(const SoundBuffer&)
        void setLooping(bint)
        void setPlayingOffset(Time)
        const SoundBuffer* getBuffer() const
        bint isLooping() const
        Time getPlayingOffset() const
        soundsource.Status getStatus() const
        void resetBuffer()

    cdef cppclass SoundStream:
        void play()
        void pause()
        void stop()
        unsigned int getChannelCount() const
        unsigned int getSampleRate() const
        vector[SoundChannel] getChannelMap() const
        soundsource.Status getStatus() const
        void setPlayingOffset(Time)
        Time getPlayingOffset() const
        void setLooping(bint)
        bint isLooping() const

    cdef cppclass Music:
        Music()
        bint openFromFile(const string&)
        bint openFromMemory(const void*, size_t)
        bint openFromStream(InputStream&)
        Time getDuration() const

    cdef cppclass SoundRecorder:
        bint start()
        bint start(unsigned int)
        void stop() nogil
        unsigned int getSampleRate() const
        bint setDevice(const string& name)
        const string& getDevice() const
        void setChannelCount(unsigned int)
        unsigned int getChannelCount() const
        const vector[SoundChannel]& getChannelMap() const

    cdef cppclass SoundBufferRecorder:
        SoundBufferRecorder()
        const SoundBuffer& getBuffer() const


from sfml cimport socket, udpsocket, ftp, http

cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass IpAddress:
        IpAddress()
        IpAddress(const IpAddress&)
        IpAddress(const string&)
        IpAddress(Uint8, Uint8, Uint8, Uint8)
        IpAddress(Uint32)
        string toString() const
        Uint32 toInteger() const
        bint operator==(IpAddress&)
        bint operator!=(IpAddress&)
        bint operator<(IpAddress&)
        bint operator>(IpAddress&)
        bint operator<=(IpAddress&)
        bint operator>=(IpAddress&)

from sfml cimport ipaddress

cdef extern from "SFML/Network.hpp" namespace "sf":

    cdef cppclass Packet:
        Packet()
        void append(const void*, size_t)
        void clear()
        const void* getData() const
        size_t getDataSize() const
        bint endOfPacket() const

    cdef cppclass Socket:
        void setBlocking(bint)
        bint isBlocking() const

    cdef cppclass TcpListener:
        TcpListener()
        unsigned short getLocalPort() const
        socket.Status listen(unsigned short)
        socket.Status listen(unsigned short, const IpAddress&)
        void close()
        socket.Status accept(TcpSocket&) nogil

    cdef cppclass TcpSocket:
        TcpSocket()
        unsigned short getLocalPort() const
        IpAddress getRemoteAddress() const
        unsigned short getRemotePort() const
        socket.Status connect(const IpAddress&, unsigned short) nogil
        socket.Status connect(const IpAddress&, unsigned short, Time) nogil
        void disconnect()
        socket.Status send(const void*, size_t) nogil
        socket.Status send(const void*, size_t, size_t&) nogil
        socket.Status send(Packet&) nogil
        socket.Status receive(void*, size_t, size_t&) nogil
        socket.Status receive(Packet&) nogil

    cdef cppclass UdpSocket:
        UdpSocket()
        unsigned short getLocalPort() const
        socket.Status bind(unsigned short)
        socket.Status bind(unsigned short, const IpAddress&)
        void unbind()
        socket.Status send(const void*, size_t, const IpAddress&, unsigned short)
        socket.Status send(Packet&, const IpAddress&, unsigned short)
        socket.Status receive(void*, size_t, size_t&, optional[IpAddress]&, unsigned short&)
        socket.Status receive(Packet&, size_t&, IpAddress&, unsigned short&)

    cdef cppclass SocketSelector:
        SocketSelector()
        SocketSelector(const SocketSelector&)
        void add(Socket&)
        void remove(Socket&)
        void clear()
        bint wait() nogil
        bint wait(Time) nogil
        bint isReady(Socket&) const

    cdef cppclass Ftp:
        Ftp()
        ftp.Response connect(const IpAddress&) nogil
        ftp.Response connect(const IpAddress&, unsigned short) nogil
        ftp.Response connect(const IpAddress&, unsigned short, Time) nogil
        ftp.Response disconnect()

        ftp.Response login() nogil
        ftp.Response login(const char*&, const char*&) nogil
        ftp.Response keepAlive() nogil
        ftp.DirectoryResponse getWorkingDirectory() nogil
        ftp.ListingResponse getDirectoryListing() nogil
        ftp.ListingResponse getDirectoryListing(const string&) nogil
        ftp.Response changeDirectory(const string&) nogil
        void setChannelCount(unsigned int)
        unsigned int getChannelCount() const
        const vector[SoundChannel]& getChannelMap() const
        ftp.Response parentDirectory() nogil
        ftp.Response createDirectory(const string&) nogil
        ftp.Response deleteDirectory(const string&) nogil
        ftp.Response renameFile(const path&, const path&) nogil
        ftp.Response deleteFile(const path&) nogil
        ftp.Response download(const path&, const path&) nogil
        ftp.Response download(const path&, const path&, ftp.TransferMode) nogil
        ftp.Response upload(const path&, const path&) nogil
        ftp.Response upload(const path&, const path&, ftp.TransferMode) nogil
        ftp.Response upload(const path&, const path&, ftp.TransferMode, bint) nogil
        ftp.Response sendCommand(const string&) nogil
        ftp.Response sendCommand(const string&, const string&) nogil

    cdef cppclass Http:
        Http()
        Http(const string&)
        Http(const string&, unsigned short)
        void setHost(const string&)
        void setHost(const string&, unsigned short)
        http.Response sendRequest(const http.Request&) nogil
        http.Response sendRequest(const http.Request&, Time) nogil
