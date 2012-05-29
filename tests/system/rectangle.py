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

a = sf.Rectangle()
b = sf.Rectangle(position=sf.Position(25, 50))
c = sf.Rectangle(position=(25, 50))
d = sf.Rectangle(size=sf.Size(75, 100))
e = sf.Rectangle(size=(75, 100))
f = sf.Rectangle(sf.Position(25, 50), sf.Size(75, 100))
g = sf.Rectangle((25, 50), (75, 100))

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(g)

assert type(a) == sf.Rectangle
assert type(b) == sf.Rectangle
assert type(c) == sf.Rectangle
assert type(d) == sf.Rectangle
assert type(e) == sf.Rectangle
assert type(f) == sf.Rectangle
assert type(g) == sf.Rectangle

# TODO: add overload operators tests
#assert a == sf.Rectangle(0, 0)
#assert b == sf.Position(0, 50)
#assert c == sf.Size(50, 0)
#assert d == [50, 100]
