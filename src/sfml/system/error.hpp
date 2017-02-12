/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML project and is available under the zlib
* license.
*/

#ifndef PYSFML_SYSTEM_ERROR_HPP
#define PYSFML_SYSTEM_ERROR_HPP

#include "Python.h"

void restorePythonErrorBuffer();
PyObject* getLastErrorMessage();

#endif // PYSFML_SYSTEM_ERROR_HPP
