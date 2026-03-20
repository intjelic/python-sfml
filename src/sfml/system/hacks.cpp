/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML and is available under the zlib license.
*/

#include <pysfml/system/hacks.hpp>

sf::Time Time_div_int(sf::Time left, std::int64_t right)
{
    return left / right;
}

sf::Time Time_div_float(sf::Time left, float right)
{
    return left / right;
}

float Time_div_Time(sf::Time left, sf::Time right)
{
    return left / right;
}

sf::String String_from_utf32(const std::uint32_t* utf32_string)
{
    return sf::String(reinterpret_cast<const char32_t*>(utf32_string));
}

const std::uint32_t* String_get_utf32_data(const sf::String& string)
{
    return reinterpret_cast<const std::uint32_t*>(string.getData());
}

void Time_idiv_int(sf::Time& left, std::int64_t right)
{
    left /= right;
}

void Time_idiv_float(sf::Time& left, float right)
{
    left /= right;
}
