#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cdef extern from "<string>" namespace "std":
	cdef cppclass string:
		char* c_str()

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
		Time operator*(Time&)
		Time operator/(Time&)
		#Time operator-=(Time&, Time)
		#Time operator+=(Time&, Time)
		#Time operator*(float)
		#Time operator*(float)
		#Time operator*(Int64)
		#Time operator/(float)
		#Time operator/(Int64)

	cdef void sleep(Time) nogil

	cdef cppclass Clock:
		Clock()
		Time getElapsedTime() const
		Time restart()

	cdef Time seconds(float)
	cdef Time milliseconds(Int32)
	cdef Time microseconds(Int64)

	cdef cppclass String:
		String(char*)
		string toAnsiString()

	cdef cppclass Vector2i:
		Vector2i()
		Vector2i(int, int)
		int x
		int y

	cdef cppclass Vector2u:
		Vector2u()
		Vector2u(unsigned int, unsigned int)
		unsigned int x
		unsigned int y

	cdef cppclass Vector2f:
		Vector2f()
		Vector2f(float, float)
		float x
		float y

	cdef cppclass Vector3i:
		Vector3i()
		Vector3i(int, int, int)
		int x
		int y
		int z

	cdef cppclass Vector3u:
		Vector3u()
		Vector3u(unsigned int, unsigned int, unsigned int)
		unsigned int x
		unsigned int y
		unsigned int z

	cdef cppclass Vector3f:
		Vector3f()
		Vector3f(float, float, float)
		float x
		float y
		float z

	cdef cppclass Vector2[T]:
		Vector2()
		Vector2(T, T)
		T x
		T y

	cdef cppclass Vector3[T]:
		Vector3()
		Vector3(T, T)
		T x
		T y
		T z

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
	cdef cppclass String

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


cimport blendmode, primitivetype, texture, shader, text, renderstates

cdef extern from *:
	ctypedef unsigned char* const_Uint8_ptr "const unsigned char*"


cdef extern from "SFML/Graphics.hpp" namespace "sf":
	cdef cppclass IntRect:
		IntRect()
		IntRect(int, int, int, int)
		IntRect(Vector2i&, Vector2i&)
		bint contains(int, int)
		bint contains(Vector2i&)
		bint intersects(IntRect&)
		bint intersects(IntRect&, IntRect&)
		int left
		int top
		int width
		int height

	cdef cppclass FloatRect:
		FloatRect()
		FloatRect(float, float, float, float)
		FloatRect(Vector2f&, Vector2f&)
		bint contains(float, float)
		bint contains(Vector2f&)
		bint intersects(FloatRect&)
		bint intersects(FloatRect&, FloatRect&)
		float left
		float top
		float width
		float height

	cdef cppclass Color:
		Color()
		Color(Uint8 r, Uint8 g, Uint8 b)
		Color(Uint8 r, Uint8 g, Uint8, Uint8 a)
		Uint8 r
		Uint8 g
		Uint8 b
		Uint8 a
		bint operator==(Color&)
		bint operator!=(Color&)
		Color operator+(Color&)
		Color operator*(Color&)
		#Color operator+=(Color&)
		#Color operator*=(Color&)

	cdef cppclass Transform:
		Transform()
		Transform(float, float, float, float, float, float, float, float, float)
		float* getMatrix()
		Transform getInverse()
		Vector2f transformPoint(float, float)
		Vector2f transformPoint(Vector2f)
		FloatRect transformRect(FloatRect&)
		Transform& combine(Transform&)
		Transform& translate(float, float)
		Transform& translate(Vector2f)
		Transform& rotate(float)
		Transform& rotate(float, float, float)
		Transform& rotate(float, Vector2f&)
		Transform& scale(float, float)
		Transform& scale(float, float, float, float)
		Transform& scale(Vector2f&)
		Transform& scale(Vector2f&, Vector2f&)
		Transform operator*(Transform&)
		#Transform operator*=(Transform&)

	cdef cppclass Image:
		Image()
		void create(unsigned int, unsigned int)
		void create(unsigned int, unsigned int, const_Uint8_ptr)
		void create(unsigned int, unsigned int, Color)
		bint loadFromFile(char*&)
		bint loadFromMemory(void*, size_t)
		bint saveToFile(char*&)
		Vector2u getSize()
		void createMaskFromColor(Color&)
		void createMaskFromColor(Color&, Uint8)
		void copy(Image&, unsigned int, unsigned int)
		void copy(Image&, unsigned int, unsigned int, IntRect&)
		void copy(Image&, unsigned int, unsigned int, IntRect&, bint)
		void setPixel(unsigned int, unsigned int, Color&)
		Color getPixel(unsigned int, unsigned int)
		Uint8* getPixelsPtr()
		void flipHorizontally()
		void flipVertically()

	cdef cppclass Texture:
		Texture()
		Texture(Texture&)
		bint create(unsigned int, unsigned int)
		bint loadFromFile(char*&)
		bint loadFromFile(char*&, IntRect&)
		bint loadFromMemory(void*, size_t)
		bint loadFromMemory(void*, size_t, IntRect&)
		bint loadFromImage(Image&)
		bint loadFromImage(Image&, IntRect&)
		Vector2u getSize()
		Image copyToImage()
		void update(Uint8*)
		void update(Uint8*, unsigned int, unsigned int, unsigned int, unsigned int)
		void update(Image&)
		void update(Image&, unsigned int, unsigned int)
		void update(Window&)
		void update(Window&, unsigned int, unsigned int)
		void setSmooth(bint)
		bint isSmooth()
		void setRepeated(bint)
		bint isRepeated()

	cdef cppclass Glyph:
		Glyph()
		int advance
		IntRect bounds
		IntRect textureRect

	cdef cppclass Font:
		Font()
		Font(Font&)
		bint loadFromFile(char*&)
		bint loadFromMemory(void*, size_t)
		Glyph& getGlyph(Uint32, unsigned int, bint)
		int getKerning(Uint32, Uint32, unsigned int)
		int getLineSpacing(unsigned int)
		Texture& getTexture(unsigned int)

	cdef cppclass Shader:
		Shader()
		bint loadFromFile(char*&, shader.Type)
		bint loadFromFile(char*&, char*&)
		bint loadFromMemory(char*&, shader.Type)
		bint loadFromMemory(char*&, char*&)
		void setParameter(char*, float)
		void setParameter(char*, float, float)
		void setParameter(char*, float, float, float)
		void setParameter(char*, float, float, float, float)
		void setParameter(char*, Vector2f&)
		void setParameter(char*, Vector3f&)
		void setParameter(char*, Color&)
		void setParameter(char*, Transform&)
		void setParameter(char*, Texture&)
		void setParameter(char*, shader.CurrentTextureType)

	cdef cppclass RenderStates:
		RenderStates()
		RenderStates(blendmode.BlendMode)
		RenderStates(Transform&)
		RenderStates(Texture*)
		RenderStates(Shader*)
		RenderStates(blendmode.BlendMode, Transform&, Texture*, Shader*)
		blendmode.BlendMode blendMode
		Transform           transform
		Texture*            texture
		Shader*             shader

	cdef cppclass Drawable:
		Drawable()

	cdef cppclass Transformable:
		Transformable()
		void setPosition(float, float)
		void setPosition(Vector2f&)
		void setRotation(float)
		void setScale(float, float)
		void setScale(Vector2f&)
		void setOrigin(float, float)
		void setOrigin(Vector2f&)
		Vector2f& getPosition()
		float     getRotation()
		Vector2f& getScale()
		Vector2f& getOrigin()
		Color&    getColor()
		void move(float, float)
		void move(Vector2f&)
		void rotate(float)
		void scale(float, float)
		void scale(Vector2f&)
		Transform getTransform()
		Transform getInverseTransform()

	cdef cppclass Sprite:
		Sprite()
		Sprite(Texture&)
		Sprite(Texture&, IntRect&)
		void setTexture(Texture&)
		void setTexture(Texture&, bint)
		void setTextureRect(IntRect&)
		void setColor(Color&)
		Texture* getTexture()
		IntRect& getTextureRect()
		Color& getColor()
		FloatRect getLocalBounds()
		FloatRect getGlobalBounds()

	cdef cppclass Text:
		Text()
		Text(String&)
		void setString(String&)
		void setFont(Font&)
		void setCharacterSize(unsigned int)
		void setStyle(Uint32)
		void setColor(Color&)
		String& getString()
		Font& getFont()
		unsigned int getCharacterSize()
		Uint32 getStyle()
		Color& getColor()
		Vector2f findCharacterPos(size_t)
		FloatRect getLocalBounds()
		FloatRect getGlobalBounds()

	cdef cppclass Shape:
		Shape()
		void setTexture(Texture*)
		void setTexture(Texture*, bint)
		void setTextureRect(IntRect&)
		void setFillColor(Color&)
		void setOutlineColor(Color&)
		void setOutlineThickness(float)
		Texture* getTexture()
		IntRect& getTextureRect()
		Color& getFillColor()
		Color& getOutlineColor()
		float getOutlineThickness()
		FloatRect getLocalBounds()
		FloatRect getGlobalBounds()
		unsigned int getPointCount()
		Vector2f getPoint(unsigned int)

	cdef cppclass CircleShape:
		CircleShape()
		CircleShape(float)
		CircleShape(float, unsigned int)
		void setRadius(float)
		float getRadius()
		void setPointCount(unsigned int)
		unsigned int getPointCount()
		Vector2f getPoint(unsigned int)

	cdef cppclass ConvexShape:
		ConvexShape()
		ConvexShape(unsigned int)
		void setPointCount(unsigned int)
		unsigned int getPointCount()
		void setPoint(unsigned int, Vector2f)
		Vector2f getPoint(unsigned int)

	cdef cppclass RectangleShape:
		RectangleShape()
		RectangleShape(Vector2f&)
		void setSize(Vector2f&)
		Vector2f& getSize()
		unsigned int getPointCount()
		Vector2f getPoint(unsigned int)

	cdef cppclass Vertex:
		Vertex()
		Vector2f position
		Color color
		Vector2f texCoords

	cdef cppclass VertexArray:
		VertexArray()
		VertexArray(primitivetype.PrimitiveType)
		VertexArray(primitivetype.PrimitiveType, unsigned int)
		unsigned int getVertexCount()
		Vertex& operator[] (unsigned int)
		void clear()
		void resize(unsigned int)
		void append(Vertex)
		void setPrimitiveType(primitivetype.PrimitiveType)
		primitivetype.PrimitiveType getPrimitiveType()
		FloatRect getBounds()

	cdef cppclass View:
		View()
		View(FloatRect&)
		View(Vector2f&, Vector2f&)
		void setCenter(float, float)
		void setCenter(Vector2f&)
		void setSize(float, float)
		void setSize(Vector2f&)
		void setRotation(float)
		void setViewport(FloatRect&)
		void reset(FloatRect&)
		Vector2f& getCenter()
		Vector2f& getSize()
		float getRotation()
		FloatRect& getViewport()
		void move(float, float)
		void move(Vector2f&)
		void rotate(float)
		void zoom(float)
		Transform& getTransform()
		Transform& getInverseTransform()

	cdef cppclass RenderTarget:
		void clear()
		void clear(Color&)
		void setView(View&)
		View& getView()
		View& getDefaultView()
		IntRect getViewport(View&)
		Vector2f mapPixelToCoords(Vector2i&)
		Vector2f mapPixelToCoords(Vector2i&, View&)
		Vector2i mapCoordsToPixel(Vector2f&)
		Vector2i mapCoordsToPixel(Vector2f&, View&)
		void draw(Drawable&)
		void draw(Drawable&, RenderStates&)
		void draw(Vertex*, unsigned int, primitivetype.PrimitiveType)
		void draw(Vertex*, unsigned int, primitivetype.PrimitiveType, RenderStates&)
		Vector2u getSize()
		void pushGLStates()
		void popGLStates()
		void resetGLStates()

	cdef cppclass RenderWindow:
		RenderWindow()
		RenderWindow(VideoMode, char*&)
		RenderWindow(VideoMode, char*&, Uint32)
		RenderWindow(VideoMode, char*&, Uint32, ContextSettings&)
		void create(WindowHandle)
		void create(WindowHandle, ContextSettings&)
		void clear()
		void clear(Color&)
		void setView(View&)
		View& getView()
		View& getDefaultView()
		IntRect getViewport(View&)
		Vector2f mapPixelToCoords(Vector2i&)
		Vector2f mapPixelToCoords(Vector2i&, View&)
		Vector2i mapCoordsToPixel(Vector2f&)
		Vector2i mapCoordsToPixel(Vector2f&, View&)
		void draw(Drawable&)
		void draw(Drawable&, RenderStates&)
		void draw(Vertex*, unsigned int, primitivetype.PrimitiveType)
		void draw(Vertex*, unsigned int, primitivetype.PrimitiveType, RenderStates&)
		Vector2u getSize()
		void pushGLStates()
		void popGLStates()
		void resetGLStates()
		Image capture()

	cdef cppclass RenderTexture:
		RenderTexture()
		bint create(unsigned int, unsigned int)
		bint create(unsigned int, unsigned int, bint depth)
		void setSmooth(bint)
		bint isSmooth()
		bint setActive()
		bint setActive(bint)
		void display()
		Texture& getTexture()


from libcpp.string cimport string
cimport listener, soundsource, soundrecorder

cdef extern from "SFML/Audio.hpp" namespace "sf":
	ctypedef Int16* const_Int16 "const sf::Int16*"

	cdef cppclass SoundBuffer:
		SoundBuffer()
		bint loadFromFile(char*&)
		bint loadFromMemory(void*, size_t)
		bint loadFromSamples(Int16*, size_t, unsigned int, unsigned int)
		bint saveToFile(char*&)
		Int16* getSamples()
		size_t getSampleCount()
		unsigned int getSampleRate()
		unsigned int getChannelCount()
		Time getDuration()

cdef extern from "SFML/Audio.hpp" namespace "sf::SoundStream":
	cdef struct Chunk:
		const_Int16 samples
		size_t sampleCount

cdef extern from "SFML/Audio.hpp" namespace "sf":
	cdef cppclass SoundSource:
		void setPitch(float)
		void setVolume(float)
		void setPosition(float, float, float)
		void setPosition(Vector3f&)
		void setRelativeToListener(bint)
		void setMinDistance(float)
		void setAttenuation(float)
		float getPitch()
		float getVolume()
		Vector3f getPosition()
		bint isRelativeToListener()
		float getMinDistance()
		float getAttenuation()

	cdef cppclass Sound:
		Sound()
		Sound(SoundBuffer&)
		void play()
		void pause()
		void stop()
		void setBuffer(SoundBuffer&)
		void setLoop(bint)
		void setPlayingOffset(Time)
		SoundBuffer* getBuffer()
		bint getLoop()
		Time getPlayingOffset()
		soundsource.Status getStatus()
		void resetBuffer()

	cdef cppclass SoundStream:
		void play()
		void pause()
		void stop()
		unsigned int getChannelCount()
		unsigned int getSampleRate()
		soundsource.Status getStatus()
		void setPlayingOffset(Time)
		Time getPlayingOffset()
		void setLoop(bint)
		bint getLoop()

	cdef cppclass Music:
		Music()
		bint openFromFile(char*&)
		bint openFromMemory(void*, size_t)
		Time getDuration()

	cdef cppclass SoundRecorder:
		void start(unsigned int)
		void stop() nogil
		unsigned int getSampleRate()

	cdef cppclass SoundBufferRecorder:
		SoundBufferRecorder()
		SoundBuffer& getBuffer()


cimport ipaddress, socket, udpsocket, ftp, http

cdef extern from "SFML/Network.hpp" namespace "sf":
	cdef cppclass IpAddress:
		IpAddress()
		IpAddress(string&)
		IpAddress(Uint8, Uint8, Uint8, Uint8)
		IpAddress(Uint32)
		string toString()
		Uint32 toInteger()
		bint operator==(IpAddress&)
		bint operator!=(IpAddress&)
		bint operator<(IpAddress&)
		bint operator>(IpAddress&)
		bint operator<=(IpAddress&)
		bint operator>=(IpAddress&)

	cdef cppclass Socket:
		void setBlocking(bint)
		bint isBlocking()

	cdef cppclass TcpListener:
		TcpListener()
		unsigned short getLocalPort()
		socket.Status listen(unsigned short)
		void close()
		socket.Status accept(TcpSocket&) nogil

	cdef cppclass TcpSocket:
		TcpSocket()
		unsigned short getLocalPort()
		IpAddress getRemoteAddress()
		unsigned short getRemotePort()
		socket.Status connect(IpAddress&, unsigned short) nogil
		socket.Status connect(IpAddress&, unsigned short, Time) nogil
		void disconnect()
		socket.Status send(void*, size_t) nogil
		socket.Status receive(void*, size_t, size_t&) nogil

	cdef cppclass UdpSocket:
		UdpSocket()
		unsigned short getLocalPort()
		socket.Status bind(unsigned short)
		void unbind()
		socket.Status send(void*, size_t, IpAddress&, unsigned short)
		socket.Status receive(void*, size_t, size_t&, IpAddress&, unsigned short&)

	cdef cppclass SocketSelector:
		SocketSelector()
		void add(Socket&)
		void remove(Socket&)
		void clear()
		bint wait() nogil
		bint wait(Time) nogil
		bint isReady(Socket&)

	cdef cppclass Ftp:
		Ftp()
		ftp.Response connect(IpAddress&) nogil
		ftp.Response connect(IpAddress&, unsigned short) nogil
		ftp.Response connect(IpAddress&, unsigned short, Time) nogil
		ftp.Response disconnect()
		ftp.Response login() nogil
		ftp.Response login(char*&, char*&) nogil
		ftp.Response keepAlive() nogil
		ftp.DirectoryResponse getWorkingDirectory() nogil
		ftp.ListingResponse getDirectoryListing() nogil
		ftp.ListingResponse getDirectoryListing(char*&) nogil
		ftp.Response changeDirectory(char*&) nogil
		ftp.Response parentDirectory() nogil
		ftp.Response createDirectory(char*&) nogil
		ftp.Response deleteDirectory(char*&) nogil
		ftp.Response renameFile(char*&, char*&) nogil
		ftp.Response deleteFile(char*&) nogil
		ftp.Response download(char*&, char*&) nogil
		ftp.Response download(char*&, char*&, ftp.TransferMode) nogil
		ftp.Response upload(char*&, char*&) nogil
		ftp.Response upload(char*&, char*&, ftp.TransferMode) nogil

	cdef cppclass Http:
		Http()
		Http(string&)
		Http(string&, unsigned short)
		void setHost(string&)
		void setHost(string&, unsigned short)
		http.Response sendRequest(http.Request&) nogil
		http.Response sendRequest(http.Request&, Time) nogil

#cimport x11
