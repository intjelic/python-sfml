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

image = sf.Image.load_from_file("icon.png")
window = sf.Window(sf.VideoMode(640, 480), "pySFML")

window.icon = image.pixels

x, y, w, h = 86, 217, image.size
pixels = image.pixels

assert pixels[w*y+x+0] == image[x, y].r
assert pixels[w*y+x+1] == image[x, y].g
assert pixels[w*y+x+2] == image[x, y].b
assert pixels[w*y+x+3] == image[x, y].a
