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

#ifndef DERIVABLE_SOUND_STREAM_HPP
#define DERIVABLE_SOUND_STREAM_HPP

#include "Python.h"
#include <SFML/Audio.hpp>
#include "pysfml/NumericObject.hpp"
#include "pysfml/audio_api.h"
#include "pysfml/system_api.h"

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
