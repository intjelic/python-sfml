Handling time
=============

.. contents:: :local:

Time in pySFML
--------------
Unlike many other libraries where time is an int number of milliseconds, or a
float number of seconds, pySFML doesn't impose any specific unit or type for
time values. Instead it leaves this choice to the user through a flexible
:class:`.Time`. All pySFML classes and functions that manipulate time values
use this class.

:class:`.Time` wraps a relative time value (in other words, a time span). It is
not a date-time class which would represent the current
year/month/day/hour/minute/second, it's just a value that represents a certain
amount of time, and how to interpret it depends on the context where it is used.

Converting time
---------------

A :class:`.Time` value can be constructed from different source units: seconds,
milliseconds and microseconds. There is a (non-member) function to turn each of
them into a :class:`.Time`: ::

   t1 = sf.microseconds(10000)
   t2 = sf.milliseconds(10)
   t3 = sf.seconds(0.01)

Note that these three times are all equal.

Similarly, a :class:`.Time` can be converted back to either seconds,
milliseconds or microseconds: ::

   time = ...

   usec = time.microseconds # long
   msec = time.milliseconds # int
   sec = time.seconds       # float


Playing with time values
------------------------
:class:`.Time` is just an amount of time, so it supports arithmetic operations
such as addition, subtraction, comparison, etc. Times can also be negative.

   t1 =  ...
   t2 = t1 * 2
   t3 = t1 + t2
   t4 = -t3

   b1 = t1 == t2
   b2 = t3 > t4

Measuring time
--------------
Now that we've seen how to manipulate time values with pySFML, let's see how to
do something that almost every program needs: measuring the time elapsed.

pySFML has a very simple class for measuring time: :class:`.Clock`. It only has
two members: :attr:`.elapsed_time`, to retrieve the time elapsed since the
clock started, and :meth:`.restart`, to restart the clock. ::

   clock = sf.Clock() # starts the clock
   # ...
   elapsed1 = clock.elapsed_time
   print(elapsed1.seconds)
   clock.restart()
   # ...
   elapsed2 = clock.elapsed_time
   print(elapsed2.seconds)

Note that restart also returns the elapsed time, so that you can avoid the
slight gap that would exist if you had to call :attr:`.elapsed_time`
explicitly before restart.
Here is an example that uses the time elapsed at each iteration of the game
loop to update the game logic::

   clock = sf.Clock()
   while window.is_open:
      elapsed = clock.restart()
      update_game(elapsed)
      #...
