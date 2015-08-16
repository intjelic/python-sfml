//------------------------------------------------------------------------------
// PySFML - Python bindings for SFML
// Copyright (c) 2012-2014, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//                          Edwin Marshall <emarshall85@gmail.com>
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the
// use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software in a
//    product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//------------------------------------------------------------------------------

#include "pysfml/NumericObject.hpp"

NumericObject::NumericObject()
: m_object(NULL)
{
}

NumericObject::NumericObject(const NumericObject& copy)
{
    m_object = copy.m_object;
    Py_INCREF(m_object);
}

NumericObject::NumericObject(PyObject* object)
: m_object(object)
{
    Py_XINCREF(m_object);
}

NumericObject::~NumericObject()
{
    Py_XDECREF(m_object);
}

PyObject* NumericObject::NumericObject::get()
{
    Py_XINCREF(m_object);
    return m_object;
}

void NumericObject::set(PyObject* object)
{
    if (m_object)
        Py_DECREF(m_object);

    m_object = object;
    Py_INCREF(m_object);
}

NumericObject NumericObject::operator+() const
{
    return PyNumber_Positive(const_cast<PyObject*>(m_object));
}

NumericObject NumericObject::operator-() const
{
    return PyNumber_Negative(const_cast<PyObject*>(m_object));
}

NumericObject NumericObject::operator+(const NumericObject& object) const
{
    return PyNumber_Add(m_object, object.m_object);
}

NumericObject NumericObject::operator-(const NumericObject& object) const
{
    return PyNumber_Subtract(m_object, object.m_object);
}

NumericObject NumericObject::operator*(const NumericObject& object) const
{
    return PyNumber_Multiply(m_object, object.m_object);
}

NumericObject NumericObject::operator/(const NumericObject& object) const
{
    return PyNumber_Divide(m_object, object.m_object);
}

NumericObject NumericObject::operator~() const
{
    return PyNumber_Invert(const_cast<PyObject*>(m_object));
}

NumericObject NumericObject::operator&(const NumericObject& object) const
{
    return PyNumber_And(m_object, object.m_object);
}

NumericObject NumericObject::operator|(const NumericObject& object) const
{
    return PyNumber_Or(m_object, object.m_object);
}

NumericObject NumericObject::operator^(const NumericObject& object) const
{
    return PyNumber_Xor(m_object, object.m_object);
}

NumericObject& NumericObject::operator+=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceAdd(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator-=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceSubtract(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator*=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceMultiply(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator/=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceDivide(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator&=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceAnd(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator|=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceOr(m_object, b.m_object);
    return *this;
}

NumericObject& NumericObject::operator^=(const NumericObject& b)
{
    m_object = PyNumber_InPlaceXor(m_object, b.m_object);
    return *this;
}

bool NumericObject::operator==(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_EQ);
}

bool NumericObject::operator!=(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_NE);
}

bool NumericObject::operator<(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_LT);
}

bool NumericObject::operator>(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_GT);
}

bool NumericObject::operator<=(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_LE);
}

bool NumericObject::operator>=(const NumericObject &b) const
{
    return PyObject_RichCompareBool(m_object, b.m_object, Py_GE);
}
