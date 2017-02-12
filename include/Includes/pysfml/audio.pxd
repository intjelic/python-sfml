# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cimport sfml as sf
from pysfml.system cimport Int16

cdef extern from "pysfml/audio/audio.h":

cdef class Chunk[type PyChunkType, object PyChunkObject]:
    cdef class sfml.audio.Chunk [object PyChunkObject]:
        cdef Int16* m_samples
        cdef size_t m_sampleCount
        cdef bint   delete_this

cdef extern from "pysfml/audio/audio_api.h":
    cdef void import_sfml__audio()

    cdef object create_chunk()
    cdef Int16* terminate_chunk(object)
    cdef object wrap_chunk(Int16*, unsigned int, bint)

