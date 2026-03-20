cimport sfml as sf
from sfml cimport Uint8
from libc.stddef cimport size_t


cdef extern from "SFML/Graphics.hpp" namespace "sf":
    ctypedef sf.Rect[int] SfIntRect
    ctypedef sf.Rect[float] SfFloatRect

    cdef cppclass SfDrawable "sf::Drawable":
        pass

    cdef cppclass SfTransformable "sf::Transformable":
        pass

    cdef cppclass SfColor "sf::Color":
        SfColor()
        SfColor(Uint8, Uint8, Uint8, Uint8)

    cdef cppclass SfTexture "sf::Texture":
        pass

    cdef cppclass SfShape "sf::Shape"(SfDrawable, SfTransformable):
        void setTexture(const SfTexture* texture, bint resetRect=*)
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

    cdef cppclass SfCircleShape "sf::CircleShape"(SfShape):
        SfCircleShape(float, size_t)
        void setRadius(float radius)
        float getRadius() const
        void setPointCount(size_t count)
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass SfConvexShape "sf::ConvexShape"(SfShape):
        SfConvexShape(size_t)
        void setPointCount(size_t count)
        size_t getPointCount() const
        void setPoint(size_t index, sf.Vector2f point)
        sf.Vector2f getPoint(size_t index) const

    cdef cppclass SfRectangleShape "sf::RectangleShape"(SfShape):
        SfRectangleShape(const sf.Vector2f&)
        void setSize(sf.Vector2f size)
        sf.Vector2f getSize() const
        size_t getPointCount() const
        sf.Vector2f getPoint(size_t index) const