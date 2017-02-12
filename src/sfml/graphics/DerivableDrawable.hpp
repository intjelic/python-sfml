/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_GRAPHICS_DERIVABLEDRAWABLE_HPP
#define PYSFML_GRAPHICS_DERIVABLEDRAWABLE_HPP

#include "Python.h"
#include <SFML/Graphics/Drawable.hpp>


const sf::Uint8* getPixelsPtr(PyObject* memoryview);

class DerivableDrawable : public sf::Drawable
{
public:
    DerivableDrawable(PyObject* object);

private:
    virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const;

    PyObject* m_object;
};

#endif // PYSFML_GRAPHICS_DERIVABLEDRAWABLE_HPP
