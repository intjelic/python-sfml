#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml as sf

foo = sf.Transformable()

print("### sf.Transformable.position ###")
assert type(foo.position) == sf.Vector2
print(foo.position)
foo.position = sf.Vector2(40, 50)
foo.position = (70, 60)
assert foo.position == sf.Vector2(70, 60)
print(foo.position)
input()

print("### sf.Transformable.rotation ###")
assert type(foo.rotation) == float
print(foo.rotation)
foo.rotation = 5.6
print(foo.rotation)
input()

print("### sf.Transformable.ratio ###")
assert type(foo.ratio) == sf.Vector2
print(foo.ratio)
foo.ratio = sf.Vector2(40, 50)
foo.ratio = (70, 60)
assert foo.ratio == sf.Vector2(70, 60)
print(foo.ratio)
input()

print("### sf.Transformable.origin ###")
assert type(foo.origin) == sf.Vector2
print(foo.origin)
foo.origin = sf.Vector2(40, 50)
foo.origin = (70, 60)
assert foo.origin == sf.Vector2(70, 60)
print(foo.origin)
input()

print("### sf.Transformable.move() ###")
foo.move(sf.Vector2(50, 30))
foo.move((20, 10))
input()

print("### sf.Transformable.rotate() ###")
foo.rotate(5.6)
input()

print("### sf.Transformable.scale() ###")
foo.scale(sf.Vector2(50, 30))
foo.scale((20, 10))
input()

print("### sf.Transformable.transform ###")
assert type(foo.transform) == sf.Transform
print(foo.transform)
input()

print("### sf.Transformable.inverse_transform ###")
assert type(foo.inverse_transform) == sf.Transform
print(foo.inverse_transform)
input()
