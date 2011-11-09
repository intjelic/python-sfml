Exceptions
==========


.. module:: sf


Currently, only one exception exists, but more specific exceptions will probably
be used in the future.


.. exception:: PySFMLException

   Raised when any important error is encountered. Typically, file loading
   methods such as :meth:`sf.Texture.load_from_file()` return the new object if
   everything went well, and raise this exception otherwise.

   A simple example of error handling::

      try:
          texture = sf.Texture.load_from_file('texture.png')
      except sf.PySFMLException as e:
          # Handle error: pring message, log it, ...

   In C++::

      sf::Texture texture;

      if (!texture.LoadFromFile("texture.png"))
      {
          // Handle error
      }

   Please understand that you don't *have* to handle exceptions every time you
   call a method that might throw one; you can handle them at a higher level or
   even not handle them at all, if the default behavior of stopping the program
   and printing a traceback is OK. This is an advantage compared to C++ SFML,
   where ignoring return statuses means that your program will try to keep
   running normally if an important error is raised.

   .. attribute:: message

      A string describing the error.  This is the same message that
      C++ SFML would write in the console.
