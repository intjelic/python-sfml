class MyDrawable(sf.Drawable):
	def __init__(self):
		sf.Drawable.__init__(self)
		# ...

	def draw(self, target, states):
		# you can draw other high-level objects
		target.draw(self.sprite, states)
		
		# ... or use the low-level API
		states.texture = self.texture
		target.draw(self.vertices, states)
		
		# ... or draw with OpenGL directly
		glBegin(GL_QUADS)
			# ...
		glEnd()
		
