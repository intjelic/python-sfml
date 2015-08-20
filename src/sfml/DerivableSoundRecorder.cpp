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

#include "DerivableSoundRecorder.hpp"
#include <iostream>

DerivableSoundRecorder::DerivableSoundRecorder(void* pyobj):
sf::SoundRecorder (),
m_pyobj           (static_cast<PyObject*>(pyobj))
{
    import_sfml__audio();
};

bool DerivableSoundRecorder::onStart()
{
    PyEval_InitThreads();

    static char method[] = "on_start";
    PyObject* r = PyObject_CallMethod(m_pyobj, method, NULL);

    if(!r)
        PyErr_Print();

    return PyObject_IsTrue(r);
}

bool DerivableSoundRecorder::onProcessSamples(const sf::Int16* samples, std::size_t sampleCount)
{
    static char method[] = "on_process_samples";
    static char format[] = "O";

    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();

    PyObject* pyChunk = (PyObject*)(wrap_chunk((sf::Int16*)samples, sampleCount, false));
    PyObject* r = PyObject_CallMethod(m_pyobj, method, format, pyChunk);

    if(!r)
        PyErr_Print();

    Py_DECREF(pyChunk);
    PyGILState_Release(gstate);

    return PyObject_IsTrue(r);
}

void DerivableSoundRecorder::onStop()
{
    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();

    static char method[] = "on_stop";
    PyObject* success = PyObject_CallMethod(m_pyobj, method, NULL);

    if(!success)
        PyErr_Print();

    PyGILState_Release(gstate);
}
