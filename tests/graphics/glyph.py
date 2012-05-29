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

print("### sf.Glyph() ###")
glyph = sf.Glyph()

print("### sf.Glyph.advance ###")
assert type(glyph.advance) == int
print(glyph.advance)
glyph.advance = -50
glyph.advance = 50
print(glyph.advance)

print("### sf.Glyph.bounds ###")
assert type(glyph.bounds) == sf.Rectangle
print(glyph.bounds)
glyph.bounds = sf.Rectangle((10, 20), (50, 60))
glyph.bounds = (10, 20, 50, 60)
assert glyph.bounds == sf.Rectangle((10, 20), (50, 60))
print(glyph.bounds)

print("### sf.Glyph.texture_rectangle ###")
assert type(glyph.texture_rectangle) == sf.Rectangle
print(glyph.texture_rectangle)
glyph.texture_rectangle = sf.Rectangle((10, 20), (50, 60))
glyph.texture_rectangle = (10, 20, 50, 60)
assert glyph.texture_rectangle == sf.Rectangle((10, 20), (50, 60))
print(glyph.texture_rectangle)
