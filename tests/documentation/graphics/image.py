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

try: 
	# load an image file from a file
	background = sf.Image.load_from_file("background.jpg")
	
	# create a 20x20 image filled with black color
	image = sf.Image.create(20, 20, sf.Color.BLACK)

except sf.SFMLException:
	exit(1)

# copy image1 on image 2 at position(10, 10)
background.blit(image, (10, 10))
	
# make the top-left pixel transparent
color = image[0, 0]
color.a = 0
image[0, 0] = color

# save the image to a file
background.save_to_file("result.png")
