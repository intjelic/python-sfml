System
======

.. module:: sf.system

.. py:function:: sleep(time)

   Make the current thread sleep for a given duration.
   
.. py:class:: Clock

      Utility class for manipulating time.
      
      sf::Clock is a lightweight class for measuring time.
      
      Its resolution depends on the underlying OS, but you can generally expect a 1 ms resolution.
      
   .. py:method:: reset()
   
         Get the time elapsed.
         
   .. py:attribute:: elapsed_time
   
         Restart the timer.


.. class:: Position(x=0, y=0)

   .. attribute:: x
   .. attribute:: y

.. class:: Size(width=0, height=0)

   .. attribute:: width
   .. attribute:: height
   
.. class:: Rectangle(width=0, =height0)

   .. attribute:: position
   .. attribute:: size
   
   .. attribute:: x
   .. attribute:: y
   .. attribute:: width
   .. attribute:: height
   
   .. attribute:: left
   .. attribute:: top
   .. attribute:: rigth
   .. attribute:: bottom
   
   .. py:classmethod:: contains(point)

      Check if a point is inside the rectangle's area. 
      
      :param sf.Position point: Point to test
      :rtype: bool
      
   .. py:classmethod:: intersects(rectangle)

      Check the intersection between two rectangles.

      This overload returns the overlapped rectangle if an intersection is found.
      
      :param sf.Rectangle rectangle: Rectangle to test 
      :return: Rectangle filled with the intersection or None
      :rtype: sf.Rectangle or None


