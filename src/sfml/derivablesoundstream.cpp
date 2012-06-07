#include "derivablesoundstream.hpp"
#include <iostream>

DerivableSoundStream::DerivableSoundStream(void* pyobj):
sf::SoundStream (),
m_pyobj         (static_cast<PyObject*>(pyobj))
{
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
    
    PyObject* pyChunk = (PyObject*)(wrap_chunk((sf::Int16*)data.samples, data.sampleCount));
    PyObject* r = PyObject_CallMethod(m_pyobj, method, format, pyChunk);
    
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
    PyObject_CallMethod(m_pyobj, method, format, pyTime);
    
 	Py_DECREF(pyTime);
 	
	PyGILState_Release(gstate);
}

