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

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Sprite")
window.clear(sf.Color.YELLOW)
window.display()

texture_a = sf.Texture.load_from_file("../data/sfml.png")
texture_b = sf.Texture.load_from_file("../data/background.jpg")
sprite = sf.Sprite(texture_a)
input()


window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

sprite.position = (100, 100)
sprite.rotation = 45
sprite.ratio = (2, 2)
sprite.origin = (25, 25)
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

sprite = sf.Sprite(texture_a)
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

sprite.move(sf.Position(100, 100))
sprite.rotate(45)
sprite.scale(sf.Position(2, 2))
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

### TEST SPRITE ###

print(sprite.texture_rectangle)
sprite.texture_rectangle = sf.Rectangle((50, 50), (250 , 250))
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

sprite.texture = texture_b
print(sprite.texture_rectangle)
print(type(sprite.texture))
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

print(sprite.color)
sprite.color = sf.Color.RED
window.clear(sf.Color.YELLOW)
window.draw(sprite)
window.display()
input()

print("## sf.Sprite.texture ##")
print(sprite.texture)
print(type(sprite.texture))
window.draw(sprite)
window.display()
input()
sprite.texture = texture_b
sprite.reset_texture_rectangle()
window.clear(sf.Color.GREEN)
window.draw(sprite)
window.display()
input()

print("## sf.Sprite.texture_rectangle ##")
print(sprite.texture_rectangle)
print(type(sprite.texture_rectangle))
sprite.texture_rectangle = (50, 50, 300, 300)
sprite.texture_rectangle = sf.Rectangle((50, 50), (300, 300))
print(sprite.texture_rectangle)
print(type(sprite.texture_rectangle))
input()

print("## sf.Sprite.color ##")
sprite.color = sf.Color.CYAN
print(sprite.color)
print(type(sprite.color))
input()


print(sprite.local_bounds)
print(sprite.global_bounds)

window = sf.RenderWindow()

