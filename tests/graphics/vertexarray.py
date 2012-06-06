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

vertex_array = sf.VertexArray()

print(len(vertex_array))
assert len(vertex_array) == 0

vertex_array.append(sf.Vertex())
vertex_array.append(sf.Vertex())
vertex_array.append(sf.Vertex())
b = sf.Vertex()
vertex_array.append(b)
print(len(vertex_array))

vertex_array.resize(1)
print(len(vertex_array))
input()

vertex_array.resize(3)
print(len(vertex_array))
input()

print(vertex_array[1].color)
vertex_array[1].color = sf.Color.RED
print(vertex_array[1].color)
input()

vertex_array[1] = sf.Vertex(color=sf.Color.BLUE)
print(vertex_array[1].color)
input()

vertex_array.clear()
print(len(vertex_array))
assert len(vertex_array) == 0
input()

print(b.color)
input()

vertex_array.resize(50)
input()


