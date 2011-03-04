Graphics
========

.. module:: sf


.. class:: Color(int r, int g, int b[, int a=255])

   Note: this class overrides comparison operators.

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
   .. attribute:: scale
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



.. class:: RenderWindow(VideoMode mode, title[, style])

   *style* can be one of:

   =================== ===========
   Name                Description
   =================== ===========
   sf.Style.NONE
   sf.Style.TITLEEBAR
   sf.Style.RESIZE
   sf.Style.CLOSE
   sf.Style.FULLSCREEN
   =================== ===========

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
   .. method:: display()
   .. method:: draw()
   .. method:: get_input()
   .. method:: get_viewport(view)
   .. method:: iter_events()

      Return an iterator which yields the current pending events. Example::
        
         for event in window.iter_events():
             if event.type == sf.Event.CLOSED:
                 # ...

   .. method:: restore_gl_states()
   .. method:: save_gl_states()
   .. method:: set_icon(int width, int height, str pixels)
   .. method:: show(show)
   .. method:: wait_event()



.. class:: VideoMode([width, height, bits_per_pixel=32])

   Note: this class overrides the comparison operators.

   .. attribute:: width
   .. attribute:: height
   .. attribute:: bits_per_pixel

   .. classmethod:: get_desktop_mode()
   .. classmethod:: get_fullscreen_modes()

   .. method:: is_valid()
