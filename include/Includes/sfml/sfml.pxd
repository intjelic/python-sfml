#-------------------------------------------------------------------------------
# PySFML - Python bindings for SFML
# Copyright (c) 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#                          Edwin Marshall <emarshall85@gmail.com>
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from the
# use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software in a
#    product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
#
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
#
# 3. This notice may not be removed or altered from any source distribution.
#-------------------------------------------------------------------------------

cdef extern from *:
    ctypedef int wchar_t

cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()

    cdef cppclass wstring:
        wchar_t* c_str()

cimport time

cdef extern from "SFML/System.hpp" namespace "sf":
    # 8 bits integer types
    ctypedef signed   char Int8
    ctypedef unsigned char Uint8

    # 16 bits integer types
    ctypedef signed   short Int16
    ctypedef unsigned short Uint16

    # 32 bits integer types
    ctypedef signed   int Int32
    ctypedef unsigned int Uint32

    # 64 bits integer types
    ctypedef signed   long long Int64
    ctypedef unsigned long long Uint64

    cdef cppclass Time:
        Time()
        float asSeconds() const
        Int32 asMilliseconds() const
        Int64 asMicroseconds() const
        bint operator==(Time&)
        bint operator!=(Time&)
        bint operator<(Time&)
        bint operator>(Time&)
        bint operator<=(Time&)
        bint operator>=(Time&)
        Time operator+(Time&)
        Time operator-(Time&)
        Time operator*(float)
        Time operator*(Int64)
        Time operator/(float)
        Time operator/(Int64)
        Time operator%(Time&)

    cdef void sleep(Time) nogil

    cdef cppclass Clock:
        Clock()
        Time getElapsedTime() const
        Time restart()

    cdef Time seconds(float)
    cdef Time milliseconds(Int32)
    cdef Time microseconds(Int64)

    cdef cppclass String:
        String()
        String(const wchar_t*)
        String(const Uint32*)
        string toAnsiString()
        wstring toWideString()
        void clear()
        int getSize() const
        bint isEmpty() const

    cdef cppclass Vector2[T]:
        Vector2()
        Vector2(T, T)
        T x
        T y

    ctypedef Vector2[int] Vector2i
    ctypedef Vector2[unsigned int] Vector2u
    ctypedef Vector2[float] Vector2f

    cdef cppclass Vector3[T]:
        Vector3()
        Vector3(T, T, T)
        T x
        T y
        T z

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

cimport style, event, videomode, keyboard, joystick, mouse, touch, sensor

cdef extern from "SFML/Window.hpp" namespace "sf::Event":
    cdef struct SizeEvent:
        unsigned int width
        unsigned int height

    cdef struct KeyEvent:
        keyboard.Key code
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
        mouse.Button button
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
        joystick.Axis axis
        float position

    cdef struct JoystickButtonEvent:
        unsigned int joystickId
        unsigned int button

    cdef struct TouchEvent:
        unsigned int finger
        int x
        int y

    cdef struct SensorEvent:
        sensor.Type type
        float x
        float y
        float z

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
        TouchEvent touch
        SensorEvent sensor

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
        bint isValid() const
        unsigned int width
        unsigned int height
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
        Window(VideoMode, const String&, unsigned long, const ContextSettings&)
        Window(WindowHandle)
        Window(WindowHandle, const ContextSettings&)
        void create(VideoMode, const String&)
        void create(VideoMode, const String&, unsigned long)
        void create(VideoMode, const String&, unsigned long, const ContextSettings&)
        void create(WindowHandle, const ContextSettings&)
        void close()
        bint isOpen() const
        const ContextSettings& getSettings() const
        bint pollEvent(Event&)
        bint waitEvent(Event&)
        Vector2i getPosition() const
        void setPosition(const Vector2i&)
        Vector2u getSize() const
        void setSize(const Vector2u)
        void setTitle(const String&)
        void setIcon(unsigned int, unsigned int, const Uint8*)
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
        WindowHandle getSystemHandle() const
        void onCreate()
        void onResize()

    cdef cppclass Context:
        Context()
        bint setActive(bint)
        Context(const ContextSettings&, unsigned int, unsigned int height)

    cdef cppclass GlResource:
        GlResource()

cimport blendmode, primitivetype, texture, shader, font, text, renderstates, transform

cdef extern from *:
    ctypedef unsigned char* const_Uint8_ptr "const unsigned char*"


cdef extern from "SFML/Graphics.hpp" namespace "sf":
    cdef cppclass Rect[T]:
        Rect()
        Rect(T, T, T, T)
        Rect(const Vector2[T]&, const Vector2[T]&)
        bint contains(T, T) const
        bint contains(const Vector2[T]&) const
        bint intersects(const Rect[T]&) const
        bint intersects(const Rect[T]&, Rect[T]&) const
        T left
        T top
        T width
        T height

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
        void create(unsigned int, unsigned int, const const_Uint8_ptr)
        void create(unsigned int, unsigned int, const Color)
        bint loadFromFile(char*&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        bint saveToFile(const char*&) const
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
        bint create(unsigned int, unsigned int)
        bint loadFromFile(const char*&)
        bint loadFromFile(const char*&, const IntRect&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromMemory(const void*, size_t, const IntRect&)
        bint loadFromStream(InputStream&)
        bint loadFromStream(InputStream&, const IntRect&)
        bint loadFromImage(const Image&)
        bint loadFromImage(const Image&, const IntRect&)
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

    cdef cppclass Glyph:
        Glyph()
        int advance
        FloatRect bounds
        IntRect textureRect

    cdef cppclass Font:
        Font()
        Font(const Font&)
        bint loadFromFile(const char*&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        Glyph& getGlyph(Uint32, unsigned int, bint) const
        int getKerning(Uint32, Uint32, unsigned int) const
        int getLineSpacing(unsigned int) const
        const Texture& getTexture(unsigned int) const
        font.Info& getInfo() const

    cdef cppclass Shader:
        Shader()
        bint loadFromFile(const char*&, shader.Type)
        bint loadFromFile(const char*&, const char*&)
        bint loadFromMemory(const char*&, shader.Type)
        bint loadFromMemory(const char*&, const char*&)
        bint loadFromStream(InputStream&, shader.Type)
        bint loadFromStream(InputStream&, InputStream&)
        void setParameter(const char*, float)
        void setParameter(const char*, float, float)
        void setParameter(const char*, float, float, float)
        void setParameter(const char*, float, float, float, float)
        void setParameter(const char*, const Vector2f&)
        void setParameter(const char*, const Vector3f&)
        void setParameter(const char*, const Color&)
        void setParameter(const char*, const Transform&)
        void setParameter(const char*, const Texture&)
        void setParameter(const char*, shader.CurrentTextureType)

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
        Text()
        Text(const String&)
        Text(const String&, const Font&)
        Text(const String&, const Font&, unsigned int)
        void setString(const String&)
        void setFont(const Font&)
        void setCharacterSize(unsigned int)
        void setStyle(Uint32)
        void setColor(const Color&)
        const String& getString() const
        const Font* getFont() const
        unsigned int getCharacterSize() const
        Uint32 getStyle() const
        const Color& getColor() const
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
        void reset(const FloatRect&)
        const Vector2f& getCenter() const
        const Vector2f& getSize() const
        float getRotation() const
        const FloatRect& getViewport() const
        void move(float, float)
        void move(const Vector2f&)
        void rotate(float)
        void zoom(float)
        const Transform& getTransform() const
        const Transform& getInverseTransform() const

    cdef cppclass RenderTarget:
        void clear()
        void clear(const Color&)
        void setView(const View&)
        const View& getView() const
        const View& getDefaultView() const
        IntRect getViewport(const View&) const
        Vector2f mapPixelToCoords(const Vector2i&) const
        Vector2f mapPixelToCoords(const Vector2i&, const View&) const
        Vector2i mapCoordsToPixel(const Vector2f&) const
        Vector2i mapCoordsToPixel(const Vector2f&, const View&) const
        void draw(const Drawable&)
        void draw(const Drawable&, const RenderStates&)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType, const RenderStates&)
        Vector2u getSize() const
        void pushGLStates()
        void popGLStates()
        void resetGLStates()

    cdef cppclass RenderWindow:
        RenderWindow()
        RenderWindow(VideoMode, const String&)
        RenderWindow(VideoMode, const String&, Uint32)
        RenderWindow(VideoMode, const String&, Uint32, const ContextSettings&)
        void create(WindowHandle)
        void create(WindowHandle, const ContextSettings&)
        void clear()
        void clear(const Color&)
        void setView(const View&)
        const View& getView() const
        const View& getDefaultView() const
        const IntRect getViewport(View&) const
        Vector2f mapPixelToCoords(const Vector2i&) const
        Vector2f mapPixelToCoords(const Vector2i&, const View&) const
        Vector2i mapCoordsToPixel(const Vector2f&) const
        Vector2i mapCoordsToPixel(const Vector2f&, const View&) const
        void draw(const Drawable&)
        void draw(const Drawable&, const RenderStates&)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType)
        void draw(const Vertex*, unsigned int, primitivetype.PrimitiveType, const RenderStates&)
        Vector2u getSize() const
        void pushGLStates()
        void popGLStates()
        void resetGLStates()
        Image capture() const

    cdef cppclass RenderTexture:
        RenderTexture()
        bint create(unsigned int, unsigned int)
        bint create(unsigned int, unsigned int, bint depth)
        void setSmooth(bint)
        bint isSmooth() const
        void setRepeated(bint)
        bint isRepeated() const
        bint setActive()
        bint setActive(bint)
        void display()
        const Texture& getTexture() const


from libcpp.string cimport string
cimport listener, soundsource, soundrecorder, soundstream

cdef extern from "SFML/Audio.hpp" namespace "sf":

    cdef cppclass SoundBuffer:
        SoundBuffer()
        SoundBuffer(const SoundBuffer&)
        bint loadFromFile(const char*&)
        bint loadFromMemory(const void*, size_t)
        bint loadFromStream(InputStream&)
        bint loadFromSamples(const Int16*, size_t, unsigned int, unsigned int)
        bint saveToFile(const char*&) const
        const Int16* getSamples() const
        size_t getSampleCount() const
        unsigned int getSampleRate() const
        unsigned int getChannelCount() const
        Time getDuration() const

    cdef cppclass SoundSource:
        SoundSource(const SoundSource&)
        void setPitch(float)
        void setVolume(float)
        void setPosition(float, float, float)
        void setPosition(const Vector3f&)
        void setRelativeToListener(bint)
        void setMinDistance(float)
        void setAttenuation(float)
        float getPitch() const
        float getVolume() const
        Vector3f getPosition() const
        bint isRelativeToListener() const
        float getMinDistance() const
        float getAttenuation() const

    cdef cppclass Sound:
        Sound()
        Sound(const SoundBuffer&)
        Sound(const Sound&)
        void play()
        void pause()
        void stop()
        void setBuffer(const SoundBuffer&)
        void setLoop(bint)
        void setPlayingOffset(Time)
        const SoundBuffer* getBuffer() const
        bint getLoop() const
        Time getPlayingOffset() const
        soundsource.Status getStatus() const
        void resetBuffer()

    cdef cppclass SoundStream:
        void play()
        void pause()
        void stop()
        unsigned int getChannelCount() const
        unsigned int getSampleRate() const
        soundsource.Status getStatus() const
        void setPlayingOffset(Time)
        Time getPlayingOffset() const
        void setLoop(bint)
        bint getLoop() const

    cdef cppclass Music:
        Music()
        bint openFromFile(const char*&)
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

    cdef cppclass SoundBufferRecorder:
        SoundBufferRecorder()
        const SoundBuffer& getBuffer() const


cimport ipaddress, socket, udpsocket, ftp, http

cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass IpAddress:
        IpAddress()
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
        socket.Status send(Packet&) nogil
        socket.Status receive(const void*, size_t, size_t&) nogil
        socket.Status receive(Packet&) nogil

    cdef cppclass UdpSocket:
        UdpSocket()
        unsigned short getLocalPort() const
        socket.Status bind(unsigned short)
        void unbind()
        socket.Status send(const void*, size_t, const IpAddress&, unsigned short)
        socket.Status send(Packet&, const IpAddress&, unsigned short)
        socket.Status receive(void*, size_t, size_t&, IpAddress&, unsigned short&)
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
        ftp.ListingResponse getDirectoryListing(const char*&) nogil
        ftp.Response changeDirectory(const char*&) nogil
        ftp.Response parentDirectory() nogil
        ftp.Response createDirectory(const char*&) nogil
        ftp.Response deleteDirectory(const char*&) nogil
        ftp.Response renameFile(const char*&, const char*&) nogil
        ftp.Response deleteFile(const char*&) nogil
        ftp.Response download(const char*&, const char*&) nogil
        ftp.Response download(const char*&, const char*&, ftp.TransferMode) nogil
        ftp.Response upload(const char*&, const char*&) nogil
        ftp.Response upload(const char*&, const char*&, ftp.TransferMode) nogil

    cdef cppclass Http:
        Http()
        Http(const string&)
        Http(const string&, unsigned short)
        void setHost(const string&)
        void setHost(const string&, unsigned short)
        http.Response sendRequest(const http.Request&) nogil
        http.Response sendRequest(const http.Request&, Time) nogil
