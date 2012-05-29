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

print("### sf.Shader() ###")
try:
	shader = sf.Shader()
	raise Warning("Shouldn't work!")
	
except UserWarning as error:
	print("This error was expected...")
input()

print("### sf.Shader.load_from_file() ###")
a = sf.Image.load_from_file(50, 50)
input()

print("### sf.Image.load_from_memory() ###")
b = sf.Image.load_from_memory(a.pixels)
input()

print("### sf.Image.set_parameter() ###")
# Not implemented
input()

print("### sf.Image.bind() ###")
a.bind()
input()

print("### sf.Image.unbind() ###")
b.unbind()
input()


print("### sf.Image.is_available() ###")
is_available = sf.Image.is_available()
assert type(is_available) == bool
print(is_available)
input()

#cdef class Shader:
	#VERTEX = dgraphics.shader.Vertex
	#FRAGMENT = dgraphics.shader.Fragment

	#@classmethod
	#def load_from_file(cls, filename, dgraphics.shader.Type type):
		#cdef dgraphics.Shader *p = new dgraphics.Shader()
		#cdef char* encoded_filename	
			
		#encoded_filename_temporary = filename.encode('UTF-8')	
		#encoded_filename = encoded_filename_temporary

		#if p.loadFromFile(encoded_filename, type):
			#return wrap_shader(p)
		
		#del p
		#raise SFMLException()

	#@classmethod
	#def load_from_memory(cls, char* shader, dgraphics.shader.Type type):
		#cdef dgraphics.Shader *p = new dgraphics.Shader()

		#if p.loadFromMemory(shader, type):
			#return wrap_shader(p)
			
		#del p
		#raise SFMLException()

