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

# this example shows the most common use of sf.Texture: drawing a sprite

#load a texture from a file
try:
	texture = sf.Texture.load_from_file("texture.png")
	
except sf.SFMLException: exit(1)

# assign it to a sprite
sprite = sf.Sprite()
sprite.texture = texture

# draw the textured sprite
window.draw(sprite);

# ======================================================================
# this example shows another common use of sf.Texture: streaming 
# real-time data, like video frames

# create an empty texture
texture = sf.Texture.create(640, 480)

# create a sprite that will display the texture
sprite = sf.Sprite(texture)

while loop: # the main loop
	# ...
	
	# get a fresh chunk of pixels (the next frame of a movie, for example)
	pixels = get_pixels_function()
	
	# update the texture
	texture.update(pixels)
	# or use update_from_pixels (faster)
	texture.update_from_pixels(pixels)
	
	# draw it
	window.draw(sprite)
	# ...
