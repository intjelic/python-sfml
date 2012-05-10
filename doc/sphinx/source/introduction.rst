Introduction
============
This binding is the version 0.9 and is based on a particular snapshot of
SFML2. This snapshot was the one available on the 20th November 2011 and
I worked with it since then and I used to call it SFML1.9.

At the time of writing these lines, a candidate release of SFML2 has 
already been out and I'm planning to focus the update of this binding 
rather than providing a stable one base on the snapshot. That's why
you may find some bugs or some illogical things in my code. However,
it is stable enought for production, you can check the examples. The 
version 1.0 of this project will be based on the release candidate if 
the final release is not yet available.

You'll find on this page a detailed description of the project.

People from SFML2 in C++ should be familiar with this binding.

History
-------
This binding was forked from the official python binding created by Bastien 
Léonard the 16th of November 2011.

I decided to fork because his project was a work-in-progress and I needed 
some features at once to write my current C++ projects in Python. I
also needed some extra-features to suit my own needs.

It has since then widely improved and I decided to share my work under 
a new license: GPLv3.

Those "extra-features" may be depreciated by people because those don't
follow the original SFML design but it shouldn't be since the 
differences are very small. You'll find an explaination for each 
differences about why they have been implemented that way. 

Major improvements
------------------
1) network module implemented.
2) sound module rewrited.
3) some current limitation of the module have been fixed such the derivability of sf.Drawable.
4) modules are implemented separatly; you can import each module independantly.
5) support cython 0.16 (faster).
6) many official examples are available and new examples have been added.
7) an extra-layer to the sfml has been added to avoid dealing with type and to provide more flexibility
8) available trought depot in launchpad for ease of installation.

A design slightly modified to fit Python principles
---------------------------------------------------
As I previously said, a few minor changes in the design have been made.
Actually this subject matches the 7th bullet in Major improvements.

A first problem comes in when we compile a python module written in C: 
variable type. It's extremely annoying to care about that; should I use
a Vector2i, a Vector2f, and going from one to another with methods like
to_Vector2f(), to_Vector2i() makes the code dirty and less readable. Also
people'd like to use a simple tuple when we have to pass a precise type 
which is Vector2i. That's why pySFML2 provides an extra-layer written
in pure Python to avoid those things.

The first thing is about sf::Vector2<T>; templates make no sens in Python.
I renamed this class to sf.Position for a matter of beauty and it supports
float and integer attributes. Everywhere you can use a sf.Position, you
may pass a tuple as well.

Whatever it happens, sf.Vector2f or sf.Vector2i are still available but
they are strongly depreciated and should be use only when it's about a part
of the binding which is in under developement (or maybe when a "position" 
strickly-speaking makes no sens).

The second thing is about a new class named sf.Size. This class which 
doesn't exist in SFML acts nearly like sf.Position but it can't have 
negative values which is a great utility is some case. Can you imagine 
a screen size with negative values? This wouldn't make sens thus use 
sf.Size instead of sf.Position.

The third thing is about sf.Rectangle. This class therefore use a 
sf.Position and a sf.Size in its intenal attributes instead of 4 
integers or float.

These classes put typeness and easiness together.

Next version
------------
I hope to provide for the next version (v1.0) a more stable binding which
supports SFML2.0 with a full documentation and all tutorials translated.
