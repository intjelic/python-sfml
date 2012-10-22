System
======

.. module:: sfml

.. contents:: :local:

Time
^^^^

.. py:class:: Time

   Represents a time value.

   :class:`sfml.system.Time` encapsulates a time value in a flexible way.

   It allows to define a time value either as a number of seconds, 
   milliseconds or microseconds. It also works the other way round: 
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

   .. py:method:: Time()
   
      Construct an :class:`sfml.system.Time` equivalent to :const:`ZERO`
   
   .. py:data:: ZERO
      
      Predefined "zero" time value. 

   .. py:attribute:: seconds
   
      Return the time value as a number of seconds.
      
   .. py:attribute:: milliseconds
   
      Return the time value as a number of milliseconds. 
      
   .. py:attribute:: microseconds
   
      Return the time value as a number of microseconds. 
      
   .. py:function:: reset()
   
      Reset the time to 0.

sleep
^^^^^

.. py:function:: sleep(duration)

   Make the current thread sleep for a given duration.

   sfml.sleep is the best way to block a program or one of its threads, 
   as it doesn't consume any CPU power.
   
   :param sfml.system.Time duration: Time to sleep
   

Clock
^^^^^

.. py:class:: Clock

   Utility class that measures the elapsed time.

   sfml.system.Clock is a lightweight class for measuring time.

   It provides the most precise time that the underlying OS can achieve 
   (generally microseconds or nanoseconds). It also ensures 
   monotonicity, which means that the returned time can never go 
   backward, even if the system time is changed.

   Usage example::

      clock = sfml.system.Clock()
      # ...
      time1 = clock.elapsed_time
      # ...
      time2 = clock.restart()

   The :class:`sfml.system.Time` value returned by the clock can then be converted to a 
   number of seconds, milliseconds or even microseconds.

   .. py:method:: Clock()
   
      Construct an :class:`sfml.system.Clock`
      
      The clock starts automatically after being constructed. 
      
   .. py:attribute:: elapsed_time
         
      Get the elapsed time.

      This attribute returns the time elapsed since the last call to 
      :func:`restart()` (or the construction of the instance if 
      :func:`restart()` has not been called).
      
      :rype: :class:`sfml.system.Time`
                  
   .. py:method:: restart()
   
      Restart the clock.

      This function puts the time counter back to zero. It also returns the time elapsed since the clock was started.
                  
      :rtype: :class:`sfml.system.Time`
   

seconds
^^^^^^^

.. py:function:: seconds(amount)

   Construct a time value from a number of seconds. 
   
   :param float amount: Number of seconds
   :return: Time value constructed from the amount of seconds
   :rtype: :class:`sfml.system.Time`
   

milliseconds
^^^^^^^^^^^^

.. py:function:: milliseconds(amount)

   Construct a time value from a number of milliseconds. 
   
   :param int amount: Number of milliseconds
   :return: Time value constructed from the amount of milliseconds
   :rtype: :class:`sfml.system.Time`
   

microseconds
^^^^^^^^^^^^

.. py:function:: microseconds(amount)

   Construct a time value from a number of microseconds. 
   
   :param int amount: Number of microseconds
   :return: Time value constructed from the amount of microseconds
   :rtype: :class:`sfml.system.Time`
   

Vector2
^^^^^^^

.. class:: Vector2

   Utility class for manipulating 2-dimensional vectors. This class is
   equivalent to the template class sf::Vector2<T> in SFML.

   :class:`sfml.system.Vector2` is a simple class that defines a mathematical 
   vector with two coordinates (:attr:`x` and :attr:`y`).

   It can be used to represent anything that has two dimensions: a size, a 
   point, a velocity, etc.

   :class:`sfml.system.Vector2` supports arithmetic operations (+, -, /, \*) 
   and comparisons (==, !=).

   Usage example::

      v1 = sfml.system.Vector2(16.5, 24)
      v1.x = 18
      y = v1.y

      v2 = v1 * 5

      v3 = v1 + v2

   For 3-dimensional vectors, see :class:`sfml.system.Vector3`
      
   .. method:: Vector2(x=0, y=0)

      Construct an :class:`sfml.system.Vector2`

   .. attribute:: x

      X coordinate of the vector.
      
   .. attribute:: y

      Y coordinate of the vector.

   .. py:classmethod: from_tuple(tuple)

      Construct the vector from a tuple.
      
      :rtype: :class:`sfml.system.Vector2`

Vector3
^^^^^^^

.. class:: Vector3

   Utility class for manipulating 3-dimensional vectors.

   :class:`sfml.system.Vector3` is a simple class that defines a mathematical 
   vector with three coordinates (:attr:`x`, :attr:`y` and :attr:`z`).

   It can be used to represent anything that has three dimensions: a 
   size, a point, a velocity, etc.

   :class:`sfml.system.Vector3` supports arithmetic operations (+, -, /, \*) and 
   comparisons (==, !=).

   Usage example::
   
      v1 = sfml.system.Vector3(16.8, 24, -8)
      v1.x = 18.2
      y = v1.y
      z = v1.z

      v2 = v1 * 5

      v3 = v1 + v2

      different = v2 is not v3

   .. method:: Vector3(x=0, y=0, z=0)

      Construct an :class:`sfml.system.Vector3`

   .. attribute:: x

      X coordinate of the vector.
      
   .. attribute:: y

      Y coordinate of the vector.

   .. attribute:: z

      Z coordinate of the vector.

   .. py:classmethod: from_tuple(tuple)

      Construct the vector from a tuple.
      
      :rtype: :class:`sfml.system.Vector3`
      
SFMLException
^^^^^^^^^^^^^

.. py:exception:: SFMLException(Exception)

   Main exception defined for all SFML functions/methods that may fail.
