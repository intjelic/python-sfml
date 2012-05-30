Introduction
============
This binding is the version 1.0 and is based on the first release 
candidate of SFML2. This is a fast release.

This page has quickly been written and attemps to summerize features, 
changes, notes, etc. but nothing is exhaustive as this is a fast release.

History
-------
This binding was forked from the official python binding created by Bastien 
Léonard 16th of November 2011.

I decided to fork because his project was a work in progress and I needed 
some features urgently in order to port my current C++ projects to Python. 
It has since then widely improved and I decided to share my work under 
a new license: GPLv3.

Major improvements
------------------
1) network module implemented.
2) sound module rewritten.
3) some current limitation of the module have been fixed such the derivability of sf.Drawable.
4) modules are implemented separatly; you can import each module independantly.
5) support cython 0.16 (faster).
6) many official examples are available and new examples have been added.
7) an extra-layer to the sfml has been added to avoid dealing with type and to provide more flexibility
8) available through depot in launchpad for ease of installation.
9) documentation provided

A design slightly modified to fit Python principles
---------------------------------------------------
A few minor changes in the design have been made. Actually this subject 
matches the 7th point in `Major improvements`.

A first problem comes in when we compile a python module written in C: 
variable type. It's extremely annoying to care about that; should I use
a Vector2i, a Vector2f, and going from one to another with methods like
to_Vector2f(), to_Vector2i() makes the code dirty and less readable. Also
people would like to use a simple tuple when we have to pass a precise type 
which is Vector2i. That's why pySFML2 provides an extra-layer written
in pure Python to avoid those things.

The first thing is about sf::Vector2<T>; templates makes no sens in Python.
I renamed this class to sf.Position for a matter of beauty and it supports
float and integer attributes. Everywhere you can use a sf.Position, you
may pass a tuple as well.

Whatever happens, sf.Vector2f or sf.Vector2i are still available but
they are strongly depreciated and should be use only when it's about a part
of the binding which is in under developement (or maybe when a "position" 
strictly-speaking makes no sense).

The second thing is about a new class named sf.Size. This class, which 
doesn't exist in SFML, acts nearly like sf.Position but it can't have 
negative values which is a great utility in some case. Can you imagine 
a screen size with negative values? This wouldn't make sense, thus use 
sf.Size instead of sf.Position.

The third thing is about sf.Rectangle. This class uses therefore an 
sf.Position and an sf.Size in its internal attributes instead of 4 
integers or float.

These classes put typeless and easiness together.

Examples::

	position = sf.Position(50, 30)
	size = sf.Size(50, 60)
	rectangle = sf.Rectangle(position, size)
	
	x, y = position
	w, h = size
	left, top, width, height = rectangle

.. Warning::

	EVERYWHERE the documentation tells you to use a sf.Position, sf.Size or
	sf.Rectangle, you're allowed to pass a tuple as well! ::
	
		myShape = sf.CircleShape()
		myShape.texture_rectangle = (10, 20, 75, 90)
		myShape.texture_rectangle = sf.Rectangle((10, 20), (75, 90))

What you should know before starting
------------------------------------
This is not exhaustive.

There are no sf::Vector2<T> and sf::Rectangle<T> so instead you use 
sf.Position, sf.Size and sf.Rectangle.

As we can't have a function and an attribute with the same name, I can't 
implement scale(), getScale and setScale(). I renamed the property scale 
to ratio.

sf.Pixels is a new class that allows you to manipulate unsigned char* 
arrays with a reference to the width and the height of the image it 
represents.

sf.Chunk is a new class that allows you to manipulate Int16 arrays but so far 
you can only get values from the array and you can't manipulate freely
(add, remove, get a slice).

Public enumeration, static public attributes and static public member 
functions follow the same convention. They are implemented in the 
following way:

	* enumeration -> constants
	* static public attributes -> constants
	* static public member functions -> classmethod
	
Examples::
	sf.Style.DEFAULT # an enumeration value
	sf.Time.ZERO # a static attribute
	sf.Texture.get_maximum_size() # a static member function
	
You can't instantiate empty or invalid sf.Shader, sf.Sprite, 
sf.Texture, sf.Font, etc and you must construct them from their class 
methods. ::

	shader = sf.Shader() # will fail.
	shader = sf.Shader.load_from_file(...) # the right way


Renamed sf.Image.copy(Image, ...) -> sf.Image.blit(Image, ...) because
sf.Image needed sf.Image.copy().

sf.Vector is for 3 dimensional position and is currently implemented and 
exclusively used in the audio module.

Its weaknesses
--------------
As module are implemented separately and that cython doesn't support this
feature yet, it involves some bad sides.

	* full class/object/function/variable names are dirty: sf.graphics.window, sf.network.network, ... (This will be partially fixed in the next release)
	* You can't use sf.Time in the audio or network module, you'll have to use an old integer.

.. note::
	To remove those bad aspects, I have to create a kind of C API for  
	the built-in types that pySFML2 provides. I prefer to have a stable binding 
	before I start coding that.

Handling error message is missing and will be implemented in the next version.

What you should be aware of
---------------------------
Cython has its limitations/bugs/current missing features.

As a class can't inherit from two classes I technically can't implement 
sf.RenderWindow because it inherits from sf.Window and sf.RenderTarget. 
I had to make a choice and did it like this for various reasons.

sf.Window inherits from sf.Window
sf.RenderTexture inherits from sf.RenderTarget
sf.Shape, sf.Text and sf.Sprite inherits from sf.TransformableDrawable (an internal class)

Don't be surprise if you attempt to know whether an object is an instance 
of via isinstance(), etc.

Next version
------------
The next version will provide a stabler binding, all tests 
implemented, the documentation fully written and some tutorials. The pure 
python layer will move to built-in types for speed.
