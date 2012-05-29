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

class MyDrawable(sf.Drawable):
	def __init__(self):
		sf.Drawable.__init__(self)
		
		self.texture = sf.Texture.load_from_file("../data/background.jpg")
		
	def draw(self, target, states):
		assert type(target) == sf.RenderTarget
		assert type(states) == sf.RenderStates
		print(target)
		print(states.transform)
		print(states.texture)
		print(states.shader)
		sprite = sf.Sprite(self.texture)
		target.draw(sprite, states)		
		

try:
	mydrawable = sf.Drawable()
	raise UserWarning("Shouldn't work!!!")
except NotImplementedError:
	print("This error was expected")
input()

window = sf.RenderWindow(sf.VideoMode(600, 600), "pySFML - Drawable")
mydrawable = MyDrawable()

myshader = sf.Shader.load_from_file("../data/wave.vert", sf.Shader.VERTEX)
mytexture = sf.Texture.load_from_file("../data/sfml.png")
renderstates = sf.RenderStates(texture=mytexture, shader=myshader)
renderstates.transform.rotate(45)

window.clear()
window.draw(mydrawable, renderstates)
window.display()
input()
