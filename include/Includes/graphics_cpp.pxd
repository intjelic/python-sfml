cimport sfml as sf
from sfml cimport Uint8
from libc.stddef cimport size_t


cdef extern from "SFML/Graphics.hpp" namespace "sf":
    ctypedef sf.Rect[int] IntRect
    ctypedef sf.Rect[float] FloatRect

    cdef cppclass Drawable:
        pass

    cdef cppclass Transformable:
        pass

    cdef cppclass Color:
        Color()
        Color(Uint8, Uint8, Uint8, Uint8)

    cdef cppclass Texture:
        pass

    cdef cppclass Shape(Drawable, Transformable):
        void setTexture(const Texture* texture, bint resetRect=*)
        void setTextureRect(const IntRect& rect)
        void setFillColor(Color color)
        void setOutlineColor(Color color)
        void setOutlineThickness(float thickness)
        const IntRect& getTextureRect() const
        Color getFillColor() const
        Color getOutlineColor() const
        float getOutlineThickness() const
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const
        FloatRect getLocalBounds() const
        FloatRect getGlobalBounds() const

    cdef cppclass CircleShape(Shape):
        CircleShape(float, size_t)
        void setRadius(float radius)
        float getRadius() const
        void setPointCount(size_t count)
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass ConvexShape(Shape):
        ConvexShape(size_t)
        void setPointCount(size_t count)
        size_t getPointCount() const
        void setPoint(size_t index, sf.Vector2f point)
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass RectangleShape(Shape):
        RectangleShape(const sf.Vector2f&)
        void setSize(sf.Vector2f size)
        sf.Vector2f getSize() const
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const