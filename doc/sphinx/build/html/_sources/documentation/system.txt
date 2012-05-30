System
======

.. module:: sf

.. py:exception:: SFMLException(Exception)

.. py:class:: Time

   Represents a time value.

   :class:`sf.Time` encapsulates a time value in a flexible way.

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
   
      t1 = sf.seconds(0.1)
      milli = t1.milliseconds

      t2 = sf.milliseconds(30)
      micro = t2.microseconds

      t3 = sf.microseconds(-800000)
      sec = t3.seconds

      def update(elapsed):
         position += speed * elapsed.seconds
         
      update(sf.milliseconds(100))

   .. py:method:: Time()
   
      Construct a :class:`sf.Time` equivalent to :const:`ZERO`
   
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

   .. py:function:: copy()
   
      Python always works by reference, unless you explicitly ask for 
      a copy, that's why this method is provided.
      
      :return: Return a copy.
      :rtype: :class:`sf.Time`


.. py:function:: sleep(duration)

   Make the current thread sleep for a given duration.

   sf.sleep is the best way to block a program or one of its threads, 
   as it doesn't consume any CPU power.
   
   :param sf.Time duration: Time to sleep
   
.. py:class:: Clock

   Utility class that measures the elapsed time.

   sf.Clock is a lightweight class for measuring time.

   It provides the most precise time that the underlying OS can achieve 
   (generally microseconds or nanoseconds). It also ensures 
   monotonicity, which means that the returned time can never go 
   backward, even if the system time is changed.

   Usage example::

      clock = sf.Clock()
      # ...
      time1 = clock.elapsed_time
      # ...
      time2 = clock.restart()

   The sf.Time value returned by the clock can then be converted to a 
   number of seconds, milliseconds or even microseconds.

   .. py:attribute:: elapsed_time
         
      Get the elapsed time.

      This attribute returns the time elapsed since the last call to 
      :funct:`restart()` (or the construction of the instance if 
      :func:`restart()` has not been called).
                  
   .. py:method:: restart()
   
      Restart the clock.

      This function puts the time counter back to zero. It also returns the time elapsed since the clock was started.
                  
      :rtype: :class:`sf.Time`
   
.. py:function:: seconds(amount)

   Construct a time value from a number of seconds. 
   
   :param float amount: Number of seconds
   :return: Time value constructed from the amount of seconds
   :rtype: :class:`sf.Time`
   
.. py:function:: milliseconds(amount)

   Construct a time value from a number of milliseconds. 
   
   :param int amount: Number of milliseconds
   :return: Time value constructed from the amount of milliseconds
   :rtype: :class:`sf.Time`
   
.. py:function:: microseconds(amount)

   Construct a time value from a number of microseconds. 
   
   :param int amount: Number of microseconds
   :return: Time value constructed from the amount of microseconds
   :rtype: :class:`sf.Time`
   
   
.. class:: Position

   Utility class for manipulating 2-dimensional position. This class is
   equivalent to the template class sf::Vector2<T> in SFML.

   :class:`sf.Position` is a simple class that defines a mathematical 
   vector with two coordinates (x and y).

   It can be used to represent anything that has two dimensions: a 
   size, a point, a velocity, etc.

   :class:`sf.Position` supports arithmetic operations (+, -, /, *) 
   and comparisons (==, !=).
   
   Usage example::
   
      p1 = sf.Position(16.5, 24)
      p1.x = 18.2
      y = p1.y

      p2 = p1 * (5, 1)
      p3 = p1 + p2

      different = p2 != p3
      
   .. note::
   
      For 3-dimensional vectors, see :class:`sf.Vector`
      
   .. method:: Position(x=0, y=0)
   
      Construct a :class:`sf.Position`
   
   .. attribute:: x
   
      X coordinate of the vector.
      
   .. attribute:: y
   
      Y coordinate of the vector.

.. class:: Size

   Utility class for manipulating 2-dimensional size. This class has no
   direct equivalent in SFML. This can be emulated in C++ by using a
   sf::Vector2<unsigned int>.

   :class:`sf.Size` is a simple class that defines a size and therefore
   can't be negative neither it's width xor it's height.

   :class:`sf.Size` also supports arithmetic operations (+, -, /, *) 
   and comparisons (==, !=).
   
   .. method:: Size(width=0, height=0)
   
      Construct a :class:`sf.Size`
      
      :param integer width: It's width.
      :param integer height: It's height
      
   .. attribute:: width
      
      It's width.
      
   .. attribute:: height
   
      It's height.
   
.. class:: Rectangle

   Utility class for manipulating 2D axis aligned rectangles.

   A rectangle is defined by its top-left corner and its size.

   It is a very simple class defined for convenience, so its member 
   variables (left, top, width and height) are public and can be 
   accessed directly via attributes, just like :class:`sf.Position` 
   and :class:`sf.Size`

   Unlike SFML, :class:`sf.Rectangle` does define functions to emulate 
   the properties that are not directly members (such as right, bottom, 
   center, etc.), it rather only provides intersection functions.

   :class:`sf.Rectangle` uses the usual rules for its boundaries:

      * The left and top edges are included in the rectangle's area
      * The right (left + width) and bottom (top + height) edges are excluded from the rectangle's area

   This means that sf.Rectangle((0, 0), (1, 1)) and 
   sf.Rectangle((1, 1), (1, 1)) don't intersect.

   Usage example::

      # define a rectangle, located at (0, 0) with a size of 20x5
      r1 = sf.Rectangle(sf.Position(0, 0), sf.Size(20, 5))
      # or r1 = sf.Rectangle((0, 0), (20, 5))

      # define another rectangle, located at (4, 2) with a size of 18x10
      position = sf.Position(4, 2)
      size = sf.Size(18, 10)

      r2 = sf.Rectangle(position, size)

      # test intersections with the point (3, 1)
      b1 = r1.contains(sf.Position(3, 1)); # True
      b2 = r2.contains((3, 1)); # False

      # test the intersection between r1 and r2
      result = r1.intersects(r2) # True

      # as there's an intersection, the result is not None but sf.Rectangle(4, 2, 16, 3)
      assert result == sf.Rectangle((4, 2), (16, 3))
      
   .. method:: Rectangle(position=(0, 0), size=(0, 0))
      
      Construct a :class:`sf.Rectangle`

   .. attribute:: position
   
      Top-left coordinate of the rectangle.
      
   .. attribute:: size
   
      Size of the rectangle.
   
   .. attribute:: left
      
      Left coordinate of the rectangle. This attribute is provided as a
      shortcut to sf.Rectangle.position.x
      
   .. attribute:: top
   
      Top coordinate of the rectangle. This attribute is provided as a
      shortcut to sf.Rectangle.position.y
      
   .. attribute:: width
   
      Width of the rectangle. This attribute is provided as a
      shortcut to sf.Rectangle.size.width
      
   .. attribute:: height
   
      Height of the rectangle. This attribute is provided as a
      shortcut to sf.Rectangle.position.height

   .. attributes:: center

      The center of the rectangle.
      
   .. attribute:: rigth
   
      The right coordinate of the rectangle.
      
   .. attribute:: bottom
   
      The bottom coordinate of the rectangle.
      
   .. method:: contains(point)

      Check if a point is inside the rectangle's area. 
      
      :param sf.Position point: Point to test
      :rtype: bool
      
   .. method:: intersects(rectangle)

      Check the intersection between two rectangles.

      This overload returns the overlapped rectangle if an intersection 
      is found.
      
      :param sf.Rectangle rectangle: Rectangle to test 
      :return: Rectangle filled with the intersection or None
      :rtype: :class:`sf.Rectangle` or None
