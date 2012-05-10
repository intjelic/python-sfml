Getting started
===============
I suggest you to read the introduction before downloading and installing.

Getting the module
-----------------

1) Compiling

First, download the source tarball from 
http://openhelbreath.net/python-sfml2/downloads/python-sfml2.tar.gz

Then you must compile, to do that, you must have a snapshot of SFML2 
(the one which was which was avalaible on the 20th November 2011). This
snapshot is called SFML1.9.

SFML1.9: http://openhelbreath.net/python-sfml2/downloads/sfml1.9.tar.gz

Once SFML1.9 is installed just type these command to compile and install pySFML2::

   sudo python setup.py install 
   sudo python3 setup.py install

2) Ubuntu

For Ubuntu 12.04 users, just type ::

   sudo add-apt-repository ppa:sonkun/sfml
   sudo apt-get update
   sudo apt-get install libsfml2-dev python-sfml2

.. Note::
   libsfml2-dev is the version 1.9 that python-sfml2 needs. Be aware that
   it will erase any other SFML version installed. The best is to make sure
   nothing is alraedy installed. Type::
      
      cd /usr/local/ && rm lib/libsfml* && rm -R include/SFML
   
.. Note::
   The PPA sonkun/sfml provides SFML 1.9 and its example. The package name
   is sfml2-examples and you can run them via simple command lines:
   sfml2-sound # will run the example 'sound'
   
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
       music = sf.Music.open_from_file(b'nice_music.ogg')
       
   except sf.SFMLException as error:
       print(error)
       exit()

   # play the music
   music.play()

   running = True

   # start the game loop
   while(running):
       # process events
       for event in window.events:
           # close window: exit
           if event.type == sf.Event.CLOSED:
               window.close()
               running = False
               
       window.clear() # clear screen
       window.draw(sprite) # draw the sprite
       window.draw(text) # draw the string
       window.display() # update the window

As you can see, the interface is the same as SFML2 but it has been pythonized.

Overview
--------
Open a terminal, run the python interpreter. Now you can play arround,
for examples, try these commands::

   >>> import sfml as sf
   >>> w = sf.RenderWindow(sf.VideoMode(640, 480), "My Window")
   >>> w.clear(sf.Color.BLUE)
   >>> w.display()
   >>> w.size = (800, 600)
   >>> w.clear(sf.Color.GREEN)
   >>> w.display()
   >>> w.close()
   >>> exit()

To try out more, some examples are provided. If you downloaded the source, 
they are in examples/ and if you installed from the debian repository
(assume you did install the package python-sfml2-examples too), just type
python-sfml2-<example name>.

For examples, python-sfml2-sound will run the official example provided by
SFML2 but translated for this binding.

.. Note::
   Examples are only avalaible for python3.2 and you can find them in 
   /usr/lib/games/python-sfml2-examples/ (if you want to read the code)
   
The available examples are:

1) sound
2) shader
3) sockets
4) sound
5) sound_capture
6) spacial_music (extra)
7) pyqt4 (extra)*

* Pyqt4 must be installed to run (not Pyside).

In other words : python-sfml2-sound, python-sfml2-shader python-sfml2-pyqt4, etc.




