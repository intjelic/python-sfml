/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_SYSTEM_HACKS_HPP
#define PYSFML_SYSTEM_HACKS_HPP

#include <Python.h>
#include <SFML/System.hpp>

#if PY_VERSION_HEX >= 0x03000000
    #define PyString_AsString PyBytes_AsString
#endif

sf::Time Time_div_int(sf::Time left, sf::Int64 right);
sf::Time Time_div_float(sf::Time left, float right);
float Time_div_Time(sf::Time left, sf::Time right);

void Time_idiv_int(sf::Time& left, sf::Int64 right);
void Time_idiv_float(sf::Time& left, float right);

#endif // PYSFML_SYSTEM_HACKS_HPP
