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

#include "error.hpp"
#include <sstream>
#include <SFML/System.hpp>

static std::stringbuf buffer;

// Insert our own buffer to retrieve and forward errors to Python
// exceptions. This function allows to restore the Python buffer in case people
// would interface Python with C++ code and so reredirect the error output.
void restorePythonErrorBuffer()
{
    sf::err().rdbuf(&buffer);
}

// Return the last error (if any) then clear the buffer to welcome the next one.
PyObject* getLastErrorMessage()
{
    // Get the error message then clean the buffer
#if PY_MAJOR_VERSION >= 3
    PyObject* error = PyBytes_FromString(buffer.str().c_str());
#else
    PyObject* error = PyString_FromString(buffer.str().c_str());
#endif

    buffer.str("");

    return error;
}
