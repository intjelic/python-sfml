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

a = sf.Vertex()
b = sf.Vertex((10, 20))
c = sf.Vertex(sf.Position(20, 30))
d = sf.Vertex((40, 50), sf.Color.RED)
e = sf.Vertex((50, 60), sf.Color.BLUE, (70, 80))
f = sf.Vertex((90, 100), sf.Color.GREEN, sf.Position(110, 120))

print(a.position)
assert a.position == sf.Position(0, 0)
a.position = (40, 50)
print(a.position)
assert a.position == sf.Position(40, 50)
assert type(a.position) == sf.Position

print(a.color)
a.color = sf.Color.CYAN
print(a.color)
assert a.color == sf.Color.CYAN
assert type(a.color) == sf.Color

print(a.tex_coords)
assert a.tex_coords == sf.Position(0, 0)
a.tex_coords = (40, 50)
print(a.tex_coords)
assert a.tex_coords == sf.Position(40, 50)
assert type(a.tex_coords) == sf.Position
