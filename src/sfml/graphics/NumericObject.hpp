/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_GRAPHICS_NUMERICOBJECT_HPP
#define PYSFML_GRAPHICS_NUMERICOBJECT_HPP

#include "Python.h"
#include <SFML/Config.hpp>

class SFML_API_EXPORT NumericObject
{
public:
    NumericObject();
    NumericObject(const NumericObject& copy);
    NumericObject(PyObject* object);

    ~NumericObject();

    PyObject* get();
    void set(PyObject* object);

    NumericObject operator+() const;
    NumericObject operator-() const;
    NumericObject operator+(const NumericObject& object) const;
    NumericObject operator-(const NumericObject& object) const;
    NumericObject operator*(const NumericObject& object) const;
    NumericObject operator/(const NumericObject& object) const;
    NumericObject operator~() const;
    NumericObject operator&(const NumericObject& object) const;
    NumericObject operator|(const NumericObject& object) const;
    NumericObject operator^(const NumericObject& object) const;

    NumericObject& operator+=(const NumericObject& b);
    NumericObject& operator-=(const NumericObject& b);
    NumericObject& operator*=(const NumericObject& b);
    NumericObject& operator/=(const NumericObject& b);
    NumericObject& operator&=(const NumericObject& b);
    NumericObject& operator|=(const NumericObject& b);
    NumericObject& operator^=(const NumericObject& b);

    bool operator==(const NumericObject &b) const;
    bool operator!=(const NumericObject &b) const;
    bool operator<(const NumericObject &b) const;
    bool operator>(const NumericObject &b) const;
    bool operator<=(const NumericObject &b) const;
    bool operator>=(const NumericObject &b) const;

private:
    PyObject* m_object;
};

#endif // PYSFML_GRAPHICS_NUMERICOBJECT_HPP
