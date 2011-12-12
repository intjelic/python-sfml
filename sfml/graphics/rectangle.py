from sfml.graphics import Position, Size


class Rectangle:
	"""
	Utility class for manipulating 2D axis aligned rectangles.

	A rectangle is defined by its position in an area and its size.

	To keep things simple, sf.Rectangle doesn't define functions to 
	emulate the properties that are not directly members (such as right, 
	bottom, center, etc.), it rather only provides intersection
	functions.

	sf.Rectangle uses the usual rules for its boundaries:

		The left and top edges are included in the rectangle's area.
		
		The right (left + width) and bottom (top + height) edges are 
		excluded from the rectangle's area.

	This means that sf.Rectangle(0, 0, 1, 1) and 
	sf.Rectangle(1, 1, 1, 1) don't intersect.
	"""
	
	def __init__(self, left, top, width, height):
		self._position = Position(left, top)
		self._size = Size(width, height)

	def __repr__(self):
		return "({0}, {1}, {2}, {3})".format(self.x, self.y, self.width, self.height)

	def __str__(self):
		return "({0}, {1}, {2}, {3})".format(self.x, self.y, self.width, self.height)
		
	def contains(self, point):
		"""
		Check if a point is inside the rectangle's area.
		"""
		return point.x >= self.x and point.x < self.right and point.y >= self.y and point.y < self.bottom
		
	def intersects(self, rectangle):
		"""
		Check the intersection between two rectangles. 
		"""
		# compute the intersection boundaries
		left = max(self.x, rectangle.x)
		top = max(self.y, rectangle.y)
		right = min(self.right, rectangle.right)
		bottom = min(self.bottom, rectangle.bottom)
		
		# if the intersection is valid (positive non zero area), then 
		# there is an intersection
		if left < right and top < bottom:
			return Geometry(left, top, right-left, bottom-top)
			
		return None
		
	def _get_position(self):
		return self._position

	def _set_position(self, position):
		self._position = position

	def _get_size(self):
		return self._size

	def _set_size(self, size):
		self._size = size

	def _get_x(self):
		return self.position.x

	def _set_x(self, x):
		self.position.x = x

	def _get_y(self):
		return self.position.y

	def _set_y(self, y):
		self.position.y = y

	def _get_width(self):
		return self.size.width

	def _set_width(self, width):
		self.size.width = width

	def _get_height(self):
		return self.size.height

	def _set_height(self, height):
		self.size.height = height

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

	x = property(_get_x, _set_x)
	y = property(_get_y, _set_y)
	width = property(_get_width, _set_width)
	height = property(_get_height, _set_height)
	
	left = property(_get_x, _set_x)
	top = property(_get_y, _set_y)
	rigth = property(_get_right, _set_right)
	bottom = property(_get_bottom, _set_bottom)
