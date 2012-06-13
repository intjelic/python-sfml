Getting started
===============
First, you need to install pySFML2, read the installation section.

After reading this, you can jump to the single tutorial that 
summarizes all big changes that may surprise you and that you should be 
aware of.

After the :ref:`tutorials-reference`, you should be able to start coding your project 
with the documentation in hand.

Your first script
-----------------
Here is the official short example to show you how simple using pySFML is. ::

	import sfml as sf


	# create the main window
	window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML Window")

	try:
		# load a sprite to display
		texture = sf.Texture.load_from_file("cute_image.png")
		sprite = sf.Sprite(texture)

		# create a graphical text to display
		font = sf.Font.load_from_file("arial.ttf")
		text = sf.Text("Hello SFML", font, 50)

		# load a music to play
		music = sf.Music.open_from_file("nice_music.ogg")

	except IOError: exit(1)

	# play the music
	music.play()

	# start the game loop
	while window.opened:
		# process events
		for event in window.events:
			# close window: exit
			if type(event) is sf.CloseEvent:
				window.close()

		window.clear() # clear screen
		window.draw(sprite) # draw the sprite
		window.draw(text) # draw the string
		window.display() # update the window

As you can see; the interface remains the same as SFML2 but it has been pythonized.

Overview
--------
Open a terminal, run the python interpreter. Now you can play around.
For example; try these commands::

   >>> import sfml as sf
   >>> w = sf.RenderWindow(sf.VideoMode(640, 480), "My first pySFML Window - or not ?")
   >>> w.clear(sf.Color.BLUE)
   >>> w.display()
   >>> w.size = (800, 600)
   >>> w.clear(sf.Color.GREEN)
   >>> w.display()
   >>> w.title = "Yes, it's my first PySFML Window"
   >>> w.display()
   >>> w.capture().show()
   >>> w.close()
   >>> exit()

To help with trying it out more, some examples are provided. If you downloaded the source 
they are in examples/ and if you installed from the debian repository
(assuming you installed the pysfml2-examples package as well), just type
pysfml2-<example name>.

For examples; pysfml2-sound will run the official example provided by
SFML2 but translated for this binding.

.. Note::
   Examples are only avalaible for python3.2 and you can find them in 
   /usr/lib/games/pysfml2-examples/ (if you want to read the code)

Tricks
------
Once you know well pySFML2, you may be interessed in knowing some 
tricks.

Unpacking
^^^^^^^^^
Many class are unpackable ::

	x, y = sf.Vector2(5, 10)
	x, y, z = sf.Vector3(5, 10, 15)

	size, bpp = sf.VideoMode((640, 480), 32)
	depth_bits, stencil_bits, antialiasing, minor_version, major_version = sf.ContextSettings()

	r, g, b, a = sf.Color.CYAN
	left, top, width, height = sf.Rectangle((5, 10), (15, 20))

sf.Image.show()
^^^^^^^^^^^^^^^

For debugging purpose, pySFML provides a function show() that allows 
you to see how an image look like (after modification, to be sure all 
operation made on the pictre was effective). ::

   image = sf.Image.load_from_image("image.png")
   image.create_mask_from_color(sf.Color.BLUE)
   image.show()
   
   texture = sf.Texture.load_from_image(image)
   texture.rotation += 45
   texture.scale *= (0.5, 1)
   texture.show()
   
Set an icon to a Window
^^^^^^^^^^^^^^^^^^^^^^^

Set an icon easily to your window :: 

	icon = sf.Image.load_from_file("data/icon.bmp")
	window.icon = icon.pixels

Shortcut for sf.IpAddress
^^^^^^^^^^^^^^^^^^^^^^^^^

A shortcut to sf.IpAddress.from_string(mystring) is sf.IpAddress(mystring). Why ?
Because the IpAddress constructor can take optionally a string, an integer or 
a tuple. But as the string argument is at the first place, this can be possible. ::

   ip = sf.IpAddress(string="www.google.com")
   ip = sf.IpAddress(integer=249780)
   ip = sf.IpAddress(bytes=(192, 168, 1, 1))

   ip = sf.IpAddress("www.google.com") # works
   ip = sf.IpAddress(249780)           # doesn't work
   ip = sf.IpAddress((192, 168, 1, 1)) # doesn't work
