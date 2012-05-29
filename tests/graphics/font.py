#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.graphics as sf

print("### sf.Font() ###")
try:
	font = sf.Font()
	raise Warning("Shouldn't work!")
	
except UserWarning as error:
	print("This error was expected...")
input()

print("### sf.Font.load_from_file() ###")
a = sf.Font.load_from_file("../data/myfont.ttf")
input()

print("### sf.Font.load_from_memory() ###")
file = open("../data/myfont.ttf", "rb")
data = file.read()
d = sf.Font.load_from_memory(data)

print("### sf.Font.get_default_font ###")
c = sf.Font.get_default_font()

print("### sf.Font.get_glyph ###")
glyph_a = c.get_glyph(56, 30, True)
glyph_b = c.get_glyph(75, 35, False)
glyph_c = c.get_glyph(125, 12, True)

assert type(glyph_a) == sf.Glyph
assert type(glyph_b) == sf.Glyph
assert type(glyph_c) == sf.Glyph

print(glyph_a)
print(glyph_b)
print(glyph_c)

print("### sf.Font.get_kerning ###")
kerning_a = a.get_kerning(20, 30, 30)
kerning_b = a.get_kerning(10, 11, 12)
kerning_c = a.get_kerning(20, 8, 10)

print(kerning_a)
print(kerning_b)
print(kerning_c)
input()

print("### sf.Font.get_texture ###")
texture = c.get_texture(12)
assert type(texture) == sf.Texture
input()



