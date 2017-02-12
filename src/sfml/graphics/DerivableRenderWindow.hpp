/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_GRAPHICS_DERIVABLERENDERWINDOW_HPP
#define PYSFML_GRAPHICS_DERIVABLERENDERWINDOW_HPP

#include "Python.h"
#include <SFML/Graphics/RenderWindow.hpp>

class DerivableRenderWindow : public sf::RenderWindow
{
public:
    DerivableRenderWindow(PyObject* object);

    void createWindow();
    void resizeWindow();

protected:
    virtual void onCreate();
    virtual void onResize();

private:
    PyObject* m_object;
};

#endif // PYSFML_GRAPHICS_DERIVABLERENDERWINDOW_HPP
