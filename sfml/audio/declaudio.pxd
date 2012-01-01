########################################################################
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>   #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################


from declsystem cimport Int16,  Uint8, Uint32
cimport listener    

cdef extern from "SFML/Audio.hpp" namespace "sf":
    cdef cppclass SoundBuffer:
        SoundBuffer()
        unsigned int GetChannelsCount()
        Uint32 GetDuration()
        Int16* GetSamples()
        unsigned int GetSampleRate()
        size_t GetSamplesCount()
        bint LoadFromFile(char*)
        bint LoadFromMemory(void*, size_t)
        bint LoadFromSamples(Int16*, size_t, unsigned int, unsigned int)
        bint SaveToFile(char*)

cimport sound_source
cimport sound_recorder

cdef extern from "SFML/Audio.hpp" namespace "sf":
    cdef cppclass SoundSource:
        void SetPitch(float pitch)
        void SetVolume(float volume)
        void SetPosition(float x, float y, float z)
        #void SetPosition(const Vector3f &position)
        void SetRelativeToListener(bint relative)
        void SetMinDistance(float distance)
        void SetAttenuation(float attenuation)
        float GetPitch()
        float GetVolume()
        #Vector3f GetPosition()
        bint IsRelativeToListener()
        float GetMinDistance()
        float GetAttenuation() 
        

    cdef cppclass Sound:
        Sound()
        Sound(SoundBuffer&)
        SoundBuffer* GetBuffer()
        bint GetLoop()
        Uint32 GetPlayingOffset()
        float GetVolume()
        sound_source.Status GetStatus()
        void Pause()
        void Play()
        void SetBuffer(SoundBuffer&)
        void SetLoop(bint)
        void SetPlayingOffset(Uint32)
        void SetVolume(float)
        void Stop()
        
        
    cdef cppclass SoundStream:
        void Play()
        void Pause()
        void Stop()
        unsigned int GetChannelsCount()
        unsigned int GetSampleRate()
        sound_source.Status GetStatus()
        void SetPlayingOffset(Uint32 timeOffset)
        Uint32 GetPlayingOffset()
        void SetLoop(bint loop)
        bint GetLoop()


    cdef cppclass Music:
        Music()
        Uint32 GetDuration()
        bint OpenFromFile(char*)
        bint OpenFromMemory(void*, size_t)
        
        
    cdef cppclass SoundRecorder:
        void Start(unsigned int sampleRate)
        void Stop()
        unsigned int GetSampleRate()
        
        
    cdef cppclass SoundBufferRecorder:
        #SoundBufferRecorder()
        SoundBuffer& GetBuffer()

ctypedef SoundBuffer const_SoundBuffer "const SoundBuffer" 
