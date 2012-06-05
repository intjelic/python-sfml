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

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Shape")
window.clear(sf.Color.WHITE)
window.display()
input()

image = sf.Texture.load_from_file("../data/sfml.png")
sprite = sf.Sprite(image)
window.draw(sprite)
window.display()
input()

texture = sf.Texture.load_from_file("../data/windows_icon2.jpg")
sprite = sf.Sprite(texture)

print("### sf.Shape() ###")

try:
	shape = sf.Shape()
	raise sf.SFMLException("You shouldn't have been able to instantiate a sf.Shape")
except NotImplementedError as error:
	print(error)
	input("Error expected, press any key to continue...")

def test_shape(shape):
	
	print("### sf.Shape.texture ###")
circle = sf.CircleShape(100, 100)
circle.texture = texture
print(circle.fill_color)
circle.fill_color = sf.Color.GREEN

print(circle.outline_color)
circle.outline_color = sf.Color.RED

print(circle.outline_thickness)
circle.outline_thickness = 15

print(circle.local_bounds)
print(circle.global_bounds)
input()

### TEST CIRCLE SHAPE ###
window.clear(sf.Color.CYAN)
window.draw(circle)
window.display()
input()

print(circle.radius)
circle.radius = 75
print(circle.point_count)
circle.point_count = 5

window.clear(sf.Color.CYAN)
window.draw(circle)
window.display()
input()

### TEST CONVEX SHAPE ###
polygon = sf.ConvexShape(10)

for i in range(polygon.point_count):
	print(polygon.get_point(i))
	
polygon.point_count = 6
polygon.set_point(0, (20, 20))
polygon.set_point(1, (30, 20))
polygon.set_point(2, (30, 40))
polygon.set_point(3, (50, 75))
polygon.set_point(4, (5, 75))
polygon.set_point(5, (5, 5))

window.clear(sf.Color.CYAN)
window.draw(polygon)
window.display()
input()


### TEST RECTANGLE SHAPE ###
rectangle = sf.RectangleShape((125, 75))
square = sf.RectangleShape((50, 50))

window.clear(sf.Color.CYAN)
window.draw(square)
window.display()
input()

print(rectangle.size)
square.size = (75, 75)

for i in range(rectangle.point_count):
	print(rectangle.get_point(i))
	
window.clear(sf.Color.CYAN)
window.draw(square)
window.display()
input()

### DRAWING ###
circle.position = (300, 20)
polygon.position = (250, 5)
rectangle.position = (5, 105)
square.position = (300, 300)

window.clear(sf.Color.CYAN)
window.draw(circle)
window.draw(polygon)
window.draw(rectangle)
window.draw(square)
window.display()
input()
