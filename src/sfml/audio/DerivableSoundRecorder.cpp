/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML and is available under the zlib license.
*/

#include <pysfml/audio/DerivableSoundRecorder.hpp>
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

bool DerivableSoundRecorder::onProcessSamples(const std::int16_t* samples, std::size_t sampleCount)
{
    static char method[] = "on_process_samples";
    static char format[] = "O";

    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();

    PyObject* pyChunk = (PyObject*)(wrap_chunk(const_cast<std::int16_t*>(samples), sampleCount, false));
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
