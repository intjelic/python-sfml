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
from random import randint

print("### sf.Image() ###")
try:
	image = sf.Image()
	raise Warning("Shouldn't work!")
	
except UserWarning as error:
	print("This error was expected...")
input()

print("### sf.Image.create() ###")
#a = sf.Image.create(50, 50, sf.Color.CYAN) # bug due to a bug in cython
a = sf.Image.create(50, 50)
input()

print("### sf.Image.create_from_pixels() ###")
b = sf.Image.create_from_pixels(a.pixels)
input()

print("### sf.Image.load_from_file() ###")
c = sf.Image.load_from_file("../data/background.jpg")
input()

print("### sf.Image.load_from_memory() ###")
file = open("../data/background.jpg", "rb")
data = file.read()
d = sf.Image.load_from_memory(data)

print("### sf.Image.save_to_file() ###")
a.save_to_file("a.png")
a.save_to_file("éééàààùù^o^.png")
b.save_to_file("b.jpg")
c.save_to_file("c.png")
d.save_to_file("d.jpg")

print("### sf.Image.size ###")
assert type(a.size) == sf.Size
assert type(b.size) == sf.Size
assert type(c.size) == sf.Size
assert type(d.size) == sf.Size
print(a.size)
print(b.size)
print(d.size)
print(d.size)
input()

print("### sf.Image.width ###")
print(a.width)
print(b.width)
print(c.width)
print(d.width)
input()

print("### sf.Image.height ###")
print(a.height)
print(b.height)
print(c.height)
print(d.height)
input()

print("### sf.Image.create_mask_from_color ###")
#d.create_mask_from_color(sf.Color.CYAN)
b.create_mask_from_color(sf.Color.BLACK)
b.save_to_file("e.png")
input()

print("### sf.Image.blit() ###")
c.blit(d, sf.Position(400, 400))
c.blit(d, (400, 400))

c.blit(d, sf.Position(50, 50), sf.Rectangle((200, 200), (200, 200)))
#c.blit(d, sf.Position(200, 200), sf.Rectangle(200, 200, 400, 400))
c.save_to_file("f.png")
input()

print("### sf.Image.pixels ###")
assert type(b.pixels) == sf.Pixels
print(a.pixels)
input()

print("### sf.Image.flip_horizontally() ###")
c.flip_horizontally()
c.save_to_file("g.png")
input()

print("### sf.Image.flip_vertically() ###")
c.flip_vertically()
c.save_to_file("h.png")
input()

print("### sf.Image.copy() ###")
i = c.copy()
i.save_to_file("i.png")
input()

print("### sf.Image.__get__ ###")
print(i[50, 50])

print("### sf.Image.__set__ ###")
for x in range(i.width):
	for y in range(i.height):
		v = randint(0, 255)
		i[x, y] = sf.Color(v, v, v, v)

i.save_to_file("j.png")
