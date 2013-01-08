#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from __future__ import division
from numbers import Number, Integral
from copy import deepcopy

cimport cython
from libcpp.string cimport string
from libcpp.vector cimport vector

from pysfml cimport dsystem
from pysfml.dsystem cimport Int8, Int16, Int32, Int64
from pysfml.dsystem cimport Uint8, Uint16, Uint32, Uint64

__all__ = ['SFMLException', 'Time', 'sleep', 'Clock', 'seconds',
			'milliseconds', 'microseconds', 'Vector2', 'Vector3']

dsystem.replace_error_handler()

def pop_error_message():
	message = dsystem.get_last_error_message().c_str()
	message = message.decode('utf-8')
	return message

def push_error_message(message):
	raise NotImplementedError

class SFMLException(Exception):
	def __init__(self, message=None):
		if not message: message = pop_error_message()
		self.message = message

		Exception.__init__(self, message)

	def __str__(self):
		return repr(self.message)


cdef public class Vector2[type PyVector2Type, object PyVector2Object]:
	cdef public object x
	cdef public object y

	def __init__(self, x=0, y=0):
		self.x = x
		self.y = y

	def __repr__(self):
		return "sf.Vector2({0})".format(self)

	def __str__(self):
		return "{0}x, {1}y".format(self.x, self.y)

	def __richcmp__(Vector2 x, y, op):
		x1, y1 = x
		try: x2, y2 = y
		except TypeError: return False

		if op == 2: return x1 == x2 and y1 == y2
		elif op == 3: return not (x1 == x2 and y1 == y2)
		else: raise NotImplementedError

	def __iter__(self):
		return iter((self.x, self.y))

	def __getitem__(self, key):
		return (self.x, self.y)[key]

	def __setitem__(self, key, value):
		setattr(self, {0: 'x', 1: 'y'}[key], value)

	def __add__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] + other, self[1] + other)
		else:
			return Vector2(self[0] + other[0], self[1] + other[1])

	def __sub__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] - other, self[1] - other)
		else:
			return Vector2(self[0] - other[0], self[1] - other[1])

	def __mul__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] * other, self[1] * other)
		else:
			return Vector2(self[0] * other[0], self[1] * other[1])

	def __truediv__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] / other, self[1] / other)
		else:
			return Vector2(self[0] / other[0], self[1] / other[1])

	def __floordiv__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] // other, self[1] // other)
		else:
			return Vector2(self[0] // other[0], self[1] // other[1])

	def __div__(self, other):
		if isinstance(other, Integral):
			return self.__floordiv__(other)
		elif isinstance(other, Number) and not isinstance(other, Integral):
			return self.__truediv__(other)
		elif all(isinstance(i, Integral) for i in other):
			return self.__floordiv__(other)
		else:
			return self.__truediv__(other)

	def __mod__(self, other):
		if isinstance(other, Number):
			return Vector2(self[0] % other, self[1] % other)
		else:
			return Vector2(self[0] % other[0], self[1] % other[1])

	def __divmod__(self, other):
		return self // other, self % other

	def __iadd__(self, other):
		if isinstance(other, Number):
			self[0] += other
			self[1] += other
		else:
			self[0] += other[0]
			self[1] += other[1]
		return self

	def __isub__(self, other):
		if isinstance(other, Number):
			self[0] -= other
			self[1] -= other
		else:
			self[0] -= other[0]
			self[1] -= other[1]
		return self

	def __imul__(self, other):
		if isinstance(other, Number):
			self[0] *= other
			self[1] *= other
		else:
			self[0] *= other[0]
			self[1] *= other[1]
		return self

	def __itruediv__(self, other):
		if isinstance(other, Number):
			self[0] /= other
			self[1] /= other
		else:
			self[0] /= other[0]
			self[1] /= other[1]
		return self

	def __ifloordiv__(self, other):
		if isinstance(other, Number):
			self[0] //= other
			self[1] //= other
		else:
			self[0] //= other[0]
			self[1] //= other[1]
		return self

	def __idiv__(self, other):
		if isinstance(other, Integral):
			return self.__ifloordiv__(other)
		elif isinstance(other, Number) and not isinstance(other, Integral):
			return self.__itruediv__(other)
		elif all(isinstance(i, Integral) for i in other):
			return self.__ifloordiv__(other)
		else:
			return self.__itruediv__(other)

	def __imod__(self, other):
		if isinstance(other, Number):
			self[0] %= other
			self[1] %= other
		else:
			self[0] %= other[0]
			self[1] %= other[1]
		return self

	def __neg__(self):
		cdef Vector2 p = Vector2.__new__(Vector2)
		p.x, p.y = self
		p.x, p.y = -p.x, -p.y
		return p

	def __pos__(self):
		cdef Vector2 p = Vector2.__new__(Vector2)
		p.x, p.y = self
		p.x, p.y = +p.x, +p.y
		return p

	def __copy__(self):
		cdef Vector2 p = Vector2.__new__(Vector2)
		p.x, p.y = self
		return p

	def __deepcopy__(self):
		cdef Vector2 p = Vector2.__new__(Vector2)
		p.x, p.y = deepcopy(self.x), deepcopy(self.y)
		return p


cdef public class Vector3[type PyVector3Type, object PyVector3Object]:
	cdef public object x
	cdef public object y
	cdef public object z

	def __init__(self, x=0, y=0, z=0):
		self.x = x
		self.y = y
		self.z = z

	def __repr__(self):
		return "sf.Vector3({0})".format(self)

	def __str__(self):
		return "{0}x, {1}y, {2}z".format(self.x, self.y, self.z)

	def __richcmp__(Vector3 x, y, op):
		x1, y1, z1 = x
		try: x2, y2, z2 = y
		except Exception: return False

		if op == 2: return x1 == x2 and y1 == y2 and z1 == z2
		elif op == 3: return not (x1 == x2 and y1 == y2 and z1 == z2)
		else: raise NotImplementedError

	def __iter__(self):
		return iter((self.x, self.y, self.z))

	def __getitem__(self, key):
		return (self.x, self.y, self.z)[key]

	def __setitem__(self, key, value):
		setattr(self, {0: 'x', 1: 'y', 2: 'z'}[key], value)

	def __add__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] + other,
						   self[1] + other, self[2] + other)
		else:
			return Vector3(self[0] + other[0],
						   self[1] + other[1], self[2] + other[2])

	def __sub__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] - other,
						   self[1] - other, self[2] - other)
		else:
			return Vector3(self[0] - other[0],
						   self[1] - other[1], self[2] - other[2])

	def __mul__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] * other,
						   self[1] * other, self[2] * other)
		else:
			return Vector3(self[0] * other[0],
						   self[1] * other[1], self[2] * other[2])

	def __truediv__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] / other,
						   self[1] / other, self[2] / other)
		else:
			return Vector3(self[0] / other[0],
						   self[1] / other[1], self[2] / other[2])

	def __floordiv__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] // other,
						   self[1] // other, self[2] // other)
		else:
			return Vector3(self[0] // other[0],
						   self[1] // other[1], self[2] // other[2])

	def __div__(self, other):
		if isinstance(other, Integral):
			return self.__floordiv__(other)
		elif isinstance(other, Number) and not isinstance(other, Integral):
			return self.__truediv__(other)
		elif all(isinstance(i, Integral) for i in other):
			return self.__floordiv__(other)
		else:
			return self.__truediv__(other)

	def __mod__(self, other):
		if isinstance(other, Number):
			return Vector3(self[0] % other,
						   self[1] % other, self[2] % other)
		else:
			return Vector3(self[0] % other[0],
						   self[1] % other[1], self[2] % other[2])

	def __divmod__(self, other):
		return self // other, self % other

	def __iadd__(self, other):
		if isinstance(other, Number):
			self[0] += other
			self[1] += other
			self[2] += other
		else:
			self[0] += other[0]
			self[1] += other[1]
			self[2] += other[2]
		return self

	def __isub__(self, other):
		if isinstance(other, Number):
			self[0] -= other
			self[1] -= other
			self[2] -= other
		else:
			self[0] -= other[0]
			self[1] -= other[1]
			self[2] -= other[2]
		return self

	def __imul__(self, other):
		if isinstance(other, Number):
			self[0] *= other
			self[1] *= other
			self[2] *= other
		else:
			self[0] *= other[0]
			self[1] *= other[1]
			self[2] *= other[2]
		return self

	def __itruediv__(self, other):
		if isinstance(other, Number):
			self[0] /= other
			self[1] /= other
			self[2] /= other
		else:
			self[0] /= other[0]
			self[1] /= other[1]
			self[2] /= other[2]
		return self

	def __ifloordiv__(self, other):
		if isinstance(other, Number):
			self[0] //= other
			self[1] //= other
			self[2] //= other
		else:
			self[0] //= other[0]
			self[1] //= other[1]
			self[2] //= other[2]
		return self

	def __div__(self, other):
		if isinstance(other, Integral):
			return self.__ifloordiv__(other)
		elif isinstance(other, Number) and not isinstance(other, Integral):
			return self.__itruediv__(other)
		elif all(isinstance(i, Integral) for i in other):
			return self.__ifloordiv__(other)
		else:
			return self.__itruediv__(other)

	def __imod__(self, other):
		if isinstance(other, Number):
			self[0] %= other
			self[1] %= other
			self[2] %= other
		else:
			self[0] %= other[0]
			self[1] %= other[1]
			self[2] %= other[2]
		return self

	def __neg__(self):
		cdef Vector3 p = Vector3.__new__(Vector3)
		p.x, p.y, p.z = self
		p.x, p.y, p.z = -p.x, -p.y, -p.z
		return p

	def __pos__(self):
		cdef Vector3 p = Vector3.__new__(Vector3)
		p.x, p.y, p.z = self
		p.x, p.y, p.z = +p.x, +p.y, +p.z
		return p

	def __copy__(self):
		cdef Vector3 p = Vector3.__new__(Vector3)
		p.x, p.y, p.z = self
		return p

	def __deepcopy__(self):
		cdef Vector3 p = Vector3.__new__(Vector3)
		p.x, p.y, p.z = deepcopy(self.x), deepcopy(self.y), deepcopy(self.z)
		return p


cdef public class Time[type PyTimeType, object PyTimeObject]:
	ZERO = wrap_time(<dsystem.Time*>&dsystem.time.Zero)

	cdef dsystem.Time *p_this

	def __init__(self):
		self.p_this = new dsystem.Time()

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return "sf.Time({0}s, {1}ms, {2}µs)".format(self.seconds, self.milliseconds, self.microseconds)

	def __str__(self):
		return "{0} milliseconds".format(self.milliseconds)

	def __richcmp__(Time x, Time y, int op):
		if op == 0:   return x.p_this[0] <	y.p_this[0]
		elif op == 2: return x.p_this[0] == y.p_this[0]
		elif op == 4: return x.p_this[0] >	y.p_this[0]
		elif op == 1: return x.p_this[0] <= y.p_this[0]
		elif op == 3: return x.p_this[0] != y.p_this[0]
		elif op == 5: return x.p_this[0] >= y.p_this[0]

	def __add__(Time x, Time y):
		cdef dsystem.Time* p = new dsystem.Time()
		p[0] = x.p_this[0] + y.p_this[0]
		return wrap_time(p)

	def __sub__(Time x, Time y):
		cdef dsystem.Time* p = new dsystem.Time()
		p[0] = x.p_this[0] - y.p_this[0]
		return wrap_time(p)

	def __iadd__(self, Time x):
		self.p_this[0] = self.p_this[0] + x.p_this[0]
		return self

	def __isub__(self, Time x):
		self.p_this[0] = self.p_this[0] - x.p_this[0]
		return self

	property seconds:
		def __get__(self):
			return self.p_this.asSeconds()

		def __set__(self, float seconds):
			self.p_this[0] = dsystem.seconds(seconds)

	property milliseconds:
		def __get__(self):
			return self.p_this.asMilliseconds()

		def __set__(self, Int32 milliseconds):
			self.p_this[0] = dsystem.milliseconds(milliseconds)

	property microseconds:
		def __get__(self):
			return self.p_this.asMicroseconds()

		def __set__(self, Int64 microseconds):
			self.p_this[0] = dsystem.microseconds(microseconds)

	def reset(self):
		self.milliseconds = 0

	def __copy__(self):
		cdef dsystem.Time* p = new dsystem.Time()
		p[0] = self.p_this[0]
		return wrap_time(p)

	def __deepcopy__(self):
		cdef dsystem.Time* p = new dsystem.Time()
		p[0] = self.p_this[0]
		return wrap_time(p)


cdef api object wrap_time(dsystem.Time* p):
	cdef Time r = Time.__new__(Time)
	r.p_this = p
	return r

def sleep(Time duration):
	with nogil: dsystem.sleep(duration.p_this[0])

cdef class Clock:
	cdef dsystem.Clock *p_this

	def __cinit__(self):
		self.p_this = new dsystem.Clock()

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return "sf.Clock({0})".format(self.elapsed_time)

	def __str__(self):
		return "{0}".format(self.elapsed_time)

	property elapsed_time:
		def __get__(self):
			cdef dsystem.Time* p = new dsystem.Time()
			p[0] = self.p_this.getElapsedTime()
			return wrap_time(p)

	def restart(self):
		cdef dsystem.Time* p = new dsystem.Time()
		p[0] = self.p_this.restart()
		return wrap_time(p)

def seconds(float amount):
	cdef dsystem.Time* p = new dsystem.Time()
	p[0] = dsystem.seconds(amount)
	return wrap_time(p)

def milliseconds(Int32 amount):
	cdef dsystem.Time* p = new dsystem.Time()
	p[0] = dsystem.milliseconds(amount)
	return wrap_time(p)

def microseconds(Int64 amount):
	cdef dsystem.Time* p = new dsystem.Time()
	p[0] = dsystem.microseconds(amount)
	return wrap_time(p)
