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


#ifndef DERIVABLE_SOUND_RECORDER_HPP
#define DERIVABLE_SOUND_RECORDER_HPP

#include "Python.h"
#include <SFML/Audio.hpp>
#include "audio_api.h"


class DerivableSoundRecorder : public sf::SoundRecorder
{
public :
	DerivableSoundRecorder(void* pyThis);

protected:
	virtual bool onStart();
	virtual bool onProcessSamples(const sf::Int16* samples, std::size_t sampleCount);
	virtual void onStop();

	PyObject* m_pyobj;
};


#endif // DERIVABLE_SOUND_RECORDER_HPP
