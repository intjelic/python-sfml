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
from transformable import test_transformable

def test_shape(shape):

	test_transformable(shape)
	
	print("### sf.Shape.texture ###")
	texture = sf.Texture.load_from_file("../data/windows_icon2.jpg")
	assert shape.texture == None
	shape.texture = texture
	assert type(shape.texture) == sf.Texture
	assert shape.texture == texture
	 
	print("### sf.Shape.texture_rectangle ###")
	assert type(shape.texture_rectangle) == sf.Rectangle
	#print(shape.texture_rectangle)
	#assert shape.texture_rectangle == sf.Rectangle()
	shape.texture_rectangle = (20, 20, 20, 20)
	assert type(shape.texture_rectangle) == sf.Rectangle
	shape.texture_rectangle = sf.Rectangle((10, 10), (20, 20))
	assert type(shape.texture_rectangle) == sf.Rectangle
	assert shape.texture_rectangle == (10, 10, 20, 20)
	
	print("### sf.Shape.fill_color ###")
	assert type(shape.fill_color) == sf.Color
	assert shape.fill_color == sf.Color.WHITE
	shape.fill_color = sf.Color.RED
	assert type(shape.fill_color) == sf.Color
	assert shape.fill_color == sf.Color.RED
	
	print("### sf.Shape.outline_color ###")
	assert type(shape.outline_color) == sf.Color
	assert shape.outline_color == sf.Color.WHITE
	shape.outline_color = sf.Color.BLUE
	assert type(shape.outline_color) == sf.Color
	assert shape.outline_color == sf.Color.BLUE
	print("### sf.Shape.outline_thickness ###")
	assert type(shape.outline_thickness) == float
	assert shape.outline_thickness == 0
	shape.outline_thickness = 10
	assert type(shape.outline_thickness) == float
	assert shape.outline_thickness == 10
	
	print("### sf.Shape.local_bounds ###")
	assert type(shape.local_bounds) == sf.Rectangle
	#assert shape.local_bounds == sf.Rectangle()
	
	print("### sf.Shape.global_bounds ###")
	assert type(shape.global_bounds) == sf.Rectangle
	#assert shape.global_bounds == sf.Rectangle()


print("### sf.Shape constructor ###")
try:
	shape = sf.Shape()
	raise sf.SFMLException("You shouldn't have been able to instantiate a sf.Shape")
except NotImplementedError as error:
	print(error)
	input("Error expected, press any key to continue...")
input()

print("### sf.CircleShape constructor ###")
a = sf.CircleShape()
b = sf.CircleShape(20)
c = sf.CircleShape(10, 3)

print("### sf.CircleShape.radius ###")
assert type(a.radius) == float
assert a.radius == 0
a.radius = 5
assert type(a.radius) == float
assert a.radius == 5

print("### sf.CircleShape.point_count ###")
assert type(a.point_count) == int
assert a.point_count == 30
a.point_count = 10
assert type(a.point_count) == int
assert a.point_count == 10

print("### sf.CircleShape.get_point() ###")
assert type(a.get_point(0)) == sf.Vector2

test_shape(a)
test_shape(b)
test_shape(c)
input()

print("### sf.ConvexShape constructor ###")
d = sf.ConvexShape()
e = sf.ConvexShape(10)

print("### sf.ConvexShape point_count ###")
assert type(d.point_count) == int
assert d.point_count == 0
assert e.point_count == 10
d.point_count = 6
assert type(d.point_count) == int
assert d.point_count == 6

print("### sf.ConvexShape set_point() ###")
points = [(20, 20), (30, 20), (30, 40), (50, 75), (5, 75), (5, 5)]

for i, point in enumerate(points):
	d.set_point(i, point)

print("### sf.ConvexShape get_point() ###")
for i in range(d.point_count):
	assert d.get_point(i) == points[i]

test_shape(d)
test_shape(e)
input()

print("### sf.RectangleShape constructor ###")
f = sf.RectangleShape()
g = sf.RectangleShape(sf.Vector2(65, 85))

print("### sf.RectangleShape.size ###")
assert type(f.size) == sf.Vector2
assert f.size == sf.Vector2()
assert g.size == (65, 85)

print("### sf.RectangleShape.get_point() ###")
assert type(f.get_point(0)) == sf.Vector2

test_shape(f)
test_shape(g)
input()

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Shape")

for shape in [a, b, c, d, e, f, g]:
	window.clear(sf.Color.WHITE)
	window.draw(shape)
	window.display()
	input()
