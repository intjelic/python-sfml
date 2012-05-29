#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#from sfml.system import Position, Size
from sfml.system.position import Position
from sfml.system.size import Size

class Rectangle:
	def __init__(self, position=(0, 0), size=(0, 0)):
		left, top = position
		width, height = size
		self._position = Position(left, top)
		self._size = Size(width, height)

	def __repr__(self):
		return "sf.Rectangle({0})".format(self)

	def __str__(self):
		return "{0}, {1}".format(self.position, self.size)
		
	def __eq__(self, other):
		left, top, width, height = other
		return self.position == Position(left, top) and self.size == Size(width, height)
			
	def __ne__(self, other):
		return not self == other
		
	def __iter__(self):
		return iter((self.left, self.top, self.width, self.height))

	def contains(self, point):
		x, y = point
		return x >= self.left and x < self.right and y >= self.top and y < self.bottom
		
	def intersects(self, rectangle):
		# compute the intersection boundaries
		left = max(self.left, rectangle.left)
		top = max(self.top, rectangle.top)
		right = min(self.right, rectangle.right)
		bottom = min(self.bottom, rectangle.bottom)
		
		# if the intersection is valid (positive non zero area), then 
		# there is an intersection
		if left < right and top < bottom:
			return Rectangle((left, top), (right-left, bottom-top))
			
		return None
		
	def _get_position(self):
		return self._position

	def _set_position(self, position):
		self._position = position

	def _get_size(self):
		return self._size

	def _set_size(self, size):
		self._size = size

	def _get_left(self):
		return self.position.x

	def _set_left(self, left):
		self.position.x = left

	def _get_top(self):
		return self.position.y

	def _set_top(self, top):
		self.position.y = top

	def _get_width(self):
		return self.size.width

	def _set_width(self, width):
		self.size.width = width

	def _get_height(self):
		return self.size.height

	def _set_height(self, height):
		self.size.height = height

	def _get_center(self):
		return self.position + self.size / 2
		
	def _set_center(self, center):
		return NotImplemented
	
	def _get_right(self):
		return self.left + self.width
		
	def _set_right(self, right):
		return NotImplemented
		
	def _get_bottom(self):
		return self.top + self.height
		
	def _set_bottom(self, bottom):
		return NotImplemented

	position = property(_get_position, _set_position)
	size = property(_get_size, _set_size)
	
	left = property(_get_left, _set_left)
	top = property(_get_top, _set_top)
	width = property(_get_width, _set_width)
	height = property(_get_height, _set_height)

	center = property(_get_center, _set_center)
	
	right = property(_get_right, _set_right)
	bottom = property(_get_bottom, _set_bottom)
