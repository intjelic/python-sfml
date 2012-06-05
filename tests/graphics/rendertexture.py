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
from rendertarget import test_rendertarget

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.RenderTexture")
window.clear(sf.Color.WHITE)
window.display()
input()

image = sf.Texture.load_from_file("../data/sfml.png")
sprite = sf.Sprite(image)
sprite.position = (50, 50)

rendertexture = sf.RenderTexture(512, 512)
rendertexture.clear(sf.Color.GREEN)
rendertexture.draw(sprite)
rendertexture.display()

test_rendertarget(rendertexture)
input()

#rendertexture = sf.RenderTexture(512, 512)
#rendertexture.clear(sf.Color.GREEN)
#rendertexture.draw(sprite)
#rendertexture.display()

#sprite = sf.Sprite(rendertexture.texture)
#sprite.position = (50, 50)

#window.clear(sf.Color.WHITE)
#window.draw(sprite)
#window.display()
#input()

#print(rendertexture.size)
#print(rendertexture.width)
#print(rendertexture.height)
#print(rendertexture.viewport)
