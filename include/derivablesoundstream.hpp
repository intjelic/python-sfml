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


#ifndef DERIVABLE_SOUND_STREAM_HPP
#define DERIVABLE_SOUND_STREAM_HPP

#include "Python.h"
#include <SFML/Audio.hpp>
#include "audio_api.h"
#include "system_api.h"

class DerivableSoundStream : public sf::SoundStream
{
public :
	DerivableSoundStream(void* pyThis);
	
	void initialize(unsigned int channelCount, unsigned int sampleRate);
	
protected:
	virtual bool onGetData(sf::SoundStream::Chunk &data);
	virtual void onSeek(sf::Time timeOffset);
	
	PyObject* m_pyobj;
};


#endif // DERIVABLE_SOUND_STREAM_HPP
