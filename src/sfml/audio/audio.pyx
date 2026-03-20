# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

#from libc.stdlib cimport malloc, free
#from cython.operator cimport preincrement as preinc, dereference as deref

cimport cython
from libc.stdlib cimport malloc, free
from libc.stdint cimport int16_t
from libc.string cimport memcpy
from libcpp.string cimport string
from libcpp.vector cimport vector

cimport sfml as sf
from sfml cimport listener as sf_listener
from sfml cimport soundrecorder as sf_soundrecorder
from sfml cimport soundsource as sf_soundsource
from pysfml cimport system as pysfml_system

from enum import IntEnum

__all__ = [
    'PlaybackDevice', 'Listener', 'Cone', 'SoundChannel', 'Chunk',
    'SoundBuffer', 'Status', 'SoundSource', 'Sound', 'SoundStream',
    'Music', 'SoundRecorder', 'SoundBufferRecorder'
]

pysfml_system.import_sfml__system()

cdef extern from "pysfml/audio/DerivableSoundStream.hpp":
    cdef cppclass DerivableSoundStream:
        DerivableSoundStream(void*)
        void initialize(unsigned int, unsigned int, const vector[sf.SoundChannel]&)

cdef extern from "pysfml/audio/DerivableSoundRecorder.hpp":
    cdef cppclass DerivableSoundRecorder:
        DerivableSoundRecorder(void*)

cdef extern from "pysfml/audio/audio_compat.hpp" namespace "pysfml::audio_compat":
    cdef cppclass ConeData:
        sf.Angle innerAngle
        sf.Angle outerAngle
        float outerGain

    vector[string] getAvailablePlaybackDevices()
    string getDefaultPlaybackDevice()
    bint setPlaybackDevice(const string& name)
    string getPlaybackDevice()
    vector[sf.SoundChannel] defaultChannelMap(unsigned int channel_count)
    bint loadSoundBufferFromSamples(sf.SoundBuffer& buffer, const int16_t* samples, size_t sample_count, unsigned int channel_count, unsigned int sample_rate, const vector[sf.SoundChannel]& channel_map)
    ConeData getListenerCone()
    void setListenerCone(const ConeData& cone)
    ConeData getSoundSourceCone(const sf.SoundSource& soundSource)
    void setSoundSourceCone(sf.SoundSource& soundSource, const ConeData& cone)
    sf.Time getMusicLoopOffset(const sf.Music& music)
    sf.Time getMusicLoopLength(const sf.Music& music)
    void setMusicLoopPoints(sf.Music& music, sf.Time offset, sf.Time length)
    void setListenerPosition(const sf.Vector3f& position)
    void setListenerDirection(const sf.Vector3f& direction)
    void setListenerVelocity(const sf.Vector3f& velocity)
    void setListenerUpVector(const sf.Vector3f& upVector)


cdef inline string _to_utf8_string(str value):
    cdef string encoded = value.encode('UTF-8')
    return encoded


cdef inline object _decode_utf8_string(const string& value):
    cdef const char* raw = value.c_str()
    return (<bytes>raw).decode('UTF-8')


cdef inline object _decode_optional_string(const string& value):
    if value.size() == 0:
        return None
    return _decode_utf8_string(value)


cdef inline sf.Angle _to_cpp_angle(object angle):
    if not isinstance(angle, pysfml_system.Angle):
        raise TypeError("angle must be an sfml.system.Angle")
    return (<pysfml_system.Angle>angle).p_this[0]


cdef inline object _wrap_angle_copy(sf.Angle angle):
    cdef sf.Angle* copy_angle = new sf.Angle()
    copy_angle[0] = angle
    return pysfml_system.wrap_angle(copy_angle)


cdef object _wrap_sound_channel_map(vector[sf.SoundChannel] channel_map):
    cdef list result = []
    cdef size_t index

    for index in range(channel_map.size()):
        result.append(SoundChannel(<int>channel_map[index]))

    return result


cdef vector[sf.SoundChannel] _to_sound_channel_map(object channel_map, unsigned int channel_count):
    cdef vector[sf.SoundChannel] result
    cdef object channel
    cdef int channel_value

    if channel_map is None:
        return defaultChannelMap(channel_count)

    if len(channel_map) != channel_count:
        raise ValueError("channel_map length must match channel_count")

    for channel in channel_map:
        channel_value = int(SoundChannel(channel))
        result.push_back(<sf.SoundChannel>channel_value)

    return result


cdef inline ConeData _to_cone_data(Cone cone):
    cdef ConeData data
    data.innerAngle = cone.m_inner_angle
    data.outerAngle = cone.m_outer_angle
    data.outerGain = cone.m_outer_gain
    return data


cdef object _wrap_cone_data(ConeData data):
    cdef Cone cone = Cone.__new__(Cone)
    cone.m_inner_angle = data.innerAngle
    cone.m_outer_angle = data.outerAngle
    cone.m_outer_gain = data.outerGain
    return cone


class SoundChannel(IntEnum):
    UNSPECIFIED = sf.Unspecified
    MONO = sf.Mono
    FRONT_LEFT = sf.FrontLeft
    FRONT_RIGHT = sf.FrontRight
    FRONT_CENTER = sf.FrontCenter
    FRONT_LEFT_OF_CENTER = sf.FrontLeftOfCenter
    FRONT_RIGHT_OF_CENTER = sf.FrontRightOfCenter
    LOW_FREQUENCY_EFFECTS = sf.LowFrequencyEffects
    BACK_LEFT = sf.BackLeft
    BACK_RIGHT = sf.BackRight
    BACK_CENTER = sf.BackCenter
    SIDE_LEFT = sf.SideLeft
    SIDE_RIGHT = sf.SideRight
    TOP_CENTER = sf.TopCenter
    TOP_FRONT_LEFT = sf.TopFrontLeft
    TOP_FRONT_RIGHT = sf.TopFrontRight
    TOP_FRONT_CENTER = sf.TopFrontCenter
    TOP_BACK_LEFT = sf.TopBackLeft
    TOP_BACK_RIGHT = sf.TopBackRight
    TOP_BACK_CENTER = sf.TopBackCenter


cdef class PlaybackDevice:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated")

    @staticmethod
    def get_available_devices():
        cdef vector[string] devices = getAvailablePlaybackDevices()
        cdef list result = []
        cdef size_t index

        for index in range(devices.size()):
            result.append(_decode_utf8_string(devices[index]))

        return result

    @staticmethod
    def get_default_device():
        return _decode_optional_string(getDefaultPlaybackDevice())

    @staticmethod
    def set_device(str name):
        return setPlaybackDevice(_to_utf8_string(name))

    @staticmethod
    def get_device():
        return _decode_optional_string(getPlaybackDevice())


cdef class Cone:
    cdef sf.Angle m_inner_angle
    cdef sf.Angle m_outer_angle
    cdef float m_outer_gain

    def __init__(self, inner_angle=None, outer_angle=None, float outer_gain=1.0):
        if inner_angle is None:
            self.m_inner_angle = sf.degrees(360)
        else:
            self.m_inner_angle = _to_cpp_angle(inner_angle)

        if outer_angle is None:
            self.m_outer_angle = sf.degrees(360)
        else:
            self.m_outer_angle = _to_cpp_angle(outer_angle)

        self.m_outer_gain = outer_gain

    def __repr__(self):
        return "Cone(inner_angle={0}, outer_angle={1}, outer_gain={2})".format(
            self.inner_angle, self.outer_angle, self.outer_gain
        )

    def __richcmp__(Cone self, Cone other, int op):
        if op == 2:
            return (
                self.m_inner_angle == other.m_inner_angle and
                self.m_outer_angle == other.m_outer_angle and
                self.m_outer_gain == other.m_outer_gain
            )
        elif op == 3:
            return not self.__richcmp__(other, 2)
        return NotImplemented

    property inner_angle:
        def __get__(self):
            return _wrap_angle_copy(self.m_inner_angle)

        def __set__(self, angle):
            self.m_inner_angle = _to_cpp_angle(angle)

    property outer_angle:
        def __get__(self):
            return _wrap_angle_copy(self.m_outer_angle)

        def __set__(self, angle):
            self.m_outer_angle = _to_cpp_angle(angle)

    property outer_gain:
        def __get__(self):
            return self.m_outer_gain

        def __set__(self, float outer_gain):
            self.m_outer_gain = outer_gain


cdef class Listener:
    def __init__(self):
        raise NotImplementedError("This class is not meant to be instantiated")

    @staticmethod
    def get_global_volume():
        return sf_listener.getGlobalVolume()

    @staticmethod
    def set_global_volume(float volume):
        sf_listener.setGlobalVolume(volume)

    @staticmethod
    def get_position():
        cdef sf.Vector3f p = sf_listener.getPosition()
        return pysfml_system.wrap_vector3f(p)

    @staticmethod
    def set_position(position):
        cdef sf.Vector3f p = pysfml_system.to_vector3f(position)
        setListenerPosition(p)

    @staticmethod
    def get_direction():
        cdef sf.Vector3f p = sf_listener.getDirection()
        return pysfml_system.wrap_vector3f(p)

    @staticmethod
    def set_direction(direction):
        cdef sf.Vector3f p = pysfml_system.to_vector3f(direction)
        setListenerDirection(p)

    @staticmethod
    def get_velocity():
        cdef sf.Vector3f p = sf_listener.getVelocity()
        return pysfml_system.wrap_vector3f(p)

    @staticmethod
    def set_velocity(velocity):
        cdef sf.Vector3f p = pysfml_system.to_vector3f(velocity)
        setListenerVelocity(p)

    @staticmethod
    def get_cone():
        return _wrap_cone_data(getListenerCone())

    @staticmethod
    def set_cone(Cone cone):
        setListenerCone(_to_cone_data(cone))

    @staticmethod
    def get_up_vector():
        cdef sf.Vector3f p = sf_listener.getUpVector()
        return pysfml_system.wrap_vector3f(p)

    @staticmethod
    def set_up_vector(up_vector):
        cdef sf.Vector3f p = pysfml_system.to_vector3f(up_vector)
        setListenerUpVector(p)

cdef public class Chunk[type PyChunkType, object PyChunkObject]:
    cdef int16_t* m_samples
    cdef size_t m_sampleCount
    cdef bint   delete_this

    def __cinit__(self):
        self.m_samples = NULL
        self.m_sampleCount = 0
        self.delete_this = False

    def __init__(self, data=None):
        if data is not None:
            self.data = data

    def __dealloc__(self):
        if self.delete_this:
            free(self.m_samples)

    def __repr__(self):
        return "Chunk(size={0}, data={1})".format(len(self), self.data[:10])

    def __len__(self):
        return self.m_sampleCount

    def __getitem__(self, size_t key):
        if key >= self.m_sampleCount:
            raise IndexError("chunk index out of range")
        return self.m_samples[key]

    def __setitem__(self, size_t key, int16_t other):
        if key >= self.m_sampleCount:
            raise IndexError("chunk assignment index out of range")
        self.m_samples[key] = other

    property data:
        def __get__(self):
            return (<char*>self.m_samples)[:len(self)*2]

        def __set__(self, bdata):
            cdef bytes data = bytes(bdata)
            cdef Py_ssize_t data_length = len(data)

            if data_length % 2:
                raise ValueError("Chunk data length must be even as it represents a 16bit array")

            if self.delete_this:
                free(self.m_samples)
                self.m_samples = NULL
                self.m_sampleCount = 0

            if data_length == 0:
                self.delete_this = True
                return

            self.m_samples = <int16_t*>malloc(data_length)
            if self.m_samples == NULL:
                raise MemoryError()

            memcpy(self.m_samples, <char*>data, data_length)
            self.m_sampleCount = data_length // 2

            self.delete_this = True

cdef api object create_chunk():
    cdef Chunk r = Chunk.__new__(Chunk)
    r.m_samples = NULL
    r.m_sampleCount = 0
    r.delete_this = False
    return r

cdef api int16_t* terminate_chunk(chunk):
    cdef Chunk p = <Chunk>chunk
    p.delete_this = False
    return p.m_samples

cdef api object wrap_chunk(int16_t* samples, unsigned int sample_count, bint delete):
    cdef Chunk r = Chunk.__new__(Chunk)
    r.m_samples = samples
    r.m_sampleCount = sample_count
    r.delete_this = delete
    return r

cdef class SoundBuffer:
    cdef sf.SoundBuffer *p_this
    cdef bint            delete_this

    def __init__(self):
        raise UserWarning("Use specific methods")

    def __dealloc__(self):
        if self.delete_this:
            del self.p_this

    def __repr__(self):
        return "SoundBuffer(sample_rate={0}, channel_count={1}, duration={2})".format(self.sample_rate, self.channel_count, self.duration)

    @classmethod
    def from_file(cls, str filename):
        cdef sf.SoundBuffer *p = new sf.SoundBuffer()

        if p.loadFromFile(filename.encode('UTF-8')):
            return wrap_soundbuffer(p)

        del p
        raise IOError(pysfml_system.popLastErrorMessage())

    @classmethod
    def from_memory(cls, data):
        cdef bytes data_bytes = bytes(data)
        cdef sf.SoundBuffer *p = new sf.SoundBuffer()

        if p.loadFromMemory(<char*>data_bytes, len(data_bytes)):
            return wrap_soundbuffer(p)

        del p
        raise IOError(pysfml_system.popLastErrorMessage())

    @classmethod
    def from_samples(cls, Chunk samples, unsigned int channel_count, unsigned int sample_rate, channel_map=None):
        cdef sf.SoundBuffer *p = new sf.SoundBuffer()
        cdef vector[sf.SoundChannel] cpp_channel_map = _to_sound_channel_map(channel_map, channel_count)

        if loadSoundBufferFromSamples(p[0], samples.m_samples, samples.m_sampleCount, channel_count, sample_rate, cpp_channel_map):
            return wrap_soundbuffer(p)

        del p
        raise IOError(pysfml_system.popLastErrorMessage())

    def to_file(self, str filename):
        if not self.p_this.saveToFile(filename.encode('UTF-8')):
            raise IOError(pysfml_system.popLastErrorMessage())

    property samples:
        def __get__(self):
            cdef Chunk r = Chunk.__new__(Chunk)
            r.m_samples = <int16_t*>self.p_this.getSamples()
            r.m_sampleCount = self.p_this.getSampleCount()
            return r

    property sample_rate:
        def __get__(self):
            return self.p_this.getSampleRate()

    property channel_count:
        def __get__(self):
            return self.p_this.getChannelCount()

    property channel_map:
        def __get__(self):
            cdef vector[sf.SoundChannel] channel_map = self.p_this.getChannelMap()
            return _wrap_sound_channel_map(channel_map)

    property duration:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_this.getDuration()
            return pysfml_system.wrap_time(p)

cdef SoundBuffer wrap_soundbuffer(sf.SoundBuffer *p, bint delete_this=True):
    cdef SoundBuffer r = SoundBuffer.__new__(SoundBuffer)
    r.p_this = p
    r.delete_this = delete_this
    return r

class Status(IntEnum):
    STOPPED = sf_soundsource.Stopped
    PAUSED = sf_soundsource.Paused
    PLAYING = sf_soundsource.Playing

cdef class SoundSource:
    cdef sf.SoundSource *p_soundsource

    def __init__(self, *args, **kwargs):
        raise UserWarning("This class is not meant to be used directly")

    property pitch:
        def __get__(self):
            return self.p_soundsource.getPitch()

        def __set__(self, float pitch):
            self.p_soundsource.setPitch(pitch)

    property pan:
        def __get__(self):
            return self.p_soundsource.getPan()

        def __set__(self, float pan):
            self.p_soundsource.setPan(pan)

    property volume:
        def __get__(self):
            return self.p_soundsource.getVolume()

        def __set__(self, float volume):
            self.p_soundsource.setVolume(volume)

    property spatialization_enabled:
        def __get__(self):
            return self.p_soundsource.isSpatializationEnabled()

        def __set__(self, bint enabled):
            self.p_soundsource.setSpatializationEnabled(enabled)

    property position:
        def __get__(self):
            cdef sf.Vector3f p = self.p_soundsource.getPosition()
            return pysfml_system.wrap_vector3f(p)

        def __set__(self, position):
            self.p_soundsource.setPosition(pysfml_system.to_vector3f(position))

    property direction:
        def __get__(self):
            cdef sf.Vector3f p = self.p_soundsource.getDirection()
            return pysfml_system.wrap_vector3f(p)

        def __set__(self, direction):
            self.p_soundsource.setDirection(pysfml_system.to_vector3f(direction))

    property cone:
        def __get__(self):
            return _wrap_cone_data(getSoundSourceCone(self.p_soundsource[0]))

        def __set__(self, Cone cone):
            setSoundSourceCone(self.p_soundsource[0], _to_cone_data(cone))

    property velocity:
        def __get__(self):
            cdef sf.Vector3f p = self.p_soundsource.getVelocity()
            return pysfml_system.wrap_vector3f(p)

        def __set__(self, velocity):
            self.p_soundsource.setVelocity(pysfml_system.to_vector3f(velocity))

    property doppler_factor:
        def __get__(self):
            return self.p_soundsource.getDopplerFactor()

        def __set__(self, float factor):
            self.p_soundsource.setDopplerFactor(factor)

    property directional_attenuation_factor:
        def __get__(self):
            return self.p_soundsource.getDirectionalAttenuationFactor()

        def __set__(self, float factor):
            self.p_soundsource.setDirectionalAttenuationFactor(factor)

    property relative_to_listener:
        def __get__(self):
            return self.p_soundsource.isRelativeToListener()

        def __set__(self, bint relative):
            self.p_soundsource.setRelativeToListener(relative)

    property min_distance:
        def __get__(self):
            return self.p_soundsource.getMinDistance()

        def __set__(self, float distance):
            self.p_soundsource.setMinDistance(distance)

    property max_distance:
        def __get__(self):
            return self.p_soundsource.getMaxDistance()

        def __set__(self, float distance):
            self.p_soundsource.setMaxDistance(distance)

    property min_gain:
        def __get__(self):
            return self.p_soundsource.getMinGain()

        def __set__(self, float gain):
            self.p_soundsource.setMinGain(gain)

    property max_gain:
        def __get__(self):
            return self.p_soundsource.getMaxGain()

        def __set__(self, float gain):
            self.p_soundsource.setMaxGain(gain)

    property attenuation:
        def __get__(self):
            return self.p_soundsource.getAttenuation()

        def __set__(self, float attenuation):
            self.p_soundsource.setAttenuation(attenuation)


cdef class Sound(SoundSource):
    cdef sf.Sound    *p_this
    cdef SoundBuffer  m_buffer

    def __init__(self, SoundBuffer buffer=None):
        if buffer is None:
            raise TypeError("buffer is required")

        if self.p_this is NULL:
            self.p_this = new sf.Sound(buffer.p_this[0])
            self.p_soundsource = <sf.SoundSource*>self.p_this
            self.m_buffer = buffer

    def __dealloc__(self):
        self.p_soundsource = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "Sound(buffer={0}, status={1}, playing_offset={2})".format(id(self.buffer), self.status, self.playing_offset)

    def play(self):
        self.p_this.play()

    def pause(self):
        self.p_this.pause()

    def stop(self):
        self.p_this.stop()

    property buffer:
        def __get__(self):
            return self.m_buffer

        def __set__(self, SoundBuffer buffer):
            self.p_this.setBuffer(buffer.p_this[0])
            self.m_buffer = buffer

    property loop:
        def __get__(self):
            return self.p_this.isLooping()

        def __set__(self, bint loop):
            self.p_this.setLooping(loop)

    property playing_offset:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_this.getPlayingOffset()
            return pysfml_system.wrap_time(p)

        def __set__(self, pysfml_system.Time time_offset):
            self.p_this.setPlayingOffset(time_offset.p_this[0])

    property status:
        def __get__(self):
            return self.p_this.getStatus()


cdef class SoundStream(SoundSource):
    cdef sf.SoundStream *p_soundstream

    def __init__(self):
        if self.__class__ == SoundStream:
            raise NotImplementedError("SoundStream is abstract")

        if self.p_soundstream is NULL:
            self.p_soundstream = <sf.SoundStream*> new DerivableSoundStream(<void*>self)
            self.p_soundsource = <sf.SoundSource*>self.p_soundstream

    def __dealloc__(self):
        self.p_soundsource = NULL

        if self.p_soundstream is not NULL:
            del self.p_soundstream

    def play(self):
        self.p_soundstream.play()

    def pause(self):
        self.p_soundstream.pause()

    def stop(self):
        self.p_soundstream.stop()

    property channel_count:
        def __get__(self):
            return self.p_soundstream.getChannelCount()

    property sample_rate:
        def __get__(self):
            return self.p_soundstream.getSampleRate()

    property channel_map:
        def __get__(self):
            cdef vector[sf.SoundChannel] channel_map = self.p_soundstream.getChannelMap()
            return _wrap_sound_channel_map(channel_map)

    property status:
        def __get__(self):
            return self.p_soundstream.getStatus()

    property playing_offset:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_soundstream.getPlayingOffset()
            return pysfml_system.wrap_time(p)

        def __set__(self, pysfml_system.Time time_offset):
            self.p_soundstream.setPlayingOffset(time_offset.p_this[0])

    property loop:
        def __get__(self):
            return self.p_soundstream.isLooping()

        def __set__(self, bint loop):
            self.p_soundstream.setLooping(loop)

    def initialize(self, unsigned int channel_count, unsigned int sample_rate, channel_map=None):
        cdef vector[sf.SoundChannel] cpp_channel_map = _to_sound_channel_map(channel_map, channel_count)

        if self.__class__ not in [Music]:
            (<DerivableSoundStream*>self.p_soundstream).initialize(channel_count, sample_rate, cpp_channel_map)

    def on_get_data(self, data):
        pass

    def on_seek(self, time_offset):
        pass

cdef class Music(SoundStream):
    cdef sf.Music *p_this
    cdef object    m_owned_data

    def __init__(self, *args, **kwargs):
        raise UserWarning("Use specific constructor")

    def __dealloc__(self):
        self.p_soundstream = NULL
        self.m_owned_data = None

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "Music(status={0}, playing_offset={1}, duration={2})".format(self.status, self.playing_offset, self.duration)

    @classmethod
    def from_file(cls, str filename):
        cdef sf.Music *p = new sf.Music()

        if p.openFromFile(filename.encode('UTF-8')):
            return wrap_music(p)

        del p
        raise IOError(pysfml_system.popLastErrorMessage())

    @classmethod
    def from_memory(cls, data):
        cdef bytes data_bytes = bytes(data)
        cdef sf.Music *p = new sf.Music()

        if p.openFromMemory(<char*>data_bytes, len(data_bytes)):
            return wrap_music(p, data_bytes)

        del p
        raise IOError(pysfml_system.popLastErrorMessage())

    property duration:
        def __get__(self):
            cdef sf.Time* p = new sf.Time()
            p[0] = self.p_this.getDuration()
            return pysfml_system.wrap_time(p)

    property loop_points:
        def __get__(self):
            cdef sf.Time* offset = new sf.Time()
            cdef sf.Time* length = new sf.Time()
            offset[0] = getMusicLoopOffset(self.p_this[0])
            length[0] = getMusicLoopLength(self.p_this[0])
            return (pysfml_system.wrap_time(offset), pysfml_system.wrap_time(length))

        def __set__(self, loop_points):
            cdef pysfml_system.Time offset
            cdef pysfml_system.Time length

            try:
                offset, length = loop_points
            except Exception:
                raise TypeError("loop_points must be a pair of sfml.system.Time values")

            if not isinstance(offset, pysfml_system.Time) or not isinstance(length, pysfml_system.Time):
                raise TypeError("loop_points must be a pair of sfml.system.Time values")

            setMusicLoopPoints(self.p_this[0], offset.p_this[0], length.p_this[0])


cdef Music wrap_music(sf.Music *p, object owned_data=None):
    cdef Music r = Music.__new__(Music)
    r.p_this = p
    r.p_soundstream = <sf.SoundStream*>p
    r.p_soundsource = <sf.SoundSource*>p
    r.m_owned_data = owned_data
    return r


cdef class SoundRecorder:
    cdef sf.SoundRecorder *p_soundrecorder

    def __init__(self, *args, **kwargs):
        if self.__class__ == SoundRecorder:
            raise NotImplementedError("SoundRecorder is abstract")

        if self.p_soundrecorder is NULL:
            self.p_soundrecorder = <sf.SoundRecorder*>new DerivableSoundRecorder(<void*>self)

    def __dealloc__(self):
        if self.p_soundrecorder is not NULL:
            del self.p_soundrecorder

    def __repr__(self):
        return "SoundRecorder(sample_rate={0})".format(self.sample_rate)

    def start(self, unsigned int sample_rate=44100):
        return self.p_soundrecorder.start(sample_rate)

    def stop(self):
        with nogil: self.p_soundrecorder.stop()

    def set_device(self, name):
        return self.p_soundrecorder.setDevice(_to_utf8_string(name))

    def get_device(self):
        cdef string device = self.p_soundrecorder.getDevice()
        return _decode_optional_string(device)

    property sample_rate:
        def __get__(self):
            return self.p_soundrecorder.getSampleRate()

    property channel_count:
        def __get__(self):
            return self.p_soundrecorder.getChannelCount()

        def __set__(self, unsigned int channel_count):
            self.p_soundrecorder.setChannelCount(channel_count)

    property channel_map:
        def __get__(self):
            cdef vector[sf.SoundChannel] channel_map = self.p_soundrecorder.getChannelMap()
            return _wrap_sound_channel_map(channel_map)

    @staticmethod
    def is_available():
        return sf_soundrecorder.isAvailable()

    @staticmethod
    def get_available_devices():
        cdef vector[string] devices = sf_soundrecorder.getAvailableDevices()
        cdef list result = []
        cdef size_t index

        for index in range(devices.size()):
            result.append(_decode_utf8_string(devices[index]))

        return result

    @staticmethod
    def get_default_device():
        return _decode_optional_string(sf_soundrecorder.getDefaultDevice())

    def on_start(self):
        return True

    def on_process_samples(self, chunk):
        return True

    def on_stop(self):
        pass

cdef class SoundBufferRecorder(SoundRecorder):
    cdef sf.SoundBufferRecorder *p_this
    cdef SoundBuffer m_buffer

    def __init__(self):
        if self.p_this is NULL:
            self.p_this = new sf.SoundBufferRecorder()
            self.p_soundrecorder = <sf.SoundRecorder*>self.p_this

            self.m_buffer = wrap_soundbuffer(<sf.SoundBuffer*>&self.p_this.getBuffer(), False)

    def __dealloc__(self):
        self.p_soundrecorder = NULL

        if self.p_this is not NULL:
            del self.p_this

    def __repr__(self):
        return "SoundBufferRecorder(buffer={0}, sample_rate={1})".format(id(self.buffer), self.sample_rate)

    property buffer:
        def __get__(self):
            return self.m_buffer
