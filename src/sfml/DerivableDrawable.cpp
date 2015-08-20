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

#include "DerivableDrawable.hpp"
#include <SFML/Graphics.hpp>
#include "pysfml/NumericObject.hpp"
#include "pysfml/graphics_api.h"

DerivableDrawable::DerivableDrawable(PyObject* object) :
m_object(object)
{
    import_sfml__graphics(); // make sure the graphics module is imported
};

void DerivableDrawable::draw(sf::RenderTarget& target_, sf::RenderStates states_) const
{
    static char format[] = "(O, O)";
    static char methodName[] = "draw";

    PyObject* target = (PyObject*)(wrap_rendertarget(&target_));
    PyObject* states = (PyObject*)(wrap_renderstates(&states_, false));

    PyObject* success = PyObject_CallMethod(m_object, methodName, format, target, states);

    if(!success)
        PyErr_Print();

    Py_DECREF(target);
    Py_DECREF(states);
}
