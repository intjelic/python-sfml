/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML and is available under the zlib license.
*/

#ifndef PYSFML_SYSTEM_HACKS_HPP
#define PYSFML_SYSTEM_HACKS_HPP

#include <Python.h>
#include <cstdint>
#include <SFML/System.hpp>

#if PY_VERSION_HEX >= 0x03000000
    #define PyString_AsString PyBytes_AsString
#endif

sf::Time Time_div_int(sf::Time left, std::int64_t right);
sf::Time Time_div_float(sf::Time left, float right);
float Time_div_Time(sf::Time left, sf::Time right);
sf::String String_from_utf32(const std::uint32_t* utf32_string);
const std::uint32_t* String_get_utf32_data(const sf::String& string);

void Time_idiv_int(sf::Time& left, std::int64_t right);
void Time_idiv_float(sf::Time& left, float right);

#endif // PYSFML_SYSTEM_HACKS_HPP
