#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cimport time

cdef extern from "<string>" namespace "std":
	cdef cppclass string:
		char* c_str()

cdef extern from "pysfml/error.hpp":
	void replace_error_handler()
	string get_last_error_message()

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
		bint operator==(Time&)
		bint operator!=(Time&)
		bint operator<(Time&)
		bint operator>(Time&)
		bint operator<=(Time&)
		bint operator>=(Time&)
		Time operator+(Time&)		
		Time operator-(Time&)
		Time operator*(Time&) 
		Time operator/(Time&)    
		#Time operator-=(Time&, Time)        
		#Time operator+=(Time&, Time)
		#Time operator*(float)
		#Time operator*(float)
		#Time operator*(Int64)
		#Time operator/(float)
		#Time operator/(Int64)
        
	cdef void sleep(Time) nogil

	cdef cppclass Clock:
		Clock()
		Time getElapsedTime()
		Time restart()

	cdef Time seconds(float)
	cdef Time milliseconds(Int32)
	cdef Time microseconds(Int64)

	cdef cppclass String:
		String(char*)
		string toAnsiString()

	cdef cppclass Vector2i:
		Vector2i()
		Vector2i(int, int)
		int x
		int y

	cdef cppclass Vector2u:
		Vector2u()
		Vector2u(unsigned int, unsigned int)
		unsigned int x
		unsigned int y
		
	cdef cppclass Vector2f:
		Vector2f()
		Vector2f(float, float)
		float x
		float y
		
	cdef cppclass Vector3i:
		Vector3i()
		Vector3i(int, int, int)
		int x
		int y
		int z
		
	cdef cppclass Vector3u:
		Vector3u()
		Vector3u(unsigned int, unsigned int, unsigned int)
		unsigned int x
		unsigned int y
		unsigned int z
		
	cdef cppclass Vector3f:
		Vector3f()
		Vector3f(float, float, float)
		float x
		float y
		float z


cdef extern from "SFML/Graphics.hpp" namespace "sf":
	cdef cppclass IntRect:
		IntRect()
		IntRect(int, int, int, int)
		IntRect(Vector2i&, Vector2i&)
		bint contains(int, int)
		bint contains(Vector2i&)
		bint intersects(IntRect&)
		bint intersects(IntRect&, IntRect&)
		int left
		int top
		int width
		int height

	cdef cppclass FloatRect:
		FloatRect()
		FloatRect(float, float, float, float)
		FloatRect(Vector2f&, Vector2f&)
		bint contains(float, float)
		bint contains(Vector2f&)
		bint intersects(FloatRect&)
		bint intersects(FloatRect&, FloatRect&)
		float left
		float top
		float width
		float height
