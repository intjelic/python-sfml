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

#include "DerivableSoundStream.hpp"
#include <iostream>

DerivableSoundStream::DerivableSoundStream(void* pyobj):
sf::SoundStream (),
m_pyobj         (static_cast<PyObject*>(pyobj))
{
    PyEval_InitThreads();
    import_sfml__system(); // make sure the system module is imported
    import_sfml__audio(); // make sure the audio module is imported
};

void DerivableSoundStream::initialize(unsigned int channelCount, unsigned int sampleRate)
{
    sf::SoundStream::initialize(channelCount, sampleRate);
}

bool DerivableSoundStream::onGetData(sf::SoundStream::Chunk &data)
{
    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();

    static char method[] = "on_get_data";
    static char format[] = "O";

    PyObject* pyChunk = (PyObject*)(create_chunk());
    PyObject* r = PyObject_CallMethod(m_pyobj, method, format, pyChunk);

    if(!r)
        PyErr_Print();

    data.samples = static_cast<const sf::Int16*>(terminate_chunk(pyChunk));
    data.sampleCount = PyObject_Length(pyChunk);

    Py_DECREF(pyChunk);

    PyGILState_Release(gstate);

    return PyObject_IsTrue(r);
}

void DerivableSoundStream::onSeek(sf::Time timeOffset)
{
    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();

    static char method[] = "on_seek";
    static char format[] = "O";

    sf::Time* copyTimeOffset = new sf::Time;
    *copyTimeOffset = timeOffset;

    PyObject* pyTime = (PyObject*)(wrap_time(copyTimeOffset));
    PyObject* success = PyObject_CallMethod(m_pyobj, method, format, pyTime);

    if(!success)
        PyErr_Print();

    Py_DECREF(pyTime);

    PyGILState_Release(gstate);
}

