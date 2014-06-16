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

#include "DerivableWindow.hpp"


DerivableWindow::DerivableWindow():
sf::Window ()
{
}

DerivableWindow::DerivableWindow(sf::VideoMode mode, const std::string& title, sf::Uint32 style, const sf::ContextSettings& settings):
sf::Window (mode, title, style, settings)
{
}

DerivableWindow::DerivableWindow(sf::WindowHandle handle, const sf::ContextSettings& settings):
sf::Window (handle, settings)
{
}


void DerivableWindow::onCreate()
{
    static char method[] = "on_create";
    PyObject* success = PyObject_CallMethod(m_pyobj, method, NULL);

    if(!success)
        PyErr_Print();
}

void DerivableWindow::onResize()
{
    static char method[] = "on_resize";
    PyObject* success = PyObject_CallMethod(m_pyobj, method, NULL);

    if(!success)
        PyErr_Print();
}

void DerivableWindow::set_pyobj(void* pyobj)
{
    m_pyobj = static_cast<PyObject*>(pyobj);
}
