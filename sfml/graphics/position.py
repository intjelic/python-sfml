class Position:
	def __init__(self, x, y):
		self._x = x
		self._y = y

	def __repr__(self):
		return "({0}, {1})".format(self.x, self.y)

	def __str__(self):
		return "({0}, {1})".format(self.x, self.y)

	def _get_x(self):
		return self._x

	def _set_x(self, x):
		self._x = x

	def _get_y(self):
		return self._y

	def _set_y(self, y):
		self._y = y

	x = property(_get_x, _set_x)
	y = property(_get_y, _set_y)
