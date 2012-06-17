Getting started
===============
First you need to install pySFML2. Read the installation section.

After reading this you can read the single tutorial that 
summarizes all the large, potentially surprising, changes that you 
should be aware of.

After the :ref:`tutorials-reference`, you should be able to start coding your project 
with the documentation at hand.

Your first script
-----------------
Here is the official short example to show you how simple using pySFML is. ::

	import sfml


	# create the main window
	window = sfml.RenderWindow(sfml.VideoMode(640, 480), "pySFML Window")

	try:
		# load a sprite to display
		texture = sfml.Texture.load_from_file("cute_image.png")
		sprite = sfml.Sprite(texture)

		# create some graphical text to display
		font = sfml.Font.load_from_file("arial.ttf")
		text = sfml.Text("Hello SFML", font, 50)

		# load music to play
		music = sfml.Music.open_from_file("nice_music.ogg")

	except IOError: exit(1)

	# play the music
	music.play()

	# start the game loop
	while window.opened:
		# process events
		for event in window.events:
			# close window: exit
			if type(event) is sfml.CloseEvent:
				window.close()

		window.clear() # clear screen
		window.draw(sprite) # draw the sprite
		window.draw(text) # draw the string
		window.display() # update the window

As you can see the interface remains the same as SFML2 but it has been pythonized.

Overview
--------
Open a terminal and run the python interpreter. Now you can play. 
For example: try these commands::

   >>> import sfml as sf
   >>> w = sfml.RenderWindow(sfml.VideoMode(640, 480), "My first pySFML Window - or not ?")
   >>> w.clear(sfml.Color.BLUE)
   >>> w.display()
   >>> w.size = (800, 600)
   >>> w.clear(sfml.Color.GREEN)
   >>> w.display()
   >>> w.title = "Yes, it's my first PySFML Window"
   >>> w.display()
   >>> w.capture().show()
   >>> w.close()
   >>> exit()

To help with trying it out more some examples are provided. If you downloaded the source 
they are in examples/. If you installed it from the Debian/Ubuntu repository
(assuming you installed the pysfml2-examples package as well) just type
pysfml2-<example name>.

For example; pysfml2-sound will run the official example provided by
SFML2, translated for this binding.

.. Note::
   Examples are only avalaible for python3.2 and can be found in 
   /usr/lib/games/pysfml2-examples/ should you wish to read the code.

Tricks
------
Once you know well pySFML2 well you may be interested in knowing some 
tricks.

Unpacking
^^^^^^^^^
Many classes are unpackable ::

	x, y = sfml.Vector2(5, 10)
	x, y, z = sfml.Vector3(5, 10, 15)

	size, bpp = sfml.VideoMode((640, 480), 32)
	depth_bits, stencil_bits, antialiasing, minor_version, major_version = sfml.ContextSettings()

	r, g, b, a = sfml.Color.CYAN
	left, top, width, height = sfml.Rectangle((5, 10), (15, 20))

sfml.Image.show()
^^^^^^^^^^^^^^^

For debugging purpose pySFML provides a show() function. This allows 
you to see how an image will look after modification. This is to be 
sure all operations made on the pictre were effective. ::

   image = sfml.Image.load_from_image("image.png")
   image.create_mask_from_color(sfml.Color.BLUE)
   image.show()
   
   texture = sfml.Texture.load_from_image(image)
   texture.update(window, (50, 60))
   texture.copy_to_image().show()
   
Attach an icon to a Window
^^^^^^^^^^^^^^^^^^^^^^^^^^

Easily attach an icon to your window :: 

	icon = sfml.Image.load_from_file("data/icon.bmp")
	window.icon = icon.pixels
