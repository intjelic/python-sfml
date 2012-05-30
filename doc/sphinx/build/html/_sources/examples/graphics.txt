Graphics
--------

transform.py ::

	t = sf.Position(50, 200)
	r = 6.88
	p = sf.Position(4, 7)

	a = sf.Transform()
	b = a.inverse

	print(a)
	print(b)

	c = a.combine(b).translate(t).rotate(r, p)

	print(c)
	
	
transformable.py ::

	foo = sf.Transformable()

	print("### sf.Transformable.position ###")
	assert type(foo.position) == sf.Position
	print(foo.position)
	foo.position = sf.Position(40, 50)
	foo.position = (70, 60)
	assert foo.position == sf.Position(70, 60)
	print(foo.position)
	input()

	print("### sf.Transformable.rotation ###")
	assert type(foo.rotation) == float
	print(foo.rotation)
	foo.rotation = 5.6
	print(foo.rotation)
	input()

	print("### sf.Transformable.ratio ###")
	assert type(foo.ratio) == sf.Position
	print(foo.ratio)
	foo.ratio = sf.Position(40, 50)
	foo.ratio = (70, 60)
	assert foo.ratio == sf.Position(70, 60)
	print(foo.ratio)
	input()

	print("### sf.Transformable.origin ###")
	assert type(foo.origin) == sf.Position
	print(foo.origin)
	foo.origin = sf.Position(40, 50)
	foo.origin = (70, 60)
	assert foo.origin == sf.Position(70, 60)
	print(foo.origin)
	input()

	print("### sf.Transformable.move() ###")
	foo.move(sf.Position(50, 30))
	foo.move((20, 10))
	input()

	print("### sf.Transformable.rotate() ###")
	foo.rotate(5.6)
	input()

	print("### sf.Transformable.scale() ###")
	foo.scale(sf.Position(50, 30))
	foo.scale((20, 10))
	input()

	print("### sf.Transformable.transform ###")
	assert type(foo.transform) == sf.Transform
	print(foo.transform)
	input()

	print("### sf.Transformable.inverse_transform ###")
	assert type(foo.inverse_transform) == sf.Transform
	print(foo.inverse_transform)
	input()

texture.py ::

	import sfml.graphics as sf

	print("### sf.Texture() ###")

	try:
		image = sf.Image()
		raise Warning("Shouldn't work!")
		
	except UserWarning as error:
		print("This error was expected...")
	input()

	print("### sf.Texture.NORMALIZED ###")
	print(sf.Texture.NORMALIZED)
	input()

	print("### sf.Texture.PIXELS ###")
	print(sf.Texture.PIXELS)
	input()

	print("### sf.Texture.PIXELS ###")
	print(sf.Texture.get_maximum_size())
	input()

	print("### sf.Texture.create() ###")
	a = sf.Texture.create(200, 250)
	input()

	print("### sf.Texture.load_from_file() ###")
	b = sf.Texture.load_from_file("../data/background.jpg")
	c = sf.Texture.load_from_file("../data/background.jpg", sf.Rectangle((50, 150), (50, 50)))
	d = sf.Texture.load_from_file("../data/background.jpg", ((50, 150, 50, 50)))
	input()

	print("### sf.Texture.load_from_memory() ###")
	file = open("../data/background.jpg", "rb")
	data = file.read()
	e = sf.Texture.load_from_memory(data)

	print("### sf.Texture.load_from_image() ###")
	image = sf.Image.load_from_file("../data/background.jpg")
	f = sf.Texture.load_from_image(image)
	g = sf.Texture.load_from_image(image, sf.Rectangle((50, 150), (50, 50)))
	h = sf.Texture.load_from_image(image, ((50, 150, 50, 50)))
	input()

	print("### sf.Texture.size ###")
	assert type(a.size) == sf.Size
	assert type(b.size) == sf.Size
	assert type(c.size) == sf.Size
	assert type(d.size) == sf.Size
	print(a.size)
	print(b.size)
	print(d.size)
	print(d.size)
	input()

	print("### sf.Texture.width ###")
	print(a.width)
	print(b.width)
	print(c.width)
	print(d.width)
	input()

	print("### sf.Texture.height ###")
	print(a.height)
	print(b.height)
	print(c.height)
	print(d.height)
	input()

	print("### sf.Texture.copy_to_image() ###")
	copy = b.copy_to_image()
	input()

	#print("### sf.Texture.update() ###")
	## not implemented yet
	#input()

	print("### sf.Texture.update_from_pixels() ###")
	image_sfml = sf.Image.load_from_file("../data/sfml.png")
	i = b.copy()
	i.update_from_pixels(image_sfml.pixels)
	i.update_from_pixels(image_sfml.pixels, sf.Rectangle((200.5, 200), (100, 50)))
	input()

	print("### sf.Texture.update_from_image() ###")
	j = b.copy()
	j.update_from_image(image_sfml)
	#j.update_from_image(image_sfml, (200, 200)) # not implemented yet due to a bug in cython
	#j.update_from_image(image_sfml, sf.Position(200, 200)) # not implemented yet due to a bug in cython
	input()

	#print("### sf.Texture.update_from_window() ###")
	#k = b.copy()
	#k.update_from_image(
	#copy = b.copy_to_image()
	#input()

	print("### sf.Texture.bind() ###")
	j.bind()
	j.bind(sf.Texture.PIXELS)
	input()

	print("### sf.Texture.smooth ###")
	assert type(j.smooth) == bool
	print(j.smooth)
	j.smooth = not j.smooth

	print("### sf.Texture.repeated ###")
	assert type(j.repeated) == bool
	print(j.repeated)
	j.repeated = not j.repeated

	print("### sf.Texture.copy() ###")
	l = b.copy()
	assert type(l) == sf.Texture

	print("### See result now ###")
	a.copy_to_image().save_to_file("result/a.png")
	b.copy_to_image().save_to_file("result/b.png")
	c.copy_to_image().save_to_file("result/c.png")
	d.copy_to_image().save_to_file("result/d.png")
	e.copy_to_image().save_to_file("result/e.png")
	f.copy_to_image().save_to_file("result/f.png")
	g.copy_to_image().save_to_file("result/g.png")
	h.copy_to_image().save_to_file("result/h.png")
	i.copy_to_image().save_to_file("result/i.png")
	j.copy_to_image().save_to_file("result/j.png")
	#k.copy_to_image().save_to_file("result/k.png")
	l.copy_to_image().save_to_file("result/l.png")
	
	
sprite.py ::

	window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Sprite")
	window.clear(sf.Color.YELLOW)
	window.display()

	texture_a = sf.Texture.load_from_file("../data/sfml.png")
	texture_b = sf.Texture.load_from_file("../data/background.jpg")
	sprite = sf.Sprite(texture_a)
	input()


	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	sprite.position = (100, 100)
	sprite.rotation = 45
	sprite.ratio = (2, 2)
	sprite.origin = (25, 25)
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	sprite = sf.Sprite(texture_a)
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	sprite.move(sf.Position(100, 100))
	sprite.rotate(45)
	sprite.scale(sf.Position(2, 2))
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	### TEST SPRITE ###

	print(sprite.texture_rectangle)
	sprite.texture_rectangle = sf.Rectangle((50, 50), (250 , 250))
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	sprite.texture = texture_b
	print(sprite.texture_rectangle)
	print(type(sprite.texture))
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	print(sprite.color)
	sprite.color = sf.Color.RED
	window.clear(sf.Color.YELLOW)
	window.draw(sprite)
	window.display()
	input()

	print("## sf.Sprite.texture ##")
	print(sprite.texture)
	print(type(sprite.texture))
	window.draw(sprite)
	window.display()
	input()
	sprite.texture = texture_b
	sprite.reset_texture_rectangle()
	window.clear(sf.Color.GREEN)
	window.draw(sprite)
	window.display()
	input()

	print("## sf.Sprite.texture_rectangle ##")
	print(sprite.texture_rectangle)
	print(type(sprite.texture_rectangle))
	sprite.texture_rectangle = (50, 50, 300, 300)
	sprite.texture_rectangle = sf.Rectangle((50, 50), (300, 300))
	print(sprite.texture_rectangle)
	print(type(sprite.texture_rectangle))
	input()

	print("## sf.Sprite.color ##")
	sprite.color = sf.Color.CYAN
	print(sprite.color)
	print(type(sprite.color))
	input()


	print(sprite.local_bounds)
	print(sprite.global_bounds)

	window = sf.RenderWindow()


shape.py ::

	import sfml.graphics as sf

	window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.Shape")
	window.clear(sf.Color.WHITE)
	window.display()
	input()

	image = sf.Texture.load_from_file("data/sfml.png")
	sprite = sf.Sprite(image)
	window.draw(sprite)
	window.display()
	input()

	texture = sf.Texture.load_from_file("data/windows_icon2.jpg")
	sprite = sf.Sprite(texture)

	print("### sf.Shape() ###")

	try:
		shape = sf.Shape()
		raise sf.SFMLException("You shouldn't have been able to instantiate a sf.Shape")
	except NotImplementedError as error:
		print(error)
		input("Error expected, press any key to continue...")

	def test_shape(shape):
		
		print("### sf.Shape.texture ###")
	circle = sf.CircleShape(100, 100)
	circle.texture = texture
	print(circle.fill_color)
	circle.fill_color = sf.Color.GREEN

	print(circle.outline_color)
	circle.outline_color = sf.Color.RED

	print(circle.outline_thickness)
	circle.outline_thickness = 15

	print(circle.local_bounds)
	print(circle.global_bounds)
	input()

	### TEST CIRCLE SHAPE ###
	window.clear(sf.Color.CYAN)
	window.draw(circle)
	window.display()
	input()

	print(circle.radius)
	circle.radius = 75
	print(circle.point_count)
	circle.point_count = 5

	window.clear(sf.Color.CYAN)
	window.draw(circle)
	window.display()
	input()

	### TEST CONVEX SHAPE ###
	polygon = sf.ConvexShape(10)

	for i in range(polygon.point_count):
		print(polygon.get_point(i))
		
	polygon.point_count = 6
	polygon.set_point(0, (20, 20))
	polygon.set_point(1, (30, 20))
	polygon.set_point(2, (30, 40))
	polygon.set_point(3, (50, 75))
	polygon.set_point(4, (5, 75))
	polygon.set_point(5, (5, 5))

	window.clear(sf.Color.CYAN)
	window.draw(polygon)
	window.display()
	input()


	### TEST RECTANGLE SHAPE ###
	rectangle = sf.RectangleShape((125, 75))
	square = sf.RectangleShape((50, 50))

	window.clear(sf.Color.CYAN)
	window.draw(square)
	window.display()
	input()

	print(rectangle.size)
	square.size = (75, 75)

	for i in range(rectangle.point_count):
		print(rectangle.get_point(i))
		
	window.clear(sf.Color.CYAN)
	window.draw(square)
	window.display()
	input()

	### DRAWING ###
	circle.position = (300, 20)
	polygon.position = (250, 5)
	rectangle.position = (5, 105)
	square.position = (300, 300)

	window.clear(sf.Color.CYAN)
	window.draw(circle)
	window.draw(polygon)
	window.draw(rectangle)
	window.draw(square)
	window.display()
	input()

rendertarget.py ::

	import sfml.graphics as sf

	print("### sf.RenderTarget() ###")
	try:
		target = sf.RenderTarget()
		raise Warning("Shouldn't work!")
		
	except NotImplementedError as error:
		print("This error was expected...")
	input()


	def test_rendertarget(target):
		print("### sf.RenderTarget.clear() ###")
		target.clear()
		target.clear(sf.Color.RED)
		input()
		
		print("### sf.RenderTarget.view ###")
		assert type(target.view) == sf.View
		print(target.view)
		target.view = sf.View()
		input()
		
		print("### sf.RenderTarget.default_view ###")
		assert type(target.default_view) == sf.View
		print(target.default_view)
		input()
		
		print("### sf.RenderTarget.get_viewport() ###")
		v1 = sf.View()
		viewport = target.get_viewport(v1)
		assert type(viewport) == sf.Rectangle
		print(viewport)
		input()
		
		print("### sf.RenderTarget.convert_coords() ###")
		v1 = sf.View()
		v2 = sf.View()
		p1 = target.convert_coords(sf.Position(40, 80))
		p2 = target.convert_coords((120, 20))
		p3 = target.convert_coords(sf.Position(5, 75), v1)
		p4 = target.convert_coords((78, 24), v2)
		
		print("### sf.RenderTarget.draw() ###")
		texture = sf.Texture.load_from_file("../data/background.jpg")
		sprite = sf.Sprite(texture)
		render_states = sf.RenderStates()
		target.draw(sprite, render_states)
		
		print("### sf.RenderTarget.size")
		assert type(target.size) == sf.Size
		print(target.size)
		print(target.width)
		print(target.height)
		
		print("### sf.RenderTarget.push_GL_states() ###")
		target.push_GL_states()
		
		print("### sf.RenderTarget.pop_GL_states() ###")
		target.pop_GL_states()
		
		print("### sf.RenderTarget.reset_GL_states() ###")
		target.reset_GL_states()


renderwindow.py ::

	import sfml.graphics as sf
	from rendertarget import test_rendertarget

	window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML - sf.RenderTexture")
	window.clear(sf.Color.WHITE)
	window.display()
	input()

	image = sf.Texture.load_from_file("../data/sfml.png")
	sprite = sf.Sprite(image)
	sprite.position = (50, 50)

	rendertexture = sf.RenderTexture(512, 512)
	rendertexture.clear(sf.Color.GREEN)
	rendertexture.draw(sprite)
	rendertexture.display()

	test_rendertarget(rendertexture)
	input()

image.py ::

	import sfml.graphics as sf
	from random import randint

	print("### sf.Image() ###")
	try:
		image = sf.Image()
		raise Warning("Shouldn't work!")
		
	except UserWarning as error:
		print("This error was expected...")
	input()

	print("### sf.Image.create() ###")
	#a = sf.Image.create(50, 50, sf.Color.CYAN) # bug due to a bug in cython
	a = sf.Image.create(50, 50)
	input()

	print("### sf.Image.create_from_pixels() ###")
	b = sf.Image.create_from_pixels(a.pixels)
	input()

	print("### sf.Image.load_from_file() ###")
	c = sf.Image.load_from_file("../data/background.jpg")
	input()

	print("### sf.Image.load_from_memory() ###")
	file = open("../data/background.jpg", "rb")
	data = file.read()
	d = sf.Image.load_from_memory(data)

	print("### sf.Image.save_to_file() ###")
	a.save_to_file("a.png")
	a.save_to_file("éééàààùù^o^.png")
	b.save_to_file("b.jpg")
	c.save_to_file("c.png")
	d.save_to_file("d.jpg")

	print("### sf.Image.size ###")
	assert type(a.size) == sf.Size
	assert type(b.size) == sf.Size
	assert type(c.size) == sf.Size
	assert type(d.size) == sf.Size
	print(a.size)
	print(b.size)
	print(d.size)
	print(d.size)
	input()

	print("### sf.Image.width ###")
	print(a.width)
	print(b.width)
	print(c.width)
	print(d.width)
	input()

	print("### sf.Image.height ###")
	print(a.height)
	print(b.height)
	print(c.height)
	print(d.height)
	input()

	print("### sf.Image.create_mask_from_color ###")
	#d.create_mask_from_color(sf.Color.CYAN)
	b.create_mask_from_color(sf.Color.BLACK)
	b.save_to_file("e.png")
	input()

	print("### sf.Image.blit() ###")
	c.blit(d, sf.Position(400, 400))
	c.blit(d, (400, 400))

	c.blit(d, sf.Position(50, 50), sf.Rectangle((200, 200), (200, 200)))
	#c.blit(d, sf.Position(200, 200), sf.Rectangle(200, 200, 400, 400))
	c.save_to_file("f.png")
	input()

	print("### sf.Image.pixels ###")
	assert type(b.pixels) == sf.Pixels
	print(a.pixels)
	input()

	print("### sf.Image.flip_horizontally() ###")
	c.flip_horizontally()
	c.save_to_file("g.png")
	input()

	print("### sf.Image.flip_vertically() ###")
	c.flip_vertically()
	c.save_to_file("h.png")
	input()

	print("### sf.Image.copy() ###")
	i = c.copy()
	i.save_to_file("i.png")
	input()

	print("### sf.Image.__get__ ###")
	print(i[50, 50])

	print("### sf.Image.__set__ ###")
	for x in range(i.width):
		for y in range(i.height):
			v = randint(0, 255)
			i[x, y] = sf.Color(v, v, v, v)

	i.save_to_file("j.png")


glyph.py ::

	import sfml.graphics as sf

	print("### sf.Glyph() ###")
	glyph = sf.Glyph()

	print("### sf.Glyph.advance ###")
	assert type(glyph.advance) == int
	print(glyph.advance)
	glyph.advance = -50
	glyph.advance = 50
	print(glyph.advance)

	print("### sf.Glyph.bounds ###")
	assert type(glyph.bounds) == sf.Rectangle
	print(glyph.bounds)
	glyph.bounds = sf.Rectangle((10, 20), (50, 60))
	glyph.bounds = (10, 20, 50, 60)
	assert glyph.bounds == sf.Rectangle((10, 20), (50, 60))
	print(glyph.bounds)

	print("### sf.Glyph.texture_rectangle ###")
	assert type(glyph.texture_rectangle) == sf.Rectangle
	print(glyph.texture_rectangle)
	glyph.texture_rectangle = sf.Rectangle((10, 20), (50, 60))
	glyph.texture_rectangle = (10, 20, 50, 60)
	assert glyph.texture_rectangle == sf.Rectangle((10, 20), (50, 60))
	print(glyph.texture_rectangle)

font.py ::

	import sfml.graphics as sf

	print("### sf.Font() ###")
	try:
		font = sf.Font()
		raise Warning("Shouldn't work!")
		
	except UserWarning as error:
		print("This error was expected...")
	input()

	print("### sf.Font.load_from_file() ###")
	a = sf.Font.load_from_file("../data/myfont.ttf")
	input()

	print("### sf.Font.load_from_memory() ###")
	file = open("../data/myfont.ttf", "rb")
	data = file.read()
	d = sf.Font.load_from_memory(data)

	print("### sf.Font.get_default_font ###")
	c = sf.Font.get_default_font()

	print("### sf.Font.get_glyph ###")
	glyph_a = c.get_glyph(56, 30, True)
	glyph_b = c.get_glyph(75, 35, False)
	glyph_c = c.get_glyph(125, 12, True)

	assert type(glyph_a) == sf.Glyph
	assert type(glyph_b) == sf.Glyph
	assert type(glyph_c) == sf.Glyph

	print(glyph_a)
	print(glyph_b)
	print(glyph_c)

	print("### sf.Font.get_kerning ###")
	kerning_a = a.get_kerning(20, 30, 30)
	kerning_b = a.get_kerning(10, 11, 12)
	kerning_c = a.get_kerning(20, 8, 10)

	print(kerning_a)
	print(kerning_b)
	print(kerning_c)
	input()

	print("### sf.Font.get_texture ###")
	texture = c.get_texture(12)
	assert type(texture) == sf.Texture
	input()


drawable.py ::

	import sfml.graphics as sf

	class MyDrawable(sf.Drawable):
		def __init__(self):
			sf.Drawable.__init__(self)
			
			self.texture = sf.Texture.load_from_file("../data/background.jpg")
			
		def draw(self, target, states):
			assert type(target) == sf.RenderTarget
			assert type(states) == sf.RenderStates
			print(target)
			print(states.transform)
			print(states.texture)
			print(states.shader)
			sprite = sf.Sprite(self.texture)
			target.draw(sprite, states)		
			

	try:
		mydrawable = sf.Drawable()
		raise UserWarning("Shouldn't work!!!")
	except NotImplementedError:
		print("This error was expected")
	input()

	window = sf.RenderWindow(sf.VideoMode(600, 600), "pySFML - Drawable")
	mydrawable = MyDrawable()

	myshader = sf.Shader.load_from_file("../data/wave.vert", sf.Shader.VERTEX)
	mytexture = sf.Texture.load_from_file("../data/sfml.png")
	renderstates = sf.RenderStates(texture=mytexture, shader=myshader)
	renderstates.transform.rotate(45)

	window.clear()
	window.draw(mydrawable, renderstates)
	window.display()
	input()
