System
======
.. currentmodule:: sfml
.. contents:: :local:

Time
^^^^
.. autoclass:: Time
   :members:

   :class:`Time` encapsulates a time value in a flexible way.

   It allows to define a time value either as a number of seconds, 
   milliseconds, or microseconds. It also works the other way round: 
   you can read a time value as either a number of seconds, 
   milliseconds or microseconds.

   By using such a flexible interface, the API doesn't impose any 
   fixed type or resolution for time values, and let the user choose 
   its own favorite representation.

   :class:`Time` values support the usual mathematical operations: you can add 
   or subtract two times, multiply or divide a time by a number, 
   compare two times, etc.

   Since they represent a time span and not an absolute time value, 
   times can also be negative.

   Usage example::

       t1 = sfml.seconds(0.1)
       milli = t1.milliseconds

       t2 = sfml.milliseconds(30)
       micro = t2.microseconds

       t3 = sfml.microseconds(-800000)
       sec = t3.seconds

       def update(elapsed):
           position += speed * elapsed.seconds
            
       update(sfml.milliseconds(100))
