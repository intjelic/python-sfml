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

print("### sf.RenderTarget() ###")
try:
	target = sf.RenderTarget()
	raise Warning("Shouldn't work!")
	
except NotImplementedError as error:
	print("This error was expected...")
input()


def test_rendertarget(target):
	print("### sf.RenderTarget.clear() ###")
	target.clear()
	target.clear(sf.Color.RED)
	input()
	
	print("### sf.RenderTarget.view ###")
	assert type(target.view) == sf.View
	print(target.view)
	target.view = sf.View()
	input()
	
	print("### sf.RenderTarget.default_view ###")
	assert type(target.default_view) == sf.View
	print(target.default_view)
	input()
	
	print("### sf.RenderTarget.get_viewport() ###")
	v1 = sf.View()
	viewport = target.get_viewport(v1)
	assert type(viewport) == sf.Rectangle
	print(viewport)
	input()
	
	print("### sf.RenderTarget.convert_coords() ###")
	v1 = sf.View()
	v2 = sf.View()
	p1 = target.convert_coords(sf.Position(40, 80))
	p2 = target.convert_coords((120, 20))
	p3 = target.convert_coords(sf.Position(5, 75), v1)
	p4 = target.convert_coords((78, 24), v2)
	
	print("### sf.RenderTarget.draw() ###")
	texture = sf.Texture.load_from_file("../data/background.jpg")
	sprite = sf.Sprite(texture)
	render_states = sf.RenderStates()
	target.draw(sprite, render_states)
	
	print("### sf.RenderTarget.size")
	assert type(target.size) == sf.Size
	print(target.size)
	print(target.width)
	print(target.height)
	
	print("### sf.RenderTarget.push_GL_states() ###")
	target.push_GL_states()
	
	print("### sf.RenderTarget.pop_GL_states() ###")
	target.pop_GL_states()
	
	print("### sf.RenderTarget.reset_GL_states() ###")
	target.reset_GL_states()
