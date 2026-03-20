#pragma once

#include <SFML/Graphics/Glsl.hpp>
#include <SFML/Graphics/Image.hpp>
#include <SFML/Graphics/RenderTexture.hpp>
#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Graphics/Shader.hpp>
#include <SFML/Graphics/Texture.hpp>
#include <SFML/Graphics/Transform.hpp>
#include <SFML/Graphics/View.hpp>

#include <filesystem>
#include <string>
#include <string_view>

namespace pysfml::graphics_compat
{
enum ShaderType
{
    Vertex = 0,
    Geometry = 1,
    Fragment = 2,
};

inline sf::Shader::Type toShaderType(const int type)
{
    switch (type)
    {
        case Geometry:
            return sf::Shader::Type::Geometry;
        case Fragment:
            return sf::Shader::Type::Fragment;
        case Vertex:
        default:
            return sf::Shader::Type::Vertex;
    }
}

inline bool loadShaderFromFile(sf::Shader& shader, const std::string& filename, const int type)
{
    return shader.loadFromFile(std::filesystem::path{filename}, toShaderType(type));
}

inline bool loadShaderFromFile(sf::Shader& shader, const std::string& vertex, const std::string& fragment)
{
    return shader.loadFromFile(std::filesystem::path{vertex}, std::filesystem::path{fragment});
}

inline bool loadShaderFromMemory(sf::Shader& shader, const char* source, const int type)
{
    return shader.loadFromMemory(std::string_view{source}, toShaderType(type));
}

inline bool loadShaderFromMemory(sf::Shader& shader, const char* vertex, const char* fragment)
{
    return shader.loadFromMemory(std::string_view{vertex}, std::string_view{fragment});
}

inline bool loadTextureFromFile(sf::Texture& texture, const std::string& filename)
{
    return texture.loadFromFile(std::filesystem::path{filename});
}

inline bool loadTextureFromFile(sf::Texture& texture, const std::string& filename, const bool sRgb)
{
    return texture.loadFromFile(std::filesystem::path{filename}, sRgb);
}

inline bool loadTextureFromFile(sf::Texture& texture, const std::string& filename, const sf::IntRect& area)
{
    return texture.loadFromFile(std::filesystem::path{filename}, false, area);
}

inline bool loadTextureFromFile(sf::Texture& texture, const std::string& filename, const bool sRgb, const sf::IntRect& area)
{
    return texture.loadFromFile(std::filesystem::path{filename}, sRgb, area);
}

inline bool loadTextureFromMemory(sf::Texture& texture, const void* data, const std::size_t size)
{
    return texture.loadFromMemory(data, size);
}

inline bool loadTextureFromMemory(sf::Texture& texture, const void* data, const std::size_t size, const bool sRgb)
{
    return texture.loadFromMemory(data, size, sRgb);
}

inline bool loadTextureFromMemory(sf::Texture& texture, const void* data, const std::size_t size, const sf::IntRect& area)
{
    return texture.loadFromMemory(data, size, false, area);
}

inline bool loadTextureFromMemory(sf::Texture& texture, const void* data, const std::size_t size, const bool sRgb, const sf::IntRect& area)
{
    return texture.loadFromMemory(data, size, sRgb, area);
}

inline bool loadTextureFromImage(sf::Texture& texture, const sf::Image& image)
{
    return texture.loadFromImage(image);
}

inline bool loadTextureFromImage(sf::Texture& texture, const sf::Image& image, const bool sRgb)
{
    return texture.loadFromImage(image, sRgb);
}

inline bool loadTextureFromImage(sf::Texture& texture, const sf::Image& image, const sf::IntRect& area)
{
    return texture.loadFromImage(image, false, area);
}

inline bool loadTextureFromImage(sf::Texture& texture, const sf::Image& image, const bool sRgb, const sf::IntRect& area)
{
    return texture.loadFromImage(image, sRgb, area);
}

inline void updateTextureFromImage(sf::Texture& texture, const sf::Image& image)
{
    texture.update(image);
}

inline void updateTextureFromImage(sf::Texture& texture, const sf::Image& image, sf::Vector2u dest)
{
    texture.update(image, dest);
}

inline void updateTextureFromWindow(sf::Texture& texture, const sf::Window& window)
{
    texture.update(window);
}

inline void updateTextureFromWindow(sf::Texture& texture, const sf::Window& window, sf::Vector2u dest)
{
    texture.update(window, dest);
}

inline void resetView(sf::View& view, const sf::FloatRect& rectangle)
{
    view = sf::View(rectangle);
}

inline sf::Image captureRenderWindow(sf::RenderWindow& window)
{
    sf::Texture texture(window.getSize());
    texture.update(window);
    return texture.copyToImage();
}

inline bool resizeRenderTexture(sf::RenderTexture& texture, sf::Vector2u size, bool depthBuffer, bool sRgb)
{
    if (!depthBuffer && !sRgb)
    {
        return texture.resize(size);
    }

    sf::ContextSettings settings;
    if (depthBuffer)
    {
        settings.depthBits = 24;
    }

    settings.sRgbCapable = sRgb;
    return texture.resize(size, settings);
}

inline void shaderSetUniform(sf::Shader& shader, const char* name, const float x)
{
    shader.setUniform(name, x);
}

inline void shaderSetUniform(sf::Shader& shader, const char* name, const float x, const float y)
{
    shader.setUniform(name, sf::Glsl::Vec2{x, y});
}

inline void shaderSetUniform(sf::Shader& shader, const char* name, const float x, const float y, const float z)
{
    shader.setUniform(name, sf::Glsl::Vec3{x, y, z});
}

inline void shaderSetUniform(sf::Shader& shader, const char* name, const float x, const float y, const float z, const float w)
{
    shader.setUniform(name, sf::Glsl::Vec4{x, y, z, w});
}

inline void shaderSetUniformVec2(sf::Shader& shader, const char* name, const float x, const float y)
{
    shader.setUniform(name, sf::Glsl::Vec2{x, y});
}

inline void shaderSetUniformVec3(sf::Shader& shader, const char* name, const float x, const float y, const float z)
{
    shader.setUniform(name, sf::Glsl::Vec3{x, y, z});
}

inline void shaderSetUniformColor(sf::Shader& shader, const char* name, const sf::Color& color)
{
    shader.setUniform(name, sf::Glsl::Vec4{color});
}

inline void shaderSetUniformTransform(sf::Shader& shader, const char* name, const sf::Transform& transform)
{
    shader.setUniform(name, sf::Glsl::Mat4{transform});
}

inline void shaderSetUniformTexture(sf::Shader& shader, const char* name, const sf::Texture& texture)
{
    shader.setUniform(name, texture);
}

inline void shaderSetUniformCurrentTexture(sf::Shader& shader, const char* name)
{
    shader.setUniform(name, sf::Shader::CurrentTexture);
}

inline void bindShader(const sf::Shader* shader)
{
    sf::Shader::bind(shader);
}

inline bool shaderIsAvailable()
{
    return sf::Shader::isAvailable();
}
} // namespace pysfml::graphics_compat