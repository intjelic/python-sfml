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
