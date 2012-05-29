#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.system as sf

print("# Seconds + convertisor")
a = sf.seconds(50)
a_ms = a.milliseconds
a_us = a.microseconds

print(a)
print(a_ms)
print(a_us)

print("# Milliseconds + convertisor")
b = sf.milliseconds(50000)
b_s = b.seconds
b_us = b.microseconds

print(b)
print(b_s)
print(b_us)

print("# Microseconds + convertisor")
c = sf.microseconds(50000000)
c_s = c.seconds
c_ms = c.milliseconds

print(c)
print(c_s)
print(c_ms)

print("# Overload operators")
d = a + b + c
e = a - b - c
f = a + b - c
g = a - b + c

print(d)
print(e)
print(f)
print(g)

print("# In-place operators")
h = a.copy()
h += b
h += c


i = a.copy()
i -= b
i -= c

j = a.copy()
j += b
j -= c

k = a.copy()
k -= b
k += c

print(h)
print(i)
print(j)
print(k)

print("# Do overload opeartors compute the same result")
assert h == d
assert i == e
assert j == f
assert k == g
print("It seems ok!")
