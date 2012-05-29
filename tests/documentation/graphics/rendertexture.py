# create a new render-window
window = sf.RenderWindow(sf.VideoMode(800, 600), "pySFML - RenderWindow")

# create a new render-texture
texture = sf.RenderTexture.create(500, 500)

# the main loop
while window.opened:
	
	# ...
	
	# clear the whole texture with red color
	texture.clear(sf.Color.RED)
	
	# draw stuff to the texture
	texture.draw(sprite)
	texture.draw(shape)
	texture.draw(text)
	
	# we're done drawing to the texture
	texture.display()
	
	# now we start rendering to the window, clear it first
	window.clear()
	
	# draw the texture
	sprite = sf.Sprite(texture.texture)
	window.draw(sprite)
	
	# end the current frame and display its content on screen
	window.display()
