/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2016, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*                          Edwin Marshall <emarshall85@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#include "DerivableDrawable.hpp"
#include <SFML/Graphics.hpp>
#include "pysfml/NumericObject.hpp"
#include "pysfml/graphics_api.h"

DerivableDrawable::DerivableDrawable(PyObject* object) :
m_object(object)
{
    import_sfml__graphics();
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
