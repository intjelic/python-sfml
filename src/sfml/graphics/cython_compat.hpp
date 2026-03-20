#ifndef PYSFML_GRAPHICS_CYTHON_COMPAT_HPP
#define PYSFML_GRAPHICS_CYTHON_COMPAT_HPP

#include <SFML/Graphics.hpp>
#include <cstdint>

namespace sf
{
using Uint8 = std::uint8_t;
using SfIntRect = IntRect;
using SfFloatRect = FloatRect;
}

using Window = sf::Window;
using Color = sf::Color;
using BlendMode = sf::BlendMode;
using StencilValue = sf::StencilValue;
using StencilMode = sf::StencilMode;
using Image = sf::Image;
using Texture = sf::Texture;
using RenderStates = sf::RenderStates;
using Drawable = sf::Drawable;
using Transform = sf::Transform;
using Transformable = sf::Transformable;
using Vector2i = sf::Vector2i;
using Vector2u = sf::Vector2u;
using Vector2f = sf::Vector2f;
using Sprite = sf::Sprite;
using Font = sf::Font;
using Glyph = sf::Glyph;
using Shader = sf::Shader;
using Text = sf::Text;
using Shape = sf::Shape;
using CircleShape = sf::CircleShape;
using ConvexShape = sf::ConvexShape;
using RectangleShape = sf::RectangleShape;
using Vertex = sf::Vertex;
using VertexArray = sf::VertexArray;
using View = sf::View;
using RenderTarget = sf::RenderTarget;
using RenderWindow = sf::RenderWindow;
using RenderTexture = sf::RenderTexture;

#endif
