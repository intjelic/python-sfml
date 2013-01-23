#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import os, sys, tempfile, struct
import sfml as sf


image_filename = sys.argv[1]

with open(image_filename, "rb") as f:
	image_width = struct.unpack("I", f.read(4))[0]
	image_height = struct.unpack("I", f.read(4))[0]
	image_data = f.read(image_width * image_height * 4)
	
f.close()

image = sf.Image.create(image_width, image_height)
x, y = (0, 0)

major, minor, micro, releaselevel, serial = sys.version_info

if major == 2:
	for i in range(0, len(image_data), 4):
		r = struct.unpack("B", image_data[i])[0]
		g = struct.unpack("B", image_data[i+1])[0]
		b = struct.unpack("B", image_data[i+2])[0]
		a = struct.unpack("B", image_data[i+3])[0]

		image[x, y] = sf.Color(r, g, b, a)
		
		x += 1
		if x == image_width:
			x = 0
			y += 1

else:
	for i in range(0, len(image_data), 4):
		r = int(image_data[i])
		g = int(image_data[i+1])
		b = int(image_data[i+2])
		a = int(image_data[i+3])

		image[x, y] = sf.Color(r, g, b, a)
		
		x += 1
		if x == image_width:
			x = 0
			y += 1


desktop_mode = sf.VideoMode.get_desktop_mode()

bpp = desktop_mode.bpp

if sf.VideoMode(image_width, image_height, bpp) > desktop_mode:
    video_size = (640, 480)
else:
    video_size = image.size
    
w, h = video_size

window = sf.RenderWindow(sf.VideoMode(w, h, bpp), 'pySFML - Image preview')
window.framerate_limit = 60

texture = sf.Texture.from_image(image)
sprite = sf.Sprite(texture)

while window.is_open:
	
	for event in window.events:
		if type(event) is sf.CloseEvent:
			window.close()
			break

	sf.sleep(sf.milliseconds(50))
	window.clear(sf.Color.WHITE)
	sf.sleep(sf.milliseconds(50))
	window.draw(sprite)
	sf.sleep(sf.milliseconds(50))
	window.display()
	sf.sleep(sf.milliseconds(150))
	
window.close()
os.remove(image_filename)
