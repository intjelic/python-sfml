Getting started
===============
First, you need to install all the stuff, read the installing section.

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
       
   except sf.SFMLException as error:
       print(error)
       exit()

   # play the music
   music.play()

   # start the game loop
   while(window.opened):
       # process events
       for event in window.events:
           # close window: exit
           if event.type == sf.Event.CLOSED:
               window.close()
               
       window.clear() # clear screen
       window.draw(sprite) # draw the sprite
       window.draw(text) # draw the string
       window.display() # update the window

As you can see; the interface is the same as SFML2 but it has been pythonized.

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
   
The available examples are:

1) sound
2) sockets
3) ftp (new)
4) sound
5) sound_capture
6) spacial_music (no official sfml example)
7) pyqt4         (no official sfml example)*

* Pyqt4 must be installed to run (not Pyside).

In other words: python-sfml2-sound, python-sfml2-pyqt4, etc.



