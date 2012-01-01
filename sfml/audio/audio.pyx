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


from libc.stdlib cimport malloc, free
from cython.operator cimport preincrement as preinc, dereference as deref
cimport declaudio


class SFMLException(Exception): pass


cdef class Listener:
    def __cinit__(self, *args, **kwargs):
        NotImplementedError("This class can't be instanciated!")
    
    ## The six following static method should be static properties.
    @classmethod
    def get_global_volume(cls):
        return declaudio.listener.GetGlobalVolume()
    
    @classmethod
    def set_global_volume(cls, float volume):
        declaudio.listener.SetGlobalVolume(volume)
    
    #@classmethod
    #def get_position(cls, filename): pass
    
    @classmethod
    def set_position(cls, x, y, z):
        declaudio.listener.SetPosition(x, y, z)
    
    ##@classmethod
    ##def set_direction(cls, filename): pass
    
    ##@classmethod
    ##def set_direction(cls, filename): pass
    
    
cdef class SoundBuffer:
    cdef declaudio.const_SoundBuffer *p_this
    cdef bint delete_this
    
    def __init__(self):
        self.delete_this = True
        raise NotImplementedError("Use static methods like load_from_file to create SoundBuffer instances")

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    property channels_count:
        def __get__(self):
            return self.p_this.GetChannelsCount()

    property duration:
        def __get__(self):
            return self.p_this.GetDuration()

    property sample_rate:
        def __get__(self):
            return self.p_this.GetSampleRate()

    property samples:
        def __get__(self):
            cdef declaudio.Int16 *p = <declaudio.Int16*>self.p_this.GetSamples()
            cdef unsigned int i
            ret = []

            for i in range(self.p_this.GetSamplesCount()):
                ret.append(int(p[i]))

            return ret

    property samples_count:
        def __get__(self):
            return self.p_this.GetSamplesCount()

    @classmethod
    def load_from_file(cls, filename):
        cdef declaudio.SoundBuffer *p = new declaudio.SoundBuffer()

        bFilename = filename.encode('UTF-8')
        if p.LoadFromFile(bFilename):
            return wrap_sound_buffer_instance(p, True)

        raise SFMLException()

    @classmethod
    def load_from_memory(cls, bytes data):
        cdef declaudio.SoundBuffer *p = new declaudio.SoundBuffer()

        if p.LoadFromMemory(<char*>data, len(data)):
            return wrap_sound_buffer_instance(p, True)

        raise SFMLException()

    @classmethod
    def load_from_samples(cls, list samples, unsigned int channels_count,
                          unsigned int sample_rate):
        cdef declaudio.SoundBuffer *p_sb = new declaudio.SoundBuffer()
        cdef declaudio.Int16 *p_samples = <declaudio.Int16*>malloc(
            len(samples) * sizeof(declaudio.Int16))
        cdef declaudio.Int16 *p_temp = NULL

        if p_samples == NULL:
            raise SFMLException()
        else:
            p_temp = p_samples

            for sample in samples:
                p_temp[0] = <int>sample
                preinc(p_temp)

            if p_sb.LoadFromSamples(p_samples, len(samples), channels_count,
                                    sample_rate):
                free(p_samples)
                return wrap_sound_buffer_instance(p_sb, True)
            else:
                free(p_samples)
                raise SFMLException()

    def save_to_file(self, char* filename):
        self.p_this.SaveToFile(filename)


cdef SoundBuffer wrap_sound_buffer_instance(declaudio.SoundBuffer *instance, bint delete_this):
    cdef SoundBuffer ret = SoundBuffer.__new__(SoundBuffer)

    ret.p_this = instance
    ret.delete_this = delete_this

    return ret


cdef class SoundSource:
    STOPPED = declaudio.sound_source.Stopped
    PAUSED = declaudio.sound_source.Paused
    PLAYING = declaudio.sound_source.Playing
    
    cdef declaudio.SoundSource *thisptr
    
    property pitch:
        def __get__(self):
            return self.thisptr.GetPitch()

        def __set__(self, float value):
            self.thisptr.SetPitch(value)

    property volume:
        def __get__(self):
            return self.thisptr.GetVolume()

        def __set__(self, float value):
            self.thisptr.SetVolume(value)
            
    property position:
        def __get__(self):
            return NotImplemented
            #cdef declaudio.Vector3f pos = self.thisptr.GetPosition()

            #return (pos.x, pos.y, pos.z)

        def __set__(self, tuple value):
            x, y, z = value
            self.thisptr.SetPosition(x, y, z)
        
    property relative_to_listener:
        def __get__(self):
            return self.thisptr.IsRelativeToListener()

        def __set__(self, bint value):
            self.thisptr.SetRelativeToListener(value)
          
    property min_distance:
        def __get__(self):
            return self.thisptr.GetMinDistance()

        def __set__(self, float value):
            self.thisptr.SetMinDistance(value)
            
    property attenuation:
        def __get__(self):
            return self.thisptr.GetAttenuation()

        def __set__(self, float value):
            self.thisptr.SetAttenuation(value)  
            
            
cdef class Sound(SoundSource):
    cdef SoundBuffer buffer
    
    def __cinit__(self, SoundBuffer buffer=None):
        if buffer is None:
            self.thisptr = <declaudio.SoundSource*>new declaudio.Sound()
            self.buffer = None
        else:
            self.thisptr = <declaudio.SoundSource*>new declaudio.Sound(buffer.p_this[0])
            self.buffer = buffer

    def __dealloc__(self):
        del self.thisptr

    property buffer:
        def __get__(self):
            return self.buffer

        def __set__(self, SoundBuffer value):
            self.buffer = value
            (<declaudio.Sound*>self.thisptr).SetBuffer(value.p_this[0])

    property loop:
        def __get__(self):
            return (<declaudio.Sound*>self.thisptr).GetLoop()

        def __set__(self, bint value):
            (<declaudio.Sound*>self.thisptr).SetLoop(value)

    property playing_offset:
        def __get__(self):
            return (<declaudio.Sound*>self.thisptr).GetPlayingOffset()

        def __set__(self, int value):
            (<declaudio.Sound*>self.thisptr).SetPlayingOffset(value)

    property status:
        def __get__(self):
            return <int>(<declaudio.Sound*>self.thisptr).GetStatus()

    def pause(self):
        (<declaudio.Sound*>self.thisptr).Pause()

    def play(self):
        (<declaudio.Sound*>self.thisptr).Play()

    def stop(self):
        (<declaudio.Sound*>self.thisptr).Stop()


cdef class SoundStream(SoundSource):
    def __cinit__(self, *args, **kwargs):
        if self.__class__ == SoundStream:
            raise NotImplementedError("SoundStream is abstract")
          
    property channels_count:
        def __get__(self):
            return (<declaudio.SoundStream*>self.thisptr).GetChannelsCount()
            
    property sample_rate:
        def __get__(self):
            return (<declaudio.SoundStream*>self.thisptr).GetSampleRate()

    property status:
        def __get__(self):
            return <int>(<declaudio.SoundStream*>self.thisptr).GetStatus()
    property playing_offset:
        def __get__(self):
            return (<declaudio.SoundStream*>self.thisptr).GetPlayingOffset()

        def __set__(self, int value):
            (<declaudio.SoundStream*>self.thisptr).SetPlayingOffset(value)
            
    property loop:
        def __get__(self):
            return (<declaudio.SoundStream*>self.thisptr).GetLoop()

        def __set__(self, bint value):
            (<declaudio.SoundStream*>self.thisptr).SetLoop(value)
        
    def play(self):
        (<declaudio.SoundStream*>self.thisptr).Play()
            
    def pause(self):
        (<declaudio.SoundStream*>self.thisptr).Pause()

    def stop(self):
        (<declaudio.SoundStream*>self.thisptr).Stop()
        
        
cdef class Music(SoundStream):
    def __init__(self):
        raise NotImplementedError("Use class methods like open_from_file() or open_from_memory() to create Music objects")

    def __dealloc__(self):
        del self.thisptr

    property duration:
        def __get__(self):
            return (<declaudio.Music*>self.thisptr).GetDuration()

    @classmethod
    def open_from_file(cls, char* filename):
        cdef declaudio.Music *p = new declaudio.Music()

        if p.OpenFromFile(filename):
            return wrap_music_instance(p)

        raise SFMLException()

    @classmethod
    def open_from_memory(cls, bytes data):
        cdef declaudio.Music *p = new declaudio.Music()

        if p.OpenFromMemory(<char*>data, len(data)):
            return wrap_music_instance(p)

        raise SFMLException()


cdef Music wrap_music_instance(declaudio.Music *p_cpp_instance):
    cdef Music ret = Music.__new__(Music)

    ret.thisptr = <declaudio.SoundSource*>p_cpp_instance

    return ret


cdef class SoundRecorder:
    cdef declaudio.SoundRecorder *thisptr
    
    def __cinit__(self, *args, **kwargs):
        if self.__class__ == SoundRecorder:
            raise NotImplementedError("SoundRecorder is abstract")
    
    def __dealloc__(self):
        del self.thisptr
    def start(self, unsigned int sampleRate=44100):
        self.thisptr.Start(sampleRate)
        
    def stop(self):
        self.thisptr.Stop()
        
    @classmethod
    def is_available(cls):
        return declaudio.sound_recorder.IsAvailable()
        
    property sample_rate:
        def __get__(self):
            return self.thisptr.GetSampleRate()
            
    
cdef class SoundBufferRecorder(SoundRecorder):
    def __cinit__(self, *args, **kwargs):
        self.thisptr = <declaudio.SoundRecorder*>new declaudio.SoundBufferRecorder()
        
    def get_buffer(self):
        cdef declaudio.const_SoundBuffer* sb
        sb = &(<declaudio.SoundBufferRecorder*>self.thisptr).GetBuffer()
        
        cdef SoundBuffer ret = SoundBuffer.__new__(SoundBuffer)

        ret.p_this = sb
        ret.delete_this = False

        return ret
