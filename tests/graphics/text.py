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

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Text")
window.clear(sf.Color.RED)
window.display()
input("### TEST GLYPH : BEGING ###")

glyph = sf.Glyph()

print(glyph.advance)
print(type(glyph.advance))
print(glyph.bounds)
print(type(glyph.bounds))
print(glyph.texture_rectangle)
print(type(glyph.texture_rectangle))

glyph.advance = -5
glyph.bounds = sf.Rectangle((5, 5), (40, 40))
glyph.texture_rectangle = sf.Rectangle((5, 5), (40, 40))

print(glyph.advance)
print(glyph.bounds)
print(glyph.texture_rectangle)

input("### TEST FONT : BEGIN ###")

font_a = sf.Font.load_from_file("../data/sansation.ttf")
file = open("../data/sansation.ttf", "rb")
data = file.read()

font_b = sf.Font.load_from_memory(data)

glyph = font_a.get_glyph(76, 30, True)
print(type(glyph))

print(font_a.get_kerning(76, 78, 30))
print(font_a.get_line_spacing(30))

texture = font_a.get_texture(30)
texture.smooth = not texture.smooth

image = sf.Image.load_from_file("../data/sfml.png")
texture.update_from_image(image)


sprite = sf.Sprite(texture)
sprite.position = (250, 250)

window.clear(sf.Color.RED)
window.draw(sprite)
window.display()

input("### TEST TEXT : BEGIN ###")
#text = sf.Text()


