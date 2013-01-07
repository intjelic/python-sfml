#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64
from dsystem cimport Vector2i, Vector2u, Vector2f
from dsystem cimport Vector3i, Vector3u, Vector3f
from dsystem cimport IntRect, FloatRect

from dsystem cimport *
from dwindow cimport *

cimport blendmode, primitivetype, texture, shader, text, renderstates

cdef extern from *:
	ctypedef unsigned char* const_Uint8_ptr "const unsigned char*"

cdef extern from "derivabledrawable.hpp":
	cdef cppclass DerivableDrawable:
		DerivableDrawable(void*)

cdef extern from "SFML/Graphics.hpp" namespace "sf":
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
		void bind()
		void bind(texture.CoordinateType)
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
		void bind()
		void unbind()
		
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
		Vector2f convertCoords(Vector2i&)
		Vector2f convertCoords(Vector2i&, View&)
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
		Vector2f convertCoords(Vector2i&)
		Vector2f convertCoords(Vector2i&, View&)
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
		
cdef extern from "derivablerenderwindow.hpp":
	cdef cppclass DerivableRenderWindow:
		DerivableRenderWindow()
		DerivableRenderWindow(VideoMode, char*)
		DerivableRenderWindow(VideoMode, char*, unsigned long)
		DerivableRenderWindow(VideoMode, char*, unsigned long, ContextSettings&)
		DerivableRenderWindow(WindowHandle window_handle)
		DerivableRenderWindow(WindowHandle window_handle, ContextSettings&)
		void set_pyobj(void*)
