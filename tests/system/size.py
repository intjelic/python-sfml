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

a = sf.Size()
b = sf.Size(height=50)
c = sf.Size(width=50)
d = sf.Size(50, 100)

print(a)
print(b)
print(c)
print(d)

assert type(a) == sf.Size
assert type(b) == sf.Size
assert type(c) == sf.Size
assert type(d) == sf.Size

# TODO: add overload operators tests
assert a == (0, 0)
assert b == sf.Position(0, 50)
assert c == sf.Size(50, 0)
assert d == [50, 100]

