/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*                          Edwin Marshall <emarshall85@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#include <pysfml/graphics/DerivableRenderWindow.hpp>

DerivableRenderWindow::DerivableRenderWindow(PyObject* object) :
m_object(object)
{
}

void DerivableRenderWindow::onCreate()
{
    static char method[] = "on_create";
    PyObject* success = PyObject_CallMethod(m_object, method, NULL);

    if(!success)
        PyErr_Print();
}

void DerivableRenderWindow::onResize()
{
    static char method[] = "on_resize";
    PyObject* success = PyObject_CallMethod(m_object, method, NULL);

    if(!success)
        PyErr_Print();
}
