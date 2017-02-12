/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_WINDOW_DERIVABLEWINDOW_HPP
#define PYSFML_WINDOW_DERIVABLEWINDOW_HPP

#include "Python.h"
#include <SFML/Window/Window.hpp>

class DerivableWindow : public sf::Window
{
public:
    DerivableWindow(PyObject* object);

protected:
    virtual void onCreate();
    virtual void onResize();

private:
    PyObject* m_object;
};

#endif // PYSFML_WINDOW_DERIVABLEWINDOW_HPP
