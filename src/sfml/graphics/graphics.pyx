# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

from libcpp.vector cimport vector
from libcpp.string cimport string
from libc.stddef cimport size_t

cimport sfml as sf

cdef extern from "SFML/Graphics.hpp" namespace "sf":
    ctypedef sf.Rect[int] SfIntRect
    ctypedef sf.Rect[float] SfFloatRect

    cdef enum SfPrimitiveType "sf::PrimitiveType":
        SfPrimitiveTypePoints "sf::PrimitiveType::Points"
        SfPrimitiveTypeLines "sf::PrimitiveType::Lines"
        SfPrimitiveTypeLineStrip "sf::PrimitiveType::LineStrip"
        SfPrimitiveTypeTriangles "sf::PrimitiveType::Triangles"
        SfPrimitiveTypeTriangleStrip "sf::PrimitiveType::TriangleStrip"
        SfPrimitiveTypeTriangleFan "sf::PrimitiveType::TriangleFan"

    cdef enum SfVertexBufferUsage "sf::VertexBuffer::Usage":
        SfVertexBufferUsageStream "sf::VertexBuffer::Usage::Stream"
        SfVertexBufferUsageDynamic "sf::VertexBuffer::Usage::Dynamic"
        SfVertexBufferUsageStatic "sf::VertexBuffer::Usage::Static"

    cdef enum SfTextStyle "sf::Text::Style":
        SfTextRegular "sf::Text::Regular"
        SfTextBold "sf::Text::Bold"
        SfTextItalic "sf::Text::Italic"
        SfTextUnderlined "sf::Text::Underlined"
        SfTextStrikeThrough "sf::Text::StrikeThrough"

    cdef cppclass SfVector2u "Vector2u":
        SfVector2u()
        SfVector2u(unsigned int, unsigned int)
        unsigned int x
        unsigned int y

    cdef cppclass SfVector2f "Vector2f":
        SfVector2f()
        SfVector2f(float, float)
        float x
        float y

    cdef cppclass SfVector2i "Vector2i":
        SfVector2i()
        SfVector2i(int, int)
        int x
        int y

    cdef enum SfStencilComparison "sf::StencilComparison":
        SfStencilComparisonNever "sf::StencilComparison::Never"
        SfStencilComparisonLess "sf::StencilComparison::Less"
        SfStencilComparisonLessEqual "sf::StencilComparison::LessEqual"
        SfStencilComparisonGreater "sf::StencilComparison::Greater"
        SfStencilComparisonGreaterEqual "sf::StencilComparison::GreaterEqual"
        SfStencilComparisonEqual "sf::StencilComparison::Equal"
        SfStencilComparisonNotEqual "sf::StencilComparison::NotEqual"
        SfStencilComparisonAlways "sf::StencilComparison::Always"

    cdef enum SfStencilUpdateOperation "sf::StencilUpdateOperation":
        SfStencilUpdateOperationKeep "sf::StencilUpdateOperation::Keep"
        SfStencilUpdateOperationZero "sf::StencilUpdateOperation::Zero"
        SfStencilUpdateOperationReplace "sf::StencilUpdateOperation::Replace"
        SfStencilUpdateOperationIncrement "sf::StencilUpdateOperation::Increment"
        SfStencilUpdateOperationDecrement "sf::StencilUpdateOperation::Decrement"
        SfStencilUpdateOperationInvert "sf::StencilUpdateOperation::Invert"

    cdef cppclass SfStencilValue "StencilValue":
        SfStencilValue(unsigned int)
        unsigned int value

    cdef cppclass SfStencilMode "StencilMode":
        SfStencilComparison stencilComparison
        SfStencilUpdateOperation stencilUpdateOperation
        SfStencilValue stencilReference
        SfStencilValue stencilMask
        bint stencilOnly

    cdef enum SfCoordinateType "sf::CoordinateType":
        SfCoordinateTypeNormalized "sf::CoordinateType::Normalized"
        SfCoordinateTypePixels "sf::CoordinateType::Pixels"

    cdef cppclass SfDrawable "Drawable":
        pass

    cdef cppclass SfTransform "Transform":
        SfTransform()
        SfTransform(float, float, float, float, float, float, float, float, float)
        const float* getMatrix() const
        SfTransform getInverse() const
        sf.Vector2f transformPoint(sf.Vector2f point) const
        SfFloatRect transformRect(const SfFloatRect& rectangle) const
        SfTransform& combine(const SfTransform& transform)
        SfTransform operator*(const SfTransform& transform)
        SfTransform& translate(sf.Vector2f offset)
        SfTransform& rotate(sf.Angle angle)
        SfTransform& rotate(sf.Angle angle, sf.Vector2f center)
        SfTransform& scale(sf.Vector2f factors)
        SfTransform& scale(sf.Vector2f factors, sf.Vector2f center)

    const SfTransform SfTransformIdentity "sf::Transform::Identity"

    cdef cppclass SfTransformable "Transformable":
        void setPosition(sf.Vector2f position)
        void setRotation(sf.Angle angle)
        void setScale(sf.Vector2f factors)
        void setOrigin(sf.Vector2f origin)
        sf.Vector2f getPosition() const
        sf.Angle getRotation() const
        sf.Vector2f getScale() const
        sf.Vector2f getOrigin() const
        void move(sf.Vector2f offset)
        void rotate(sf.Angle angle)
        void scale(sf.Vector2f factor)
        const SfTransform& getTransform() const
        const SfTransform& getInverseTransform() const

    cdef cppclass SfColor "Color":
        SfColor()
        SfColor(unsigned char, unsigned char, unsigned char, unsigned char)
        unsigned char r
        unsigned char g
        unsigned char b
        unsigned char a

    cdef cppclass SfImage "Image":
        SfImage()
        void resize(SfVector2u size)
        void resize(SfVector2u size, SfColor color)
        void resize(SfVector2u size, const unsigned char* pixels)
        bint loadFromFile(const string&)
        bint loadFromMemory(const void*, size_t)
        bint saveToFile(const string&) const
        void createMaskFromColor(SfColor color, unsigned char alpha)
        bint copy(const SfImage& source, SfVector2u dest, const SfIntRect& sourceRect, bint applyAlpha)
        void setPixel(SfVector2u coords, SfColor color)
        SfColor getPixel(SfVector2u coords) const
        const unsigned char* getPixelsPtr() const
        SfVector2u getSize() const
        void flipHorizontally()
        void flipVertically()

    cdef cppclass SfTexture "Texture":
        SfTexture()
        SfTexture(SfVector2u size, bint sRgb)
        SfVector2u getSize() const
        SfImage copyToImage() const
        void update(const unsigned char* pixels)
        void update(const unsigned char* pixels, SfVector2u size, SfVector2u dest)
        void update(const SfImage& image)
        void update(const SfImage& image, SfVector2u dest)
        void setSmooth(bint smooth)
        bint isSmooth() const
        bint isRepeated() const
        void setRepeated(bint repeated)
        bint isSrgb() const
        bint generateMipmap()
        unsigned int getNativeHandle() const

    cdef cppclass SfGlyph "Glyph":
        float advance
        int lsbDelta
        int rsbDelta
        SfFloatRect bounds
        SfIntRect textureRect

    cdef enum SfBlendFactor "sf::BlendMode::Factor":
        SfBlendFactorZero "sf::BlendMode::Factor::Zero"
        SfBlendFactorOne "sf::BlendMode::Factor::One"
        SfBlendFactorSrcColor "sf::BlendMode::Factor::SrcColor"
        SfBlendFactorOneMinusSrcColor "sf::BlendMode::Factor::OneMinusSrcColor"
        SfBlendFactorDstColor "sf::BlendMode::Factor::DstColor"
        SfBlendFactorOneMinusDstColor "sf::BlendMode::Factor::OneMinusDstColor"
        SfBlendFactorSrcAlpha "sf::BlendMode::Factor::SrcAlpha"
        SfBlendFactorOneMinusSrcAlpha "sf::BlendMode::Factor::OneMinusSrcAlpha"
        SfBlendFactorDstAlpha "sf::BlendMode::Factor::DstAlpha"
        SfBlendFactorOneMinusDstAlpha "sf::BlendMode::Factor::OneMinusDstAlpha"

    cdef enum SfBlendEquation "sf::BlendMode::Equation":
        SfBlendEquationAdd "sf::BlendMode::Equation::Add"
        SfBlendEquationSubtract "sf::BlendMode::Equation::Subtract"
        SfBlendEquationReverseSubtract "sf::BlendMode::Equation::ReverseSubtract"
        SfBlendEquationMin "sf::BlendMode::Equation::Min"
        SfBlendEquationMax "sf::BlendMode::Equation::Max"

    cdef cppclass SfBlendMode "BlendMode":
        SfBlendMode()
        SfBlendMode(SfBlendFactor colorSourceFactor,
                    SfBlendFactor colorDestinationFactor,
                    SfBlendEquation colorBlendEquation,
                    SfBlendFactor alphaSourceFactor,
                    SfBlendFactor alphaDestinationFactor,
                    SfBlendEquation alphaBlendEquation)
        SfBlendFactor colorSrcFactor
        SfBlendFactor colorDstFactor
        SfBlendEquation colorEquation
        SfBlendFactor alphaSrcFactor
        SfBlendFactor alphaDstFactor
        SfBlendEquation alphaEquation

    const SfBlendMode SfBlendAlpha "sf::BlendAlpha"
    const SfBlendMode SfBlendAdd "sf::BlendAdd"
    const SfBlendMode SfBlendMultiply "sf::BlendMultiply"
    const SfBlendMode SfBlendNone "sf::BlendNone"

    cdef cppclass SfFontInfo "Font::Info":
        string family

    cdef cppclass SfFont "Font":
        SfFont()
        bint openFromFile(const string&)
        bint openFromMemory(const void*, size_t)
        SfGlyph& getGlyph(unsigned int, unsigned int, bint, float outlineThickness) const
        int getKerning(unsigned int, unsigned int, unsigned int) const
        int getLineSpacing(unsigned int) const
        const SfTexture& getTexture(unsigned int) const
        const SfFontInfo& getInfo() const

    cdef cppclass SfShader "Shader":
        SfShader()

    cdef cppclass SfRenderStates "RenderStates":
        SfRenderStates()
        SfBlendMode blendMode
        SfStencilMode stencilMode
        SfTransform transform
        SfCoordinateType coordinateType
        const SfTexture* texture
        const SfShader* shader

    const SfRenderStates SfDefaultRenderStates "RenderStates::Default"

    cdef cppclass SfVertex "Vertex":
        SfVertex()
        sf.Vector2f position
        SfColor color
        sf.Vector2f texCoords

    cdef cppclass SfVertexArray "VertexArray"(SfDrawable):
        SfVertexArray()
        SfVertexArray(SfPrimitiveType type, size_t vertexCount)
        size_t getVertexCount() const
        SfVertex& operator[](size_t index)
        void clear()
        void resize(size_t vertexCount)
        void append(const SfVertex& vertex)
        void setPrimitiveType(SfPrimitiveType type)
        SfPrimitiveType getPrimitiveType() const
        SfFloatRect getBounds() const

    cdef cppclass SfVertexBuffer "sf::VertexBuffer"(SfDrawable):
        SfVertexBuffer()
        SfVertexBuffer(SfPrimitiveType type)
        SfVertexBuffer(SfVertexBufferUsage usage)
        SfVertexBuffer(SfPrimitiveType type, SfVertexBufferUsage usage)
        SfVertexBuffer(const SfVertexBuffer& copy)
        bint create(size_t vertexCount)
        size_t getVertexCount() const
        bint update(const SfVertex* vertices)
        bint update(const SfVertex* vertices, size_t vertexCount, unsigned int offset)
        bint update(const SfVertexBuffer& vertexBuffer)
        unsigned int getNativeHandle() const
        void setPrimitiveType(SfPrimitiveType type)
        SfPrimitiveType getPrimitiveType() const
        void setUsage(SfVertexBufferUsage usage)
        SfVertexBufferUsage getUsage() const

cdef extern from "SFML/Window/WindowEnums.hpp" namespace "sf::Style":
    cdef enum SfWindowStyle:
        SfWindowStyleNone "sf::Style::None"
        SfWindowStyleTitlebar "sf::Style::Titlebar"
        SfWindowStyleResize "sf::Style::Resize"
        SfWindowStyleClose "sf::Style::Close"
        SfWindowStyleDefault "sf::Style::Default"

cdef extern from "SFML/Graphics.hpp" namespace "sf":
    cdef cppclass SfView "View":
        SfView()
        SfView(const SfFloatRect& rectangle)
        void setCenter(sf.Vector2f center)
        void setSize(sf.Vector2f size)
        void setRotation(sf.Angle angle)
        void setViewport(const SfFloatRect& viewport)
        void setScissor(const SfFloatRect& scissor)
        sf.Vector2f getCenter() const
        sf.Vector2f getSize() const
        sf.Angle getRotation() const
        const SfFloatRect& getViewport() const
        const SfFloatRect& getScissor() const
        void move(sf.Vector2f offset)
        void rotate(sf.Angle angle)
        void zoom(float factor)
        const SfTransform& getTransform() const
        const SfTransform& getInverseTransform() const

    cdef cppclass SfWindow "Window":
        void display()

    cdef cppclass SfRenderTarget "RenderTarget":
        void clear()
        void clear(SfColor color)
        void clear(SfColor color, SfStencilValue stencilValue)
        void clearStencil(SfStencilValue stencilValue)
        void setView(const SfView& view)
        const SfView& getView() const
        const SfView& getDefaultView() const
        SfIntRect getViewport(const SfView& view) const
        SfIntRect getScissor(const SfView& view) const
        sf.Vector2f mapPixelToCoords(sf.Vector2i point) const
        sf.Vector2f mapPixelToCoords(sf.Vector2i point, const SfView& view) const
        sf.Vector2i mapCoordsToPixel(sf.Vector2f point) const
        sf.Vector2i mapCoordsToPixel(sf.Vector2f point, const SfView& view) const
        void draw(const SfDrawable& drawable)
        void draw(const SfDrawable& drawable, const SfRenderStates& states)
        void draw(const SfVertex* vertices, size_t vertexCount, SfPrimitiveType type)
        void draw(const SfVertex* vertices, size_t vertexCount, SfPrimitiveType type, const SfRenderStates& states)
        void draw(const SfVertexBuffer& vertexBuffer)
        void draw(const SfVertexBuffer& vertexBuffer, const SfRenderStates& states)
        void draw(const SfVertexBuffer& vertexBuffer, size_t firstVertex, size_t vertexCount, const SfRenderStates& states)
        SfVector2u getSize() const
        bint isSrgb() const
        bint setActive(bint active)
        void pushGLStates()
        void popGLStates()
        void resetGLStates()

    cdef cppclass SfRenderWindow "RenderWindow"(SfWindow, SfRenderTarget):
        SfRenderWindow()
        void create(sf.WindowHandle handle)
        void create(sf.WindowHandle handle, const sf.ContextSettings& settings)

    cdef cppclass SfRenderTexture "RenderTexture"(SfRenderTarget):
        SfRenderTexture()
        void setSmooth(bint smooth)
        bint isSmooth() const
        void setRepeated(bint repeated)
        bint isRepeated() const
        bint setActive(bint active)
        bint generateMipmap()
        bint isSrgb() const
        void display()
        const SfTexture& getTexture() const

    cdef cppclass SfSprite "Sprite"(SfDrawable, SfTransformable):
        SfSprite(const SfTexture& texture)
        SfSprite(const SfTexture& texture, const SfIntRect& rectangle)
        void setTexture(const SfTexture& texture, bint resetRect)
        void setTextureRect(const SfIntRect& rectangle)
        void setColor(SfColor color)
        const SfIntRect& getTextureRect() const
        SfColor getColor() const
        SfFloatRect getLocalBounds() const
        SfFloatRect getGlobalBounds() const

    cdef cppclass SfText "Text"(SfDrawable, SfTransformable):
        SfText(const SfFont& font, sf.String string, unsigned int characterSize)
        void setString(const sf.String& string)
        void setFont(const SfFont& font)
        void setCharacterSize(unsigned int size)
        void setLineSpacing(float spacingFactor)
        void setLetterSpacing(float spacingFactor)
        void setStyle(unsigned int style)
        void setFillColor(SfColor color)
        void setOutlineColor(SfColor color)
        void setOutlineThickness(float thickness)
        const sf.String& getString() const
        unsigned int getCharacterSize() const
        float getLetterSpacing() const
        float getLineSpacing() const
        unsigned int getStyle() const
        SfColor getFillColor() const
        SfColor getOutlineColor() const
        float getOutlineThickness() const
        sf.Vector2f findCharacterPos(size_t) const
        SfFloatRect getLocalBounds() const
        SfFloatRect getGlobalBounds() const

    cdef cppclass SfShape "Shape"(SfDrawable, SfTransformable):
        void setTexture(const SfTexture* texture, bint resetRect)
        void setTextureRect(const SfIntRect& rect)
        void setFillColor(SfColor color)
        void setOutlineColor(SfColor color)
        void setOutlineThickness(float thickness)
        const SfIntRect& getTextureRect() const
        SfColor getFillColor() const
        SfColor getOutlineColor() const
        float getOutlineThickness() const
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const
        SfFloatRect getLocalBounds() const
        SfFloatRect getGlobalBounds() const

    cdef cppclass SfCircleShape "CircleShape"(SfShape):
        SfCircleShape(float, size_t)
        void setRadius(float radius)
        float getRadius() const
        void setPointCount(size_t count)
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass SfConvexShape "ConvexShape"(SfShape):
        SfConvexShape(size_t)
        void setPointCount(size_t count)
        size_t getPointCount() const
        void setPoint(size_t index, sf.Vector2f point)
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass SfRectangleShape "RectangleShape"(SfShape):
        SfRectangleShape(const sf.Vector2f&)
        void setSize(sf.Vector2f size)
        sf.Vector2f getSize() const
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const

cdef extern from "pysfml/graphics/DerivableDrawable.hpp":
    cdef cppclass DerivableDrawable:
        DerivableDrawable(object)

    const unsigned char* getPixelsPtr(object)

cdef extern from "pysfml/graphics/DerivableRenderWindow.hpp":
    cdef cppclass DerivableRenderWindow:
        DerivableRenderWindow(object)

        void createWindow()
        void resizeWindow()

cdef extern from "pysfml/window/compat.hpp" namespace "pysfml::window_compat":
    void createRenderWindow(SfRenderWindow& window, sf.VideoMode mode, const sf.String& title, unsigned int style, const sf.ContextSettings& settings)

cdef extern from "SFML/Graphics/Texture.hpp" namespace "sf::Texture":
    unsigned int getMaximumSize()
    void bind(const SfTexture* texture, SfCoordinateType coordinateType)

cdef extern from "SFML/Graphics/VertexBuffer.hpp":
    void bindVertexBuffer "sf::VertexBuffer::bind"(const SfVertexBuffer* vertexBuffer)
    bint vertexBufferIsAvailable "sf::VertexBuffer::isAvailable"()

cdef extern from "pysfml/graphics/shader_compat.hpp" namespace "pysfml::graphics_compat":
    cdef enum ShaderType:
        ShaderTypeVertex "pysfml::graphics_compat::Vertex"
        ShaderTypeGeometry "pysfml::graphics_compat::Geometry"
        ShaderTypeFragment "pysfml::graphics_compat::Fragment"

    bint loadShaderFromFile(SfShader& shader, const string& filename, int type)
    bint loadShaderFromFile(SfShader& shader, const string& vertex, const string& fragment)
    bint loadShaderFromMemory(SfShader& shader, const char* source, int type)
    bint loadShaderFromMemory(SfShader& shader, const char* vertex, const char* fragment)
    bint loadTextureFromFile(SfTexture& texture, const string& filename)
    bint loadTextureFromFile(SfTexture& texture, const string& filename, bint sRgb)
    bint loadTextureFromFile(SfTexture& texture, const string& filename, const SfIntRect& area)
    bint loadTextureFromFile(SfTexture& texture, const string& filename, bint sRgb, const SfIntRect& area)
    bint loadTextureFromMemory(SfTexture& texture, const void* data, size_t size)
    bint loadTextureFromMemory(SfTexture& texture, const void* data, size_t size, bint sRgb)
    bint loadTextureFromMemory(SfTexture& texture, const void* data, size_t size, const SfIntRect& area)
    bint loadTextureFromMemory(SfTexture& texture, const void* data, size_t size, bint sRgb, const SfIntRect& area)
    bint loadTextureFromImage(SfTexture& texture, const SfImage& image)
    bint loadTextureFromImage(SfTexture& texture, const SfImage& image, bint sRgb)
    bint loadTextureFromImage(SfTexture& texture, const SfImage& image, const SfIntRect& area)
    bint loadTextureFromImage(SfTexture& texture, const SfImage& image, bint sRgb, const SfIntRect& area)
    void updateTextureFromImage(SfTexture& texture, const SfImage& image)
    void updateTextureFromImage(SfTexture& texture, const SfImage& image, SfVector2u dest)
    void updateTextureFromWindow(SfTexture& texture, const sf.Window& window)
    void updateTextureFromWindow(SfTexture& texture, const sf.Window& window, sf.Vector2u dest)
    void shaderSetUniform(SfShader& shader, const char* name, float x)
    void shaderSetUniform(SfShader& shader, const char* name, float x, float y)
    void shaderSetUniform(SfShader& shader, const char* name, float x, float y, float z)
    void shaderSetUniform(SfShader& shader, const char* name, float x, float y, float z, float w)
    void shaderSetUniformVec2(SfShader& shader, const char* name, float x, float y)
    void shaderSetUniformVec3(SfShader& shader, const char* name, float x, float y, float z)
    void shaderSetUniformColor(SfShader& shader, const char* name, const SfColor& color)
    void shaderSetUniformTransform(SfShader& shader, const char* name, const SfTransform& transform)
    void shaderSetUniformTexture(SfShader& shader, const char* name, const SfTexture& texture)
    void shaderSetUniformCurrentTexture(SfShader& shader, const char* name)
    void bindShader(const SfShader* shader)
    bint shaderIsAvailable()
    void resetView(SfView& view, const SfFloatRect& rectangle)
    bint resizeRenderTexture(SfRenderTexture& texture, SfVector2u size, bint depthBuffer, bint sRgb)

from libc.stdlib cimport malloc, free

__all__ = ['Factor', 'Equation', 'StencilComparison', 'StencilUpdateOperation',
            'StencilValue', 'StencilMode', 'CoordinateType', 'BlendMode',
            'PrimitiveType', 'Color', 'Rect', 'Transform', 'Image', 'Texture',
            'Glyph', 'Font', 'Shader', 'CurrentTexture', 'RenderStates',
            'Drawable', 'Transformable', 'TransformableDrawable', 'Sprite',
            'TextStyle', 'Text', 'Shape', 'CircleShape', 'ConvexShape',
            'RectangleShape', 'Vertex', 'VertexArray', 'VertexBufferUsage',
            'VertexBuffer', 'View', 'RenderTarget',
            'RenderTexture', 'RenderWindow']

__all__ += ['BLEND_ALPHA', 'BLEND_ADD', 'BLEND_MULTIPLY', 'BLEND_NONE']

string_type = [bytes, str]
numeric_type = [int, float]

import sys
from copy import copy, deepcopy
from enum import IntEnum

from pysfml.system cimport Vector2, Vector3
from pysfml.system cimport to_vector2i, to_vector2f
from pysfml.system cimport to_string, wrap_string
from pysfml.system cimport popLastErrorMessage, import_sfml__system
from pysfml.window cimport VideoMode, ContextSettings, Window

import sfml.system as sf_system

import_sfml__system()


cdef inline sf.Angle to_rotation_angle(object angle):
    if isinstance(angle, sf_system.Angle):
        return sf.radians(<float>angle.radians)

    if isinstance(angle, int) or isinstance(angle, float):
        return sf.degrees(<float>angle)

    raise TypeError("angle must be an sfml.system.Angle or a number of degrees")


cdef inline object wrap_rotation_angle(sf.Angle angle):
    return sf_system.radians(angle.asRadians())

class PrimitiveType:
    POINTS = SfPrimitiveTypePoints
    LINES = SfPrimitiveTypeLines
    LINES_STRIP = SfPrimitiveTypeLineStrip
    TRIANGLES = SfPrimitiveTypeTriangles
    TRIANGLES_STRIP = SfPrimitiveTypeTriangleStrip
    TRIANGLES_FAN = SfPrimitiveTypeTriangleFan


cdef public class Rect[type PyRectType, object PyRectObject]:
    cdef public object left
    cdef public object top
    cdef public object width
    cdef public object height

    def __init__(self, position=(0, 0), size=(0, 0)):
        left, top = position
        width, height = size
        self.left = left
        self.top = top
        self.width = width
        self.height = height

    def __repr__(self):
        return "Rect(position={0}, size={1})".format(self.position, self.size)

    def __str__(self):
        return "({0}, {1}, {2}, {3})".format(self.left, self.top, self.width, self.height)

    def __richcmp__(Rect self, other_, op):
        cdef Rect other

        if isinstance(other_, Rect):
            other = <Rect>other_
        else:
            left, top, width, height = other_
            other = Rect((left, top), (width, height))

        if op == 2:
            return tuple(self) == tuple(other)
        elif op == 3:
            return tuple(self) != tuple(other)
        else:
            return NotImplemented

    def __iter__(self):
        return iter((self.left, self.top, self.width, self.height))

    def __copy__(self):
        return Rect(self.position, self.size)

    property position:
        def __get__(self):
            return Vector2(self.left, self.top)

        def __set__(self, position):
            self.left, self.top = position

    property size:
        def __get__(self):
            return Vector2(self.width, self.height)

        def __set__(self, size):
            self.width, self.height = size

    def contains(self, point):
        if isinstance(point, Vector2):
            point = (<Vector2>point).x, (<Vector2>point).y

        x, y = point
        return self.left <= x < self.left + self.width and self.top <= y < self.top + self.height

    def find_intersection(self, rectangle):
        cdef Rect other

        if isinstance(rectangle, Rect):
            other = <Rect>rectangle
        else:
            left, top, width, height = rectangle
            other = Rect((left, top), (width, height))

        left = max(self.left, other.left)
        top = max(self.top, other.top)
        right = min(self.left + self.width, other.left + other.width)
        bottom = min(self.top + self.height, other.top + other.height)

        if right <= left or bottom <= top:
            return None

        return Rect((left, top), (right - left, bottom - top))

    def intersects(self, rectangle):
        cdef object intersection = self.find_intersection(rectangle)

        if intersection is None:
            return Rect()

        return intersection

cdef api Rect wrap_intrect(sf.IntRect* p):
    cdef Rect r = Rect.__new__(Rect)
    r.left = p[0].position.x
    r.top = p[0].position.y
    r.width = p[0].size.x
    r.height = p[0].size.y
    return r

cdef api Rect wrap_floatrect(sf.FloatRect* p):
    cdef Rect r = Rect.__new__(Rect)
    r.left = p[0].position.x
    r.top = p[0].position.y
    r.width = p[0].size.x
    r.height = p[0].size.y
    return r

cdef api sf.FloatRect to_floatrect(rectangle):
    l, t, w, h = rectangle
    return SfFloatRect(sf.Vector2f(l, t), sf.Vector2f(w, h))

cdef api sf.IntRect to_intrect(rectangle):
    l, t, w, h = rectangle
    return SfIntRect(sf.Vector2i(l, t), sf.Vector2i(w, h))

cdef public class Color [type PyColorType, object PyColorObject]:
    BLACK = Color(0, 0, 0)
    WHITE = Color(255, 255, 255)
    RED = Color(255, 0, 0)
    GREEN = Color(0, 255, 0)
    BLUE = Color(0, 0, 255)
    YELLOW = Color(255, 255, 0)
    MAGENTA = Color(255, 0, 255)
    CYAN = Color(0, 255, 255)
    TRANSPARENT = Color(0, 0, 0, 0)

    cdef SfColor *p_this

    def __cinit__(self, unsigned char r=0, unsigned char g=0, unsigned char b=0, unsigned char a=255):
        self.p_this = new SfColor(r, g, b, a)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "Color(red={0}, green={1}, blue={2}, alpha={3})".format(self.r, self.g, self.b, self.a)

    def __str__(self):
        return "(R={0}, G={1}, B={2}, A={3})".format(self.r, self.g, self.b, self.a)

    def __int__(self):
        return ((self.r << 24) | (self.g << 16) | (self.b << 8) | self.a)

    def __index__(self):
        return int(self)

    def __iter__(self):
        return iter((self.r, self.g, self.b, self.a))

    def __richcmp__(Color x, Color y, int op):
        if op == 2:
            return tuple(x) == tuple(y)
        elif op == 3:
            return tuple(x) != tuple(y)
        else:
            return NotImplemented

    def __add__(Color x, Color y):
        r = Color(0, 0, 0)
        r.r = min(255, x.r + y.r)
        r.g = min(255, x.g + y.g)
        r.b = min(255, x.b + y.b)
        r.a = min(255, x.a + y.a)
        return r

    def __mul__(Color x, Color y):
        r = Color(0, 0, 0)
        r.r = (x.r * y.r) // 255
        r.g = (x.g * y.g) // 255
        r.b = (x.b * y.b) // 255
        r.a = (x.a * y.a) // 255
        return r

    def __iadd__(self, Color x):
        self.r = min(255, self.r + x.r)
        self.g = min(255, self.g + x.g)
        self.b = min(255, self.b + x.b)
        self.a = min(255, self.a + x.a)
        return self

    def __imul__(self, Color x):
        self.r = (self.r * x.r) // 255
        self.g = (self.g * x.g) // 255
        self.b = (self.b * x.b) // 255
        self.a = (self.a * x.a) // 255
        return self

    property r:
        def __get__(self):
            return self.p_this.r

        def __set__(self, unsigned char r):
            self.p_this.r = r

    property g:
        def __get__(self):
            return self.p_this.g

        def __set__(self, unsigned char g):
            self.p_this.g = g

    property b:
        def __get__(self):
            return self.p_this.b

        def __set__(self, unsigned char b):
            self.p_this.b = b

    property a:
        def __get__(self):
            return self.p_this.a

        def __set__(self, unsigned int a):
            self.p_this.a = a

    def __copy__(self):
        cdef Color p = Color.__new__(Color)
        p.r, p.g, p.b, p.a = self
        return p

cdef api Color wrap_color(sf.Color *p):
    cdef Color r = Color.__new__(Color)
    r.p_this = <SfColor*>p
    return r


cdef class Transform:
    cdef SfTransform *p_this
    cdef bint          delete_this

    IDENTITY = wrap_transform(<SfTransform*>&SfTransformIdentity)

    def __init__(self):
        self.p_this = new SfTransform()
        self.delete_this = True

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        cdef float *p = <float*>self.p_this.getMatrix()
        return "Transform({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8})".format(
                            p[0], p[4], p[12], p[1], p[5], p[13], p[3], p[7], p[15])

    def __str__(self):
        cdef float *p = <float*>self.p_this.getMatrix()
        return "[{0}, {1}, {2}]\n[{3}, {4}, {5}]\n[{6}, {7}, {8}]".format(
                            str(p[0])[:3], str(p[4])[:3], str(p[12])[:3],
                            str(p[1])[:3], str(p[5])[:3], str(p[13])[:3],
                            str(p[3])[:3], str(p[7])[:3], str(p[15])[:3])

    def __mul__(Transform x, Transform y):
        r = Transform()
        r.p_this[0] = x.p_this[0] * y.p_this[0]
        return r

    def __imul__(self, Transform x):
        self.p_this[0] = self.p_this[0] * x.p_this[0]
        return self

    @classmethod
    def from_values(cls, float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22):
        cdef Transform r = Transform.__new__(Transform)
        r.p_this = new SfTransform(a00, a01, a02, a10, a11, a12, a20, a21, a22)
        r.delete_this = True
        return r

    property matrix:
        def __get__(self):
            return <long>self.p_this.getMatrix()

    property inverse:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_this.getInverse()
            return wrap_transform(p)

    def transform_point(self, point):
        cdef sf.Vector2f p = self.p_this.transformPoint(to_vector2f(point))
        return Vector2(p.x, p.y)

    def transform_rectangle(self, rectangle):
        cdef SfFloatRect p = self.p_this.transformRect(to_floatrect(rectangle))
        return Rect((p.position.x, p.position.y), (p.size.x, p.size.y))

    def combine(self, Transform transform):
        self.p_this.combine(transform.p_this[0])
        return self

    def translate(self, offset):
        self.p_this.translate(to_vector2f(offset))
        return self

    def rotate(self, angle, center=None):
        if not center:
            self.p_this.rotate(to_rotation_angle(angle))
        else:
            self.p_this.rotate(to_rotation_angle(angle), to_vector2f(center))

        return self

    def scale(self, factor, center=None):
        if not center:
            self.p_this.scale(to_vector2f(factor))
        else:
            self.p_this.scale(to_vector2f(factor), to_vector2f(center))

        return self

cdef Transform wrap_transform(SfTransform *p, bint d=True):
    cdef Transform r = Transform.__new__(Transform)
    r.p_this = p
    r.delete_this = d
    return r

class Factor(IntEnum):
    ZERO = SfBlendFactorZero
    ONE = SfBlendFactorOne
    SRC_COLOR = SfBlendFactorSrcColor
    ONE_MINUS_SRC_COLOR = SfBlendFactorOneMinusSrcColor
    DST_COLOR = SfBlendFactorDstColor
    ONE_MINUS_DST_COLOR = SfBlendFactorOneMinusDstColor
    SRC_ALPHA = SfBlendFactorSrcAlpha
    ONE_MINUS_SRC_ALPHA = SfBlendFactorOneMinusSrcAlpha
    DST_ALPHA = SfBlendFactorDstAlpha
    ONE_MINUS_DST_ALPHA = SfBlendFactorOneMinusDstAlpha

class Equation(IntEnum):
    ADD = SfBlendEquationAdd
    SUBTRACT = SfBlendEquationSubtract


class StencilComparison(IntEnum):
    NEVER = SfStencilComparisonNever
    LESS = SfStencilComparisonLess
    LESS_EQUAL = SfStencilComparisonLessEqual
    GREATER = SfStencilComparisonGreater
    GREATER_EQUAL = SfStencilComparisonGreaterEqual
    EQUAL = SfStencilComparisonEqual
    NOT_EQUAL = SfStencilComparisonNotEqual
    ALWAYS = SfStencilComparisonAlways


class StencilUpdateOperation(IntEnum):
    KEEP = SfStencilUpdateOperationKeep
    ZERO = SfStencilUpdateOperationZero
    REPLACE = SfStencilUpdateOperationReplace
    INCREMENT = SfStencilUpdateOperationIncrement
    DECREMENT = SfStencilUpdateOperationDecrement
    INVERT = SfStencilUpdateOperationInvert

cdef public class BlendMode[type PyBlendModeType, object PyBlendModeObject]:
    cdef SfBlendMode *p_this

    def __cinit__(self,
        int color_source_factor = 6,
        int color_destination_factor = 7,
        int color_blend_equation = 0,
        int alpha_source_factor = 1,
        int alpha_destination_factor = 7,
        int alpha_blend_equation = 0):
        self.p_this = new SfBlendMode(<SfBlendFactor>color_source_factor,
            <SfBlendFactor>color_destination_factor,
            <SfBlendEquation>color_blend_equation,
            <SfBlendFactor>alpha_source_factor,
            <SfBlendFactor>alpha_destination_factor,
            <SfBlendEquation>alpha_blend_equation)

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "BlendMode({0}, {1}, {2}, {3}, {4}, {5})".format(self.color_src_factor, self.color_dst_factor, self.color_equation,
            self.alpha_src_factor, self.alpha_dst_factor, self.alpha_equation)

    def __richcmp__(BlendMode x, BlendMode y, int op):
        if op == 2:
            return (
                x.p_this[0].colorSrcFactor == y.p_this[0].colorSrcFactor and
                x.p_this[0].colorDstFactor == y.p_this[0].colorDstFactor and
                x.p_this[0].colorEquation == y.p_this[0].colorEquation and
                x.p_this[0].alphaSrcFactor == y.p_this[0].alphaSrcFactor and
                x.p_this[0].alphaDstFactor == y.p_this[0].alphaDstFactor and
                x.p_this[0].alphaEquation == y.p_this[0].alphaEquation
            )
        elif op == 3:
            return (
                x.p_this[0].colorSrcFactor != y.p_this[0].colorSrcFactor or
                x.p_this[0].colorDstFactor != y.p_this[0].colorDstFactor or
                x.p_this[0].colorEquation != y.p_this[0].colorEquation or
                x.p_this[0].alphaSrcFactor != y.p_this[0].alphaSrcFactor or
                x.p_this[0].alphaDstFactor != y.p_this[0].alphaDstFactor or
                x.p_this[0].alphaEquation != y.p_this[0].alphaEquation
            )

        raise NotImplementedError

    property color_src_factor:
        def __get__(self):
            return <int>self.p_this[0].colorSrcFactor

        def __set__(self, int color_src_factor):
            self.p_this[0].colorSrcFactor = <SfBlendFactor>color_src_factor

    property color_dst_factor:
        def __get__(self):
            return <int>self.p_this[0].colorDstFactor

        def __set__(self, int color_dst_factor):
            self.p_this[0].colorDstFactor = <SfBlendFactor>color_dst_factor

    property color_equation:
        def __get__(self):
            return <int>self.p_this[0].colorEquation

        def __set__(self, int color_equation):
            self.p_this[0].colorEquation = <SfBlendEquation>color_equation

    property alpha_src_factor:
        def __get__(self):
            return <int>self.p_this[0].alphaSrcFactor

        def __set__(self, int alpha_src_factor):
            self.p_this[0].alphaSrcFactor = <SfBlendFactor>alpha_src_factor

    property alpha_dst_factor:
        def __get__(self):
            return <int>self.p_this[0].alphaDstFactor

        def __set__(self, int alpha_dst_factor):
            self.p_this[0].alphaDstFactor = <SfBlendFactor>alpha_dst_factor

    property alpha_equation:
        def __get__(self):
            return <int>self.p_this[0].alphaEquation

        def __set__(self, int alpha_equation):
            self.p_this[0].alphaEquation = <SfBlendEquation>alpha_equation

cdef api BlendMode wrap_blendmode(sf.BlendMode *p):
    cdef BlendMode blendmode = BlendMode()
    blendmode.p_this[0] = (<SfBlendMode*>p)[0]
    return blendmode

BLEND_ALPHA = wrap_blendmode(<sf.BlendMode*>&SfBlendAlpha)
BLEND_ADD = wrap_blendmode(<sf.BlendMode*>&SfBlendAdd)
BLEND_MULTIPLY = wrap_blendmode(<sf.BlendMode*>&SfBlendMultiply)
BLEND_NONE = wrap_blendmode(<sf.BlendMode*>&SfBlendNone)

cdef public class Image[type PyImageType, object PyImageObject]:
    cdef SfImage *p_this

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "Image(size={0})".format(self.size)

    def __getitem__(self, tuple v):
        cdef SfColor *p = new SfColor()
        p[0] = self.p_this.getPixel(SfVector2u(v[0], v[1]))
        return wrap_color(<sf.Color*>p)

    def __setitem__(self, tuple k, Color v):
        self.p_this.setPixel(SfVector2u(k[0], k[1]), v.p_this[0])

    def __copy__(self):
        cdef SfImage *p = new SfImage()
        p[0] = self.p_this[0]
        return wrap_image(<sf.Image*>p)

    def __getbuffer__(self, Py_buffer *buffer, int flags):
        buffer.buf = <char*>self.p_this.getPixelsPtr()
        buffer.format = 'c'
        buffer.internal = NULL
        buffer.itemsize = 1
        buffer.len = self.p_this.getSize().x * self.p_this.getSize().y * 4
        buffer.ndim = 1
        buffer.obj = self
        buffer.readonly = 1
        buffer.shape = NULL
        buffer.strides = NULL
        buffer.suboffsets = NULL

    def __releasebuffer__(self, Py_buffer *buffer):
        pass

    @classmethod
    def create(cls, unsigned int width, unsigned int height, Color color=None):
        cdef SfImage *p = new SfImage()

        if not color:
            p.resize(SfVector2u(width, height))
        else:
            p.resize(SfVector2u(width, height), color.p_this[0])

        return wrap_image(<sf.Image*>p)

    @classmethod
    def from_size(cls, unsigned int width, unsigned int height, Color color=None):
        cdef SfImage *p = new SfImage()

        if not color:
            p.resize(SfVector2u(width, height))
        else:
            p.resize(SfVector2u(width, height), color.p_this[0])

        return wrap_image(<sf.Image*>p)

    @classmethod
    def from_pixels(cls, int width, int height, pixels):
        cdef SfImage *p = new SfImage()
        cdef const unsigned char* pixels_ptr = getPixelsPtr(memoryview(pixels))

        p.resize(SfVector2u(width, height), pixels_ptr)
        return wrap_image(<sf.Image*>p)

    @classmethod
    def from_file(cls, basestring filename):
        cdef SfImage *p = new SfImage()

        if p.loadFromFile(filename.encode('UTF-8')):
            return wrap_image(<sf.Image*>p)

        del p
        raise IOError(popLastErrorMessage())

    @classmethod
    def from_memory(cls, bytes data):
        cdef SfImage *p = new SfImage()

        if p.loadFromMemory(<char*>data, len(data)):
            return wrap_image(<sf.Image*>p)

        del p
        raise IOError(popLastErrorMessage())

    def to_file(self, basestring filename):
        if not self.p_this.saveToFile(filename.encode('UTF-8')):
            raise IOError(popLastErrorMessage())

    property size:
        def __get__(self):
            return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

    property width:
        def __get__(self):
            return self.size.x

    property height:
        def __get__(self):
            return self.size.y

    def create_mask_from_color(self, Color color, unsigned char alpha=0):
        self.p_this.createMaskFromColor(color.p_this[0], alpha)

    def blit(self, Image source, dest, source_rect=None, bint apply_alpha=False):
        x, y = dest

        if not source_rect:
            self.p_this.copy(source.p_this[0], SfVector2u(x, y), to_intrect((0, 0, 0, 0)), apply_alpha)
        else:
            self.p_this.copy(source.p_this[0], SfVector2u(x, y), to_intrect(source_rect), apply_alpha)

    property pixels:
        def __get__(self):
            return memoryview(self)

    def flip_horizontally(self):
        self.p_this.flipHorizontally()

    def flip_vertically(self):
        self.p_this.flipVertically()


cdef api Image wrap_image(sf.Image *p):
    cdef Image r = Image.__new__(Image)
    r.p_this = <SfImage*>p
    return r

class CoordinateType(IntEnum):
    NORMALIZED = SfCoordinateTypeNormalized
    PIXELS = SfCoordinateTypePixels


class VertexBufferUsage(IntEnum):
    STREAM = SfVertexBufferUsageStream
    DYNAMIC = SfVertexBufferUsageDynamic
    STATIC = SfVertexBufferUsageStatic


cdef inline unsigned int to_stencil_uint(value):
    if isinstance(value, StencilValue):
        return (<StencilValue>value).p_this[0].value

    return <unsigned int>value


cdef class StencilValue:
    cdef SfStencilValue *p_this
    cdef bint delete_this

    def __init__(self, unsigned int value=0):
        self.p_this = new SfStencilValue(value)
        self.delete_this = True

    def __dealloc__(self):
        if self.delete_this and self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "StencilValue({0})".format(self.value)

    def __int__(self):
        return self.p_this.value

    def __index__(self):
        return self.p_this.value

    def __richcmp__(StencilValue self, other, int op):
        cdef unsigned int other_value

        if isinstance(other, StencilValue):
            other_value = (<StencilValue>other).p_this.value
        else:
            other_value = <unsigned int>other

        if op == 2:
            return self.p_this.value == other_value
        elif op == 3:
            return self.p_this.value != other_value

        return NotImplemented

    property value:
        def __get__(self):
            return self.p_this.value

        def __set__(self, unsigned int value):
            self.p_this.value = value


cdef StencilValue wrap_stencilvalue(SfStencilValue *p, bint d=True):
    cdef StencilValue r = StencilValue.__new__(StencilValue)
    r.p_this = p
    r.delete_this = d
    return r


cdef class StencilMode:
    cdef SfStencilMode *p_this
    cdef bint delete_this

    def __init__(self,
                 int comparison=<int>StencilComparison.ALWAYS,
                 int update_operation=<int>StencilUpdateOperation.KEEP,
                 reference=0,
                 mask=0xFFFFFFFF,
                 bint stencil_only=False):
        self.p_this = new SfStencilMode()
        self.delete_this = True
        self.comparison = comparison
        self.update_operation = update_operation
        self.reference = reference
        self.mask = mask
        self.stencil_only = stencil_only

    def __dealloc__(self):
        if self.delete_this and self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "StencilMode(comparison={0}, update_operation={1}, reference={2}, mask={3}, stencil_only={4})".format(
            self.comparison, self.update_operation, self.reference, self.mask, self.stencil_only)

    def __richcmp__(StencilMode self, other, int op):
        cdef StencilMode other_mode

        if not isinstance(other, StencilMode):
            return NotImplemented

        other_mode = <StencilMode>other

        if op == 2:
            return (
                self.p_this[0].stencilComparison == other_mode.p_this[0].stencilComparison and
                self.p_this[0].stencilUpdateOperation == other_mode.p_this[0].stencilUpdateOperation and
                self.p_this[0].stencilReference.value == other_mode.p_this[0].stencilReference.value and
                self.p_this[0].stencilMask.value == other_mode.p_this[0].stencilMask.value and
                self.p_this[0].stencilOnly == other_mode.p_this[0].stencilOnly
            )
        elif op == 3:
            return not self.__richcmp__(other, 2)

        return NotImplemented

    property comparison:
        def __get__(self):
            return <int>self.p_this[0].stencilComparison

        def __set__(self, int comparison):
            self.p_this[0].stencilComparison = <SfStencilComparison>comparison

    property update_operation:
        def __get__(self):
            return <int>self.p_this[0].stencilUpdateOperation

        def __set__(self, int update_operation):
            self.p_this[0].stencilUpdateOperation = <SfStencilUpdateOperation>update_operation

    property reference:
        def __get__(self):
            return wrap_stencilvalue(&self.p_this[0].stencilReference, False)

        def __set__(self, reference):
            self.p_this[0].stencilReference = SfStencilValue(to_stencil_uint(reference))

    property mask:
        def __get__(self):
            return wrap_stencilvalue(&self.p_this[0].stencilMask, False)

        def __set__(self, mask):
            self.p_this[0].stencilMask = SfStencilValue(to_stencil_uint(mask))

    property stencil_only:
        def __get__(self):
            return self.p_this[0].stencilOnly

        def __set__(self, bint stencil_only):
            self.p_this[0].stencilOnly = stencil_only


cdef StencilMode wrap_stencilmode(SfStencilMode *p, bint d=True):
    cdef StencilMode r = StencilMode.__new__(StencilMode)
    r.p_this = p
    r.delete_this = d
    return r

cdef public class Texture[type PyTextureType, object PyTextureObject]:
    cdef SfTexture *p_this
    cdef bint delete_this

    cdef object __weakref__

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        return "Texture(size={0}, smooth={1}, repeated={2}, srgb={3})".format(self.size, self.smooth, self.repeated, self.srgb)

    def __copy__(self):
        cdef SfTexture *p = new SfTexture()
        p[0] = self.p_this[0]
        return wrap_texture(<sf.Texture*>p, True)

    @classmethod
    def create(cls, unsigned int width, unsigned int height, bint srgb=False):
        cdef SfTexture *p = new SfTexture(SfVector2u(width, height), srgb)
        return wrap_texture(<sf.Texture*>p, True)

    @classmethod
    def from_size(cls, unsigned int width, unsigned int height, bint srgb=False):
        cdef SfTexture *p = new SfTexture(SfVector2u(width, height), srgb)
        return wrap_texture(<sf.Texture*>p, True)

    @classmethod
    def from_file(cls, basestring filename, area=None, bint srgb=False):
        cdef SfTexture *p = new SfTexture()

        if not area:
            if loadTextureFromFile(p[0], filename.encode('UTF-8'), srgb):
                return wrap_texture(<sf.Texture*>p, True)
        else:
            if loadTextureFromFile(p[0], filename.encode('UTF-8'), srgb, to_intrect(area)):
                return wrap_texture(<sf.Texture*>p, True)

        del p
        raise IOError(popLastErrorMessage())

    @classmethod
    def from_memory(cls, bytes data, area=None, bint srgb=False):
        cdef SfTexture *p = new SfTexture()

        if not area:
            if loadTextureFromMemory(p[0], <char*>data, len(data), srgb):
                return wrap_texture(<sf.Texture*>p, True)
        else:
            if loadTextureFromMemory(p[0], <char*>data, len(data), srgb, to_intrect(area)):
                return wrap_texture(<sf.Texture*>p, True)

        del p
        raise IOError(popLastErrorMessage())

    @classmethod
    def from_image(cls, Image image, area=None, bint srgb=False):
        cdef SfTexture *p = new SfTexture()

        if not area:
            if loadTextureFromImage(p[0], image.p_this[0], srgb):
                return wrap_texture(<sf.Texture*>p, True)
        else:
            if loadTextureFromImage(p[0], image.p_this[0], srgb, to_intrect(area)):
                return wrap_texture(<sf.Texture*>p, True)

        del p
        raise IOError(popLastErrorMessage())

    property size:
        def __get__(self):
            return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

        def __set__(self, size):
            raise NotImplemented

    property width:
        def __get__(self):
            return self.size.x

        def __set__(self, width):
            raise NotImplemented

    property height:
        def __get__(self):
            return self.size.y

        def __set__(self, height):
            raise NotImplemented

    def copy_to_image(self):
        cdef SfImage *p = new SfImage()
        p[0] = self.p_this.copyToImage()
        return wrap_image(<sf.Image*>p)

    def to_image(self):
        cdef SfImage *p = new SfImage()
        p[0] = self.p_this.copyToImage()
        return wrap_image(<sf.Image*>p)

    def update(self, *args, **kwargs):
        if len(args) == 0:
            raise UserWarning("No arguments provided. It requires at least one.")

        if len(args) > 2:
            raise UserWarning("Too much arguments provided. It requires at most two.")

        if type(args[0]) is Image:
            if len(args) == 2:
                if type(args[1]) in [Vector2, tuple]:
                    self.update_from_image(args[0], args[1])
                else:
                    raise UserWarning("The second argument must be either a sf.Vector2 or a tuple")
            else:
                self.update_from_image(args[0])

        elif isinstance(args[0], Window):
            if len(args) == 2:
                if type(args[1]) in [Vector2, tuple]:
                    self.update_from_window(args[0], args[1])
                else:
                    raise UserWarning("The second argument must be either a sf.Vector2 or a tuple")
            else:
                self.update_from_window(args[0])

        else:
            raise UserWarning("The first argument must be either sf.Pixels, sf.Image or sf.Window")

    def update_from_pixels(self, pixels, *args):
        cdef const unsigned char* pixels_ptr = getPixelsPtr(memoryview(pixels))

        if not args:
            self.p_this.update(pixels_ptr)
        else:
            width, height, x, y = args
            self.p_this.update(pixels_ptr, SfVector2u(width, height), SfVector2u(x, y))

    def update_from_image(self, Image image, position=None):
        if not position:
            updateTextureFromImage(self.p_this[0], image.p_this[0])
        else:
            x, y = position
            updateTextureFromImage(self.p_this[0], image.p_this[0], SfVector2u(x, y))

    def update_from_window(self, Window window, position=None):
        if not position:
            updateTextureFromWindow(self.p_this[0], window.p_window[0])
        else:
            x, y = position
            updateTextureFromWindow(self.p_this[0], window.p_window[0], sf.Vector2u(x, y))

    @staticmethod
    def bind(Texture texture=None, int coordinate_type=0):
        if not texture:
            bind(NULL, <SfCoordinateType>coordinate_type)
        else:
            bind(<const SfTexture*>texture.p_this, <SfCoordinateType>coordinate_type)

    property smooth:
        def __get__(self):
            return self.p_this.isSmooth()

        def __set__(self, bint smooth):
            self.p_this.setSmooth(smooth)

    property repeated:
        def __get__(self):
            return self.p_this.isRepeated()

        def __set__(self, bint repeated):
            self.p_this.setRepeated(repeated)

    property srgb:
        def __get__(self):
            return self.p_this.isSrgb()

    def generate_mipmap(self):
        return self.p_this.generateMipmap()

    property native_handle:
        def __get__(self):
            return self.p_this.getNativeHandle()

    @staticmethod
    def get_maximum_size():
        return getMaximumSize()


cdef api Texture wrap_texture(sf.Texture *p, bint d):
    cdef Texture r = Texture.__new__(Texture)
    r.p_this = <SfTexture*>p
    r.delete_this = d
    return r


cdef class Glyph:
    cdef SfGlyph *p_this

    def __init__(self):
        self.p_this = new SfGlyph()

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "Glyph(advance={0}, bounds={1}, texture_rectangle={2})".format(self.advance, self.bounds, self.texture_rectangle)

    property advance:
        def __get__(self):
            return self.p_this[0].advance

        def __set__(self, float advance):
            self.p_this[0].advance = advance

    property bounds:
        def __get__(self):
            return wrap_floatrect(&self.p_this[0].bounds)

        def __set__(self, bounds):
            self.p_this[0].bounds = to_floatrect(bounds)

    property texture_rectangle:
        def __get__(self):
            return wrap_intrect(&self.p_this[0].textureRect)

        def __set__(self, texture_rectangle):
            self.p_this[0].textureRect = to_intrect(texture_rectangle)

cdef Glyph wrap_glyph(SfGlyph *p):
    cdef Glyph r = Glyph.__new__(Glyph)
    r.p_this = p
    return r

cdef class Font:
    cdef SfFont *p_this
    cdef bint     delete_this
    cdef Texture  m_texture

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        if self.delete_this: del self.p_this

    def __repr__(self):
        return "Font()"

    @classmethod
    def from_file(cls, basestring filename):
        cdef SfFont *p = new SfFont()

        if p.openFromFile(filename.encode('UTF-8')):
            return wrap_font(p)

        del p
        raise IOError(popLastErrorMessage())

    @classmethod
    def from_memory(cls, bytes data):
        cdef SfFont *p = new SfFont()

        if p.openFromMemory(<char*>data, len(data)):
            return wrap_font(p)

        del p
        raise IOError(popLastErrorMessage())

    def get_glyph(self, unsigned int code_point, unsigned int character_size, bint bold):
        cdef SfGlyph *p = new SfGlyph()
        p[0] = self.p_this.getGlyph(code_point, character_size, bold, 0.0)
        return wrap_glyph(p)

    def get_kerning(self, unsigned int first, unsigned int second, unsigned int character_size):
        return self.p_this.getKerning(first, second, character_size)

    def get_line_spacing(self, unsigned int character_size):
        return self.p_this.getLineSpacing(character_size)

    def get_texture(self, unsigned int character_size):
        cdef SfTexture *p
        p = <SfTexture*>&self.p_this[0].getTexture(character_size)
        return wrap_texture(<sf.Texture*>p, False)

    property info:
        def __get__(self):
            cdef SfFontInfo info
            info = self.p_this[0].getInfo()
            return info.family


cdef Font wrap_font(SfFont *p, bint d=True):
    cdef Font r = Font.__new__(Font)
    r.p_this = p
    r.delete_this = d
    return r


class CurrentTextureType:
    def __repr__(self):
        return "CurrentTexture"


CurrentTexture = CurrentTextureType()

cdef class Shader:
    cdef SfShader *p_this
    cdef bint              delete_this

    def __init__(self):
        raise UserWarning("Use a specific constructor")

    def __dealloc__(self):
        if self.delete_this: del self.p_this

    def __repr__(self):
        return "Shader()"

    @classmethod
    def from_file(cls, basestring vertex=None, basestring fragment=None):
        cdef SfShader *p = new SfShader()

        if vertex and fragment:
            if loadShaderFromFile(p[0], <string>vertex.encode('UTF-8'), <string>fragment.encode('UTF-8')):
                return wrap_shader(p)
        elif vertex:
            if loadShaderFromFile(p[0], <string>vertex.encode('UTF-8'), <int>ShaderTypeVertex):
                return wrap_shader(p)
        elif fragment:
            if loadShaderFromFile(p[0], <string>fragment.encode('UTF-8'), <int>ShaderTypeFragment):
                return wrap_shader(p)
        else:
            raise TypeError("This method takes at least 1 argument (0 given)")

        del p
        raise IOError(popLastErrorMessage())

    @classmethod
    def from_memory(cls, char* vertex=NULL, char* fragment=NULL):
        cdef SfShader *p = new SfShader()

        if vertex is NULL and fragment is NULL:
            raise TypeError("This method takes at least 1 argument (0 given)")

        if vertex and fragment:
            if loadShaderFromMemory(p[0], vertex, fragment):
                return wrap_shader(p)
        elif vertex:
            if loadShaderFromMemory(p[0], vertex, <int>ShaderTypeVertex):
                return wrap_shader(p)
        elif fragment:
            if loadShaderFromMemory(p[0], fragment, <int>ShaderTypeFragment):
                return wrap_shader(p)

        del p
        raise IOError(popLastErrorMessage())

    def set_uniform(self, name, value, *extra_values):
        cdef tuple numeric_values

        if type(name) not in [bytes, unicode, str]:
            raise UserWarning("The first argument must be a string (bytes, unicode or str)")

        if extra_values:
            numeric_values = (value,) + extra_values

            if len(numeric_values) < 2 or len(numeric_values) > 4:
                raise UserWarning("Wrong number of numeric values.")

            for index, numeric_value in enumerate(numeric_values, start=2):
                if type(numeric_value) not in numeric_type:
                    raise UserWarning("Argument {0} must be a number".format(index))

            if len(numeric_values) == 2:
                self.set_2float_parameter(name, numeric_values[0], numeric_values[1])
            elif len(numeric_values) == 3:
                self.set_3float_parameter(name, numeric_values[0], numeric_values[1], numeric_values[2])
            else:
                self.set_4float_parameter(name, numeric_values[0], numeric_values[1], numeric_values[2], numeric_values[3])
            return

        if value is CurrentTexture:
            self.set_currenttexturetype_parameter(name)
        elif type(value) in [Vector2, tuple]:
            if type(value) is Vector2:
                self.set_vector2_paramater(name, value)
            elif len(value) == 2:
                self.set_vector2_paramater(name, value)
            elif len(value) == 3:
                self.set_vector3_paramater(name, value)
            elif len(value) == 4:
                self.set_4float_parameter(name, value[0], value[1], value[2], value[3])
            else:
                raise UserWarning("The uniform value tuple must have length 2, 3, or 4")
        elif type(value) is Color:
            self.set_color_parameter(name, value)
        elif type(value) is Transform:
            self.set_transform_parameter(name, value)
        elif type(value) is Texture:
            self.set_texture_parameter(name, value)
        elif type(value) in numeric_type:
            self.set_1float_parameter(name, value)
        else:
            raise UserWarning("The uniform value must be a number, tuple, Vector2, Color, Transform, Texture, or CurrentTexture")

    def set_1float_parameter(self, name, float x):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniform(self.p_this[0], encoded_name, x)

    def set_2float_parameter(self, name, float x, float y):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniform(self.p_this[0], encoded_name, x, y)

    def set_3float_parameter(self, name, float x, float y, float z):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniform(self.p_this[0], encoded_name, x, y, z)

    def set_4float_parameter(self, name, float x, float y, float z, float w):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniform(self.p_this[0], encoded_name, x, y, z, w)

    def set_vector2_paramater(self, name, vector):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        x, y = vector
        shaderSetUniformVec2(self.p_this[0], encoded_name, x, y)

    def set_vector3_paramater(self, name, vector):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        x, y, z = vector
        shaderSetUniformVec3(self.p_this[0], encoded_name, x, y, z)

    def set_color_parameter(self, name, Color color):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniformColor(self.p_this[0], encoded_name, color.p_this[0])

    def set_transform_parameter(self, name, Transform transform):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniformTransform(self.p_this[0], encoded_name, transform.p_this[0])

    def set_texture_parameter(self, name, Texture texture):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniformTexture(self.p_this[0], encoded_name, texture.p_this[0])

    def set_currenttexturetype_parameter(self, name):
        cdef char* encoded_name

        encoded_name_temporary = name.encode('UTF-8')
        encoded_name = encoded_name_temporary

        shaderSetUniformCurrentTexture(self.p_this[0], encoded_name)

    @staticmethod
    def bind(Shader shader=None):
        if not shader:
            bindShader(NULL)
        else:
            bindShader(shader.p_this)

    @staticmethod
    def is_available():
        return shaderIsAvailable()


cdef Shader wrap_shader(SfShader *p, bint d=True):
    cdef Shader r = Shader.__new__(Shader)
    r.p_this = p
    r.delete_this = d
    return r


cdef public class RenderStates[type PyRenderStatesType, object PyRenderStatesObject]:
    DEFAULT = wrap_renderstates(<SfRenderStates*>&SfDefaultRenderStates, False)

    cdef SfRenderStates *p_this
    cdef bint                    delete_this
    cdef StencilMode             m_stencil_mode
    cdef Transform               m_transform
    cdef Texture                 m_texture
    cdef Shader                  m_shader

    def __init__(self,
                 BlendMode blend_mode=BLEND_ALPHA,
                 StencilMode stencil_mode=None,
                 Transform transform=None,
                 int coordinate_type=CoordinateType.PIXELS,
                 Texture texture=None,
                 Shader shader=None):
        self.p_this = new SfRenderStates()

        self.m_stencil_mode = wrap_stencilmode(&self.p_this[0].stencilMode, False)
        self.m_transform = wrap_transform(&self.p_this[0].transform, False)
        self.m_texture = None
        self.m_shader = None

        self.blend_mode = blend_mode
        if stencil_mode:
            self.stencil_mode = stencil_mode

        self.coordinate_type = coordinate_type
        if transform:
            self.transform = transform

        if texture:
            self.texture = texture

        if shader:
            self.shader = shader

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        return "RenderStates(blend_mode={0}, stencil_mode={1}, transform={2}, coordinate_type={3}, texture={4}, shader={5})".format(
            id(self.blend_mode), self.stencil_mode, id(self.transform), self.coordinate_type, id(self.texture), id(self.shader))

    property blend_mode:
        def __get__(self):
            return wrap_blendmode(<sf.BlendMode*>&self.p_this[0].blendMode)

        def __set__(self, BlendMode blend_mode):
            self.p_this[0].blendMode = blend_mode.p_this[0]

    property stencil_mode:
        def __get__(self):
            return self.m_stencil_mode

        def __set__(self, StencilMode stencil_mode):
            self.p_this[0].stencilMode = stencil_mode.p_this[0]

    property transform:
        def __get__(self):
            return self.m_transform

        def __set__(self, Transform transform):
            self.p_this[0].transform = transform.p_this[0]

    property coordinate_type:
        def __get__(self):
            return <int>self.p_this[0].coordinateType

        def __set__(self, int coordinate_type):
            self.p_this[0].coordinateType = <SfCoordinateType>coordinate_type

    property texture:
        def __get__(self):
            return self.m_texture

        def __set__(self, Texture texture):
            self.p_this[0].texture = texture.p_this
            self.m_texture = texture

    property shader:
        def __get__(self):
            return self.m_shader

        def __set__(self, Shader shader):
            self.p_this[0].shader = shader.p_this
            self.m_shader = shader

cdef api RenderStates wrap_renderstates(SfRenderStates *p, bint d):
    cdef RenderStates r = RenderStates.__new__(RenderStates)
    r.p_this = p
    r.delete_this = d

    r.m_stencil_mode = wrap_stencilmode(&p[0].stencilMode, False)
    r.m_transform = wrap_transform(<SfTransform*>&p[0].transform, False)
    if p[0].texture:
        r.m_texture = wrap_texture(<sf.Texture*>p[0].texture, False)
    else:
        r.m_texture = None
    if p[0].shader:
        r.m_shader = wrap_shader(<SfShader*>p[0].shader, False)
    else:
        r.m_shader = None

    return r

cdef public class Drawable[type PyDrawableType, object PyDrawableObject]:
    cdef SfDrawable *p_drawable

    def __init__(self, *args, **kwargs):
        if self.__class__ == Drawable:
            raise NotImplementedError('Drawable is abstact')

        if self.p_drawable is NULL:
            self.p_drawable = <SfDrawable*>new DerivableDrawable(self)

    def __dealloc__(self):
        if self.p_drawable is not NULL:
            del self.p_drawable

    def draw(self, RenderTarget target, RenderStates states):
        pass

cdef class Transformable:
    cdef SfTransformable *p_this
    cdef bint             delete_this

    def __cinit__(self):
        self.p_this = NULL
        self.delete_this = False

    def __init__(self):
        if self.p_this is NULL:
            self.p_this = new SfTransformable()
            self.delete_this = True

    def __dealloc__(self):
        if self.delete_this and self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "Transformable(position={0}, rotation={1}, scale={2}, origin={3})".format(self.position, self.rotation, self.scale, self.origin)

    property position:
        def __get__(self):
            return Vector2(self.p_this.getPosition().x, self.p_this.getPosition().y)

        def __set__(self, position):
            self.p_this.setPosition(to_vector2f(position))

    property rotation:
        def __get__(self):
            return wrap_rotation_angle(self.p_this.getRotation())

        def __set__(self, angle):
            self.p_this.setRotation(to_rotation_angle(angle))

    property scale:
        def __get__(self):
            return Vector2(self.p_this.getScale().x, self.p_this.getScale().y)

        def __set__(self, factor):
            self.p_this.setScale(to_vector2f(factor))

    property origin:
        def __get__(self):
            return Vector2(self.p_this.getOrigin().x, self.p_this.getOrigin().y)

        def __set__(self, origin):
            self.p_this.setOrigin(to_vector2f(origin))

    def move(self, offset):
        self.p_this.move(to_vector2f(offset))

    def rotate(self, angle):
        self.p_this.rotate(to_rotation_angle(angle))

    def scale_by(self, factor):
        self.p_this.scale(to_vector2f(factor))

    property transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_this.getTransform()
            return wrap_transform(p)

    property inverse_transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_this.getInverseTransform()
            return wrap_transform(p)

cdef Transformable wrap_transformable(SfTransformable *p, bint d=False):
    cdef Transformable r = Transformable.__new__(Transformable)
    r.p_this = p
    r.delete_this = d
    return r

cdef public class TransformableDrawable(Drawable)[type PyTransformableDrawableType, object PyTransformableDrawableObject]:
    cdef SfTransformable *p_transformable
    cdef bint             delete_transformable

    def __cinit__(self):
        self.p_transformable = NULL
        self.delete_transformable = False

    def __init__(self, *args, **kwargs):
        if self.__class__ == TransformableDrawable:
            raise NotImplementedError('TransformableDrawable is not meant to be used')

        super().__init__(*args, **kwargs)

        if self.p_transformable is NULL:
            self.p_transformable = new SfTransformable()
            self.delete_transformable = True

    def __dealloc__(self):
        if self.delete_transformable and self.p_transformable is not NULL:
            del self.p_transformable

    def __repr__(self):
        return "TransformableDrawable(position={0}, rotation={1}, scale={2}, origin={3})".format(self.position, self.rotation, self.scale, self.origin)

    property position:
        def __get__(self):
            return Vector2(self.p_transformable.getPosition().x, self.p_transformable.getPosition().y)

        def __set__(self, position):
            self.p_transformable.setPosition(to_vector2f(position))

    property rotation:
        def __get__(self):
            return wrap_rotation_angle(self.p_transformable.getRotation())

        def __set__(self, angle):
            self.p_transformable.setRotation(to_rotation_angle(angle))

    property scale:
        def __get__(self):
            return Vector2(self.p_transformable.getScale().x, self.p_transformable.getScale().y)

        def __set__(self, factor):
            self.p_transformable.setScale(to_vector2f(factor))

    property origin:
        def __get__(self):
            return Vector2(self.p_transformable.getOrigin().x, self.p_transformable.getOrigin().y)

        def __set__(self, origin):
            self.p_transformable.setOrigin(to_vector2f(origin))

    def move(self, offset):
        self.p_transformable.move(to_vector2f(offset))

    def rotate(self, angle):
        self.p_transformable.rotate(to_rotation_angle(angle))

    def scale_by(self, factor):
        self.p_transformable.scale(to_vector2f(factor))

    property transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_transformable.getTransform()
            return wrap_transform(p)

    property inverse_transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_transformable.getInverseTransform()
            return wrap_transform(p)

    property transformable:
        def __get__(self):
            return wrap_transformable(self.p_transformable)


cdef public class Sprite(TransformableDrawable)[type PySpriteType, object PySpriteObject]:
    cdef SfSprite *p_this
    cdef Texture    m_texture

    def __init__(self, Texture texture, rectangle=None):
        if self.p_this is NULL:
            if not rectangle:
                self.p_this = new SfSprite(texture.p_this[0])
            else:
                self.p_this = new SfSprite(texture.p_this[0], to_intrect(rectangle))

            self.p_drawable = <SfDrawable*>self.p_this
            self.p_transformable = <SfTransformable*>self.p_this

            self.m_texture = texture

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "Sprite(texture={0}, texture_rectangle={1}, color={2})".format(id(self.texture), self.texture_rectangle, self.color)

    property texture:
        def __get__(self):
            return self.m_texture

        def __set__(self, Texture texture):
            self.p_this.setTexture(texture.p_this[0], True)
            self.m_texture = texture

    property texture_rectangle:
        def __get__(self):
            cdef SfIntRect rect = self.p_this.getTextureRect()
            return wrap_intrect(&rect)

        def __set__(self, rectangle):
            self.p_this.setTextureRect(to_intrect(rectangle))

    property color:
        def __get__(self):
            cdef SfColor* p = new SfColor()
            p[0] = self.p_this.getColor()
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_this.setColor(color.p_this[0])

    property local_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_this.getLocalBounds()
            return wrap_floatrect(&p)

    property global_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_this.getGlobalBounds()
            return wrap_floatrect(&p)


class TextStyle(IntEnum):
    REGULAR = SfTextRegular
    BOLD = SfTextBold
    ITALIC = SfTextItalic
    UNDERLINED = SfTextUnderlined
    STRIKE_THROUGH = SfTextStrikeThrough

cdef class Text(TransformableDrawable):
    cdef SfText *p_this
    cdef Font     m_font

    def __init__(self, Font font, unicode string=None, unsigned int character_size=30):
        if font is None:
            raise TypeError("font is required")

        if self.p_this is NULL:
            if string is None:
                string = u""

            self.p_this = new SfText(font.p_this[0], to_string(string), character_size)
            self.p_drawable = <SfDrawable*>self.p_this
            self.p_transformable = <SfTransformable*>self.p_this
            self.m_font = font

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "Text(string={0}, font={1}, character_size={2}, style={3}, fill_color={4}, outline_color={5}, outline_thickness={6})".format(
            self.string[:10], id(self.font), self.character_size, self.style, self.fill_color, self.outline_color, self.outline_thickness)

    property string:
        def __get__(self):
            cdef sf.String value = self.p_this.getString()
            return wrap_string(&value)

        def __set__(self, unicode string):
            self.p_this.setString(to_string(string))

    property font:
        def __get__(self):
            return self.m_font

        def __set__(self, Font font):
            self.p_this.setFont(font.p_this[0])
            self.m_font = font

    property character_size:
        def __get__(self):
            return self.p_this.getCharacterSize()

        def __set__(self, unsigned int size):
            self.p_this.setCharacterSize(size)

    property letter_spacing:
        def __get__(self):
            return self.p_this.getLetterSpacing()

        def __set__(self, float spacing_factor):
            self.p_this.setLetterSpacing(spacing_factor)

    property line_spacing:
        def __get__(self):
            return self.p_this.getLineSpacing()

        def __set__(self, float spacing_factor):
            self.p_this.setLineSpacing(spacing_factor)

    property style:
        def __get__(self):
            return self.p_this.getStyle()

        def __set__(self, unsigned int style):
            self.p_this.setStyle(style)

    property fill_color:
        def __get__(self):
            cdef SfColor* p = new SfColor()
            p[0] = self.p_this.getFillColor()
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_this.setFillColor(color.p_this[0])

    property outline_color:
        def __get__(self):
            cdef SfColor* p = new SfColor()
            p[0] = self.p_this.getOutlineColor()
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_this.setOutlineColor(color.p_this[0])

    property outline_thickness:
        def __get__(self):
            return self.p_this.getOutlineThickness()

        def __set__(self, float thickness):
            self.p_this.setOutlineThickness(thickness)

    property local_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_this.getLocalBounds()
            return wrap_floatrect(&p)

    property global_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_this.getGlobalBounds()
            return wrap_floatrect(&p)

    def find_character_pos(self, size_t index):
        cdef sf.Vector2f p = self.p_this.findCharacterPos(index)
        return Vector2(p.x, p.y)


cdef public class Shape(TransformableDrawable)[type PyShapeType, object PyShapeObject]:
    cdef SfShape *p_shape
    cdef Texture   m_texture

    def __init__(self, *args, **kwargs):
        if self.__class__ == Shape:
            raise NotImplementedError('Shape is abstact')

    def __dealloc__(self):
        self.p_drawable = NULL
        self.p_transformable = NULL

    property texture:
        def __get__(self):
            return self.m_texture

        def __set__(self, Texture texture):
            if texture:
                self.p_shape.setTexture(texture.p_this, True)
                self.m_texture = texture
            else:
                self.p_shape.setTexture(<SfTexture*>NULL, True)
                self.m_texture = None

    property texture_rectangle:
        def __get__(self):
            cdef SfIntRect rect = self.p_shape.getTextureRect()
            return wrap_intrect(&rect)

        def __set__(self, rectangle):
            self.p_shape.setTextureRect(to_intrect(rectangle))

    property fill_color:
        def __get__(self):
            cdef SfColor* p = new SfColor()
            p[0] = self.p_shape.getFillColor()
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_shape.setFillColor(color.p_this[0])

    property outline_color:
        def __get__(self):
            cdef SfColor* p = new SfColor()
            p[0] = self.p_shape.getOutlineColor()
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_shape.setOutlineColor(color.p_this[0])

    property outline_thickness:
        def __get__(self):
            return self.p_shape.getOutlineThickness()

        def __set__(self, float thickness):
            self.p_shape.setOutlineThickness(thickness)

    property local_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_shape.getLocalBounds()
            return wrap_floatrect(&p)

    property global_bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_shape.getGlobalBounds()
            return wrap_floatrect(&p)

    property point_count:
        def __get__(self):
            return self.p_shape.getPointCount()

    def get_point(self, unsigned int index):
        return Vector2(self.p_shape.getPoint(index).x, self.p_shape.getPoint(index).y)


cdef class CircleShape(Shape):
    cdef SfCircleShape *p_this

    def __init__(self, float radius=0, unsigned int point_count=30):
        if self.p_this is NULL:
            self.p_this = new SfCircleShape(radius, point_count)

            self.p_drawable = <SfDrawable*>self.p_this
            self.p_transformable = <SfTransformable*>self.p_this
            self.p_shape = <SfShape*>self.p_this

    def __dealloc__(self):
        self.p_shape = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "CircleShape(texture={0}, texture_rectangle={1}, fill_color={2}, outline_color={3}, outline_thickness={4}, radius={5}, point_count={6})".format(id(self.texture), self.texture_rectangle, self.fill_color, self.outline_color, self.outline_thickness, self.radius, self.point_count)

    property radius:
        def __get__(self):
            return self.p_this.getRadius()

        def __set__(self, float radius):
            self.p_this.setRadius(radius)

    property point_count:
        def __get__(self):
            return self.p_this.getPointCount()

        def __set__(self, unsigned int count):
            self.p_this.setPointCount(count)

cdef public class ConvexShape(Shape)[type PyConvexShapeType, object PyConvexShapeObject]:
    cdef SfConvexShape *p_this

    def __init__(self, unsigned int point_count=0):
        if self.p_this is NULL:
            self.p_this = new SfConvexShape(point_count)

            self.p_drawable = <SfDrawable*>self.p_this
            self.p_transformable = <SfTransformable*>self.p_this
            self.p_shape = <SfShape*>self.p_this

    def __dealloc__(self):
        self.p_shape = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "ConvexShape(texture={0}, texture_rectangle={1}, fill_color={2}, outline_color={3}, outline_thickness={4}, point_count={5})".format(id(self.texture), self.texture_rectangle, self.fill_color, self.outline_color, self.outline_thickness, self.point_count)

    property point_count:
        def __get__(self):
            return self.p_this.getPointCount()

        def __set__(self, unsigned int count):
            self.p_this.setPointCount(count)

    def set_point(self, unsigned int index, point):
        self.p_this.setPoint(index, to_vector2f(point))


cdef api object wrap_convexshape(sf.ConvexShape *p):
    cdef ConvexShape r = ConvexShape.__new__(ConvexShape)
    r.p_this = <SfConvexShape*>p
    r.p_drawable = <SfDrawable*>p
    r.p_transformable = <SfTransformable*>p
    r.p_shape = <SfShape*>p

    return r

cdef class RectangleShape(Shape):
    cdef SfRectangleShape *p_this

    def __init__(self, size=(0, 0)):
        if self.p_this is NULL:
            self.p_this = new SfRectangleShape(to_vector2f(size))

            self.p_drawable = <SfDrawable*>self.p_this
            self.p_transformable = <SfTransformable*>self.p_this
            self.p_shape = <SfShape*>self.p_this

    def __dealloc__(self):
        self.p_shape = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "RectangleShape(texture={0}, texture_rectangle={1}, fill_color={2}, outline_color={3}, outline_thickness={4}, size={5}, point_count={6})".format(id(self.texture), self.texture_rectangle, self.fill_color, self.outline_color, self.outline_thickness, self.size, self.point_count)

    property size:
        def __get__(self):
            return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

        def __set__(self, size):
            self.p_this.setSize(to_vector2f(size))

    property point_count:
        def __get__(self):
            return self.p_this.getPointCount()

cdef class Vertex:
    cdef SfVertex *p_this
    cdef bint              delete_this

    def __init__(self, position=None, Color color=None, tex_coords=None):
        self.p_this = new SfVertex()
        self.delete_this = True

        if position:
            self.position = position

        if color:
            self.color = color

        if tex_coords:
            self.tex_coords = tex_coords

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        return "Vertex(position={0}, color={1}, tex_coords={2})".format(self.position, self.color, self.tex_coords)

    property position:
        def __get__(self):
            return Vector2(self.p_this.position.x, self.p_this.position.y)

        def __set__(self, position):
            self.p_this.position.x, self.p_this.position.y = position

    property color:
        def __get__(self):
            cdef SfColor *p = new SfColor()
            p[0] = self.p_this.color
            return wrap_color(<sf.Color*>p)

        def __set__(self, Color color):
            self.p_this.color = color.p_this[0]

    property tex_coords:
        def __get__(self):
            return Vector2(self.p_this.texCoords.x, self.p_this.texCoords.y)

        def __set__(self, tex_coords):
            self.p_this.texCoords.x, self.p_this.texCoords.y = tex_coords

cdef Vertex wrap_vertex(SfVertex* p, bint d=True):
    cdef Vertex r = Vertex.__new__(Vertex)
    r.p_this = p
    r.delete_this = d
    return r


cdef SfVertex* vertex_sequence_to_array(vertices, size_t *vertex_count) except NULL:
    cdef tuple vertex_items = tuple(vertices)
    cdef size_t count = len(vertex_items)
    cdef SfVertex* raw_vertices = NULL
    cdef size_t index
    cdef object vertex

    if vertex_count != NULL:
        vertex_count[0] = count

    if count == 0:
        return <SfVertex*>NULL

    raw_vertices = <SfVertex*>malloc(count * sizeof(SfVertex))
    if raw_vertices == NULL:
        raise MemoryError()

    for index in range(count):
        vertex = vertex_items[index]
        if not isinstance(vertex, Vertex):
            free(raw_vertices)
            raise TypeError("vertices must contain only sf.Vertex instances")

        raw_vertices[index] = (<Vertex>vertex).p_this[0]

    return raw_vertices


cdef class VertexArray(Drawable):
    cdef SfVertexArray *p_this

    def __init__(self, int type=0, unsigned int vertex_count=0):
        if self.p_this is NULL:
            self.p_this = new SfVertexArray(<SfPrimitiveType>type, vertex_count)
            self.p_drawable = <SfDrawable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "VertexArray(length={0}, primitive_type={1}, bounds={2})".format(len(self), self.primitive_type, self.bounds)

    def __len__(self):
        return self.p_this.getVertexCount()

    def __getitem__(self, unsigned int index):
        if index < len(self):
            return wrap_vertex(&self.p_this[0][index], False)
        else:
            raise IndexError

    def __setitem__(self, unsigned int index, Vertex key):
        self.p_this[0][index] = key.p_this[0]

    def clear(self):
        self.p_this.clear()

    def resize(self, unsigned int vertex_count):
        self.p_this.resize(vertex_count)

    def append(self, Vertex vertex):
        self.p_this.append(vertex.p_this[0])

    property primitive_type:
        def __get__(self):
            return <int>self.p_this.getPrimitiveType()

        def __set__(self, int primitive_type):
            self.p_this.setPrimitiveType(<SfPrimitiveType>primitive_type)

    property bounds:
        def __get__(self):
            cdef SfFloatRect p = self.p_this.getBounds()
            return wrap_floatrect(&p)


cdef class VertexBuffer(Drawable):
    cdef SfVertexBuffer *p_this

    def __init__(self, int primitive_type=<int>PrimitiveType.POINTS, int usage=<int>VertexBufferUsage.STREAM):
        if self.p_this is NULL:
            self.p_this = new SfVertexBuffer(<SfPrimitiveType>primitive_type, <SfVertexBufferUsage>usage)
            self.p_drawable = <SfDrawable*>self.p_this

    def __dealloc__(self):
        self.p_drawable = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "VertexBuffer(length={0}, primitive_type={1}, usage={2})".format(len(self), self.primitive_type, self.usage)

    def __len__(self):
        return self.p_this.getVertexCount()

    def create(self, unsigned int vertex_count):
        return self.p_this.create(vertex_count)

    def update(self, vertices, unsigned int offset=0):
        cdef size_t vertex_count = 0
        cdef SfVertex* raw_vertices = NULL

        if isinstance(vertices, VertexBuffer):
            return self.p_this.update((<VertexBuffer>vertices).p_this[0])

        raw_vertices = vertex_sequence_to_array(vertices, &vertex_count)

        try:
            return self.p_this.update(raw_vertices, vertex_count, offset)
        finally:
            if raw_vertices != NULL:
                free(raw_vertices)

    property primitive_type:
        def __get__(self):
            return <int>self.p_this.getPrimitiveType()

        def __set__(self, int primitive_type):
            self.p_this.setPrimitiveType(<SfPrimitiveType>primitive_type)

    property usage:
        def __get__(self):
            return <int>self.p_this.getUsage()

        def __set__(self, int usage):
            self.p_this.setUsage(<SfVertexBufferUsage>usage)

    property native_handle:
        def __get__(self):
            return self.p_this.getNativeHandle()

    @staticmethod
    def bind(VertexBuffer vertex_buffer=None):
        if vertex_buffer is None:
            bindVertexBuffer(<const SfVertexBuffer*>NULL)
        else:
            bindVertexBuffer(<const SfVertexBuffer*>vertex_buffer.p_this)

    @staticmethod
    def is_available():
        return vertexBufferIsAvailable()


cdef class View:
    cdef SfView       *p_this
    cdef RenderWindow  m_renderwindow
    cdef RenderTarget  m_rendertarget

    def __init__(self, rectangle=None):
        if not rectangle:
            self.p_this = new SfView()
        else:
            self.p_this = new SfView(to_floatrect(rectangle))

    def __dealloc__(self):
        del self.p_this

    def __repr__(self):
        return "View(center={0}, size={1}, rotation={2}, viewport={3}, scissor={4})".format(self.center, self.size, self.rotation, self.viewport, self.scissor)

    property center:
        def __get__(self):
            return Vector2(self.p_this.getCenter().x, self.p_this.getCenter().y)

        def __set__(self, center):
            self.p_this.setCenter(to_vector2f(center))
            self._update_target()

    property size:
        def __get__(self):
            return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)

        def __set__(self, size):
            self.p_this.setSize(to_vector2f(size))
            self._update_target()

    property rotation:
        def __get__(self):
            return wrap_rotation_angle(self.p_this.getRotation())

        def __set__(self, angle):
            self.p_this.setRotation(to_rotation_angle(angle))
            self._update_target()

    property viewport:
        def __get__(self):
            cdef SfFloatRect rect = self.p_this.getViewport()
            return wrap_floatrect(&rect)

        def __set__(self, viewport):
            self.p_this.setViewport(to_floatrect(viewport))
            self._update_target()

    property scissor:
        def __get__(self):
            cdef SfFloatRect rect = self.p_this.getScissor()
            return wrap_floatrect(&rect)

        def __set__(self, scissor):
            self.p_this.setScissor(to_floatrect(scissor))
            self._update_target()

    def reset(self, rectangle):
        resetView(self.p_this[0], to_floatrect(rectangle))
        self._update_target()

    def move(self, float x, float y):
        self.p_this.move(to_vector2f((x, y)))
        self._update_target()

    def rotate(self, angle):
        self.p_this.rotate(to_rotation_angle(angle))
        self._update_target()

    def zoom(self, float factor):
        self.p_this.zoom(factor)
        self._update_target()

    property transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_this.getTransform()
            return wrap_transform(p)

    property inverse_transform:
        def __get__(self):
            cdef SfTransform *p = new SfTransform()
            p[0] = self.p_this.getInverseTransform()
            return wrap_transform(p)

    def _update_target(self):
        if self.m_renderwindow:
            self.m_renderwindow.view = self

        if self.m_rendertarget:
            self.m_rendertarget.view = self

cdef View wrap_view(SfView *p):
    cdef View r = View.__new__(View)
    r.p_this = p
    return r

cdef View wrap_view_for_renderwindow(SfView *p, RenderWindow renderwindow):
    cdef View r = View.__new__(View)
    r.p_this = p
    r.m_renderwindow = renderwindow
    return r

cdef View wrap_view_for_rendertarget(SfView *p, RenderTarget rendertarget):
    cdef View r = View.__new__(View)
    r.p_this = p
    r.m_rendertarget = rendertarget
    return r


cdef public class RenderTarget[type PyRenderTargetType, object PyRenderTargetObject]:
    cdef SfRenderTarget *p_rendertarget

    def __init__(self, *args, **kwargs):
        if self.__class__ == RenderTarget:
            raise NotImplementedError('RenderTarget is abstact')

    def clear(self, Color color=None, stencil_value=None):
        cdef SfColor clear_color

        if stencil_value is None:
            if color is None:
                self.p_rendertarget.clear()
            else:
                self.p_rendertarget.clear(color.p_this[0])
            return

        if color is None:
            clear_color = SfColor(0, 0, 0, 255)
        else:
            clear_color = color.p_this[0]

        self.p_rendertarget.clear(clear_color, SfStencilValue(to_stencil_uint(stencil_value)))

    def clear_stencil(self, value=0):
        self.p_rendertarget.clearStencil(SfStencilValue(to_stencil_uint(value)))

    def set_active(self, bint active=True):
        return self.p_rendertarget.setActive(active)

    property srgb:
        def __get__(self):
            return self.p_rendertarget.isSrgb()

    property view:
        def __get__(self):
            cdef SfView *p = new SfView()
            p[0] = self.p_rendertarget.getView()
            return wrap_view_for_rendertarget(p, self)

        def __set__(self, View view):
            self.p_rendertarget.setView(view.p_this[0])
            view.m_renderwindow = None
            view.m_rendertarget = self

    property default_view:
        def __get__(self):
            cdef SfView *p = new SfView()
            p[0] = self.p_rendertarget.getDefaultView()
            return wrap_view_for_rendertarget(p, self)

    def get_viewport(self, View view):
        cdef SfIntRect p = self.p_rendertarget.getViewport(view.p_this[0])
        return wrap_intrect(&p)

    def get_scissor(self, View view):
        cdef SfIntRect p = self.p_rendertarget.getScissor(view.p_this[0])
        return wrap_intrect(&p)

    def map_pixel_to_coords(self, point, View view=None):
        cdef sf.Vector2f ret

        if not view:
            ret = self.p_rendertarget.mapPixelToCoords(to_vector2i(point))
        else:
            ret = self.p_rendertarget.mapPixelToCoords(to_vector2i(point), view.p_this[0])

        return Vector2(ret.x, ret.y)

    def map_coords_to_pixel(self, point, View view=None):
        cdef sf.Vector2i ret

        if not view:
            ret = self.p_rendertarget.mapCoordsToPixel(to_vector2f(point))
        else:
            ret = self.p_rendertarget.mapCoordsToPixel(to_vector2f(point), view.p_this[0])

        return Vector2(ret.x, ret.y)

    def draw(self, Drawable drawable, RenderStates states=None):
        if not states:
            self.p_rendertarget.draw(drawable.p_drawable[0])
        else:
            self.p_rendertarget.draw(drawable.p_drawable[0], states.p_this[0])

    def draw_vertices(self, vertices, int primitive_type, RenderStates states=None):
        cdef size_t vertex_count = 0
        cdef SfVertex* raw_vertices = vertex_sequence_to_array(vertices, &vertex_count)

        try:
            if not states:
                self.p_rendertarget.draw(raw_vertices, vertex_count, <SfPrimitiveType>primitive_type)
            else:
                self.p_rendertarget.draw(raw_vertices, vertex_count, <SfPrimitiveType>primitive_type, states.p_this[0])
        finally:
            if raw_vertices != NULL:
                free(raw_vertices)

    def draw_vertex_buffer(self, VertexBuffer vertex_buffer, RenderStates states=None, first_vertex=None, vertex_count=None):
        cdef size_t first = 0
        cdef size_t count = 0

        if first_vertex is None and vertex_count is None:
            if not states:
                self.p_rendertarget.draw(vertex_buffer.p_this[0])
            else:
                self.p_rendertarget.draw(vertex_buffer.p_this[0], states.p_this[0])
            return

        if first_vertex is not None:
            first = <size_t>first_vertex

        if vertex_count is None:
            count = len(vertex_buffer) - first
        else:
            count = <size_t>vertex_count

        if not states:
            self.p_rendertarget.draw(vertex_buffer.p_this[0], first, count, SfDefaultRenderStates)
        else:
            self.p_rendertarget.draw(vertex_buffer.p_this[0], first, count, states.p_this[0])

    property size:
        def __get__(self):
            return Vector2(self.p_rendertarget.getSize().x, self.p_rendertarget.getSize().y)

    property width:
        def __get__(self):
            return self.size.x

    property height:
        def __get__(self):
            return self.size.y

    def push_GL_states(self):
        self.p_rendertarget.pushGLStates()

    def pop_GL_states(self):
        self.p_rendertarget.popGLStates()

    def reset_GL_states(self):
        self.p_rendertarget.resetGLStates()


cdef api object wrap_rendertarget(sf.RenderTarget* p):
    cdef RenderTarget r = RenderTarget.__new__(RenderTarget)
    r.p_rendertarget = <SfRenderTarget*>p
    return r


cdef class RenderWindow(Window):
    cdef SfRenderWindow *p_this

    def __init__(self, VideoMode mode, unicode title, unsigned int style=SfWindowStyleDefault, ContextSettings settings=ContextSettings()):
        if self.p_this == NULL:
            self.p_this = <SfRenderWindow*>new DerivableRenderWindow(self)
            createRenderWindow(self.p_this[0], mode.p_this[0], to_string(title), style, settings.p_this[0])
            self.p_window = <sf.Window*>self.p_this

    def __dealloc__(self):
        self.p_window = NULL
        if self.p_this != NULL:
            del self.p_this

    def __repr__(self):
        return "RenderWindow(position={0}, size={1}, is_open={2})".format(self.position, self.size, self.is_open)

    def clear(self, Color color=None, stencil_value=None):
        cdef SfColor clear_color

        if stencil_value is None:
            if color is None:
                self.p_this.clear()
            else:
                self.p_this.clear(color.p_this[0])
            return

        if color is None:
            clear_color = SfColor(0, 0, 0, 255)
        else:
            clear_color = color.p_this[0]

        self.p_this.clear(clear_color, SfStencilValue(to_stencil_uint(stencil_value)))

    def clear_stencil(self, value=0):
        self.p_this.clearStencil(SfStencilValue(to_stencil_uint(value)))

    property srgb:
        def __get__(self):
            return self.p_this.isSrgb()

    property view:
        def __get__(self):
            cdef SfView *p = new SfView()
            p[0] = self.p_this.getView()
            return wrap_view_for_renderwindow(p, self)

        def __set__(self, View view):
            self.p_this.setView(view.p_this[0])
            view.m_renderwindow = self
            view.m_rendertarget = None

    property default_view:
        def __get__(self):
            cdef SfView *p = new SfView()
            p[0] = self.p_this.getDefaultView()
            return wrap_view_for_renderwindow(p, self)

    def get_viewport(self, View view):
        cdef SfIntRect p = self.p_this.getViewport(view.p_this[0])
        return wrap_intrect(&p)

    def get_scissor(self, View view):
        cdef SfIntRect p = self.p_this.getScissor(view.p_this[0])
        return wrap_intrect(&p)

    def map_pixel_to_coords(self, point, View view=None):
        cdef sf.Vector2f ret

        if not view:
            ret = self.p_this.mapPixelToCoords(to_vector2i(point))
        else:
            ret = self.p_this.mapPixelToCoords(to_vector2i(point), view.p_this[0])

        return Vector2(ret.x, ret.y)

    def map_coords_to_pixel(self, point, View view=None):
        cdef sf.Vector2i ret

        if not view:
            ret = self.p_this.mapCoordsToPixel(to_vector2f(point))
        else:
            ret = self.p_this.mapCoordsToPixel(to_vector2f(point), view.p_this[0])

        return Vector2(ret.x, ret.y)

    def draw(self, Drawable drawable, RenderStates states=None):
        if not states:
            self.p_this.draw(drawable.p_drawable[0])
        else:
            self.p_this.draw(drawable.p_drawable[0], states.p_this[0])

    def draw_vertices(self, vertices, int primitive_type, RenderStates states=None):
        cdef size_t vertex_count = 0
        cdef SfVertex* raw_vertices = vertex_sequence_to_array(vertices, &vertex_count)

        try:
            if not states:
                self.p_this.draw(raw_vertices, vertex_count, <SfPrimitiveType>primitive_type)
            else:
                self.p_this.draw(raw_vertices, vertex_count, <SfPrimitiveType>primitive_type, states.p_this[0])
        finally:
            if raw_vertices != NULL:
                free(raw_vertices)

    def draw_vertex_buffer(self, VertexBuffer vertex_buffer, RenderStates states=None, first_vertex=None, vertex_count=None):
        cdef size_t first = 0
        cdef size_t count = 0

        if first_vertex is None and vertex_count is None:
            if not states:
                self.p_this.draw(vertex_buffer.p_this[0])
            else:
                self.p_this.draw(vertex_buffer.p_this[0], states.p_this[0])
            return

        if first_vertex is not None:
            first = <size_t>first_vertex

        if vertex_count is None:
            count = len(vertex_buffer) - first
        else:
            count = <size_t>vertex_count

        if not states:
            self.p_this.draw(vertex_buffer.p_this[0], first, count, SfDefaultRenderStates)
        else:
            self.p_this.draw(vertex_buffer.p_this[0], first, count, states.p_this[0])

    def push_GL_states(self):
        self.p_this.pushGLStates()

    def pop_GL_states(self):
        self.p_this.popGLStates()

    def reset_GL_states(self):
        self.p_this.resetGLStates()

    def on_create(self):
        (<DerivableRenderWindow*>self.p_this).createWindow()

    def on_resize(self):
        (<DerivableRenderWindow*>self.p_this).resizeWindow()

cdef class RenderTexture(RenderTarget):
    cdef SfRenderTexture *p_this
    cdef Texture m_texture

    def __init__(self, unsigned int width, unsigned int height, bint depthBuffer=False, bint srgb=False):
        if self.p_this is NULL:
            self.p_this = new SfRenderTexture()
            self.p_rendertarget = <SfRenderTarget*>self.p_this

            resizeRenderTexture(self.p_this[0], SfVector2u(width, height), depthBuffer, srgb)

            self.m_texture = wrap_texture(<sf.Texture*>&self.p_this.getTexture(), False)

    def __dealloc__(self):
        self.p_rendertarget = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "RenderTexture(size={0}, smooth={1}, repeated={2}, srgb={3})".format(self.size, self.smooth, self.repeated, self.srgb)

    property smooth:
        def __get__(self):
            return self.p_this.isSmooth()

        def __set__(self, bint smooth):
            self.p_this.setSmooth(smooth)

    property repeated:
        def __get__(self):
            return self.p_this.isRepeated()

        def __set__(self, bint repeated):
            self.p_this.setRepeated(repeated)

    def set_active(self, bint active=True):
        return self.p_this.setActive(active)

    def generate_mipmap(self):
        return self.p_this.generateMipmap()

    def display(self):
        self.p_this.display()

    property texture:
        def __get__(self):
            return self.m_texture
