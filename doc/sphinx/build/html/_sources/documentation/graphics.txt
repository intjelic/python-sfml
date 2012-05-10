Graphics
========

.. module:: sf.graphics


.. py:class:: Color(r, g, b[, a=255])

      Utility class for manpulating RGBA colors.

      sf.Color is a simple color class composed of 4 components: Red, 
      Green, Blue, Alpha (opacity)

      Each component is a property, an unsigned integer in the range 
      [0, 255]. Thus, colors can be constructed and manipulated very 
      easily::

         c1 = sf.Color(255, 0, 0) # red
         c1.r = 0;                # make it black
         c1.b = 128;              # make it dark blue

      The fourth component of colors, named "alpha", represents the 
      opacity of the color. A color with an alpha value of 255 will be 
      fully opaque, while an alpha value of 0 will make a color fully 
      transparent, whatever the value of the other components.

      Colors can also be added and modulated (multiplied) using the 
      overloaded operators + and *. 

   .. py:attribute:: r
   
      Red component.

   .. py:attribute:: g
   
      Green component.
      
   .. py:attribute:: b
   
      Blue component.
      
   .. py:attribute:: a
   
      Alpha (opacity) component.
      
      The most common colors are already defined as static variables::

         black   = sf.Color.BLACK
         white   = sf.Color.WHITE
         red     = sf.Color.RED
         green   = sf.Color.GREEN
         blue    = sf.Color.BLUE
         yellow  = sf.Color.YELLOW
         magenta = sf.Color.MAGENTA
         cyan    = sf.Color.CYAN
   

.. py:class:: Matrix3(float a00, float a01, float a02,\
                   float a10, float a11, float a12,\
                   float a20, float a21, float a22)

   Note: this class overrides the multiplication operator.

   .. attribute:: IDENTITY

      Class attribute containing the identity matrix.

   .. classmethod:: projection(center, size, float rotation)
   .. classmethod:: transformation(origin, translation, float rotation, scale)

   .. method:: __str__()

      Return the content of the matrix in a human-readable format.

   .. method:: get_inverse()
   .. method:: transform()


.. py:class:: Image(int width, int height[, color])

   Class for loading, manipulating and saving images.

   sf.Image is an abstraction to manipulate images as bidimensional arrays of pixels.

   The class provides functions to load, read, write and save pixels, as well as many other useful functions.

   sf.Image can handle a unique internal representation of pixels, which is RGBA 32 bits. This means that a pixel must be composed of 8 bits red, green, blue and alpha channels -- just like a sf.Color. All the functions that return an array of pixels follow this rule, and all parameters that you pass to sf.Image functions (such as :meth:`load_from_pixels`) must use this representation as well.

   A sf.Image can be copied, but it is a heavy resource and if possible you should always use references to pass or return them to avoid useless copies.

   Usage example::

      # load an image file from a file
      try: background = sf.Image.load_from_file("background.jpg")
      except sf.Exception: exit(1)
      
      # create a 20x20 image filled with black color
      image = sf.Image()
      image.create(20, 20, sf.Color.BLACK)


      # copy image1 on image2 at position (10, 10)
      image.copy(background, 10, 10)

      # make the top-left pixel transparent
      sf.Color color = image[0, 0]
      color.alpha = 0
      image[0, 0] = color
       
      # save the image to a file
      try: image.save_to_file("result.png")

   .. py:classmethod:: load_from_file(filename)
   
      Load the image from a file on disk.
      
   .. py:classmethod:: load_from_memory(str mem)
   
      Load the image from a file in memory.
      
   .. py:classmethod:: load_from_pixels(int width, int height, str pixels)
   
      Create the image from an arry of pixels.
      
   .. py:method:: save_to_file(filename)
   
      Save the image to a file on disk.
      
   .. py:attribute:: width
   
      The width of the image.
         
   .. py:attribute:: height
   
      The height of the image.
         
   .. py:attribute:: size
   
      The size of the image.
         
   .. py:method:: create_mask_from_color(color, int alpha)
   
      Create a transparency mask from a specified color-key.
             
   .. py:method:: copy(Image source, int dest_x, int dest_y[, source_rect, apply_alpha])
   
      Copy pixels from another image onto this one.
      
   .. py:method:: __getitem__()

      Get a pixel from the image. Equivalent to :meth:`get_pixel()`. Example::

         print image[0,0]  # Create tuple implicitly
         print image[(0,0)]  # Create tuple explicitly

   .. py:method:: __setitem__()

      Set a pixel of the image. Equivalent to :meth:`set_pixel()`. Example::

         image[0,0] = sf.Color(10, 20, 30)  # Create tuple implicitly
         image[(0,0)] = sf.Color(10, 20, 30)  # Create tuple explicitly

   .. py:method:: get_pixel(int x, int y)
   .. py:method:: get_pixels()

   .. py:method:: set_pixel(int x, int y, color)
   .. py:method:: update_pixels(str pixels[, rect])


.. py:class:: Texture([int width[, int height]])

   This class has been recently introduced in SFML 2. It basically
   replaces the :class:`Image` class, except when you need to access
   or set pixels, which is only possible with Images.

   .. py:attribute:: MAXIMUM_SIZE
   .. py:attribute:: height   
   .. py:attribute:: smooth
   .. py:attribute:: width

   .. py:classmethod:: load_from_file(filename[, area])

      *area* can be either a tuple or an :class:`sf.IntRect`.

   .. py:classmethod:: load_from_image(image[, area])

      *area* can be either a tuple or an :class:`sf.IntRect`.

   .. py:classmethod:: load_from_memory(bytes data[, area])

      *area* can be either a tuple or an :class:`sf.IntRect`.

   .. py:method:: bind()
   .. py:method:: get_tex_coords(rect):

      *rect* can be either a tuple or an :class:`sf.IntRect`.

   .. py:method:: update(object source, int p1=-1, int p2=-1, int p3=-1, int p4=-1)

      This method can be called in three ways, to be consistent with
      the C++ method overloading::

          update(bytes pixels[, width, height, x, y])
          update(image[, x, y])
          update(window[, x, y])


.. py:class:: Drawable

      Abstract base class for objects that can be drawn to a render target.

      sf.Drawable defines the attributes and operations that are common to all the drawable classes:

      transformations (position, rotation, scale, local origin)
      global overlay color
      blending mode with background pixels
      the ability to be drawn on a sf.RenderTarget (either RenderWindow or RenderTexture)

      Please note that all these attributes are hardware accelerated, therefore they are extremely cheap to use (unlike older libraries that perform slow transformations on the CPU, such as rotation or scale).

      Usage example::

         # here we'll use a sf.Sprite to demonstrate the features of sf.Drawable
         drawable = sf.Sprite(texture)

         drawable.origin = (10, 20)         # set its origin to the local point (10, 20)
         drawable.position = (100, 100)     # set its position to (100, 100)
         drawable.rotation = 45             # set its orientation to 45 degrees
         drawable.color = sf.Color.RED      # set its global color to red
         drawable.blend_mode = sf.Blend.ADD # set an additive blend mode

         window.Draw(drawable); # finally draw it (window is a sf.RenderWindow)

      Deriving your own class from sf.Drawable is possible, however you have to use the sf.Renderer class instead of direct OpenGL calls, which is more limited. To create a derived drawable class, all you have to do is to override the virtual Render function.

      One of the main benefits of creating your own drawable class is that you can build hierarchies of drawable objects. Indeed, when you draw a drawable inside the Render function of another drawable, the former inherits the transformations and color of the latter and combines them with its own attributes. This way, you can apply global transformations/color to a set of drawables as if it was a single entity.

      Example::

         class MyDrawable: sf.Drawable
             def render(self, target, renderer):
                 # low-level geometry rendering
                 renderer.texture = texture
                 renderer.begin(sf.Renderer.QUADLIST)
                     renderer.add_vertex(...)
                     renderer.add_vertex(...)
                     renderer.add_vertex(...)
                     renderer.add_vertex(...)
                 renderer.end();
    
                 # high-level drawable rendering
                 target.draw(mySubSprite);


   .. py:attribute:: x
   
      The X position of the object.
      
   .. py:attribute:: y
   
      The Y position of the object. 
      
   .. py:attribute:: position
   
      The position of the object.
      
   .. py:attribute:: scale
   
      The scale factors of the object.
      
      The object returned by this property will behave, but it might
      be important in some cases to know that its exact type isn't
      tuple, although its class does inherit tuple. In practice it
      should behave just like a tuple, except if you write code that
      checks for exact type using the ``type()`` function. Instead,
      use ``isinstance()``::

         if isinstance(some_object, tuple):
             # We now know that some_object is a tuple

   .. py:attribute:: origin

      The local origin of the object.

   .. py:attribute:: rotation

      The orientation of the object.

   .. py:attribute:: color

      The global color of the object.

   .. py:attribute:: blend_mode

      The blending mode of the object.

   .. py:method:: move(float x, float y)

      Move the object by a given offset.

   .. py:method:: scale(float x, float y)
   
         Scale the object.

   .. py:method:: rotate(float angle)

         Rotate the object.

   .. py:method:: tranform_to_local(float x, float y)
   
         Transform a point in object local coordinates.

   .. py:method:: transform_to_global(float x, float y)

         Transform a local point in global coordinates.


.. py:class:: Shape()

   A convex, colored polygon with an optional outline.

   sf.Shape is a drawable class that allows to define and display a custom convex shape on a render target.

   It is important to keep in mind that shapes must always be convex, otherwise they may not be drawn correctly. Moreover, the points must be added in the right order; using a random order would also result in an incorrect shape.

   A shape is made of points that have their own individual attributes:

       * position (relative to the origin of the shape)
       * color
       * outline color

   Shapes have an outline that can be enabled or not. You can control the thickness of the outline with the SetOutlineThickness function.

   They also inherits all the functions from sf.Drawable: position, rotation, scale, origin, (global) color and blend_mode.

   Some static functions are provided to directly create common shapes such as lines, rectangles and circles::

      line      = sf.Shape.line(start, end, thickness, color)
      rectangle = sf.Shape.rectangle(rect, thickness)
      circle    = sf.Shape.circle(center, radius, color)

   A common mistake is to mix the individual points positions / colors and the global position / color of the shape. They are completely separate attributes that are combined when the shape is drawn (positions are added, colors are multiplied).::

      line = sf.Shape.line((100, 100), (200, 200), 10, sf.Color.RED);
      line.position # will return (0, 0), *not* (100, 100)
      line.color    # is white, *not* red

   So if you plan to change the position / color of your shape after it is created, you'd better create the points around the origin and with white color, and use only the global position / color (SetPosition, SetColor).

   Usage example::
   
      shape = sf.Shape() # create a shape

      # define its points
      shape.add_point((10, 10), sf.Color.WHITE, sf.Color.RED)
      shape.add_point((50, 10), sf.Color.WHITE, sf.Color.GREEN)
      shape.add_point((10, 50), sf.Color.WHITE, sf.Color.BLUE)

      # enable outline only
      shape.fill_enabled = False
      shape.outline_enabled = True
      shape.outline_thickness = 10

      #display it
      window.draw(shape); # window is a sf.RenderWindow

      # display static shapes
      window.draw(sf.Shape.line((0, 0), (10, 20), sf.Color.RED))
      window.draw(sf.Shape.rectangle((100, 1000, 50, 20), sf.Color.GREEN))
      window.draw(sf.Shape.circle((500, 500), 20, sf.Color.BLUE, 5, sf.Color.BLACK))

   .. py:method:: add_point(position[, color[, outline_color]])
   
      Add a new point to the shape. 
      
      The new point is inserted at the end of the shape.
      
      :param sf.Position position: 	Position of the point 
      :param sf.Color color: Color of the point 
      :param sf.Color outline_color: Outline color of the point 
      
   .. py:attribute:: points_count
   
   	The number of points composing the shape.
      
   .. py:attribute:: fill_enabled
   .. py:attribute:: outline_enabled
   .. py:attribute:: outline_thickness

   .. py:method:: set_point_position(int index, float x, float y)
   
      Change the position of a point.
      
   .. py:method:: set_point_color(int index, color)
   
      Change the color of a point.
      
   .. py:method:: set_point_outline_color(int index, color)
   
      Change the outline color of a point.
      
   .. py:method:: get_point_position(int index)

      Get the position of a point.

   .. py:method:: get_point_color(int index)

      Get the color of a point.

   .. py:method:: get_point_outline_color(int index)

      Get the outline color of a point.

   .. py:classmethod:: line(start, end, thickness, color[, outline=0[, outline_color=sf.Color.BLACK]])

      Create a new line.
      
      :param sf.Position start: Start point
      :param sf.Position end: End point
      :param integer thickness: 	Thickness of the line
      :param sf.Color color: Color of the shape's points
      :param integer outline: Outline thickness
      :param sf.Color outline_color: Outline color of the shape's points
      :rtype: sf.Shape
   
   .. py:classmethod:: rectangle(rectangle, color[, float outline=0[, outline_color=sf.Color.BLACK]])
   
      Create a new rectangular shape.

      :param sf.Rectangle rectangle: Rectangle defining the shape
      :param sf.Color color: Color of the shape's points
      :param integer outline: Outline thickness 
      :param sf.Color outline_color: Outline color of the shape's points
      :rtype: sf.Shape
      
   .. py:classmethod:: circle(center, radius, color[, outline=0[, outline_color=sf.Color.BLACK]])

      Create a new circular shape.
      
      :param sf.Position center: Center of the circle 
      :param integer radius: Radius of the circle 
      :param sf.Color color: 	Color of the shape's points 
      :param integer outline: Outline thickness 
      :param sf.Color outline_color: Outline color of the shape's points
      :rtype: sf.Shape
      

.. class:: Sprite([texture])

   .. attribute:: blend_mode
   .. attribute:: color
   .. attribute:: height
   .. attribute:: origin
   .. attribute:: position
   .. attribute:: rotation
   .. attribute:: the_scale
   .. attribute:: size
   .. attribute:: texture
   .. attribute:: width
   .. attribute:: x
   .. attribute:: y

   .. method:: __getitem__()

      Equivalent to :meth:`get_pixel()`.

   .. method:: get_sub_rect()

      .. warning::

         This method returns a copy of the rectangle, so code like
         this won't work::

             sprite.get_sub_rect().top = 10

   .. method:: flip_x(flipped)
   .. method:: flip_y(flipped)
   .. method:: move(float x, float y)
   .. method:: resize(float width, float height)
   .. method:: rotate(float angle)
   .. method:: scale(float x, float y)
   .. method:: set_sub_rect(rect)

      *rect* can be either a tuple or an :class:`IntRect`.

   .. method:: set_texture(image[, adjust_to_new_size=False])
   .. method:: transform_to_global(float x, float y)
   .. method:: transform_to_local(float x, float y)


.. class:: Shader

   The constructor will raise ``NotImplementedError`` if called.  Use
   class methods like :meth:`load_from_file()` or :meth:`load_from_memory()`
   instead.

   .. classmethod:: load_from_file(filename)
   .. classmethod:: load_from_memory(str shader)

   .. method:: bind()

   .. method:: set_parameter(str name, float x[, float y, float z, float w])

      After *name*, you can pass as many parameters as four, depending
      on your need.

   .. method:: set_texture(str name)
   .. method:: set_current_texture(str name)
   .. method:: unbind()
   

.. py:class:: RenderTarget()

   Base class for all render targets (window, texture, ...)

   sf.RenderTarget defines the common behaviour of all the 2D render targets usable in the graphics module.

   It makes it possible to draw 2D entities like sprites, shapes, text without using any OpenGL command directly.

   A sf.RenderTarget is also able to use views (sf.View), which are a kind of 2D cameras. With views you can globally scroll, rotate or zoom everything that is drawn, without having to transform every single entity. See the documentation of sf::View for more details and sample pieces of code about this class.

   .. py:method:: clear([color=sf.Color.BLACK])
   
   Clear the entire target with a single color.

   This function is usually called once every frame, to clear the previous contents of the target.
   
   .. py:method:: draw(object[, shader])
      
   Draw an object into the target with an optional shader.

   This function draws anything that inherits from the sf.Drawable base class (sf.Sprite, sf.Shape, sf.Text, or even your own derived classes). The shader alters the way that the pixels are processed right before being written to the render target.
   

.. py:class:: RenderWindow(VideoMode mode, title[, style[, ContextSettings settings]])

   .. attribute:: active
   .. attribute:: cursor_position
   .. attribute:: default_view
   .. attribute:: framerate_limit
   .. attribute:: frame_time
   .. attribute:: height
   .. attribute:: joystick_threshold
   .. attribute:: key_repeat_enabled
   .. attribute:: opened
   .. attribute:: position
   .. attribute:: settings
   .. attribute:: show_mouse_cursor
   .. attribute:: size
   .. attribute:: system_handle

      Return the system handle as a long (or int on Python 3). Windows
      and Mac users will probably need to cast this as another type
      suitable for their system's API. Please contact me and show me
      your use case so that I can make the API more user-friendly.

   .. attribute:: title
   .. attribute:: vertical_sync_enabled
   .. attribute:: view
   .. attribute:: width

   .. classmethod:: from_window_handle(long window_handle[, ContextSettings settings])

      Equivalent to this C++ constructor::

         RenderWindow(WindowHandle, ContextSettings=ContextSettings())

   .. method:: clear([color])
   .. method:: close()
   .. method:: convert_coords(x, y[, view])
   .. method:: create(VideoMode mode, title[, int style[, ContextSettings settings]])
   .. method:: display()
   .. method:: draw()
   .. method:: get_input()
   .. method:: get_viewport(view)
   .. method:: poll_event()
   .. method:: restore_gl_states()
   .. method:: save_gl_states()
   .. method:: set_icon(int width, int height, str pixels)
   .. method:: show(show)
   .. method:: wait_event()


.. class:: RenderTexture(int width, int height[, bool depth=False])

   .. attribute:: active
   .. attribute:: default_view
   .. attribute:: height
   .. attribute:: texture
   .. attribute:: smooth
   .. attribute:: view
   .. attribute:: width
    
   .. method:: clear([color])
   .. method:: convert_coords(int x, int y[, view])
   .. method:: create(int width, int height[, bool depth=False])
   .. method:: display()
   .. method:: draw(drawable[, shader])
   .. method:: get_viewport(view)
   .. method:: restore_gl_states()
   .. method:: save_gl_states()


.. class:: ContextSettings(int depth=24, int stencil=8, int antialiasing=0, int major=2, int minor=0)

   Structure defining the settings of the OpenGL context attached to a window.

   ContextSettings allows to define several advanced settings of the OpenGL context attached to a window.

   All these settings have no impact on the regular SFML rendering (graphics module) -- except the anti-aliasing level, so you may need to use this structure only if you're using SFML as a windowing system for custom OpenGL rendering.

   The depth_bits and stencil_bits properties define the number of bits per pixel requested for the (respectively) depth and stencil buffers.

   antialiasing_level represents the requested number of multisampling levels for anti-aliasing.

   major_version and minor_version define the version of the OpenGL context that you want. Only versions greater or equal to 3.0 are relevant; versions lesser than 3.0 are all handled the same way (i.e. you can use any version < 3.0 if you don't want an OpenGL 3 context).

   Please note that these values are only a hint. No failure will be reported if one or more of these values are not supported by the system; instead, SFML will try to find the closest valid match. You can then retrieve the settings that the window actually used to create its context, with sf.Window.settings.


   .. attribute:: depth_bits
   
      Bits of the depth buffer.
      
   .. attribute:: stencil_bits
   
      Bits of the stencil buffer.  
      
   .. attribute:: antialiasing_level
   
      Level of antialiasing.
          
   .. attribute:: major_version
   
      Major number of the context version to create.
      
   .. attribute:: minor_version
   
      Minor number of the context version to create.
   

.. py:class:: VideoMode([width, height, bits_per_pixel=32])

   sf.VideoMode defines a video mode (width, height, bpp)

   A video mode is defined by a width and a height (in pixels) and a depth (in bits per pixel).

   Video modes are used to setup windows (sf.Window) at creation time.

   The main usage of video modes is for fullscreen mode: indeed you must use one of the valid video modes allowed by the OS (which are defined by what the monitor and the graphics card support), otherwise your window creation will just fail.

   sf.VideoMode provides a static function for retrieving the list of all the video modes supported by the system: get_fullscreen_modes().

   A custom video mode can also be checked directly for fullscreen compatibility with its is_valid() function.

   Additionnally, sf.VideoMode provides a static function to get the mode currently used by the desktop: get_desktop_mode(). This allows to build windows with the same size or pixel depth as the current resolution.

   Usage example::

      # display the list of all the video modes available for fullscreen
      for i, mode in enumerate(sf.VideoMode.get_fullscreen_modes()):
          print("Mode #{0}: {1}x{2} - {3} bpp".format(i, mode.width, mode.height, mode.bits_per_pixel))

      # create a window with the same pixel depth as the desktop
      desktop = sf.VideoMode.get_desktop_mode()
      window.create(sf.VideoMode(1024, 768, desktop.bits_per_pixel), "SFML window")

   .. py:attribute:: width
   
   	Video mode width, in pixels.
      
   .. py:attribute:: height
   
      Video mode height, in pixels.
      
   .. py:attribute:: bits_per_pixel
   
      Video mode pixel depth, in bits per pixels.

   .. py:classmethod:: get_desktop_mode()
   
      Get the current desktop video mode. 
   
   .. py:classmethod:: get_fullscreen_modes()
         
      Retrieve all the video modes supported in fullscreen mode.

      When creating a fullscreen window, the video mode is restricted to be compatible with what the graphics driver and monitor support. This function returns the complete list of all video modes that can be used in fullscreen mode. The returned array is sorted from best to worst, so that the first element will always give the best mode (higher width, height and bits-per-pixel).

   .. py:method:: is_valid()

      Tell whether or not the video mode is valid.

      The validity of video modes is only relevant when using fullscreen windows; otherwise any video mode can be used with no restriction.


.. class:: View( )

   2D camera that defines what region is shown on screen

   sf.View defines a camera in the 2D scene.

   This is a very powerful concept: you can scroll, rotate or zoom the entire scene without altering the way that your drawable objects are drawn.

   A view is composed of a source rectangle, which defines what part of the 2D scene is shown, and a target viewport, which defines where the contents of the source rectangle will be displayed on the render target (window or texture).

   The viewport allows to map the scene to a custom part of the render target, and can be used for split-screen or for displaying a minimap, for example. If the source rectangle has not the same size as the viewport, its contents will be stretched to fit in.

   To apply a view, you have to assign it to the render target. Then, every objects drawn in this render target will be affected by the view until you use another view.

   Usage example::

      window = sf.RenderWindow()
      view = sf.View()

      # initialize the view to a rectangle located at (100, 100) and with a size of 400x200
      view.reset(sf.Rectangle(100, 100, 400, 200))

      # rotate it by 45 degrees
      view.rotate(45)

      # set its target viewport to be half of the window and apply it
      view.viewport = sf.Rectangle(0, 0, 0.5, 1) # or a tuple (0, 0, 0.5, 1)
      window.view = view

      # render stuff
      window.draw(some_sprite);

      # set the default view back
      window.view = window.default_view

      # render stuff not affected by the view
      window.draw(some_text);

   .. attribute:: center
   
      The center of the view.
      
   .. attribute:: size
   
      The size of the view.
      
   .. attribute:: rotation
   
      The orientation of the view.
      
   .. attribute:: viewport 
   
      The target viewport.

      The viewport is the rectangle into which the contents of the view are displayed, expressed as a factor (between 0 and 1) of the size of the RenderTarget to which the view is applied. For example, a view which takes the left side of the target would be defined with view.viewport = (0, 0, 0.5, 1). By default, a view has a viewport which covers the entire target.
      
   .. method:: reset()
   
      Reset the view to the given rectangle.

      Note that this function resets the rotation angle to 0
      
   .. method:: move(offset)
         
      Move the view relatively to its current position. 
      
   .. method:: rotate((float angle)
   
      Rotate the view relatively to its current orientation.
      
   .. method:: zoom(float factor)
   
      Resize the view rectangle relatively to its current size.

      Resizing the view simulates a zoom, as the zone displayed on screen grows or shrinks. factor is a multiplier:

          1 keeps the size unchanged
          > 1 makes the view bigger (objects appear smaller)
          < 1 makes the view smaller (objects appear bigger)

   .. classmethod:: from_center_and_size(center, size)

      *center* and *size* can be either tuples or :class:`Vector2f`.

   .. classmethod:: from_rect(rect)

   .. attribute:: width
   .. attribute:: height
   

.. class:: Font()

   .. attribute:: DEFAULT_FONT

      The default font (Arial), as a class attribute::

         print sf.Font.DEFAULT_FONT


   .. classmethod:: load_from_file(filename)
   .. classmethod:: load_from_memory(str data)

   .. method:: get_glyph(int code_point, int character_size, bool bold)
   .. method:: get_texture(int character_size)
   .. method:: get_kerning(int first, int second, int character_size)
   .. method:: get_line_spacing(int character_size)



.. class:: Text([string, font, character_size=0])

   Graphical text that can be drawn to a render target.

   sf.Text is a drawable class that allows to easily display some text with custom style and color on a render target.

   It inherits all the functions from sf.Drawable: position, rotation, scale, origin, (global) color and blend mode. It also adds text-specific properties such as the font to use, the character size, the font style (bold, italic, underlined), and the text to display of course. It also provides convenience functions to calculate the graphical size of the text, or to get the visual position of a given character.

   sf.Text works in combination with the sf.Font class, which loads and provides the glyphs (visual characters) of a given font.

   The separation of sf.Font and sf.Text allows more flexibility and better performances: indeed a sf.Font is a heavy resource, and any operation on it is slow (often too slow for real-time applications). On the other side, a sf::Text is a lightweight object which can combine the glyphs data and metrics of a sf.Font to display any text on a render target.

   It is important to note that the sf.Text instance doesn't copy the font that it uses, it only keeps a reference to it. Thus, a sf.Font must not be destructed while it is used by a sf.Text (i.e. never write a function that uses a local sf.Font instance for creating a text).

   Usage example::

      # declare and load a font
      font = sf.Font()
      font.load_from_file("arial.tff")

      # create a text
      text = sf.Text("hello")
      text.font = font
      text.character_size = 30
      text.style = sf.Text.REGULAR

      # display it
      window.draw(text); // window is a sf.RenderWindow

   .. attribute:: string
   
      The text's string.
      
   .. attribute:: font
         
      Set the text's font.

      Texts have a valid font by default, which the built-in Font.DEFAULT_FONT.
      
   .. attribute:: character_size
         
      The character size.

      The default size is 30.
      
   .. attribute:: style

      Can be one or more of the following:

      * ``sf.Text.REGULAR``
      * ``sf.Text.BOLD``
      * ``sf.Text.ITALIC``
      * ``sf.Text.UNDERLINED``

      Example::
      
         text.style = sf.Text.BOLD | sf.Text.ITALIC 
         
   .. attribute:: rect

      The bounding rectangle of the text.

      The returned rectangle is in global coordinates.
      

.. class:: Glyph

   Structure describing a glyph.

   A glyph is the visual representation of a character.

   The sf.Glyph structure provides the information needed to handle the glyph:

       * its coordinates in the font's texture
       * its bounding rect
       * the offset to apply to get the starting position of the next glyph
       
   .. attribute:: advance

      Offset to move horizontically to the next character.

   .. attribute:: bounds

      Bounding rectangle of the glyph, in coordinates relative to the baseline.
   
   .. attribute:: sub_rect
   
      Texture coordinates of the glyph inside the font's texture.
