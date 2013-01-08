#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64
from dsystem cimport Time, Vector3f

cimport listener, soundsource, soundrecorder

cdef extern from "SFML/Audio.hpp" namespace "sf":
	ctypedef Int16* const_Int16 "const sf::Int16*"	
	
	cdef cppclass SoundBuffer:
		SoundBuffer()
		bint loadFromFile(char*&)
		bint loadFromMemory(void*, size_t)
		bint loadFromSamples(Int16*, size_t, unsigned int, unsigned int)
		bint saveToFile(char*&)
		Int16* getSamples()
		size_t getSampleCount()	
		unsigned int getSampleRate()
		unsigned int getChannelCount()
		Time getDuration()

cdef extern from "SFML/Audio.hpp" namespace "sf::SoundStream":
	cdef struct Chunk:
		const_Int16 samples
		size_t sampleCount

cdef extern from "SFML/Audio.hpp" namespace "sf":
	cdef cppclass SoundSource:
		void setPitch(float)
		void setVolume(float)
		void setPosition(float, float, float)
		void setPosition(Vector3f&)
		void setRelativeToListener(bint)
		void setMinDistance(float)
		void setAttenuation(float)
		float getPitch()
		float getVolume()
		Vector3f getPosition()
		bint isRelativeToListener()
		float getMinDistance()
		float getAttenuation() 

	cdef cppclass Sound:
		Sound()
		Sound(SoundBuffer&)
		void play()
		void pause()
		void stop()
		void setBuffer(SoundBuffer&)
		void setLoop(bint)
		void setPlayingOffset(Time)
		SoundBuffer* getBuffer()
		bint getLoop()
		Time getPlayingOffset()
		soundsource.Status getStatus()
		void resetBuffer()

	cdef cppclass SoundStream:
		void play()
		void pause()
		void stop()
		unsigned int getChannelCount()
		unsigned int getSampleRate()
		soundsource.Status getStatus()
		void setPlayingOffset(Time)
		Time getPlayingOffset()
		void setLoop(bint)
		bint getLoop()

	cdef cppclass Music:
		Music()
		bint openFromFile(char*&)
		bint openFromMemory(void*, size_t)
		Time getDuration()	

	cdef cppclass SoundRecorder:
		void start(unsigned int)
		void stop() nogil
		unsigned int getSampleRate()

	cdef cppclass SoundBufferRecorder:
		SoundBufferRecorder()
		SoundBuffer& getBuffer()
		
cdef extern from "pysfml/derivablesoundstream.hpp":
	cdef cppclass DerivableSoundStream:
		DerivableSoundStream(void*)
		void initialize(unsigned int, unsigned int)
		
cdef extern from "pysfml/derivablesoundrecorder.hpp":
	cdef cppclass DerivableSoundRecorder:
		DerivableSoundRecorder(void*)
		
