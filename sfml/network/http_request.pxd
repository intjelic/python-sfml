cdef extern from "SFML/Graphics.hpp" namespace "sf::Http::Request":
    cdef cppclass Method:
        pass
        
cdef extern from "SFML/Network.hpp" namespace "sf::Http::Request":
    int Get
    int Post
    int Head
