#ifndef SOUND_STREAM_HPP
#define SOUND_STREAM_HPP


#include "Python.h"
#include <SFML/Audio.hpp>


class CppSoundStream : public sf::SoundStream
{
public :
    CppSoundStream(void* obj);

private :
    virtual bool OnGetData(sf::Chunk& data);
    virtual void OnSeek(Uint32 timeOffset);

    char  m_ogdFormat[];
    char  m_ogdMethodName[];
    char  m_osFormat[];
    char  m_osMethodName[];
	void* m_pyThis; // this is a PyObject pointer
};


#endif // SOUND_STREAM_HPP
