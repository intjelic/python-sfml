cdef extern from "SFML/Audio.hpp" namespace "sf::Listener":
    cdef void SetGlobalVolume(float volume)
    cdef float GetGlobalVolume()
    cdef void SetPosition(float x, float y, float z)
    #cdef void SetPosition(const Vector3f &position)
    #cdef Vector3f GetPosition()
    cdef void SetDirection(float x, float y, float z)
    #cdef void SetDirection(Vector3f &direction)
    #cdef Vector3f GetDirection()
