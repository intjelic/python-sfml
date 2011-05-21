Graphics
========

.. module:: sf



Misc
----


.. class:: Color(int r, int g, int b[, int a=255])

   Note: this class overrides some comparison and arithmetic operators in the
   same way that the C++ class does..

   The following colors are available as static attibutes, e.g. you can use
   ``sf.Color.WHITE`` to obtain a reference to the white color.

    * BLACK
    * WHITE
    * RED
    * GREEN
    * BLUE
    * YELLOW
    * MAGENTA
    * CYAN

   .. attribute:: r
   .. attribute:: g
   .. attribute:: b
   .. attribute:: a




.. class:: Drawable

   Base class for classes like :class:`Sprite` or :class:`Text`. Creating your
   own drawables by deriving this class currently isn't supported, so you
   shouldn't need to directly interact with it.

   .. attribute:: blend_mode
   .. attribute:: color
   .. attribute:: origin
   .. attribute:: position
   .. attribute:: rotation
   .. attribute:: scale

      The object returned by this property will behave, but it might
      be important in some cases to know that its exact type isn't
      tuple, although its class does inherit tuple. In practice it
      should behave just like a tuple, except if you write code that
      checks for exact type using the ``type()`` function. Instead,
      use ``isinstance()``::

        if isinstance(some_object, tuple):
            # We now know that some_object is a tuple

   .. attribute:: x
   .. attribute:: y

   .. method:: tranform_to_local(float x, float y)
   .. method:: transform_to_global(float x, float y)
   .. method:: move(float x, float y)
   .. method:: rotate(float angle)
   .. method:: scale(float x, float y)



.. class:: Matrix3(float a00, float a01, float a02,\
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







Image display and effects
-------------------------



.. class:: Shape


   .. attribute:: blend_mode
   .. attribute:: color
   .. attribute:: fill_enabled
   .. attribute:: origin
   .. attribute:: outline_enabled
   .. attribute:: outline_thickness
   .. attribute:: points_count
   .. attribute:: position
   .. attribute:: rotation
   .. attribute:: the_scale
   .. attribute:: x
   .. attribute:: y

   .. classmethod:: line(float p1x, float p1y, float p2x, float p2y,\
                         float thickness, color\
                         [, float outline=0.0[, outline_color]])
   .. classmethod:: rectangle(float left, float top, float width,\
                              float height, color\
                              [, float outline=0.0[, outline_color]])
   .. classmethod:: circle(float x, float y, float radius, color\
                           [, float outline=0.0[, outline_color]])

   .. method:: add_point(float x, float y[, color[, outline_color]])
   .. method:: get_point_color(int index)
   .. method:: get_point_outline_color(int index)
   .. method:: get_point_position(int index)
   .. method:: move(float x, float y)
   .. method:: rotate(float angle)
   .. method:: scale(float x, float y)
   .. method:: set_point_color(int index, color)
   .. method:: set_point_outline_color(int index, color)
   .. method:: set_point_position(int index, float x, float y)
   .. method:: tranform_to_local(float x, float y)
   .. method:: transform_to_global(float x, float y)




.. class:: Image(int width, int height[, color])

   .. attribute:: height
   .. attribute:: smooth
   .. attribute:: width

   .. classmethod:: get_maxmimum_size()
   .. classmethod:: load_from_file(filename)
   .. classmethod:: load_from_screen(window[, source_rect])
   .. classmethod:: load_from_memory(str mem)
   .. classmethod:: load_from_pixels(int width, int height, str pixels)

   .. method:: __getitem__()

      Get a pixel from the image. Equivalent to :meth:`get_pixel()`. Example::

         print image[0,0]  # Create tuple implicitly
         print image[(0,0)]  # Create tuple explicitly

   .. method:: __setitem__()

      Set a pixel of the image. Equivalent to :meth:`set_pixel()`. Example::

         image[0,0] = sf.Color(10, 20, 30)  # Create tuple implicitly
         image[(0,0)] = sf.Color(10, 20, 30)  # Create tuple explicitly

   .. method:: bind()
   .. method:: copy(Image source, int dest_x, int dest_y\
                    [, source_rect, apply_alpha])
   .. method:: create_mask_from_color(color, int alpha)
   .. method:: get_pixel(int x, int y)
   .. method:: get_pixels()
   .. method:: get_tex_coords(rect)
   .. method:: save_to_file(filename)
   .. method:: set_pixel(int x, int y, color)
   .. method:: update_pixels(str pixels[, rect])



.. class:: Sprite([image, position=(0,0), scale=(1,1), rotation=0.0,\
                  color=sf.Color.WHITE])

   .. attribute:: blend_mode
   .. attribute:: color
   .. attribute:: height
   .. attribute:: image
   .. attribute:: origin
   .. attribute:: position
   .. attribute:: rotation
   .. attribute:: the_scale
   .. attribute:: size
   .. attribute:: sub_rect
   .. attribute:: width
   .. attribute:: x
   .. attribute:: y

   .. method:: __getitem__()

      Equivalent to :meth:`get_pixel()`.

   .. method:: get_pixel(int x, int y)
   .. method:: flip_x(flipped)
   .. method:: flip_y(flipped)
   .. method:: move(float x, float y)
   .. method:: resize(float width, float height)
   .. method:: rotate(float angle)
   .. method:: scale(float x, float y)
   .. method:: set_image(image[, adjust_to_new_size=False])
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




.. class:: RenderImage(int width, int height[, bool depth=False])

   .. attribute:: active
   .. attribute:: default_view
   .. attribute:: height
   .. attribute:: image
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





Windowing
---------


.. class:: RenderWindow(VideoMode mode, title\
                        [, style[, ContextSettings settings]])

   *style* can be one of:

   ======================= ===========
   Name                    Description
   ======================= ===========
   ``sf.Style.NONE``
   ``sf.Style.TITLEEBAR``
   ``sf.Style.RESIZE``
   ``sf.Style.CLOSE``
   ``sf.Style.FULLSCREEN``
   ======================= ===========

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
   .. attribute:: title
   .. attribute:: view
   .. attribute:: width

   .. method:: clear([color])
   .. method:: close()
   .. method:: convert_coords(x, y[, view])
   .. method:: create(VideoMode mode, title\
                      [, int style[, ContextSettings settings]])
   .. method:: display()
   .. method:: draw()
   .. method:: get_input()
   .. method:: get_viewport(view)
   .. method:: iter_events()

      Return an iterator which yields the current pending events. Example::
        
         for event in window.iter_events():
             if event.type == sf.Event.CLOSED:
                 # ...

   .. method:: poll_event()
   .. method:: restore_gl_states()
   .. method:: save_gl_states()
   .. method:: set_icon(int width, int height, str pixels)
   .. method:: show(show)
   .. method:: wait_event()




.. class:: ContextSettings(int depth=24, int stencil=8, int antialiasing=0,\
                           int major=2, int minor=0)

   .. attribute:: antialiasing_level
   .. attribute:: depth_bits
   .. attribute:: major_version
   .. attribute:: minor_version
   .. attribute:: stencil_bits



.. class:: VideoMode([width, height, bits_per_pixel=32])

   Note: this class overrides the comparison operators.

   .. attribute:: width
   .. attribute:: height
   .. attribute:: bits_per_pixel

   .. classmethod:: get_desktop_mode()
   .. classmethod:: get_fullscreen_modes()

   .. method:: is_valid()



.. class:: View( )



   .. attribute:: center
   .. attribute:: height
   .. attribute:: rotation
   .. attribute:: size
   .. attribute:: viewport
   .. attribute:: width

   .. classmethod:: from_rect(rect)
   .. classmethod:: from_rect_and_size(rect, (width, height))

   .. method:: move
   .. method:: reset
   .. method:: rotate
   .. method:: zoom





Text
----


.. class:: Font()

   .. attribute:: DEFAULT_FONT

      The default font (Arial), as a class attribute::

         print sf.Font.DEFAULT_FONT


   .. classmethod:: load_from_file(filename)
   .. classmethod:: load_from_memory(str data)

   .. method:: get_glyph(int code_point, int character_size, bool bold)
   .. method:: get_image(int character_size)
   .. method:: get_kerning(int first, int second, int character_size)
   .. method:: get_line_spacing(int character_size)



.. class:: Text([string, font, character_size=0])

   *string* can be either a regular string or Unicode. SFML will
   internally store characters as 32-bit integers. A ``str`` object
   will end up being interpreted by SFML as an "ANSI string" (cp1252
   encoding). A ``unicode`` object will be interpreted as 32-bit code
   points, as you would expect.

   .. attribute:: blend_mode
   .. attribute:: color
   .. attribute:: character_size
   .. attribute:: font
   .. attribute:: origin
   .. attribute:: position
   .. attribute:: rect
   .. attribute:: rotation
   .. attribute:: the_scale
   .. attribute:: string
   .. attribute:: x
   .. attribute:: y

      This attribute can be set as either a ``str`` or ``unicode``
      object. The value retrieved will be either ``str`` or
      ``unicode`` as well, depending on what type has been set
      before. See :class:`Text` for more information.

   .. attribute:: style

      Can be one or more of the following:

      * ``sf.Text.REGULAR``
      * ``sf.Text.BOLD``
      * ``sf.Text.ITALIC``
      * ``sf.Text.UNDERLINED``

      Example::

         text.style = sf.Text.BOLD | sf.Text.ITALIC

   .. method:: tranform_to_local(float x, float y)
   .. method:: transform_to_global(float x, float y)
   .. method:: move(float x, float y)
   .. method:: rotate(float angle)
   .. method:: scale(float x, float y)



.. class:: Glyph

   .. attribute:: advance
   .. attribute:: bounds
   .. attribute:: sub_rect
