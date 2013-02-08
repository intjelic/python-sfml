System
======
.. module:: sfml.system
.. contents:: :local:

Time
^^^^

.. py:class:: Time

   Represents a time value.

   :class:`Time` encapsulates a time value in a flexible way.

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
   
      Construct a :class:`Time` equivalent to :const:`ZERO`
   
   .. py:data:: ZERO
      
      Predefined "zero" time value. Make sure to copy this value via 
      the **copy** module.
      
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

   :func:`sleep` is the best way to block a program or one of its threads, 
   as it doesn't consume any CPU power.
   
   :param sfml.system.Time duration: Time to sleep
   

Clock
^^^^^

.. py:class:: Clock

   Utility class that measures the elapsed time.

   :class:`Clock` is a lightweight class for measuring time.

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
      
      :rtype: :class:`sfml.system.Time`
                  
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

   :class:`Vector2` is a simple class that defines a mathematical 
   vector with two coordinates (:attr:`x` and :attr:`y`).

   It can be used to represent anything that has two dimensions: a size, a 
   point, a velocity, etc.

   :class:`Vector2` supports arithmetic operations (+, -, /, \*), unary 
   operations and comparisons (==, !=).

   Usage example::

      v1 = sf.Vector2(16.5, 24)
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

   :class:`Vector3` is a simple class that defines a mathematical 
   vector with three coordinates (:attr:`x`, :attr:`y` and :attr:`z`).

   It can be used to represent anything that has three dimensions: a 
   size, a point, a velocity, etc.

   :class:`Vector3` supports arithmetic operations (+, -, /, \*), unary 
   operations and comparisons (==, !=).

   Usage example::
   
      v1 = sf.Vector3(16.8, 24, -8)
      v1.x = 18.2
      y = v1.y
      z = v1.z

      v2 = v1 * 5

      v3 = v1 + v2

      assert v2 is not v3

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


Thread
^^^^^^

.. class:: Thread

   Utility class to manipulate threads.

   Threads provide a way to run multiple parts of the code in parallel.

   When you launch a new thread, the execution is split and both the new thread 
   and the caller run in parallel.

   To use a :class:`Thread`, you construct it directly with the function to 
   execute as the entry point of the thread.

   The thread ends when its function is terminated. If the owner sf.Thread 
   instance is destroyed before the thread is finished, the destructor will 
   wait (see :meth:`wait`)

   Usage example::
   
      def functor(a, b, c):
         # do something in parallel
         
      mythread = sf.Thread(functor, 16.8, 24, -8)
      mythread.launch()

   .. method:: Thread(functor, *args, **kwargs)
   
      Construct the thread from a callable object with optional arguments.
      
      .. note:: 
      
         This does **not** run the thread, use :meth:`launch`.

   .. method:: launch()
   
      Run the thread.

      This function starts the entry point passed to the thread's constructor, 
      and returns immediately. After this function returns, the thread's 
      function is running in parallel to the calling code.

   .. method:: terminate()

      Terminate the thread.

      This function immediately stops the thread, without waiting for its 
      function to finish. Terminating a thread with this function is not safe, 
      and can lead to local variables not being destroyed on some operating 
      systems. You should rather try to make the thread function terminate by 
      itself.

   .. method:: wait()

      Wait until the thread finishes.

      This function will block the execution until the thread's function ends. 
      
      .. warning:: 
         
         If the thread function never ends, the calling thread will block 
         forever. If this function is called from its owner thread, it returns 
         without doing anything.


Mutex
^^^^^

.. class:: Mutex

   Blocks concurrent access to shared resources from multiple threads.

   Mutex stands for "MUTual EXclusion".

   A mutex is a synchronization object, used when multiple threads are involved.

   When you want to protect a part of the code from being accessed 
   simultaneously by multiple threads, you typically use a mutex. When a thread 
   is locked by a mutex, any other thread trying to lock it will be blocked 
   until the mutex is released by the thread that locked it. This way, you can 
   allow only one thread at a time to access a critical region of your code.

   Usage example::

      database = Database() # this is a critical resoruce that needs some protection

      mutex = sf.Mutex()
      
      def thread1():
         mutex.lock() # this call will block the thread if the mutex is already locked by thread2
         database.write(...)
         mutex.unlock() # if thread2 was waiting, it will now be unblocked
         
      def thread2():
         mutex.lock() # this call will block the thread if the mutex is already locked by thread1
         database.write(...)
         mutex.unlock() # if thread1 was waiting, it will now be unblocked
         
   Be very careful with mutexes. A bad usage can lead to bad problems, like 
   deadlocks (two threads are waiting for each other and the application is 
   globally stuck).

   To make the usage of mutexes more robust, particularly in environments where 
   exceptions can be thrown, you should use the helper class `class:`Lock` to 
   lock/unlock mutexes.

   pySFML mutexes are recursive, which means that you can lock a mutex multiple 
   times in the same thread without creating a deadlock. In this case, the 
   first call to :meth:`lock` behaves as usual, and the following ones have no 
   effect. However, you must call `meth:`unlock` exactly as many times as you 
   called :meth:`lock`. If you don't, the mutex won't be released.

   .. method:: Mutex()
   
      Construct a mutex.
      
   .. method:: lock()
   
      Lock the mutex.

      If the mutex is already locked in another thread, this call will block 
      the execution until the mutex is released.

   .. method:: unlock()

      Unlock the mutex.


   
Lock
^^^^

.. class:: Lock

   Automatic wrapper for locking and unlocking mutexes.

   :class:`Lock` is a RAII wrapper for :class:`Mutex`.

   By unlocking it in its destructor, it ensures that the mutex will always be 
   released when the current scope (most likely a function) ends. This is even 
   more important when an exception or an early return statement can interrupt 
   the execution flow of the function.

   For maximum robustness, :class:`Lock` should always be used to lock/unlock a 
   mutex.

   Usage example::

      mutex = sf.Mutex()
      
      def function():
         lock = sf.Lock(mutex) # mutex is now locked
         
         function_that_may_throw_an_exception() # mutex is unlocked if this function throws
         
         if (some_condition):
            return # mutex is unlocked
            
         # mutex is unlocked
   
   Because the mutex is not explicitely unlocked in the code, it may remain 
   locked longer than needed. If the region of the code that needs to be 
   protected by the mutex is not the entire function, just delete the lock via 
   *del*. ::

      mutex = sf.Mutex()
      
      def function():
         lock = sf.Lock(mutex)
         code_that_requires_protection()
         del lock
         code_that_doesnt_care_about_the_mutex()

   Having a mutex locked longer than required is a bad practice which can lead 
   to bad performances. Don't forget that when a mutex is locked, other threads 
   may be waiting doing nothing until it is released.

   .. method:: Lock(mutex)
   
   Construct the lock with a target mutex.

   The mutex passed to :class:`Lock` is automatically locked.


SFMLException
^^^^^^^^^^^^^

.. py:exception:: SFMLException(Exception)

   Main exception defined for all SFML functions/methods that may fail.
