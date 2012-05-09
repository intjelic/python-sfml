#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cdef extern from "<string>" namespace "std":
	cdef cppclass string:
		char* c_str()

cdef extern from "SFML/System.hpp" namespace "sf":
	# 8 bits integer types
	ctypedef signed   char Int8
	ctypedef unsigned char Uint8

	# 16 bits integer types
	ctypedef signed   short Int16
	ctypedef unsigned short Uint16

	# 32 bits integer types
	ctypedef signed   int Int32
	ctypedef unsigned int Uint32

	# 64 bits integer types
	ctypedef signed   long long Int64
	ctypedef unsigned long long Uint64
	
	cdef cppclass Time:
		Time()
		float asSeconds()
		Int32 asMilliseconds()
		Int64 asMicroseconds()

	cdef void sleep(Time)

	cdef cppclass Clock:
		Clock()
		Time getElapsedTime()
		Time restart()

#	cdef cppclass String:
#		String()
#		String(Uint32*)
#		Uint32* GetData()
#		size_t GetSize()
#		string ToAnsiString()

#    cdef cppclass Vector2f:
#        Vector2f()
#        Vector2f(float, float)
#        float x
#        float y

#    cdef cppclass Vector2i:
#        Vector2i()
#        Vector2i(int, int)
#        int x
#        int y

#    cdef cppclass Vector3f:
#        Vector3f()
#        Vector3f(float, float, float)
#        float x
#        float y
#        float z

        
#cdef extern from "SFML/Graphics.hpp" namespace "sf":
#    cdef cppclass IntRect:
#        IntRect()
#        IntRect(int, int, int, int)
#        bint Contains(int, int)
#        bint Intersects(IntRect&)
#        bint Intersects(IntRect&, IntRect&)
#        int Left
#        int Top
#        int Width
#        int Height

#    cdef cppclass FloatRect:
#        FloatRect()
#        FloatRect(float, float, float, float)
#        bint Contains(int, int)
#        bint Intersects(FloatRect&)
#        bint Intersects(FloatRect&, FloatRect&)
#        float Left
#        float Top
#        float Width
#        float Height
