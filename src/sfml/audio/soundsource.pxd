cdef extern from "SFML/Audio.hpp" namespace "sf::SoundSource":
    cdef cppclass Status

    int Stopped
    int Paused
    int Playing
