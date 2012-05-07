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


cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()
        

cdef extern from "SFML/System.hpp" namespace "sf":
    ctypedef short Int16
    ctypedef unsigned char Uint8
    ctypedef unsigned int Uint32

    cdef void Sleep(Uint32)

    cdef cppclass Clock:
        Clock()
        Uint32 GetElapsedTime()
        void Reset()
        
    cdef cppclass Vector2f:
        Vector2f()
        Vector2f(float, float)
        float x
        float y

    cdef cppclass Vector2i:
        Vector2i()
        Vector2i(int, int)
        int x
        int y

    cdef cppclass Vector3f:
        Vector3f()
        Vector3f(float, float, float)
        float x
        float y
        float z

    cdef cppclass String:
        String()
        String(Uint32*)
        Uint32* GetData()
        size_t GetSize()
        string ToAnsiString()
        
        
cdef extern from "SFML/Graphics.hpp" namespace "sf":
    cdef cppclass IntRect:
        IntRect()
        IntRect(int, int, int, int)
        bint Contains(int, int)
        bint Intersects(IntRect&)
        bint Intersects(IntRect&, IntRect&)
        int Left
        int Top
        int Width
        int Height

    cdef cppclass FloatRect:
        FloatRect()
        FloatRect(float, float, float, float)
        bint Contains(int, int)
        bint Intersects(FloatRect&)
        bint Intersects(FloatRect&, FloatRect&)
        float Left
        float Top
        float Width
        float Height
