#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

cimport cython
from cython.operator cimport dereference as deref
from cython.operator cimport preincrement as inc

from libcpp.vector cimport vector

cimport dsystem, dwindow, dgraphics
from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64

__all__ = ['BlendMode', 'PrimitiveType', 'Color', 'Transform', 
			'Image', 'Texture', 'Glyph', 'Font', 'Shader', 
			'RenderStates', 'Drawable', 'Transformable', 'Sprite', 
			'Text', 'Shape', 'CircleShape', 'ConvexShape', 
			'RectangleShape', 'Vertex', 'VertexArray', 'View', 
			'RenderTarget', 'RenderTexture', 'RenderWindow', 
			'HandledWindow', 'Rectangle', 'TransformableDrawable']
			
string_type = [bytes, unicode, str]
numeric_type = [int, long, float, long]

import os, tempfile, struct, subprocess, sys
from copy import copy, deepcopy
from warnings import warn

from sfml.system import SFMLException
from sfml.system import pop_error_message, push_error_message

cdef extern from "system.h":
	cdef class sfml.system.Vector2 [object PyVector2Object]:
		cdef public object x
		cdef public object y
			
	cdef class sfml.system.Vector3 [object PyVector3Object]:
		cdef public object x
		cdef public object y
		cdef public object z

cdef extern from "window.h":
	cdef class sfml.window.Window [object PyWindowObject]:
		cdef dwindow.Window *p_window
		
	cdef class sfml.window.VideoMode [object PyVideoModeObject]:
		cdef dwindow.VideoMode *p_this
		
	cdef class sfml.window.ContextSettings [object PyContextSettingsObject]:
		cdef dwindow.ContextSettings *p_this
		
	cdef class sfml.window.Pixels [object PyPixelsObject]:
		cdef Uint8          *p_array
		cdef unsigned int    m_width
		cdef unsigned int    m_height


cdef Pixels wrap_pixels(Uint8 *p, unsigned int w, unsigned int h):
	cdef Pixels r = Pixels.__new__(Pixels)
	r.p_array, r.m_width, r.m_height = p, w, h
	return r
	
# utility functions for sf.Vector2
cdef dsystem.Vector2i vector2_to_vector2i(vector):
	x, y = vector
	return dsystem.Vector2i(x, y)
	
cdef dsystem.Vector2f vector2_to_vector2f(vector):
	x, y = vector
	return dsystem.Vector2f(x, y)

# utility functions for sf.Rectangle
cdef dsystem.FloatRect rectangle_to_floatrect(rectangle):
	l, t, w, h = rectangle
	return dsystem.FloatRect(l, t, w, h)
	
cdef dsystem.IntRect rectangle_to_intrect(rectangle):
	l, t, w, h = rectangle
	return dsystem.IntRect(l, t, w, h)

cdef Rectangle intrect_to_rectangle(dsystem.IntRect* intrect):
	return Rectangle((intrect.left, intrect.top), (intrect.width, intrect.height))

cdef Rectangle floatrect_to_rectangle(dsystem.FloatRect* floatrect):
	return Rectangle((floatrect.left, floatrect.top), (floatrect.width, floatrect.height))


class BlendMode:
	BLEND_ALPHA = dgraphics.blendmode.BlendAlpha
	BLEND_ADD = dgraphics.blendmode.BlendAdd
	BLEND_MULTIPLY = dgraphics.blendmode.BlendMultiply
	BLEND_NONE = dgraphics.blendmode.BlendNone


class PrimitiveType:
	POINTS = dgraphics.primitivetype.Points
	LINES = dgraphics.primitivetype.Lines
	LINES_STRIP = dgraphics.primitivetype.LinesStrip
	TRIANGLES = dgraphics.primitivetype.Triangles
	TRIANGLES_STRIP = dgraphics.primitivetype.TrianglesStrip
	TRIANGLES_FAN = dgraphics.primitivetype.TrianglesFan
	QUADS = dgraphics.primitivetype.Quads
	
	
cdef class Rectangle:
	cdef public Vector2 position
	cdef public Vector2 size

	def __init__(self, position=(0, 0), size=(0, 0)):
		left, top = position
		width, height = size
		self.position = Vector2(left, top)
		self.size = Vector2(width, height)
		
	def __repr__(self):
		return "sf.Rectangle({0})".format(self)

	def __str__(self):
		return "{0}x, {1}y, {2}w, {3}h".format(self.left, self.top, self.width, self.height)

	def __richcmp__(Rectangle x, y, op):
		try: left, top, width, height = y
		except Exception: return False
		
		if op == 2: return x.position == Vector2(left, top) and x.size == Vector2(width, height)
		elif op == 3: return not (x.position == Vector2(left, top) and x.size == Vector2(width, height))
		else: raise NotImplementedError

	def __iter__(self):
		return iter((self.left, self.top, self.width, self.height))

	def __copy__(self):
		cdef Rectangle p = Rectangle.__new__(Rectangle)
		p.position = copy(self.position)
		p.size = copy(self.size)
		return p
		
	def __deepcopy__(self):
		cdef Rectangle p = Rectangle.__new__(Rectangle)
		p.position = copy(self.position)
		p.size = copy(self.size)
		return p
		
	property left:
		def __get__(self):
			return self.position.x
		
		def __set__(self, left):
			self.position.x = left
			
	property top:
		def __get__(self):
			return self.position.y
		
		def __set__(self, top):
			self.position.y = top
			
	property width:
		def __get__(self):
			return self.size.x
		
		def __set__(self, width):
			self.size.x = width
			
	property height:
		def __get__(self):
			return self.size.y
		
		def __set__(self, height):
			self.size.y = height
			
	property center:
		def __get__(self):
			return self.position + self.size / 2
		
		def __set__(self, center):
			raise NotImplementedError
	
	property right:
		def __get__(self):
			return self.left + self.width
		
		def __set__(self, right):
			raise NotImplementedError
			
	property bottom:
		def __get__(self):
			return self.top + self.height
		
		def __set__(self, bottom):
			raise NotImplemented

	def contains(self, point):
		x, y = point
		return x >= self.left and x < self.right and y >= self.top and y < self.bottom
		
	def intersects(self, rectangle):
		# make sure the rectangle is a rectangle (to get its right/bottom border)
		l, t, w, h = rectangle
		rectangle = Rectangle(l, t, w, h)
		
		# compute the intersection boundaries
		left = max(self.left, rectangle.left)
		top = max(self.top, rectangle.top)
		right = min(self.right, rectangle.right)
		bottom = min(self.bottom, rectangle.bottom)
		
		# if the intersection is valid (positive non zero area), then 
		# there is an intersection
		if left < right and top < bottom:
			return Rectangle((left, top), (right-left, bottom-top))
			
		
	def copy(self):
		cdef Rectangle p = Rectangle.__new__(Rectangle)
		p.position = self.position.copy()
		p.size = self.size.copy()
		return p
		
cdef class Color:
	BLACK = Color(0, 0, 0)
	WHITE = Color(255, 255, 255)
	RED = Color(255, 0, 0)
	GREEN = Color(0, 255, 0)
	BLUE = Color(0, 0, 255)
	YELLOW = Color(255, 255, 0)
	MAGENTA = Color(255, 0, 255)
	CYAN = Color(0, 255, 255)
	TRANSPARENT = Color(0, 0, 0, 0)

	cdef dgraphics.Color *p_this

	def __cinit__(self, Uint8 r=0, Uint8 g=0, Uint8 b=0, Uint8 a=255):
		self.p_this = new dgraphics.Color(r, g, b, a)

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return 'sf.Color({0})'.format(self)
		
	def __str__(self):
		return "{0}r, {1}g, {2}b, {3}a".format(self.r, self.g, self.b, self.a)
		
	def __iter__(self):
		return iter((self.r, self.g, self.b, self.a))

	def __richcmp__(Color x, Color y, int op):
		if op == 2: return x.p_this[0] == y.p_this[0]
		elif op == 3: return x.p_this[0] != y.p_this[0]
		else: return NotImplemented

	def __add__(Color x, Color y):
		r = Color(0, 0, 0)
		r.p_this[0] = x.p_this[0] + y.p_this[0]
		return r
		
	def __mul__(Color x, Color y):
		r = Color(0, 0, 0)
		r.p_this[0] = x.p_this[0] * y.p_this[0]
		return r

	def __iadd__(self, Color x):
		self.p_this[0] = self.p_this[0] + x.p_this[0]
		return self

	def __imul__(self, Color x):
		self.p_this[0] = self.p_this[0] * x.p_this[0]
		return self

	property r:
		def __get__(self):
			return self.p_this.r

		def __set__(self, Uint8 r):
			self.p_this.r = r

	property g:
		def __get__(self):
			return self.p_this.g

		def __set__(self, Uint8 g):
			self.p_this.g = g

	property b:
		def __get__(self):
			return self.p_this.b

		def __set__(self, Uint8 b):
			self.p_this.b = b

	property a:
		def __get__(self):
			return self.p_this.a

		def __set__(self, unsigned int a):
			self.p_this.a = a
                        
	def __copy__(self):
		cdef Color p = Color.__new__(Color)
		p.r, p.g, p.b, p.a = self
		return p
		
	def __deepcopy__(self):
		cdef Color p = Color.__new__(Color)
		p.r, p.g, p.b, p.a = self
		return p

cdef Color wrap_color(dgraphics.Color *p):
	cdef Color r = Color.__new__(Color)
	r.p_this = p
	return r


cdef class Transform:
	cdef dgraphics.Transform *p_this
	cdef bint                 delete_this
	
	def __init__(self):
		self.p_this = new dgraphics.Transform()
		self.delete_this = True

	def __dealloc__(self):
		if self.delete_this:
			del self.p_this

	def __repr__(self):
		cdef float *p = <float*>self.p_this.getMatrix()
		return "sf.Transform({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8})".format(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8])

	def __str__(self):
		cdef float *p = <float*>self.p_this.getMatrix()
		return "[{0}, {1}, {2}]\n[{3}, {4}, {5}]\n[{6}, {7}, {8}]".format(str(p[0])[:3], str(p[1])[:3], str(p[2])[:3], str(p[3])[:3], str(p[7])[:3], str(p[5])[:3], str(p[6])[:3], str(p[7])[:3], str(p[8])[:3])

	def __mul__(Transform x, Transform y):
		r = Transform()
		r.p_this[0] = x.p_this[0] * y.p_this[0]
		return r

	def __imul__(self, Transform x):
		self.p_this[0] = self.p_this[0] * x.p_this[0]
		return self
		
	@classmethod
	def from_values(self, float a00, float a01, float a02, float a10, float a11, float a12, float a20, float a21, float a22):
		cdef Transform r = Transform.__new__(Transform)
		r.p_this = new dgraphics.Transform(a00, a01, a02, a10, a11, a12, a20, a21, a22)
		return r

	property matrix:
		def __get__(self):
			return <long>self.p_this.getMatrix()
		
	property inverse:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_this.getInverse()
			return wrap_transform(p)
	
	def transform_point(self, point):
		cdef dsystem.Vector2f p = self.p_this.transformPoint(vector2_to_vector2f(point))
		return Vector2(p.x, p.y)
		
	def transform_rectangle(self, rectangle):
		cdef dsystem.FloatRect p = self.p_this.transformRect(rectangle_to_floatrect(rectangle))
		return Rectangle((p.top, p.left), (p.width, p.height))
		
	def combine(self, Transform transform):
		self.p_this.combine(transform.p_this[0])
		return self
		
	def translate(self, offset):
		self.p_this.translate(vector2_to_vector2f(offset))
		return self
		
	def rotate(self, float angle, center=None):
		if not center:
			self.p_this.rotate(angle)
		else:
			self.p_this.rotate(angle, vector2_to_vector2f(center))
			
		return self
		
	def scale(self, factor, center=None):
		if not center:
			self.p_this.scale(vector2_to_vector2f(factor))
		else:
			self.p_this.scale(vector2_to_vector2f(factor), vector2_to_vector2f(center))
			
		return self
		
		
cdef Transform wrap_transform(dgraphics.Transform *p, bint d=True):
	cdef Transform r = Transform.__new__(Transform)
	r.p_this = p
	r.delete_this = d
	return r
	
cdef Transformable wrap_transformable(dgraphics.Transformable *p):
	cdef Transformable r = Transformable.__new__(Transformable)
	r.p_this = p
	return r


cdef class Image:
	cdef dgraphics.Image *p_this
	
	def __init__(self):
		raise UserWarning("Use a specific constructor")

	def __dealloc__(self):
		del self.p_this
		
	def __getitem__(self, tuple v):
		cdef dgraphics.Color *p = new dgraphics.Color()
		p[0] = self.p_this.getPixel(v[0], v[1])
		return wrap_color(p)

	def __setitem__(self, tuple k, Color v):
		self.p_this.setPixel(k[0], k[1], v.p_this[0])

	def __copy__(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this[0]
		return wrap_image(p)
		
	def __deepcopy__(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this[0]
		return wrap_image(p)
		
	@classmethod
	def create(cls, unsigned int width, unsigned int height, Color color=None):
		cdef dgraphics.Image *p = new dgraphics.Image()
		if not color: p.create(width, height)
		else: p.create(width, height, color.p_this[0])
		return wrap_image(p)
		
	@classmethod
	def from_size(cls, unsigned int width, unsigned int height, Color color=None):
		cdef dgraphics.Image *p = new dgraphics.Image()
		if not color: p.create(width, height)
		else: p.create(width, height, color.p_this[0])
		return wrap_image(p)

	@classmethod
	def from_pixels(cls, Pixels pixels):
		cdef dgraphics.Image *p
		
		if pixels.p_array != NULL:
			p = new dgraphics.Image()
			p.create(pixels.m_width, pixels.m_height, pixels.p_array)
			return wrap_image(p)
			
		raise SFMLException("sf.Pixels's array points on NULL - It would create an empty image")

	@classmethod
	def create_from_pixels(cls, Pixels pixels):
		warn('Please use Image.from_pixels(pixels) instead.', DeprecationWarning)
		return cls.from_pixels(pixels)

	@classmethod
	def from_file(cls, filename):
		cdef dgraphics.Image *p = new dgraphics.Image()
		cdef char* encoded_filename	

		encoded_filename_temporary = filename.encode('UTF-8')	
		encoded_filename = encoded_filename_temporary

		if p.loadFromFile(encoded_filename):
			return wrap_image(p)
			
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_file(cls, filename):
		warn('Please use Image.from_file(filename) instead.', DeprecationWarning)
		return cls.from_file(filename)

	@classmethod
	def from_memory(cls, bytes data):
		cdef dgraphics.Image *p = new dgraphics.Image()

		if p.loadFromMemory(<char*>data, len(data)):
			return wrap_image(p)
			
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_memory(cls, bytes data):
		warn('Please use Image.from_memory(data) instead.', DeprecationWarning)
		return cls.from_memory(data)

	def to_file(self, filename):
		cdef char* encoded_filename	
			
		encoded_filename_temporary = filename.encode('UTF-8')	
		encoded_filename = encoded_filename_temporary

		if not self.p_this.saveToFile(encoded_filename): raise IOError(pop_error_message())

	def save_to_file(self, filename):
		warn('Please use Image.to_file(filename) instead.', DeprecationWarning)
		return self.to_file(filename)

	
	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)
		
	property width:
		def __get__(self):
			return self.size.x
	
	property height:
		def __get__(self):
			return self.size.y
	
	def create_mask_from_color(self, Color color, Uint8 alpha=0):
		self.p_this.createMaskFromColor(color.p_this[0], alpha)
	
	def blit(self, Image source, dest, source_rect=None, bint apply_alpha=False):
		x, y = dest
		if not source_rect: self.p_this.copy(source.p_this[0], x, y, dsystem.IntRect(0, 0, 0, 0), apply_alpha)
		else: self.p_this.copy(source.p_this[0], x, y, rectangle_to_intrect(source_rect), apply_alpha)
	
	property pixels:
		def __get__(self):
			if self.p_this.getPixelsPtr():
				return wrap_pixels(<Uint8*>self.p_this.getPixelsPtr(), self.width, self.height)
		
	def flip_horizontally(self):
		self.p_this.flipHorizontally()
		
	def flip_vertically(self):
		self.p_this.flipVertically()

	def show(self):
		script_filename = os.path.dirname(__file__) + "/show.py"
		temporaryfile_filename = tempfile.mkstemp()[1]
		
		with open(temporaryfile_filename, "wb") as temporaryfile:
			temporaryfile.write(struct.pack("I", self.pixels.width))
			temporaryfile.write(struct.pack("I", self.pixels.height))
			temporaryfile.write(self.pixels.data)
			
		subprocess.Popen([sys.executable, script_filename, temporaryfile_filename])

	def copy(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this[0]
		return wrap_image(p)


cdef Image wrap_image(dgraphics.Image *p):
	cdef Image r = Image.__new__(Image)
	r.p_this = p
	return r


cdef public class Texture[type PyTextureType, object PyTextureObject]:
	NORMALIZED = dgraphics.texture.Normalized
	PIXELS = dgraphics.texture.Pixels
	
	cdef dgraphics.Texture *p_this
	cdef bint               delete_this
	
	def __init__(self):
		raise UserWarning("Use a specific constructor")

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	def __copy__(self):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		p[0] = self.p_this[0]
		return wrap_texture(p)
		
	def __deepcopy__(self):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		p[0] = self.p_this[0]
		return wrap_texture(p)
		
	def draw(self, RenderTarget target, states):
		target.p_rendertarget.draw((<dgraphics.Drawable*>self.p_this)[0])
		
	@classmethod
	def create(cls, unsigned int width, unsigned int height):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		
		if p.create(width, height):
			return wrap_texture(p)
		
		del p
		raise SFMLException()
		
	@classmethod
	def from_size(cls, unsigned int width, unsigned int height):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		
		if p.create(width, height):
			return wrap_texture(p)
		
		del p
		raise SFMLException()

	@classmethod
	def from_file(cls, filename, area=None):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		cdef char* encoded_filename
		
		encoded_filename_temporary = filename.encode('UTF-8')	
		encoded_filename = encoded_filename_temporary
		
		if not area:
			if p.loadFromFile(encoded_filename): return wrap_texture(p)
		else:
			l, t, w, h = area
			if p.loadFromFile(encoded_filename, dsystem.IntRect(l, t, w, h)): return wrap_texture(p)
			
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_file(cls, filename, area=None):
		warn('Please use Texture.from_file(filename, area) instead.', DeprecationWarning)
		return cls.from_file(filename, area)

	@classmethod
	def from_memory(cls, bytes data, area=None):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		
		if not area:
			if p.loadFromMemory(<char*>data, len(data)): return wrap_texture(p)
		else:
			l, t, w, h = area
			if p.loadFromMemory(<char*>data, len(data), dsystem.IntRect(l, t, w, h)): return wrap_texture(p)
	
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_memory(cls, bytes data, area=None):
		warn('Please use Texture.from_memory(data, area) instead.', DeprecationWarning)
		return cls.from_memory(data, area)
		
	@classmethod
	def from_image(cls, Image image, area=None):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		
		if not area:
			if p.loadFromImage(image.p_this[0]): return wrap_texture(p)
		else:
			l, t, w, h = area
			if p.loadFromImage(image.p_this[0], dsystem.IntRect(l, t, w, h)): return wrap_texture(p)
		
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_image(cls, Image image, area=None):
		warn('Please use Texture.from_image(image, area) instead.', DeprecationWarning)
		return cls.from_image(image, area)

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)
			
		def __set__(self, size):
			raise NotImplemented
	
	property width:
		def __get__(self):
			return self.size.x
			
		def __set__(self, width):
			raise NotImplemented
	
	property height:
		def __get__(self):
			return self.size.y
			
		def __set__(self, height):
			raise NotImplemented

	def copy_to_image(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this.copyToImage()
		return wrap_image(p)
	
	def to_image(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this.copyToImage()
		return wrap_image(p)

	def copy_to_image(self):
		warn('Please use Texture.to_image() instead.', DeprecationWarning)
		return self.to_image()
	
	def update(self, *args, **kwargs):
		if len(args) == 0:
			raise UserWarning("No arguments provided. It requires at least one.")
			
		if len(args) > 2:
			raise UserWarning("Too much arguments provided. It requires at most two.")
			
		if type(args[0]) is Pixels:
			if len(args) == 2:
				if type(args[1]) in [Vector2, tuple]:
					self.update_from_pixels(args[0], args[1])
				else: raise UserWarning("The second argument must be either a sf.Vector2 or a tuple")
			else:
				self.update_from_pixels(args[0])
				
		elif type(args[0]) is Image:
			if len(args) == 2:
				if type(args[1]) in [Vector2, tuple]:
					self.update_from_image(args[0], args[1])
				else: raise UserWarning("The second argument must be either a sf.Vector2 or a tuple")
			else:
				self.update_from_image(args[0])
				
		elif isinstance(args[0], Window):
			if len(args) == 2:
				if type(args[1]) in [Vector2, tuple]:
					self.update_from_window(args[0], args[1])
				else: raise UserWarning("The second argument must be either a sf.Vector2 or a tuple")
			else:
				self.update_from_window(args[0])
				
		else: raise UserWarning("The first argument must be either sf.Pixels, sf.Image or sf.Window")


	def update_from_pixels(self, Pixels pixels, position=None):
		if not position:
			self.p_this.update(pixels.p_array)
		else:
			x, y = position
			self.p_this.update(pixels.p_array, pixels.m_width, pixels.m_height, <unsigned int>x, <unsigned int>y)
			
	def update_from_image(self, Image image, position=None):
		if not position:
			self.p_this.update(image.p_this[0])
		else:
			x, y = position
			self.p_this.update(image.p_this[0], <unsigned int>x, <unsigned int>y)

	def update_from_window(self, Window window, position=None):
		if not position:
			self.p_this.update(window.p_window[0])
		else:
			x, y = position
			self.p_this.update(window.p_window[0], <unsigned int>x, <unsigned int>y)

	def bind(self, dgraphics.texture.CoordinateType coordinate_type=dgraphics.texture.Normalized):
		self.p_this.bind(coordinate_type)

	property smooth:
		def __get__(self):
			return self.p_this.isSmooth()
			
		def __set__(self, bint smooth):
			self.p_this.setSmooth(smooth)
		
	property repeated:
		def __get__(self):
			return self.p_this.isRepeated()
			
		def __set__(self, bint repeated):
			self.p_this.setRepeated(repeated)

	def copy(self):
		cdef dgraphics.Texture *p = new dgraphics.Texture()
		p[0] = self.p_this[0]
		return wrap_texture(p)
		
	@classmethod
	def get_maximum_size(cls):
		return dgraphics.texture.getMaximumSize()
		
		
cdef Texture wrap_texture(dgraphics.Texture *p, bint d=True):
	cdef Texture r = Texture.__new__(Texture)
	r.p_this = p
	r.delete_this = d
	return r


cdef class Glyph:
	cdef dgraphics.Glyph *p_this

	def __init__(self):
		self.p_this = new dgraphics.Glyph()

	def __dealloc__(self):
		del self.p_this

	property advance:
		def __get__(self):
			return self.p_this.advance

		def __set__(self, int advance):
			self.p_this.advance = advance

	property bounds:
		def __get__(self):
			return intrect_to_rectangle(&self.p_this.bounds)
			
		def __set__(self, bounds):
			self.p_this.bounds = rectangle_to_intrect(bounds)

	property texture_rectangle:
		def __get__(self):
			return intrect_to_rectangle(&self.p_this.textureRect)
			
		def __set__(self, texture_rectangle):
			self.p_this.textureRect = rectangle_to_intrect(texture_rectangle)


cdef Glyph wrap_glyph(dgraphics.Glyph *p):
	cdef Glyph r = Glyph.__new__(Glyph)
	r.p_this = p
	return r


cdef class Font:
	cdef dgraphics.Font *p_this
	cdef bint            delete_this
	cdef Texture         m_texture
	
	def __init__(self):
		raise UserWarning("Use a specific constructor")

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	@classmethod
	def from_file(cls, filename):
		cdef dgraphics.Font *p = new dgraphics.Font()
		cdef char* encoded_filename	

		encoded_filename_temporary = filename.encode('UTF-8')	
		encoded_filename = encoded_filename_temporary

		if p.loadFromFile(encoded_filename):
			return wrap_font(p)

		del p
		raise IOError(pop_error_message())
	
	@classmethod
	def load_from_file(cls, filename):
		warn('Please use Font.from_file(data) instead.', DeprecationWarning)
		return cls.from_file(filename)

	@classmethod
	def from_memory(cls, bytes data):
		cdef dgraphics.Font *p = new dgraphics.Font()

		if p.loadFromMemory(<char*>data, len(data)):
			return wrap_font(p)
			
		del p
		raise IOError(pop_error_message())

	@classmethod
	def load_from_memory(cls, bytes data):
		warn('Please use Font.from_memory(data) instead.', DeprecationWarning)
		return cls.from_memory(data)

	def get_glyph(self, Uint32 code_point, unsigned int character_size, bint bold):
		cdef dgraphics.Glyph *p = new dgraphics.Glyph()
		p[0] = self.p_this.getGlyph(code_point, character_size, bold)
		return wrap_glyph(p)

	def get_kerning(self, Uint32 first, Uint32 second, unsigned int character_size):
		return self.p_this.getKerning(first, second, character_size)

	def get_line_spacing(self, unsigned int character_size):
		return self.p_this.getLineSpacing(character_size)

	def get_texture(self, unsigned int character_size):
		cdef dgraphics.Texture *p
		p = <dgraphics.Texture*>&self.p_this.getTexture(character_size)
		return wrap_texture(p, False)

cdef Font wrap_font(dgraphics.Font *p, bint d=True):
	cdef Font r = Font.__new__(Font)
	r.p_this = p
	r.delete_this = d
	return r

	
cdef class Shader:
	cdef dgraphics.Shader *p_this
	cdef bint              delete_this
	
	def __init__(self):
		raise UserWarning("Use a specific constructor")

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	@classmethod
	def from_file(cls, vertex=None, fragment=None):
		cdef dgraphics.Shader *p = new dgraphics.Shader()
		cdef char* encoded_vertex_filename
		cdef char* encoded_fragment_filename
		
		if vertex:
			encoded_vertex_filename_temporary = vertex.encode('utf-8')	
			encoded_vertex_filename = encoded_vertex_filename_temporary

		if fragment:
			encoded_fragment_filename_temporary = fragment.encode('utf-8')	
			encoded_fragment_filename = encoded_fragment_filename_temporary

		if vertex and fragment:
			if p.loadFromFile(encoded_vertex_filename, encoded_fragment_filename):
				return wrap_shader(p)
		elif vertex:
			if p.loadFromFile(encoded_vertex_filename, dgraphics.shader.Vertex):
				return wrap_shader(p)
		elif fragment:
			if p.loadFromFile(encoded_fragment_filename, dgraphics.shader.Fragment):
				return wrap_shader(p)
		else:
			raise TypeError("This method takes at least 1 argument (0 given)")
			
		del p
		raise IOError(pop_error_message())
		
	@classmethod
	def load_from_file(cls, vertex, fragment):
		warn('Please use Shader.from_file(vertex, fragment) instead.', 
			 DeprecationWarning)
		return cls.from_file(vertex, fragment)

	@classmethod
	def load_vertex_from_file(cls, filename):
		warn('Please use Shader.from_file(vertex=filename) instead.', 
			 DeprecationWarning)
		return cls.from_file(vertex=filename)
		
	@classmethod
	def load_fragment_from_file(cls, filename):
		warn('Please use Shader.from_file(fragment=filename) instead.', 
			 DeprecationWarning)
		return cls.from_file(fragment=filename)
		
	@classmethod
	def from_memory(cls, char* vertex=NULL, char* fragment=NULL):
		cdef dgraphics.Shader *p = new dgraphics.Shader()

		if vertex is None and fragment is None:
			raise TypeError("This method takes at least 1 argument (0 given)")
			
		if vertex and fragment:
			if p.loadFromMemory(vertex, fragment):
				return wrap_shader(p)
				
			del p
			raise IOError(pop_error_message())
			
		if vertex: 
			return Shader.vertex_from_memory(vertex)
		elif fragment: 
			return Shader.fragment_from_memory(fragment)

	@classmethod
	def load_from_memory(cls, char* vertex, char* fragment):
		warn('Please use Shader.from_memory(vertex, fragment) instead.', DeprecationWarning)
		return cls.from_memory(vertex, fragment)
		
	@classmethod
	def load_vertex_from_memory(cls, char* vertex):
		warn('Please use Shader.from_memory(vertex=vertex) instead.', DeprecationWarning)
		return cls.from_memory(vertex=vertex)
		
	@classmethod
	def vertex_from_memory(cls, char* vertex):
		warn('Please use Shader.from_memory(vertex=vertex) instead.', DeprecationWarning)
		return cls.from_memory(vertex=vertex)
		
	@classmethod
	def load_fragment_from_memory(cls, char* fragment):
		warn('Please use Shader.from_memory(fragment=fragment) instead.', DeprecationWarning)
		return cls.from_memory(fragment=fragment)
		
	@classmethod
	def fragment_from_memory(cls, char* fragment):
		warn('Please use Shader.from_memory(fragment=fragment) instead.', DeprecationWarning)
		return cls.from_memory(fragment=fragment)

	def set_parameter(self, *args, **kwargs):
		if len(args) == 0:
			raise UserWarning("No arguments provided. It requires at least one string.")
			
		if type(args[0]) not in [bytes, unicode, str]:
			raise UserWarning("The first argument must be a string (bytes, unicode or str)")

		if len(args) == 1:
			self.set_currenttexturetype_parameter(args[0])
		elif len(args) == 2:
			if type(args[1]) in [Vector2, tuple]:
				if type(args[1]) is Vector2:
					self.set_vector2_paramater(args[0], args[1])
					return
				elif len(args[1]) == 2:
					self.set_vector2_paramater(args[0], args[1])
				elif len(args[1]) == 3:
					self.set_vector3_paramater(args[0], args[1])
				else:
					raise UserWarning("The second argument must be a tuple of length 2 or 3")
			elif type(args[1]) is Color:
				self.set_color_parameter(args[0], args[1])
			elif type(args[1]) is Transform:
				self.set_transform_parameter(args[0], args[1])
			elif type(args[1]) is Texture:
				self.set_texture_parameter(args[0], args[1])
			elif type(args[1]) in numeric_type:
				self.set_1float_parameter(args[0], args[1])
			else:
				raise UserWarning("The second argument type must be a number, an sf.Position, an sf.Color, an sf.Transform or an sf.Texture")
		else:
			if len(args) > 5:
				raise UserWarning("Wrong number of argument.")
			for i in range(1, len(args)):
				if type(args[i]) not in numeric_type:
					raise UserWarning("Argument {0} must be a number".format(i+1))
			if len(args) == 3:
				self.set_2float_parameter(args[0], args[1], args[2])
			elif len(args) == 4:
				self.set_3float_parameter(args[0], args[1], args[2], args[3])
			else:
				self.set_4float_parameter(args[0], args[1], args[2], args[3], args[4])

	def set_1float_parameter(self, name, float x):
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, x)

	def set_2float_parameter(self, name, float x, float y):
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, x, y)

	def set_3float_parameter(self, name, float x, float y, float z):
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, x, y, z)

	def set_4float_parameter(self, name, float x, float y, float z, float w):
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, x, y, z, w)

	def set_vector2_paramater(self, name, vector): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		x, y = vector
		self.p_this.setParameter(encoded_name, dsystem.Vector2f(x, y))
	
	def set_vector3_paramater(self, name, vector): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary

		x, y, z = vector
		self.p_this.setParameter(encoded_name, dsystem.Vector3f(x, y, z))
	
	def set_color_parameter(self, name, Color color): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, color.p_this[0])
	
	def set_transform_parameter(self, name, Transform transform): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, transform.p_this[0])
	
	def set_texture_parameter(self, name, Texture texture): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, texture.p_this[0])
	
	def set_currenttexturetype_parameter(self, name): 
		cdef char* encoded_name
		
		encoded_name_temporary = name.encode('UTF-8')	
		encoded_name = encoded_name_temporary
		
		self.p_this.setParameter(encoded_name, dgraphics.shader.CurrentTexture)
	
	def bind(self):
		self.p_this.bind()

	def unbind(self):
		self.p_this.unbind()
		
	@classmethod
	def is_available(cls):
		return dgraphics.shader.isAvailable()


cdef Shader wrap_shader(dgraphics.Shader *p, bint d=True):
	cdef Shader r = Shader.__new__(Shader)
	r.p_this = p
	r.delete_this = d
	return r


cdef class RenderStates:
	DEFAULT = wrap_renderstates(<dgraphics.RenderStates*>&dgraphics.renderstates.Default, False)
	
	cdef dgraphics.RenderStates *p_this
	cdef bint                    delete_this
	cdef Transform               m_transform
	cdef Texture                 m_texture
	cdef Shader                  m_shader
	
	def __init__(self, dgraphics.blendmode.BlendMode blend_mode=dgraphics.blendmode.BlendAlpha, Transform transform=None, Texture texture=None, Shader shader=None):
		self.p_this = new dgraphics.RenderStates()
		
		self.m_transform = wrap_transform(&self.p_this.transform, False)
		self.m_texture = None
		self.m_shader = None
		
		if blend_mode: self.blend_mode = blend_mode
		if transform: self.transform = transform
		if texture: self.texture = texture
		if shader: self.shader = shader

	def __dealloc__(self):
		if self.delete_this: del self.p_this

	property blend_mode:
		def __get__(self):
			return self.p_this.blendMode
			
		def __set__(self, dgraphics.blendmode.BlendMode blend_mode):
			self.p_this.blendMode = blend_mode

	property transform:
		def __get__(self):
			return self.m_transform
			
		def __set__(self, Transform transform):
			self.p_this.transform = transform.p_this[0]

	property texture:
		def __get__(self):
			return self.m_texture
			
		def __set__(self, Texture texture):
			self.p_this.texture = texture.p_this			
			self.m_texture = texture
			
	property shader:
		def __get__(self):
			return self.m_shader
			
		def __set__(self, Shader shader):
			self.p_this.shader = shader.p_this			
			self.m_shader = shader

cdef RenderStates wrap_renderstates(dgraphics.RenderStates *p, bint d=True):
	cdef RenderStates r = RenderStates.__new__(RenderStates)
	r.p_this = p
	r.delete_this = d
	r.m_transform = wrap_transform(&p.transform, False)
	if p.texture: r.m_texture = wrap_texture(<dgraphics.Texture*>p.texture, False)
	else: r.m_texture = None
	if p.shader: r.m_shader = wrap_shader(<dgraphics.Shader*>p.shader, False)
	else: r.m_shader = None
	return r
	
cdef api object api_wrap_renderstates(dgraphics.RenderStates *p):
	cdef RenderStates r = RenderStates.__new__(RenderStates)
	r.p_this = p
	r.delete_this = False
	r.m_transform = wrap_transform(&p.transform, False)
	if p.texture: r.m_texture = wrap_texture(<dgraphics.Texture*>p.texture, False)
	else: r.m_texture = None
	if p.shader: r.m_shader = wrap_shader(<dgraphics.Shader*>p.shader, False)
	else: r.m_shader = None
	return r


cdef public class Drawable[type PyDrawableType, object PyDrawableObject]:
	cdef dgraphics.Drawable *p_drawable
	
	def __cinit__(self, *args, **kwargs):
		if self.__class__ == Drawable:
			raise NotImplementedError('Drawable is abstact')
			
		self.p_drawable = <dgraphics.Drawable*>new dgraphics.DerivableDrawable(<void*>self)
			
	def draw(self, RenderTarget target, RenderStates states): pass
	
cdef class Transformable:
	cdef dgraphics.Transformable *p_this
	
	def __cinit__(self):
		self.p_this = new dgraphics.Transformable()

	def __dealloc__(self):
		del self.p_this

	property position:
		def __get__(self):
			return Vector2(self.p_this.getPosition().x, self.p_this.getPosition().y)
			
		def __set__(self, position):
			self.p_this.setPosition(vector2_to_vector2f(position))
		
	property rotation:
		def __get__(self):
			return self.p_this.getRotation()
			
		def __set__(self, float angle):
			self.p_this.setRotation(angle)
		
	property ratio:
		def __get__(self):
			return Vector2(self.p_this.getScale().x, self.p_this.getScale().y)
			
		def __set__(self, factor):
			self.p_this.setScale(vector2_to_vector2f(factor))
		
	property origin:
		def __get__(self):
			return Vector2(self.p_this.getOrigin().x, self.p_this.getOrigin().y)
			
		def __set__(self, origin):
			self.p_this.setOrigin(vector2_to_vector2f(origin))
		
	def move(self, offset):
		self.p_this.move(vector2_to_vector2f(offset))
		
	def rotate(self, float angle):
		self.p_this.rotate(angle)

	def scale(self, factor):
		self.p_this.scale(vector2_to_vector2f(factor))
				
	property transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_this.getTransform()
			return wrap_transform(p)
		
	property inverse_transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_this.getInverseTransform()
			return wrap_transform(p)


cdef class TransformableDrawable(Drawable):
	cdef dgraphics.Transformable *p_transformable
	
	def __cinit__(self, *args, **kwargs):
		if self.__class__ == TransformableDrawable:
			raise NotImplementedError('TransformableDrawable is abstact')
		
		if self.__class__ not in [Sprite, Shape, Text]:
			self.p_transformable = new dgraphics.Transformable()
			
	property position:
		def __get__(self):
			return Vector2(self.p_transformable.getPosition().x, self.p_transformable.getPosition().y)
			
		def __set__(self, position):
			self.p_transformable.setPosition(vector2_to_vector2f(position))
		
	property rotation:
		def __get__(self):
			return self.p_transformable.getRotation()
			
		def __set__(self, float angle):
			self.p_transformable.setRotation(angle)
		
	property ratio:
		def __get__(self):
			return Vector2(self.p_transformable.getScale().x, self.p_transformable.getScale().y)
			
		def __set__(self, factor):
			self.p_transformable.setScale(vector2_to_vector2f(factor))
		
	property origin:
		def __get__(self):
			return Vector2(self.p_transformable.getOrigin().x, self.p_transformable.getOrigin().y)
			
		def __set__(self, origin):
			self.p_transformable.setOrigin(vector2_to_vector2f(origin))
		
	def move(self, offset):
		self.p_transformable.move(vector2_to_vector2f(offset))
		
	def rotate(self, float angle):
		self.p_transformable.rotate(angle)
		
	def scale(self, factor):
		self.p_transformable.scale(vector2_to_vector2f(factor))
		
	property transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_transformable.getTransform()
			return wrap_transform(p)
		
	property inverse_transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_transformable.getInverseTransform()
			return wrap_transform(p)
			
	property transformable:
		def __get__(self):
			return wrap_transformable(self.p_transformable)

cdef class Sprite(TransformableDrawable):
	cdef dgraphics.Sprite *p_this
	cdef Texture           m_texture
	
	def __cinit__(self, Texture texture, rectangle=None):
		if not rectangle: self.p_this = new dgraphics.Sprite(texture.p_this[0])
		else:
			l, t, w, h = rectangle
			self.p_this = new dgraphics.Sprite(texture.p_this[0], dsystem.IntRect(l, t, w, h))
			
		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this
		
		self.m_texture = texture
		
	def __dealloc__(self):
		del self.p_this

	def draw(self, RenderTarget target, RenderStates states):
		target.p_rendertarget.draw((<dgraphics.Drawable*>self.p_this)[0])
	
	property texture:
		def __get__(self):
			return self.m_texture

		def __set__(self, Texture texture):
			self.p_this.setTexture(texture.p_this[0], True)
			self.m_texture = texture

	property texture_rectangle:
		def __get__(self):
			return intrect_to_rectangle(<dsystem.IntRect*>(&self.p_this.getTextureRect()))
			
		def __set__(self, rectangle):
			self.p_this.setTextureRect(rectangle_to_intrect(rectangle))

	property color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_this.getColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_this.setColor(color.p_this[0])

	property local_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_this.getLocalBounds()
			return floatrect_to_rectangle(&p)
		
	property global_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_this.getGlobalBounds()
			return floatrect_to_rectangle(&p)


cdef class Text(TransformableDrawable):
	REGULAR    = dgraphics.text.Regular
	BOLD       = dgraphics.text.Bold
	ITALIC     = dgraphics.text.Italic
	UNDERLINED = dgraphics.text.Underlined

	cdef dgraphics.Text *p_this
	cdef Font            m_font

	def __init__(self, string=None, Font font=None, unsigned int character_size=30):
		self.p_this = new dgraphics.Text()
		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this
		
		if string: self.string = string
		if font: self.font = font
		self.character_size = character_size

	def __dealloc__(self):
		del self.p_this

	property string:
		def __get__(self):
			cdef char* decoded_string
			decoded_string = <char*>self.p_this.getString().toAnsiString().c_str()
			
			return decoded_string.decode('utf-8')

		def __set__(self, string):
			cdef char* encoded_string	

			encoded_string_temporary = string.encode('utf-8')	
			encoded_string = encoded_string_temporary
			
			self.p_this.setString(dgraphics.String(encoded_string))
					
	property font:
		def __get__(self):
			return self.m_font
			
		def __set__(self, Font font):
			self.p_this.setFont(font.p_this[0])
			self.m_font = font

	property character_size:
		def __get__(self):
			return self.p_this.getCharacterSize()
			
		def __set__(self, unsigned int size):
			self.p_this.setCharacterSize(size)

	property style:
		def __get__(self):
			return self.p_this.getStyle()
			
		def __set__(self, Uint32 style):
			self.p_this.setStyle(style)

	property color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_this.getColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_this.setColor(color.p_this[0])

	property local_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_this.getLocalBounds()
			return floatrect_to_rectangle(&p)

	property global_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_this.getGlobalBounds()
			return floatrect_to_rectangle(&p)

	def find_character_pos(self, size_t index):
		cdef dsystem.Vector2f p = self.p_this.findCharacterPos(index)
		return Vector2(p.x, p.y)


cdef class Shape(TransformableDrawable):
	cdef dgraphics.Shape *p_shape
	cdef Texture          m_texture
	
	def __cinit__(self, *args, **kwargs):
		if self.__class__ == Shape:
			raise NotImplementedError('Shape is abstact')

	def draw(self, RenderTarget target, RenderStates):
		target.p_rendertarget.draw((<dgraphics.Drawable*>self.p_shape)[0])
		
	property texture:
		def __get__(self):
			return self.m_texture

		def __set__(self, Texture texture):
			if texture:
				self.p_shape.setTexture(texture.p_this, True)
				self.m_texture = texture
			else:
				self.p_shape.setTexture(NULL)
				self.m_texture = None

	property texture_rectangle:
		def __get__(self):
			return intrect_to_rectangle(<dsystem.IntRect*>(&self.p_shape.getTextureRect()))
			
		def __set__(self, rectangle):
			self.p_shape.setTextureRect(rectangle_to_intrect(rectangle))
		
	property fill_color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_shape.getFillColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_shape.setFillColor(color.p_this[0])

	property outline_color:
		def __get__(self):
			cdef dgraphics.Color* p = new dgraphics.Color()
			p[0] = self.p_shape.getOutlineColor()
			return wrap_color(p)
			
		def __set__(self, Color color):
			self.p_shape.setOutlineColor(color.p_this[0])
		
	property outline_thickness:
		def __get__(self):
			return self.p_shape.getOutlineThickness()
			
		def __set__(self, float thickness):
			self.p_shape.setOutlineThickness(thickness)
		
	property local_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_shape.getLocalBounds()
			return floatrect_to_rectangle(&p)

	property global_bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_shape.getGlobalBounds()
			return floatrect_to_rectangle(&p)

	property point_count:
		def __get__(self):
			return self.p_shape.getPointCount()
			
	def get_point(self, unsigned int index):
		return Vector2(self.p_shape.getPoint(index).x, self.p_shape.getPoint(index).y)


cdef class CircleShape(Shape):
	cdef dgraphics.CircleShape *p_this
	
	def __cinit__(self, float radius=0, unsigned int point_count=30):
		self.p_this = new dgraphics.CircleShape(radius, point_count)

		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this
		self.p_shape = <dgraphics.Shape*>self.p_this
		
	def __dealloc__(self):
		del self.p_this
		
	property radius:
		def __get__(self):
			return self.p_this.getRadius()
			
		def __set__(self, float radius):
			self.p_this.setRadius(radius)
		
	property point_count:
		def __get__(self):
			return self.p_this.getPointCount()
			
		def __set__(self, unsigned int count):
			self.p_this.setPointCount(count)


cdef class ConvexShape(Shape):
	cdef dgraphics.ConvexShape *p_this
	
	def __cinit__(self, unsigned int point_count=0):
		self.p_this = new dgraphics.ConvexShape(point_count)
		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this
		self.p_shape = <dgraphics.Shape*>self.p_this
		
	def __dealloc__(self):
		del self.p_this

	property point_count:
		def __get__(self):
			return self.p_this.getPointCount()
			
		def __set__(self, unsigned int count):
			self.p_this.setPointCount(count)
		
	def set_point(self, unsigned int index, point):
		self.p_this.setPoint(index, vector2_to_vector2f(point))

		
cdef class RectangleShape(Shape):
	cdef dgraphics.RectangleShape *p_this
	
	def __cinit__(self, size=(0, 0)):
		self.p_this = new dgraphics.RectangleShape(vector2_to_vector2f(size))
		self.p_drawable = <dgraphics.Drawable*>self.p_this
		self.p_transformable = <dgraphics.Transformable*>self.p_this
		self.p_shape = <dgraphics.Shape*>self.p_this
		
	def __dealloc__(self):
		del self.p_this

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)
			
		def __set__(self, size):
			self.p_this.setSize(vector2_to_vector2f(size))


cdef class Vertex:
	cdef dgraphics.Vertex *p_this
	cdef bint              delete_this
	
	def __init__(self, position=None, Color color=None, tex_coords=None):
		self.p_this = new dgraphics.Vertex()
		self.delete_this = True
		
		if position: self.position = position
		if color: self.color = color
		if tex_coords: self.tex_coords = tex_coords
		
	def __dealloc__(self):
		if self.delete_this: del self.p_this
		
	property position:
		def __get__(self):
			return Vector2(self.p_this.position.x, self.p_this.position.y)
			
		def __set__(self, position):
			self.p_this.position.x, self.p_this.position.y = position
		
	property color:
		def __get__(self):
			cdef dgraphics.Color *p = new dgraphics.Color()
			p[0] = self.p_this.color
			return wrap_color(p)

		def __set__(self, Color color):
			self.p_this.color = color.p_this[0]	

	property tex_coords:
		def __get__(self):
			return Vector2(self.p_this.texCoords.x, self.p_this.texCoords.y)
			
		def __set__(self, tex_coords):
			self.p_this.texCoords.x, self.p_this.texCoords.y = tex_coords
	
cdef Vertex wrap_vertex(dgraphics.Vertex* p, bint d=True):
	cdef Vertex r = Vertex.__new__(Vertex)
	r.p_this = p
	r.delete_this = d
	return r


cdef class VertexArray(Drawable):
	cdef dgraphics.VertexArray *p_this

	def __init__(self, dgraphics.primitivetype.PrimitiveType type = dgraphics.primitivetype.Points, unsigned int vertex_count=0):
		self.p_this = new dgraphics.VertexArray(type, vertex_count)
		self.p_drawable = <dgraphics.Drawable*>self.p_this
		
	def __dealloc__(self):
		del self.p_this

	def __len__(self):
		return self.p_this.getVertexCount()
		
	def __getitem__(self, unsigned int index):
		if index < len(self):
			return wrap_vertex(&self.p_this[0][index], False)
		else:
			raise IndexError
		
	def __setitem__(self, unsigned int index, Vertex key):
		self.p_this[0][index] = key.p_this[0]
		
	def draw(self, RenderTarget target, states):
		target.p_rendertarget.draw((<dgraphics.Drawable*>self.p_this)[0])
		
	def clear(self):
		self.p_this.clear()
		
	def resize(self, unsigned int vertex_count):
		self.p_this.resize(vertex_count)
		
	def append(self, Vertex vertex):
		self.p_this.append(vertex.p_this[0])
		
	property primitive_type:
		def __get__(self):
			return self.p_this.getPrimitiveType()
			
		def __set__(self, dgraphics.primitivetype.PrimitiveType primitive_type):
			self.p_this.setPrimitiveType(primitive_type)
			
	property bounds:
		def __get__(self):
			cdef dsystem.FloatRect p = self.p_this.getBounds()
			return floatrect_to_rectangle(&p)


cdef class View:
	cdef dgraphics.View  *p_this
	cdef RenderWindow     m_renderwindow
	cdef RenderTarget     m_rendertarget
	
	def __init__(self, rectangle=None):
		if not rectangle: self.p_this = new dgraphics.View()
		else: self.p_this = new dgraphics.View(rectangle_to_floatrect(rectangle))

	def __dealloc__(self):
		del self.p_this
	
	property center:
		def __get__(self):
			return Vector2(self.p_this.getCenter().x, self.p_this.getCenter().y)
			
		def __set__(self, center):
			self.p_this.setCenter(vector2_to_vector2f(center))
			self._update_target()

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)
			
		def __set__(self, size):
			self.p_this.setSize(vector2_to_vector2f(size))
			self._update_target()

	property rotation:
		def __get__(self):
			return self.p_this.getRotation()
			
		def __set__(self, float angle):
			self.p_this.setRotation(angle)
			self._update_target()

	property viewport:
		def __get__(self):
			return floatrect_to_rectangle(<dsystem.FloatRect*>(&self.p_this.getViewport()))

		def __set__(self, viewport):
			self.p_this.setViewport(rectangle_to_floatrect(viewport))
			self._update_target()

	def reset(self, rectangle):
		self.p_this.reset(rectangle_to_floatrect(rectangle))
		self._update_target()
	
	def move(self, float x, float y):
		self.p_this.move(dsystem.Vector2f(x, y))
		self._update_target()

	def rotate(self, float angle):
		self.p_this.rotate(angle)
		self._update_target()

	def zoom(self, float factor):
		self.p_this.zoom(factor)
		self._update_target()
	
	property transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_this.getTransform()
			return wrap_transform(p)

	property inverse_transform:
		def __get__(self):
			cdef dgraphics.Transform *p = new dgraphics.Transform()
			p[0] = self.p_this.getInverseTransform()
			return wrap_transform(p)

	def _update_target(self):
		if self.m_renderwindow:
			self.m_renderwindow.view = self

		if self.m_rendertarget:
			self.m_rendertarget.view = self

cdef View wrap_view(dgraphics.View *p):
	cdef View r = View.__new__(View)
	r.p_this = p
	return r
	
cdef View wrap_view_for_renderwindow(dgraphics.View *p, RenderWindow renderwindow):
	cdef View r = View.__new__(View)
	r.p_this = p
	r.m_renderwindow = renderwindow
	return r
	
cdef View wrap_view_for_rendertarget(dgraphics.View *p, RenderTarget rendertarget):
	cdef View r = View.__new__(View)
	r.p_this = p
	r.m_rendertarget = rendertarget
	return r


cdef public class RenderTarget[type PyRenderTargetType, object PyRenderTargetObject]:
	cdef dgraphics.RenderTarget *p_rendertarget

	def __init__(self, *args, **kwargs):
		if self.__class__ == RenderTarget:
			raise NotImplementedError('RenderTarget is abstact')

	def clear(self, Color color=None):
		if not color: self.p_rendertarget.clear()
		else: self.p_rendertarget.clear(color.p_this[0])
		
	property view:
		def __get__(self):
			cdef dgraphics.View *p = new dgraphics.View()
			p[0] = self.p_rendertarget.getView()
			return wrap_view_for_rendertarget(p, self)
			
		def __set__(self, View view):
			self.p_rendertarget.setView(view.p_this[0])
			view.m_renderwindow = None
			view.m_rendertarget = self

	property default_view:
		def __get__(self):
			cdef dgraphics.View *p = new dgraphics.View()
			p[0] = self.p_rendertarget.getDefaultView()
			return wrap_view_for_rendertarget(p, self)

	def get_viewport(self, View view):
		cdef dsystem.IntRect p = self.p_rendertarget.getViewport(view.p_this[0])
		return intrect_to_rectangle(&p)
		
	def convert_coords(self, point, View view=None):
		cdef dsystem.Vector2f ret

		if not view: ret = self.p_rendertarget.convertCoords(vector2_to_vector2i(point))
		else: ret = self.p_rendertarget.convertCoords(vector2_to_vector2i(point), view.p_this[0])

		return Vector2(ret.x, ret.y)
			
	def draw(self, Drawable drawable, RenderStates states=None):
		if not states: self.p_rendertarget.draw(drawable.p_drawable[0])
		else: self.p_rendertarget.draw(drawable.p_drawable[0], states.p_this[0])

	property size:
		def __get__(self):
			return Vector2(self.p_rendertarget.getSize().x, self.p_rendertarget.getSize().y)
		
	property width:
		def __get__(self):
			return self.size.x

	property height:
		def __get__(self):
			return self.size.y

	def push_GL_states(self):
		self.p_rendertarget.pushGLStates()
		
	def pop_GL_states(self):
		self.p_rendertarget.popGLStates()
		
	def reset_GL_states(self):
		self.p_rendertarget.resetGLStates()


cdef api object wrap_rendertarget(dgraphics.RenderTarget* p):
	cdef RenderTarget r = RenderTarget.__new__(RenderTarget)
	r.p_rendertarget = p
	return r


cdef class RenderWindow(Window):
	cdef dgraphics.RenderWindow *p_this
	
	def __init__(self, VideoMode mode, title, Uint32 style=dwindow.style.Default, ContextSettings settings=None):
		cdef char* encoded_title
		
		encoded_title_temporary = title.encode(u"ISO-8859-1")
		encoded_title = encoded_title_temporary
			
		if self.__class__ is not RenderWindow:
			if not settings: self.p_this = <dgraphics.RenderWindow*>new dgraphics.DerivableRenderWindow(mode.p_this[0], encoded_title, style)
			else: self.p_this = <dgraphics.RenderWindow*>new dgraphics.DerivableRenderWindow(mode.p_this[0], encoded_title, style, settings.p_this[0])			
		else:
			if not settings: self.p_this = new dgraphics.RenderWindow(mode.p_this[0], encoded_title, style)
			else: self.p_this = new dgraphics.RenderWindow(mode.p_this[0], encoded_title, style, settings.p_this[0])
			
		self.p_window = <dwindow.Window*>self.p_this

	def __dealloc__(self):
		del self.p_this

	def clear(self, Color color=None):
		if not color: self.p_this.clear()
		else: self.p_this.clear(color.p_this[0])
		
	property view:
		def __get__(self):
			cdef dgraphics.View *p = new dgraphics.View()
			p[0] = self.p_this.getView()
			return wrap_view_for_renderwindow(p, self)
			
		def __set__(self, View view):
			self.p_this.setView(view.p_this[0])
			view.m_renderwindow = self
			view.m_rendertarget = None

	property default_view:
		def __get__(self):
			cdef dgraphics.View *p = new dgraphics.View()
			p[0] = self.p_this.getDefaultView()
			return wrap_view_for_renderwindow(p, self)

	def get_viewport(self, View view):
		cdef dsystem.IntRect p = self.p_this.getViewport(view.p_this[0])
		return intrect_to_rectangle(&p)
		
	def convert_coords(self, point, View view=None):
		cdef dsystem.Vector2f ret

		if not view: ret = self.p_this.convertCoords(vector2_to_vector2i(point))
		else: ret = self.p_this.convertCoords(vector2_to_vector2i(point), view.p_this[0])

		return Vector2(ret.x, ret.y)

	def draw(self, Drawable drawable, RenderStates states=None):
		if not states: self.p_this.draw(drawable.p_drawable[0])
		else: self.p_this.draw(drawable.p_drawable[0], states.p_this[0])

	property size:
		def __get__(self):
			return Vector2(self.p_this.getSize().x, self.p_this.getSize().y)
		
	property width:
		def __get__(self):
			return self.size.x

	property height:
		def __get__(self):
			return self.size.y

	def push_GL_states(self):
		self.p_this.pushGLStates()
		
	def pop_GL_states(self):
		self.p_this.popGLStates()
		
	def reset_GL_states(self):
		self.p_this.resetGLStates()

	def capture(self):
		cdef dgraphics.Image *p = new dgraphics.Image()
		p[0] = self.p_this.capture()
		return wrap_image(p)


cdef class RenderTexture(RenderTarget):
	cdef dgraphics.RenderTexture *p_this
	cdef Texture                  m_texture
	
	def __init__(self, unsigned int width, unsigned int height, bint depthBuffer=False):
		self.p_this = new dgraphics.RenderTexture()
		self.p_rendertarget = <dgraphics.RenderTarget*>self.p_this
		
		self.p_this.create(width, height, depthBuffer)
		
		self.m_texture = wrap_texture(<dgraphics.Texture*>&self.p_this.getTexture(), False)
		
	def __dealloc__(self):
		del self.p_this
	
	property smooth:
		def __get__(self):
			return self.p_this.isSmooth()
			
		def __set__(self, bint smooth):
			self.p_this.setSmooth(smooth)
	
	property active:
		def __set__(self, bint active):
			self.p_this.setActive(active)
			
	def display(self):
		self.p_this.display()
	
	property texture:
		def __get__(self):
			return self.m_texture

cdef class HandledWindow(RenderTarget):
	cdef dgraphics.RenderWindow *p_this
	cdef dgraphics.Window       *p_window
	
	def __init__(self):
		self.p_this = new dgraphics.RenderWindow()
		self.p_rendertarget = <dgraphics.RenderTarget*>self.p_this
		self.p_window = <dwindow.Window*>self.p_this
		
	def __dealloc__(self):
		del self.p_this

	def create(self, unsigned long window_handle, ContextSettings settings=None):
		if not settings: self.p_this.create(<dwindow.WindowHandle>window_handle)
		else: self.p_this.create(<dwindow.WindowHandle>window_handle, settings.p_this[0])
		
	def display(self):
		self.p_window.display()
