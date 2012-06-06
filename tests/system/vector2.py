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

print("# Constructors + __eq__ + __ne__")
v0 = sf.Vector2()
assert v0 == sf.Vector2(0, 0)
assert v0 == (0, 0)

v1 = sf.Vector2(x=5)
assert v1 == sf.Vector2(5, 0)
assert v1 == (5, 0)

v2 = sf.Vector2(y=5)
assert v2 == sf.Vector2(0, 5)
assert v2 == (0, 5)

v3 = sf.Vector2(10, 15)
assert v3 == sf.Vector2(10, 15)
assert v3 == (10, 15)

print("# Overload operators")
#TODO

print("# In-place operators")
#TODO
