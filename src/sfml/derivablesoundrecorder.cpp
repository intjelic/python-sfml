////////////////////////////////////////////////////////////////////////////////
//
// pySFML - Python bindings for SFML
// Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////


#include "pysfml/derivablesoundrecorder.hpp"
#include <iostream>

DerivableSoundRecorder::DerivableSoundRecorder(void* pyobj):
sf::SoundRecorder (),
m_pyobj           (static_cast<PyObject*>(pyobj))
{
	import_sfml__audio(); // make sure the audio module is imported
};

bool DerivableSoundRecorder::onStart()
{
    PyEval_InitThreads();
    
	static char method[] = "on_start";
    PyObject* r = PyObject_CallMethod(m_pyobj, method, NULL);
    
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

	Py_DECREF(pyChunk);
	PyGILState_Release(gstate);
	
    return PyObject_IsTrue(r);
}

void DerivableSoundRecorder::onStop()
{
    PyGILState_STATE gstate;
    gstate = PyGILState_Ensure();
    
	static char method[] = "on_stop";
    PyObject_CallMethod(m_pyobj, method, NULL);
    
   	PyGILState_Release(gstate);
}
