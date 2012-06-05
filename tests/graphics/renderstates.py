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

foo = sf.RenderStates()
print(foo.blend_mode)
print(foo.transform)
print(foo.texture)
print(foo.shader)

texture = sf.Texture.load_from_file("../data/background.jpg")
shader = sf.Shader.load_vertex_from_file("../data/wave.vert")

print(texture)
print(shader)

try:
	image = sf.Image.load_from_file("../data/background.jpg")
	foo.texture = image

except TypeError:
	print("This error was expected")
input()

foo.texture = texture
foo.shader = shader

texture = "something else"
shader = "something else"
input()

print(foo.texture)
print(foo.shader)
input()

default = sf.RenderStates.DEFAULT
print(default.blend_mode)
print(default.transform)
print(default.texture)
print(default.shader)
input()

default = "something else"
another_default = sf.RenderStates.DEFAULT
input()
