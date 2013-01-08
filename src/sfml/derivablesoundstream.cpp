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


#include "pysfml/derivablesoundstream.hpp"
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
    PyObject_CallMethod(m_pyobj, method, format, pyTime);
    
 	Py_DECREF(pyTime);
 	
	PyGILState_Release(gstate);
}

