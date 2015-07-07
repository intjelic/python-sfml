System
======
.. contents:: :local:
.. py:module:: sfml.system


Vector2
^^^^^^^

.. class:: Vector2

   Utility class for manipulating 2-dimensional vectors.

   :class:`Vector2` is a simple class that defines a mathematical vector with
   two coordinates (:attr:`x` and :attr:`y`).

   It can be used to represent anything that has two dimensions: a size, a
   point, a velocity, etc.

   :class:`Vector2` supports arithmetic operations (+, -, /, \*), unary
   operations and comparisons (==, !=).

   It contains no mathematical function like dot product, cross product,
   length, etc.

   Usage example::

      v1 = sf.Vector2(16.5, 24)
      v1.x = 18.2
      y = v1.y

      v2 = v1 * 5

      v3 = v1 + v2

      different = v2 != v3

   Note: for 3-dimensional vectors, see :class:`.Vector3`

   .. method:: Vector2(x=0, y=0)

      Construct an :class:`sfml.system.Vector2`

   .. attribute:: x

      X coordinate of the vector.

   .. attribute:: y

      Y coordinate of the vector.

Vector3
^^^^^^^

.. class:: Vector3

   Utility class for manipulating 3-dimensional vectors.

   :class:`Vector3` is a simple class that defines a mathematical vector with
   three coordinates (:attr:`x`, :attr:`y` and :attr:`z`).

   It can be used to represent anything that has three dimensions: a size, a
   point, a velocity, etc.

   :class:`Vector3` supports arithmetic operations (+, -, /, \*), unary
   operations and comparisons (==, !=).

   It contains no mathematical function like dot product, cross product,
   length, etc.

   Usage example::

      v1 = sf.Vector3(16.5, 24, -8.2)
      v1.x = 18.2
      y = v1.y
      z = v1.z

      v2 = v1 * 5

      v3 = v1 + v2

      different = v2 != v3

   Note: for 2-dimensional vectors, see :class:`.Vector2`

   .. method:: Vector3(x=0, y=0, z=0)

      Construct an :class:`sfml.system.Vector3`

   .. attribute:: x

      X coordinate of the vector.

   .. attribute:: y

      Y coordinate of the vector.

   .. attribute:: z

      Z coordinate of the vector.

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

Time
^^^^

.. class:: Time

   Represents a time value.

   :class:`Time` encapsulates a time value in a flexible way.

   It allows to define a time value either as a number of seconds, milliseconds
   or microseconds. It also works the other way round: you can read a time
   value as either a number of seconds, milliseconds or microseconds.

   By using such a flexible interface, the API doesn't impose any fixed type or
   resolution for time values, and let the user choose its own favorite
   representation.

   :class:`Time` values support the usual mathematical operations: you can add
   or subtract two times, multiply or divide a time by a number, compare two
   times, etc.

   Since they represent a time span and not an absolute time value, times can
   also be negative.

   Usage example::

      t1 = sf.seconds(0.1)
      milli = t1.milliseconds

      t2 = sf.milliseconds(30)
      micro = t2.microseconds

      t3 = sf.microseconds(-800000)
      sec = t3.seconds

   ::

      def update(elapsed):
         position += speed * elapsed.seconds

      update(sf.milliseconds(100))

   See also: :class:`.Clock`

   .. method:: Time()

      Construct a :class:`Time` equivalent to :const:`ZERO`

   .. data:: ZERO

      Predefined "zero" time value. Copy this value with the **copy** module.

   .. attribute:: seconds

      Return the time value as a number of seconds.

   .. attribute:: milliseconds

      Return the time value as a number of milliseconds.

   .. attribute:: microseconds

      Return the time value as a number of microseconds.

Clock
^^^^^

.. class:: Clock

   Utility class that measures the elapsed time.

   :class:`Clock` is a lightweight class for measuring time.

   It provides the most precise time that the underlying OS can achieve
   (generally microseconds or nanoseconds). It also ensures monotonicity, which
   means that the returned time can never go backward, even if the system time
   is changed.

   Usage example::

      clock = sf.Clock()
      # ...
      time1 = clock.elapsed_time
      # ...
      time2 = clock.restart()

   The :class:`Time` value returned by the clock can then be converted to a
   number of seconds, milliseconds or even microseconds.

   See also: :class:`.Time`

   .. method:: Clock()

      Construct a :class:`Clock`

      The clock starts automatically after being constructed.

   .. attribute:: elapsed_time

      Get the elapsed time.

      This attribute returns the time elapsed since the last call to
      :func:`restart()` (or the construction of the instance if
      :func:`restart()` has not been called).

      :return: :class:`.Time` elapsed
      :rtype: :class:`sfml.system.Time`

   .. method:: restart()

      Restart the clock.

      This function puts the time counter back to zero. It also returns the
      time elapsed since the clock was started.

      :return: :class:`.Time` elapsed
      :rtype: :class:`sfml.system.Time`

sleep
^^^^^

.. function:: sleep(duration)

   Make the current thread sleep for a given duration.

   :func:`sleep` is the best way to block a program or one of its threads, as
   it doesn't consume any CPU power.

   :param sfml.system.Time duration: Time to sleep
