System
======

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


.. class:: Vector2f(float x=0.0; float y=0.0)

   You don't have to use this class; everywhere you can pass a
   :class:`Vector2f`, you should be able to pass a tuple as well. However, it
   can be more practical to use it, as it overrides arithmetic and comparison
   operators, is mutable and requires that you use ``x`` and ``y`` members
   instead of indexing.

   .. attribute:: x
   .. attribute:: y

   .. classmethod:: from_tuple(t)

   .. method:: copy()

      Return a new :class:`Vector2f` with ``x`` and ``y`` set to the
      value of ``self``.

