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

print("### sf.Texture() ###")

try:
	image = sf.Image()
	raise Warning("Shouldn't work!")
	
except UserWarning as error:
	print("This error was expected...")
input()

print("### sf.Texture.NORMALIZED ###")
print(sf.Texture.NORMALIZED)
input()

print("### sf.Texture.PIXELS ###")
print(sf.Texture.PIXELS)
input()

print("### sf.Texture.PIXELS ###")
print(sf.Texture.get_maximum_size())
input()

print("### sf.Texture.create() ###")
a = sf.Texture.create(200, 250)
input()

print("### sf.Texture.load_from_file() ###")
b = sf.Texture.load_from_file("../data/background.jpg")
c = sf.Texture.load_from_file("../data/background.jpg", sf.Rectangle((50, 150), (50, 50)))
d = sf.Texture.load_from_file("../data/background.jpg", (50, 150, 50, 50))
input()

print("### sf.Texture.load_from_memory() ###")
file = open("../data/background.jpg", "rb")
data = file.read()
e = sf.Texture.load_from_memory(data)

print("### sf.Texture.load_from_image() ###")
image = sf.Image.load_from_file("../data/background.jpg")
f = sf.Texture.load_from_image(image)
g = sf.Texture.load_from_image(image, sf.Rectangle((50, 150), (50, 50)))
h = sf.Texture.load_from_image(image, (50, 150, 50, 50))
input()

print("### sf.Texture.size ###")
assert type(a.size) == sf.Vector2
assert type(b.size) == sf.Vector2
assert type(c.size) == sf.Vector2
assert type(d.size) == sf.Vector2
print(a.size)
print(b.size)
print(d.size)
print(d.size)
input()

print("### sf.Texture.width ###")
print(a.width)
print(b.width)
print(c.width)
print(d.width)
input()

print("### sf.Texture.height ###")
print(a.height)
print(b.height)
print(c.height)
print(d.height)
input()

print("### sf.Texture.copy_to_image() ###")
copy = b.copy_to_image()
input()

#print("### sf.Texture.update() ###")
## not implemented yet
#input()

print("### sf.Texture.update_from_pixels() ###")
image_sfml = sf.Image.load_from_file("../data/sfml.png")
i = b.copy()
i.update_from_pixels(image_sfml.pixels)
i.update_from_pixels(image_sfml.pixels, sf.Rectangle((200.5, 200), (100, 50)))
input()

print("### sf.Texture.update_from_image() ###")
j = b.copy()
j.update_from_image(image_sfml)
#j.update_from_image(image_sfml, (200, 200)) # not implemented yet due to a bug in cython
#j.update_from_image(image_sfml, sf.Position(200, 200)) # not implemented yet due to a bug in cython
input()

#print("### sf.Texture.update_from_window() ###")
#k = b.copy()
#k.update_from_image(
#copy = b.copy_to_image()
#input()

print("### sf.Texture.bind() ###")
j.bind()
j.bind(sf.Texture.PIXELS)
input()

print("### sf.Texture.smooth ###")
assert type(j.smooth) == bool
print(j.smooth)
j.smooth = not j.smooth

print("### sf.Texture.repeated ###")
assert type(j.repeated) == bool
print(j.repeated)
j.repeated = not j.repeated

print("### sf.Texture.copy() ###")
l = b.copy()
assert type(l) == sf.Texture

print("### See result now ###")
a.copy_to_image().save_to_file("result/a.png")
b.copy_to_image().save_to_file("result/b.png")
c.copy_to_image().save_to_file("result/c.png")
d.copy_to_image().save_to_file("result/d.png")
e.copy_to_image().save_to_file("result/e.png")
f.copy_to_image().save_to_file("result/f.png")
g.copy_to_image().save_to_file("result/g.png")
h.copy_to_image().save_to_file("result/h.png")
i.copy_to_image().save_to_file("result/i.png")
j.copy_to_image().save_to_file("result/j.png")
#k.copy_to_image().save_to_file("result/k.png")
l.copy_to_image().save_to_file("result/l.png")
