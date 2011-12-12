class Size:
	def __init__(self, width, height):
		self._width = width
		self._height = height

	def __repr__(self):
		return "({0}, {1})".format(self.width, self.height)

	def __str__(self):
		return "({0}, {1})".format(self.width, self.height)

	def _get_width(self):
		return self._width

	def _set_width(self, width):
		self._width = width

	def _get_height(self):
		return self._height

	def _set_height(self, height):
		self._height = height

	width = property(_get_width, _set_width)
	height = property(_get_height, _set_height)
