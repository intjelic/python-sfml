Introduction
============

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
differences on why they have been implemented that way. 

When I discovered his binding I had never heard about cython and when I
read the source I was amaze of how easy a python binding can be made 
with Cython.

A python binding is really the perfect way to sketch a software using 
SFML.


Major improvements
------------------
1) network module implemented
2) sound module rewrited
3) some current limitation of the module have been fixed such the derivability of sf.Drawable.
4) modules are implemented separatly; you can import each module independantly
5) 


Minor changes
-------------
As I previously said, a few minor changes in the design have been made.

The first one is about sf::Vector2<T>; templates make no sens in Python.
I renamed this class to sf.Position for a matter of beauty and it supports
float and integer attributes. Everywhere you can use a sf.Position, you
may pass a tuple as well.

Whatever it happens, sf.Vector2f or sf.Vector2i are still available but
they are strongly depreciated and should be use only when it's about a part
of the binding which is in under developement or when a "position" 
strickly-speaking makes no sens.

The second thing is about sf.Size; a new class which doesn't exist in SFML.
This class acts nearly like sf.Position but it can't have negative values 
which is a great utility is some case. Can you imagine a screen size with 
negativ value ? This wouldn't make sens thus use sf.Size instead of sf.Position.

The third thing is about sf.Rectangle. This class therefore use a sf.Position
and a sf.Size in its intenal attributes instead of 4 integers or float.


What's coming
-------------
I planned to set-up a non-officiel debian repository where people can
get the lastest version of SFML2 in C++ and this project with regularly
update of theese. It allows to synchronize all projects (user's projects
and this binding which can't be updated everytime a chagne is made in the
SFML2 branch).

Big modifications in the design have been recently made in SFML2 but 
this is too early to keep this binding up-to-date with because theese 
modifications are subjet to change. People shouldn't use the very lastest
version for their serious project and should wait instead. That's why
this binding will stand on its previous version.

I invite you to have a look at the bug tracker of this project located
here: http://www.dewachterjonathan.be/flyspray/ (you have to choose the
right project which is "python-sfml2".


Last updates
------------
Here i'm going to write what i'm currently working on.
