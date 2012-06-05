#include "derivablesoundrecorder.hpp"
#include <iostream>

DerivableSoundRecorder::DerivableSoundRecorder(void* pyobj):
sf::SoundRecorder (),
m_pyobj           (static_cast<PyObject*>(pyobj))
{
	import_sfml__audio(); // make sure the audio module is imported
};

bool DerivableSoundRecorder::onStart()
{
	static char method[] = "on_start";
    PyObject* r = PyObject_CallMethod(m_pyobj, method, NULL);
    
    return true;
    return PyObject_IsTrue(r);
}

bool DerivableSoundRecorder::onProcessSamples(const sf::Int16* samples, std::size_t sampleCount)
{
	static char method[] = "on_process_samples";	
    static char format[] = "O";

    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();
    
    PyObject* pyChunk = (PyObject*)(wrap_chunk((sf::Int16*)samples, sampleCount));
    PyObject* r = PyObject_CallMethod(m_pyobj, method, format, pyChunk);

	Py_DECREF(pyChunk);
	PyGILState_Release(gstate);
	
	return true;
    return PyObject_IsTrue(r);
}

void DerivableSoundRecorder::onStop()
{
	std::cout << "onStop()" << std::endl;
	static char method[] = "on_stop";
    PyObject_CallMethod(m_pyobj, method, NULL);
}
