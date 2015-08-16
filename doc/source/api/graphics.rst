Graphics
========
.. module:: sfml.graphics
.. contents:: :local:


PrimitiveType
^^^^^^^^^^^^^

.. py:class:: PrimitiveType

   Empty class that defines some constants. The are the types of
   primitives that an :class:`VertexArray` can render.

   :const:`POINTS` and :class:`LINES` have no area, therefore their
   thickness will always be 1 pixel, regardless of the current transform
   and view.

   .. py:data:: POINTS

      List of individual points.

   .. py:data:: LINES

      List of individual lines.

   .. py:data:: LINES_STRIP

      List of connected lines, a point uses the previous point to form a line.

   .. py:data:: TRIANGLES

      List of individual triangles.

   .. py:data:: TRIANGLES_STRIP

      List of connected triangles, a point uses the two previous points to form a triangle.

   .. py:data:: TRIANGLES_FAN

      List of connected triangles, a point uses the common center and the previous point to form a triangle.

   .. py:data:: QUADS

      List of individual quads.


Rect
^^^^

.. class:: Rect

   Utility class for manipulating 2D axis aligned rectangles.

   A rectangle is defined by its top-left corner and its size.

   It is a very simple class defined for convenience, so its member
   variables (left, top, width and height) are public and can be
   accessed directly via attributes, just like :class:`.Vector2`.

   Unlike SFML, :class:`Rect` does define functions to emulate
   the properties that are not directly members (such as right, bottom,
   center, etc.).

   :class:`Rect` uses the usual rules for its boundaries:

      * The left and top edges are included in the rectangle's area
      * The right (left + width) and bottom (top + height) edges are excluded from the rectangle's area

   This means that (0, 0, 1, 1) and (1, 1, 1, 1) don't intersect.

   Usage example::

      # define a rectangle, located at (0, 0) with a size of 20x5
      r1 = sf.Rect(sf.Vector2(0, 0), sf.Vector2(20, 5))
      # or r1 = sf.Rect((0, 0), (20, 5))

      # define another rectangle, located at (4, 2) with a size of 18x10
      position = sf.Vector2(4, 2)
      size = sf.Vector2(18, 10)

      r2 = sf.Rect(position, size)

      # test intersections with the point (3, 1)
      b1 = r1.contains(sf.Vector2(3, 1)) # True
      b2 = r2.contains((3, 1)) # False

      # test the intersection between r1 and r2
      result = r1.intersects(r2) # True

      # as there's an intersection, the result is not None but (4, 2, 16, 3)
      assert result == sf.Rect((4, 2), (16, 3))

   .. method:: Rect(position=(0, 0), size=(0, 0))

      Construct an :class:`sfml.graphics.Rect`

   .. attribute:: position

      Top-left coordinate of the rectangle.

   .. attribute:: size

      Position of the rectangle.

   .. attribute:: left

      Left coordinate of the rectangle. This attribute is provided as a
      shortcut to sfml.graphics.Rect.position.x

   .. attribute:: top

      Top coordinate of the rectangle. This attribute is provided as a
      shortcut to sfml.graphics.Rect.position.y

   .. attribute:: width

      Width of the rectangle. This attribute is provided as a
      shortcut to sfml.graphics.Rect.size.width

   .. attribute:: height

      Height of the rectangle. This attribute is provided as a
      shortcut to sfml.graphics.Rect.position.height

   .. attribute:: center

      The center of the rectangle.

   .. attribute:: right

      The right coordinate of the rectangle.

   .. attribute:: bottom

      The bottom coordinate of the rectangle.

   .. method:: contains(point)

      Check if a point is inside the rectangle's area.

      :param sfml.system.Vector2 point: Point to test
      :rtype: bool

   .. method:: intersects(rectangle)

      Check the intersection between two rectangles.

      This overload returns the overlapped rectangle if an intersection
      is found.

      :param sfml.graphics.Rect rectangle: Rectangle to test
      :return: Rectangle filled with the intersection or None
      :rtype: :class:`sfml.graphics.Rect` or None


Color
^^^^^

.. py:class:: Color

      Utility class for manipulating RGBA colors.

      :class:`Color` is a simple color class composed of 4
      components:

         * Red,
         * Green
         * Blue
         * Alpha (opacity)

      Each component is a property, an unsigned integer in the range
      [0, 255]. Thus, colors can be constructed and manipulated very
      easily::

         c1 = sf.Color(255, 0, 0) # red
         c1.r = 0                 # make it black
         c1.b = 128               # make it dark blue

      The fourth component of colors, named "alpha", represents the
      opacity of the color. A color with an alpha value of 255 will be
      fully opaque, while an alpha value of 0 will make a color fully
      transparent, whatever the value of the other components is.

      The most common colors are already defined. ::

         black       = sf.Color.BLACK
         white       = sf.Color.WHITE
         red         = sf.Color.RED
         green       = sf.Color.GREEN
         blue        = sf.Color.BLUE
         yellow      = sf.Color.YELLOW
         magenta     = sf.Color.MAGENTA
         cyan        = sf.Color.CYAN
         transparent = sf.Color.TRANSPARENT

      Colors can also be added and modulated (multiplied) using the
      overloaded operators + and \*.

   .. py:method:: Color([r=0[, g=0[, b=0[, a=255]]]])

      Construct the color from its 4 RGBA components.

      :param integer r: Red component (in the range [0, 255])
      :param integer g: Green component (in the range [0, 255])
      :param integer b: Blue component (in the range [0, 255])
      :param integer a: Alpha (opacity) component (in the range [0, 255])

   .. py:data:: BLACK

      Black predefined color.

   .. py:data:: WHITE

      White predefined color.

   .. py:data:: RED

      Red predefined color.

   .. py:data:: GREEN

      Green predefined color.

   .. py:data:: BLUE

      Blue predefined color.

   .. py:data:: YELLOW

      Yellow predefined color.

   .. py:data:: MAGENTA

      Magenta predefined color.

   .. py:data:: CYAN

      Cyan predefined color.

   .. py:data:: TRANSPARENT

      Transparent (black) predefined color.

   .. py:attribute:: r

      Red component.

   .. py:attribute:: g

      Green component.

   .. py:attribute:: b

      Blue component.

   .. py:attribute:: a

      Alpha (opacity) component.

Transform
^^^^^^^^^

.. py:class:: Transform

   Define a 3x3 transform matrix.

   A :class:`Transform` specifies how to translate, rotate, scale,
   shear, project, whatever things.

   In mathematical terms, it defines how to transform a coordinate
   system into another.

   For example, if you apply a rotation transform to a sprite, the
   result will be a rotated sprite. And anything that is transformed
   by this rotation transform will be rotated the same way, according
   to its initial position.

   Transforms are typically used for drawing. But they can also be
   used for any computation that requires to transform points between
   the local and global coordinate systems of an entity (like
   collision detection).

   Usage example::

      # define a translation transform
      translation = sf.Transform()
      translation.translate((20, 50))

      # define a rotation transform
      rotation = sf.Transform()
      rotation.rotate(45)

      # combine them
      transform = translation * rotation

      # use the result to transform stuff...
      point = transform.transform_point((10, 20))
      rectangle = transform.transform_rectangle(sf.Rect((0, 0), (10, 100)))

   .. py:classmethod:: from_values(a00, a01, a02, a10, a11, a12, a20, a21, a22)

      Construct a transform from a 3x3 matrix

      :param float a00: Element (0, 0) of the matrix
      :param float a01: Element (0, 1) of the matrix
      :param float a02: Element (0, 2) of the matrix
      :param float a10: Element (1, 0) of the matrix
      :param float a11: Element (1, 1) of the matrix
      :param float a12: Element (1, 2) of the matrix
      :param float a20: Element (2, 0) of the matrix
      :param float a21: Element (2, 1) of the matrix
      :param float a22: Element (2, 2) of the matrix
      :rtype: :class:`sfml.graphics.Transform`

   .. py:attribute:: matrix

      Return the transform as a 4x4 matrix.

      This function returns a pointer to an array of 16 floats
      containing the transform elements as a 4x4 matrix, which is
      directly compatible with OpenGL functions.

      :type: long

   .. py:attribute:: inverse

      Return the inverse of the transform.

      If the inverse cannot be computed, an identity transform is
      returned.

      :type: :class:`sfml.graphics.Transform`

   .. py:method:: transform_point(point)

      Transform a 2D point.

      :param point: Point to transform
      :type point: :class:`sfml.system.Vector2` or tuple
      :return: Transformed point
      :rtype: :class:`sfml.system.Vector2`

   .. py:method:: transform_rectangle(rectangle)

      Transform a rectangle.

      Since SFML doesn't provide support for oriented rectangles, the
      result of this function is always an axis-aligned rectangle.
      Which means that if the transform contains a rotation, the
      bounding rectangle of the transformed rectangle is returned.

      :param rectangle: Rectangle to transform
      :type rectangle: :class:`sfml.graphics.Rect` or tuple
      :return: Transformed rectangle
      :rtype: :class:`sfml.graphics.Rect`

   .. py:method:: combine(transform)

      Combine the current transform with another one.

      The result is a transform that is equivalent to applying this
      followed by transform. Mathematically, it is equivalent to a
      matrix multiplication.

      This function returns a reference *self*, so that calls can be
      chained.

      :param sfml.graphics.Rect transform: Transform to combine with this transform
      :return: Return itself
      :rtype: :class:`sfml.graphics.Transform`

   .. py:method:: translate(offset)

      Combine the current transform with a translation.

      This function returns a reference to *self*, so that calls can be
      chained. ::

         transform = sf.Transform()
         transform.translate(sf.Vector2(100, 200)).rotate(45)

      :param offset: Translation offset to apply
      :type offset: :class:`sfml.system.Vector2` or tuple
      :return: Return itself
      :rtype: :class:`sfml.graphics.Transform`

   .. py:method:: rotate(angle[, center])

      Combine the current transform with a rotation.

      The center of rotation is provided for convenience as a second
      argument, so that you can build rotations around arbitrary points
      more easily (and efficiently) than the usual
      translate(-center).rotate(angle).translate(center).

      This function returns a reference to *self*, so that calls can be
      chained. ::

         transform = sf.Transform()
         transform.rotate(90, (8, 3)).translate((50, 20))

      :param float angle: Rotation angle, in degrees
      :param center: Center of rotation
      :type center: :class:`sfml.system.Vector2` or tuple
      :return: Return itself
      :rtype: :class:`sfml.graphics.Transform`

   .. py:method:: scale(factor[, center])

      Combine the current transform with a scaling.

      The center of scaling is provided for convenience as a second
      argument, so that you can build scaling around arbitrary points
      more easily (and efficiently) than the usual
      translate(-center).scale(factors).translate(center).

      This function returns a reference to *self*, so that calls can be
      chained. ::

         transform = sf.Transform()
         transform.scale((2, 1), (8, 3)).rotate(45)

      :param factor: Scaling factors
      :type factor: :class:`sfml.system.Vector2` or tuple
      :param center: Center of scaling
      :type center: :class:`sfml.system.Vector2` or tuple
      :return: Return itself
      :rtype: :class:`sfml.graphics.Transform`

BlendMode
^^^^^^^^^

.. py:class:: BlendMode

   :class:`BlendMode` is a class that represents a blend mode. A blend mode
   determines how the colors of an object you draw are mixed with the colors
   that are already in the buffer.

   The class is composed of 6 components, each of which has its own public
   member variable:

      * Color Source Factor (:attr:`color_src_factor`)
      * Color Destination Factor (:attr:`color_dst_factor`)
      * Color Blend Equation (:attr:`color_equation`)
      * Alpha Source Factor (:attr:`alpha_src_factor`)
      * Alpha Destination Factor (:attr:`alpha_dst_factor`)
      * Alpha Blend Equation (:attr:`alpha_equation`)

   The source factor specifies how the pixel you are drawing contributes to the
   final color. The destination factor specifies how the pixel already drawn in
   the buffer contributes to the final color.

   The color channels RGB (red, green, blue; simply referred to as color) and A
   (alpha; the transparency) can be treated separately. This separation can be
   useful for specific blend modes, but most often you won't need it and will
   simply treat the color as a single unit.

   The blend factors and equations correspond to their OpenGL equivalents. In
   general, the color of the resulting pixel is calculated according to the
   following formula `src` is the color of the source pixel, `dst` the color of
   the destination pixel, the other variables correspond to the public members,
   with the equations being + or - operators)::

      dst.rgb = colorSrcFactor * src.rgb (colorEquation) colorDstFactor * dst.rgb
      dst.a   = alphaSrcFactor * src.a   (alphaEquation) alphaDstFactor * dst.a

   All factors and colors are represented as floating point numbers between 0
   and 1. Where necessary, the result is clamped to fit in that range.

   The most common blending modes are defined as constants in the sf namespace::

      sf.BLEND_ALPHA
      sf.BLEND_ADD
      sf.BLEND_MULTIPLY
      sf.BLEND_NONE


   In SFML, a blend mode can be specified every time you draw a :class:`Drawable`
   object to a render target. It is part of the :class:`RenderStates` compound
   that is passed to the member function :meth:`draw`.

   +---------------------+---------------------------------------------+
   | Factor              | Description                                 |
   +=====================+=============================================+
   | ZERO                | (0, 0, 0, 0)                                |
   +---------------------+---------------------------------------------+
   | ONE                 | (1, 1, 1, 1)                                |
   +---------------------+---------------------------------------------+
   | SRC_COLOR           | (src.r, src.g, src.b, src.a)                |
   +---------------------+---------------------------------------------+
   | ONE_MINUS_SRC_COLOR | (1, 1, 1, 1) - (src.r, src.g, src.b, src.a) |
   +---------------------+---------------------------------------------+
   | DST_COLOR           | (dst.r, dst.g, dst.b, dst.a)                |
   +---------------------+---------------------------------------------+
   | ONE_MINUS_DST_COLOR | (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a) |
   +---------------------+---------------------------------------------+
   | SRC_ALPHA           | (src.a, src.a, src.a, src.a)                |
   +---------------------+---------------------------------------------+
   | ONE_MINUS_SRC_ALPHA | (1, 1, 1, 1) - (src.a, src.a, src.a, src.a) |
   +---------------------+---------------------------------------------+
   | DST_ALPHA           | (dst.a, dst.a, dst.a, dst.a)                |
   +---------------------+---------------------------------------------+
   | ONE_MINUS_DST_ALPHA | (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a) |
   +---------------------+---------------------------------------------+

   +----------+-------------------------------------------+
   | Equation | Description                               |
   +==========+===========================================+
   | ADD      | Pixel = Src * SrcFactor + Dst * DstFactor |
   +----------+-------------------------------------------+
   | SUBTRACT | Pixel = Src * SrcFactor - Dst * DstFactor |
   +----------+-------------------------------------------+

   .. py:method:: BlendMode(*args, **kwargs):

      Construct the blend mode given the factors and equation.

      :param integer color_source_factor: Specifies how to compute the source factor for the color channels.
      :param integer color_destination_factor: Specifies how to compute the destination factor for the color channels.
      :param integer color_blend_equation: Specifies how to combine the source and destination colors.
      :param integer alpha_source_factor: Specifies how to compute the source factor.
      :param integer alpha_destination_factor: Specifies how to compute the destination factor.
      :param integer alpha_blend_equation: Specifies how to combine the source and destination alphas.

   .. py:attribute:: color_src_factor

      Source blending factor for the color channels

   .. py:attribute:: color_dst_factor

      Destination blending factor for the color channels

   .. py:attribute:: color_equation

      Blending equation for the color channels

   .. py:attribute:: alpha_src_factor

      Source blending factor for the alpha channel

   .. py:attribute:: alpha_dst_factor

      Destination blending factor for the alpha channel

   .. py:attribute:: alpha_equation

      Blending equation for the alpha channel

.. py:data:: BLEND_ALPHA

   Blend source and dest according to dest alpha

.. py:data:: BLEND_ADD

   Add source to dest

.. py:data:: BLEND_MULTIPLY

   Multiply source and dest

.. py:data:: BLEND_NONE

   Overwrite dest with source

Pixels
^^^^^^

.. py:class:: Pixels

   .. py:attribute:: width

   .. py:attribute:: height

   .. py:attribute:: data


Image
^^^^^

.. py:class:: Image

   Class for loading, manipulating and saving images.

   :class:`Image` is an abstraction to manipulate images as
   bidimensional arrays of pixels.

   The class provides functions to load, read, write and save pixels,
   as well as many other useful functions.

   :class:`Image` can handle a unique internal representation of
   pixels, which is RGBA 32 bits. This means that a pixel must be
   composed of 8 bits red, green, blue and alpha channels -- just like
   an :class:`Color`. All the functions that return an array of
   pixels follow this rule, and all parameters that you pass to
   :class:`Image` functions (such as :func:`from_pixels`) must
   use this representation as well.

   A :class:`Image` can be copied, but it is a heavy resource; keep it in
   mind!

   For debugging purpose, you can call its method :meth:`show` that
   displays its content in an external window in an external thread.

   Usage example::

      try:
         # load an image file from a file
         background = sf.Image.from_file("background.jpg")

      except IOError: exit(1)

      # create a 20x20 image filled with black color
      image = sf.Image.create(20, 20, sf.Color.BLACK)

      # copy image1 on image 2 at position(10, 10)
      background.blit(image, (10, 10))

      # make the top-left pixel transparent
      color = image[0, 0]
      color.a = 0
      image[0, 0] = color

      # save the image to a file
      background.to_file("result.png")

   .. py:classmethod:: create(width, height[, color])

      Create the image and fill it with a unique color.

      :param integer width: Width of the image
      :param integer height: Height of the image
      :param sfml.graphics.Color color: Fill color
      :rtype: :class:`sfml.graphics.Image`

   .. py:classmethod:: from_pixels(pixels)

      Create the image from an array of pixels wrapped around
      :class:`Pixels`. This function fails without raising error if
      pixels are invalid. On the other hand, it raises one if *pixels*
      points on *NULL*?

      :raise: :exc:`sfml.system.SFMLException` - If *pixels* is empty.
      :param sfml.window.Pixels pixels: Array of pixels to copy to the image
      :rtype: :class:`sfml.graphics.Image`

   .. py:classmethod:: from_file(filename)

      Load the image from a file on disk.

      The supported image formats are bmp, png, tga, jpg, gif, psd, hdr
      and pic. Some format options are not supported, like progressive
      jpeg. If this function fails, it raises an exception.

      :raise: :exc:`IOError` - The image failed to load
      :param str filename: Path of the image file to load
      :rtype: :class:`sfml.graphics.Image`

   .. py:classmethod:: from_memory(data)

      Load the image from a file in memory.

      The supported image formats are bmp, png, tga, jpg, gif, psd, hdr
      and pic. Some format options are not supported, like progressive
      jpeg. If this function fails, it raises an exception.

      :raise: :exc:`IOError` - The image failed to load
      :param bytes data: The data to load, in bytes
      :rtype: :class:`sfml.graphics.Image`

   .. py:classmethod:: to_file(filename)

      Save the image to a file on disk.

      The format of the image is automatically deduced from the
      extension. The supported image formats are bmp, png, tga and jpg.
      The destination file is overwritten if it already exists.

      :raise: :exc:`IOError` - If the image is empty
      :param str filename: Path of the file to save

   .. py:attribute:: size

      Return the size of the image.

      :type: :class:`sfml.system.Vector2`

   .. py:attribute:: width

      Return the width of the image.

      :type: integer

   .. py:attribute:: height

      Return the width of the image.

      :type: height

   .. py:method:: create_mask_from_color(color[, alpha=0])

      Create a transparency mask from a specified color-key.

      This function sets the alpha value of every pixel matching the
      given color to alpha (0 by default), so that they become
      transparent.

      :param sfml.graphics.Color color: Color to make transparent
      :param integer alpha: Alpha value to assign to transparent pixels

   .. py:method:: blit(source, dest[, source_rect=(0, 0, 0, 0)[, apply_alpha=False]])

      Copy pixels from another image onto this one.

      This function does a slow pixel copy and should not be used
      intensively. It can be used to prepare a complex static image
      from several others, but if you need this kind of feature in
      real-time you'd better use :class:`RenderTexture`.

      If *source_rect* is empty, the whole image is copied. If
      *apply_alpha* is set to true, the transparency of source pixels is
      applied. If it is false, the pixels are copied unchanged with
      their alpha value.

      :param sfml.graphics.Image source: Source image to copy
      :param dest: Coordinate of the destination position
      :type dest: :class:`sfml.system.Vector2` or None
      :param source_rect: Sub-rectangle of the source image to copy
      :type source_rect: :class:`sfml.graphics.Rect` or tuple
      :param bool apply_alpha: Should the copy take in account the source transparency ?

   .. py:attribute:: pixels

      Get a read-only pointer to the array of pixels. This pointer is
      wrapped around :class:`Pixels`.

      The returned value points to an array of RGBA pixels made of 8
      bits integers components. The size of the array is :attr:`width`
      * :attr:`height` * 4.

      .. warning::

         The returned object may become invalid if you modify the
         image, so you should never store it for too long. If the image
         is empty, None is returned.

      :type: :class:`sfml.window.Pixels` or None

   .. py:method:: flip_horizontally()

      Flip the image horizontally (left <-> right)

   .. py:method:: flip_vertically

      Flip the image vertically (top <-> bottom)

   .. py:method:: __getitem__()

      Get a pixel from the image. ::

         print(image[0,0])    # create tuple implicitly
         print(image[(0,0)])  # create tuple explicitly

   .. py:method:: __setitem__()

      Set a pixel of the image. ::

         image[0,0]   = sfml.graphics.Color(10, 20, 30)  # create tuple implicitly
         image[(0,0)] = sfml.graphics.Color(10, 20, 30)  # create tuple explicitly


Texture
^^^^^^^

.. py:class:: Texture

   :class:`Image` living on the graphics card that can be used for
   drawing.

   :class:`Texture` stores pixels that can be drawn, with a sprite
   for example.

   A texture lives in the graphics card memory, therefore it is very
   fast to draw a texture to a render target, or copy a render target
   to a texture (the graphics card can access both directly).

   Being stored in the graphics card memory has some drawbacks. A
   texture cannot be manipulated as freely as an :class:`Image`, you
   need to prepare the pixels first and then upload them to the texture
   in a single operation (see :func:`Texture.update`).

   :class:`Texture` makes it easy to convert from/to
   :class:`Image`, but keep in mind that these calls require
   transfers between the graphics card and the central memory,
   therefore they are slow operations.

   A texture can be loaded from an image, but also directly from a file
   or a memory. The necessary shortcuts are defined so that you don't
   need an image first for the most common cases. However, if you want
   to perform some modifications on the pixels before creating the
   final texture, you can load your file to an :class:`Image`, do
   whatever you need with the pixels, and then call
   :func:`Texture.from_image`.

   Since they live in the graphics card memory, the pixels of a texture
   cannot be accessed without a slow copy first. And they cannot be
   accessed individually. Therefore, if you need to read the texture's
   pixels (like for pixel-perfect collisions), it is recommended to
   store the collision information separately, for example in an array
   of booleans.

   Like :class:`Image`, :class:`Texture` can handle a unique
   internal representation of pixels, which is RGBA 32 bits. This means
   that a pixel must be composed of 8 bits red, green, blue and alpha
   channels -- just like an :class:`Color`.

   Usage example:

   This first example shows the most common use of :class:`Texture` drawing a sprite ::

      #load a texture from a file
      try:
         texture = sf.Texture.from_file("texture.png")

      except IOError: exit(1)

      # assign it to a sprite
      sprite = sf.Sprite(texture)

      # draw the textured sprite
      window.draw(sprite);

   This second example shows another common use of :class:`Texture` streaming real-time data, like video frames ::

      # create an empty texture
      texture = sf.Texture.create(640, 480)

      # create a sprite that will display the texture
      sprite = sf.Sprite(texture)

      while loop: # the main loop
         # ...

         # get a fresh chunk of pixels (the next frame of a movie, for example)
         pixels = get_pixels_function()

         # update the texture
         texture.update(pixels)
         # or use update_from_pixels (faster)
         texture.update_from_pixels(pixels)

         # draw it
         window.draw(sprite)
         # ...

   .. py:method:: Texture()

      The default constructor is not meant to be called. It will raise
      :exc:`NotImplementedError` with a message telling you that you
      must use a specific constructor.

      Those specific constructors are: :func:`create`,
      :func:`from_file`, :func:`from_memory`,
      :func:`from_image`.

   .. py:data:: NORMALIZED

      Texture coordinates in range [0 .. 1].

   .. py:data:: PIXELS

      Texture coordinates in range [0 .. size].

   .. py:classmethod:: create(width, height)

      Create a texture.

      :param integer width: Width of the texture
      :param integer height: Height of the texture
      :rtype: :class:`sfml.graphics.Texture`

   .. py:classmethod:: from_file(filename[, area=(0, 0, 0, 0)])

      Load the texture from a file on disk.

      This function is a shortcut for the following code::

         image = sf.Image.from_file(filename)
         texture.from_image(image, area)

      The area argument can be used to load only a sub-rectangle of the
      whole image. If you want the entire image then leave the default
      value (which is an empty :class:`Rect`). If the area
      rectangle crosses the bounds of the image, it is adjusted to fit
      the image size.

      The maximum size for a texture depends on the graphics driver and
      can be retrieved with the :func:`get_maximum_size` function.

      If this function fails, it raises an exception.

      :raise: :class:`IOError` - The texture failed to load
      :param str filename: Path of the image file to load
      :param area: Area of the image to load
      :type area: :class:`sfml.graphics.Rect`
      :rtype: :class:`sfml.graphics.Texture`

   .. py:classmethod:: from_memory(data, area=(0, 0, 0, 0))

      Load the texture from a file in memory.

      This function is a shortcut for the following code::

         image = sf.Image.from_memory(data)
         texture = sf.Texture.from_image(image, area)

      The area argument can be used to load only a sub-rectangle of the
      whole image. If you want the entire image then leave the default
      value (which is an empty :class:`Rect`). If the area
      rectangle crosses the bounds of the image, it is adjusted to fit
      the image size.

      The maximum size for a texture depends on the graphics driver and
      can be retrieved with the :func:`get_maximum_size` function.

      If this function fails, it raises an exception.

      :raise: :class:`IOError` - The texture failed to load
      :param bytes data: Data to load
      :param area: Area of the image to load
      :type area: :class:`sfml.graphics.Rect`
      :rtype: :class:`sfml.graphics.Texture`

   .. py:classmethod:: from_image(image[, area=(0, 0, 0, 0)])

      Load the texture from an image.

      The area argument can be used to load only a sub-rectangle of the
      whole image. If you want the entire image then leave the default
      value (which is an empty :class:`Rect`). If the area
      rectangle crosses the bounds of the image, it is adjusted to fit
      the image size.

      The maximum size for a texture depends on the graphics driver and
      can be retrieved with the :func:`get_maximum_size` function.

      If this function fails, it raises an error.

      :raise: :class:`sfml.system.SFMLException` - The texture failed to load
      :param sfml.graphics.Image image: Image to load into the texture
      :param sfml.graphics.Rect area: Area of the image to load
      :rtype: :class:`sfml.graphics.Texture`

   .. py:attribute:: size

      Return the size of the texture.

      :type: :class:`sfml.system.Vector2`

   .. py:attribute:: width

      Return the width of the texture.

      :type: integer

   .. py:attribute:: height

      Return the height of the texture.

      :type: integer

   .. py:method:: to_image()

      Copy the texture pixels to an image.

      This function performs a slow operation that downloads the
      texture's pixels from the graphics card and copies them to a new
      image, potentially applying transformations to pixels if
      necessary (texture may be padded or flipped).

      :return: Image containing the texture's pixels
      :type: :class:`sfml.graphics.Image`

   .. py:method:: update(*args, **kwargs)

      Refer to :meth:`update_from_pixels`, :meth:`update_from_image`
      or :meth:`update_from_window`.

      This method is provided for convenience, its sisters will be
      faster as they don't have to check the argument's type.

   .. py:method:: update_from_pixels(pixels[, position])

      Update the whole texture from an array of pixels.

      The pixel array is assumed to have the same size as the area
      rectangle, and to contain 32-bits RGBA pixels.

      This function does nothing if pixels is null or if the texture
      was not previously created.

      :param sfml.graphics.Pixels pixels: Array of pixels to copy to the texture
      :param sfml.system.Vector2 position: Offset in the texture where to copy the source pixels

   .. py:method:: update_from_image(image[, position])

      Update the texture from an image.

      Although the source image can be smaller than the texture, this
      function is usually used for updating the whole texture. Provide
      the additional argument **position** for updating a sub-area of
      the texture.

      No additional check is performed on the size of the image,
      passing an image bigger than the texture will lead to an
      undefined behaviour.

      This function does nothing if the texture was not previously
      created.

      :param sfml.graphics.Image image: Image to copy to the texture
      :param sfml.system.Vector2 position: Offset in the texture where to copy the source image

   .. py:method:: update_from_window(window[, position])

      Update the texture from the contents of a window.

      Although the source window can be smaller than the texture, this
      function is usually used for updating the whole texture. Provide
      the additional argument **position** for updating a sub-area of
      the texture.

      No additional check is performed on the size of the window,
      passing a window bigger than the texture will lead to an
      undefined behaviour.

      This function does nothing if either the texture or the window
      was not previously created.

      :param sfml.window.Window window: Window to copy to the texture
      :param sfml.system.Vector2 position: Offset in the texture where to copy the source window

   .. py:method:: bind(coordinate_type=sfml.graphics.Texture.NORMALIZED)

      Activate the texture for rendering.

      This function is mainly used internally by the SFML rendering
      system. However it can be useful when using :class:`Texture`
      together with OpenGL code (this function is equivalent to
      glBindTexture).

      The coordinateType argument controls how texture coordinates will
      be interpreted. If :const:`NORMALIZED` (the default), they must
      be in range [0 .. 1], which is the default way of handling
      texture coordinates with OpenGL. If :const:`PIXELS`, they must be
      given in pixels (range [0 .. size]). This mode is used internally
      by the graphics classes of SFML, it makes the definition of
      texture coordinates more intuitive for the high-level API, users
      don't need to compute normalized values.

      :param coordinate_type: Type of texture coordinates to use
      :type coordinate_type: :class:`sfml.graphics.Texture`'s constant

   .. py:attribute:: smooth

      Get/set the smooth filter.

      When the filter is activated, the texture appears smoother so
      that pixels are less noticeable. However if you want the texture
      to look exactly the same as its source file, you should leave it
      disabled. The smooth filter is disabled by default.

      :type: bool

   .. py:attribute:: repeated

      Enable or disable repeating.

      Repeating is involved when using texture coordinates outside the
      texture rectangle [0, 0, width, height]. In this case, if repeat
      mode is enabled, the whole texture will be repeated as many times
      as needed to reach the coordinate (for example, if the X texture
      coordinate is 3 * width, the texture will be repeated 3 times).
      If repeat mode is disabled, the "extra space" will instead be
      filled with border pixels. Warning: on very old graphics cards,
      white pixels may appear when the texture is repeated. With such
      cards, repeat mode can be used reliably only if the texture has
      power-of-two dimensions (such as 256x128). Repeating is disabled
      by default.

      :type: bool

   .. py:classmethod:: get_maximum_size()

      Get the maximum texture size allowed.

      This maximum size is defined by the graphics driver. You can
      expect a value of 512 pixels for low-end graphics card, and up to
      8192 pixels or more for newer hardware.

      :return: Maximum size allowed for textures, in pixels
      :rtype: integer


Glyph
^^^^^

.. py:class:: Glyph

   Structure describing a glyph.

   A glyph is the visual representation of a character.

   The :class:`Glyph` structure provides the information needed to
   handle the glyph:

       * its coordinates in the font's texture
       * its bounding rectangle
       * the offset to apply to get the starting position of the next glyph


   .. py:method:: Glyph()

      Default constructor.

      :rtype: :class:`sfml.graphics.Glyph`

   .. py:attribute:: advance

      Offset to move horizontally to the next character.

      :rtype: integer

   .. py:attribute:: bounds

      Bounding rectangle of the glyph, in coordinates relative to the
      baseline.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:attribute:: texture_rectangle

      :class:`Texture` coordinates of the glyph inside the font's
      texture.

      :rtype: :class:`sfml.graphics.Rect`

Font
^^^^

.. py:class:: Font

      Class for loading and manipulating character fonts.

      Fonts can be loaded from a file or from memory, and supports the
      most common types of fonts.

      See the :func:`from_file` function for the complete list of
      supported formats.

      Once it is loaded, an :class:`Font` instance provides three
      types of informations about the font:

          * Global metrics, such as the line spacing
          * Per-glyph metrics, such as bounding box or kerning
          * Pixel representation of glyphs

      Fonts alone are not very useful: they hold the font data but
      cannot make anything useful of it. To do so you need to use the
      :class:`Text` class, which is able to properly output text
      with several options such as character size, style, color,
      position, rotation, etc. This separation allows more flexibility
      and better performances: indeed an :class:`Font` is a heavy
      resource, and any operation on it is slow (often too slow for
      real-time applications). On the other side, an :class:`Text` is
      a lightweight object which can combine the glyphs data and
      metrics of an :class:`Font` to display any text on a render
      target. Note that it is also possible to bind several
      :class:`Text` instances to the same :class:`Font`.

      It is important to note that the :class:`Text` instance
      doesn't copy the font that it uses, it only keeps a reference to
      it. Thus, an :class:`Font` must not be destructed while it is
      used by an :class:`Text`.

      Usage example::

         # declare a new font
         try:
            font = sf.Font.from_file("arial.ttf")

         except IOError: exit(1) # error...

         # create a text which uses our font
         text1 = sf.Text()
         text1.font = font
         text1.character_size = 30
         text1.style = sf.Text.REGULAR

         # create another text using the same font, but with different parameters
         text2 = sf.Text()
         text2.font = font
         text2.character_size = 50
         text2.style = sf.Text.ITALIC

      Apart from loading font files, and passing them to instances of
      :class:`Text`, you should normally not have to deal directly
      with this class. However, it may be useful to access the font
      metrics or rasterized glyphs for advanced usage.

   .. py:method:: Font()

      The default constructor is not meant to be called. It will raise
      :exc:`NotImplementedError` with a message telling you that you
      must use a specific constructor.

      Those specific constructors are: :func:`from_file` and
      :func:`from_memory`.

   .. py:classmethod:: from_file(filename)

      Load the font from a file.

      The supported font formats are: TrueType, Type 1, CFF, OpenType,
      SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42. Note that this
      function know nothing about the standard fonts installed on the
      user's system, thus you can't load them directly.

      This function raises an exception if it fails.

      :raise: :exc:`IOError` - The font failed to load
      :param str filename: Path of the font file to load
      :rtype: :class:`sfml.graphics.Font`

   .. py:classmethod:: from_memory(data)

      Load the font from a file in memory.

      The supported font formats are: TrueType, Type 1, CFF, OpenType,
      SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42. Note that this
      function know nothing about the standard fonts installed on the
      user's system, thus you can't load them directly.

      This function raises an exception if it fails.

      :raise: :exc:`IOError` - The font failed to load
      :param bytes data: The data to load
      :rtype: :class:`sfml.graphics.Font`

   .. py:method:: get_glyph(code_point, character_size, bold)

      Retrieve a glyph of the font.

      :param integer code_point: Unicode code point of the character to get
      :param integer character_size: Reference character size
      :param bool bold: Retrieve the bold version or the regular one ?
      :return: The glyph corresponding to *code_point* and *character_size*
      :rtype: :class:`sfml.graphics.Glyph`

   .. py:method:: get_kerning(first, second, character_size)

      Get the kerning offset of two glyphs.

      The kerning is an extra offset (negative) to apply between two
      glyphs when rendering them, to make the pair look more "natural".
      For example, the pair "AV" have a special kerning to make them
      closer than other characters. Most of the glyphs pairs have a
      kerning offset of zero, though.

      :param integer first: Unicode code point of the first character
      :param integer second: Unicode code point of the second character
      :param integer character_size: Reference character size
      :return: Kerning value for first and second, in pixels
      :rtype: integer

   .. py:method:: get_line_spacing(character_size)

      Get the line spacing.

      Line spacing is the vertical offset to apply between two
      consecutive lines of text.

      :param integer character_size: Reference character size
      :return: Line spacing, in pixels
      :rtype: integer

   .. py:method:: get_texture(character_size)

      Retrieve the texture containing the loaded glyphs of a certain
      size.

      The contents of the returned texture changes as more glyphs are
      requested, thus it is not very relevant. It is mainly used
      internally by :class:`Text`.

      :param integer character_size: Reference character size
      :return: Texture containing the glyphs of the requested size
      :rtype: :class:`sfml.graphics.Texture`

   .. py:attribute:: info

      Various information about a font.

      :return: A string containing the font family
      :rtype: str


Shader
^^^^^^

.. py:class:: Shader

   :class:`Shader` class (vertex and fragment)

   Shaders are programs written using a specific language, executed
   directly by the graphics card and allowing to apply real-time
   operations to the rendered entities.

   There are two kinds of shaders:

       * Vertex shaders, that process vertices
       * Fragment (pixel) shaders, that process pixels

   A :class:`Shader` can be composed of either a vertex shader
   alone, a fragment shader alone, or both combined (see the variants
   of the load functions).

   Shaders are written in GLSL, which is a C-like language dedicated to
   OpenGL shaders. You'll probably need to learn its basics before
   writing your own shaders for pySFML.

   Like any C/C++ program, a shader has its own variables that you can
   set from your Python application. :class:`Shader` handles 4
   different types of variables:

       * floats
       * vectors (2, 3 or 4 components)
       * textures
       * transforms (matrices)

   .. py:method:: Shader()

      The default constructor is not meant to be called. It will raise
      :exc:`NotImplementedError` with a message telling you that you
      must use a specific constructor.

      Those specific constructors are: :func:`from_file` and :func:`from_memory`.

   .. py:classmethod:: from_file(vertex_filename=None, fragment_filename=None)

      Load a vertex shader **or** a fragment shader **or** both from files.

      The sources must be text files containing valid shaders in GLSL
      language. GLSL is a C-like language dedicated to OpenGL shaders;
      you'll probably need to read a good documentation for it before
      writing your own shaders.

      :raise: :exc:`IOError` - If one of the two shaders failed to load
      :param str vertex_filename: Path of the vertex or fragment shader file to load
      :param str fragment_filename: Path of the fragment shader file to load
      :rtype: :class:`sfml.graphics.Shader`


   .. py:classmethod:: from_memory(vertex_shader=None, fragment_shader=None)

      Load a vertex shader **or** a fragment shader **or** both from source
      codes in memory.

      This function loads both the vertex and the fragment shaders. If
      one of them fails to load, the error :exc:`IOError` is raised.
      The sources must be valid shaders in GLSL language. GLSL is a
      C-like language dedicated to OpenGL shaders; you'll probably need
      to read a good documentation for it before writing your own
      shaders.

      :raise: :exc:`IOError` - If one of the two shaders failed to load
      :param str vertex_shader: String containing the source code of the vertex shader
      :param str fragment_shader: String containing the source code of the fragment shader
      :rtype: :class:`sfml.graphics.Shader`

   .. py:method:: set_parameter(*args, **kwargs)

      This method takes care of calling the suitable set_parameter
      method. See the table below:


      +--------------------+------------------------------------------+
      | Parameters         | Method                                   |
      +====================+==========================================+
      | 1 float            | :meth:`set_1float_parameter`             |
      +--------------------+------------------------------------------+
      | 2 float            | :meth:`set_2float_parameter`             |
      +--------------------+------------------------------------------+
      | 3 float            | :meth:`set_3float_parameter`             |
      +--------------------+------------------------------------------+
      | 4 float            | :meth:`set_4float_parameter`             |
      +--------------------+------------------------------------------+
      | :class:`.Vector2`  | :meth:`set_vector2_parameter`            |
      +--------------------+------------------------------------------+
      | :class:`.Vector3`  | :meth:`set_vector3_parameter`            |
      +--------------------+------------------------------------------+
      | :class:`.Color`    | :meth:`set_color_parameter`              |
      +--------------------+------------------------------------------+
      | :class:`Transform` | :meth:`set_transform_parameter`          |
      +--------------------+------------------------------------------+
      | :class:`Texture`   | :meth:`set_texture_parameter`            |
      +--------------------+------------------------------------------+
      | CURRENT_TEXTURE    | :meth:`set_currenttexturetype_parameter` |
      +--------------------+------------------------------------------+

   .. py:method:: set_1float_parameter(name, x)

      Change a float parameter of the shader.


      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a float (float GLSL
      type).

      Example::

         uniform float myparam; // this is the variable in the shader

      ::

         shader.set_1float_parameter("myparam", 5.2) # using the specific method (faster)
         shader.set_parameter("myparam", 5.2)        # using the general method

      :param str name: Name of the parameter in the shader
      :param float x: Value to assign

   .. py:method:: set_2float_parameter(name, x, y)

      Change a 2-components vector parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 2x1 vector (vec2
      GLSL type).

      Example::

         uniform vec2 myparam; // this is the variable in the shader

      ::

         shader.set_2float_parameter("myparam", 5.2, 6) # using the specific method (faster)
         shader.set_parameter("myparam", 5.2, 6)        # using the general method

      :param str name: Name of the parameter in the shader
      :param float x: First component of the value to assign
      :param float y: Second component of the value to assign

   .. py:method:: set_3float_parameter(name, x, y, z)

      Change a 3-components vector parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 3x1 vector (vec3
      GLSL type).

      Example::

         uniform vec3 myparam; // this is the variable in the shader

      ::

         shader.set_3float_parameter("myparam", 5.2, 6, -8.1) # using the specific method (faster)
         shader.set_parameter("myparam", 5.2, 6, -8.1)        # using the general method

      :param str name: Name of the parameter in the shader
      :param float x: First component of the value to assign
      :param float y: Second component of the value to assign
      :param float z: Third component of the value to assign

   .. py:method:: set_4float_parameter(name, x, y, z, w)

      Change a 4-components vector parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 4x1 vector (vec4
      GLSL type).

      Example::

         uniform vec4 myparam; // this is the variable in the shader

      ::

         shader.set_4float_parameter("myparam", 5.2, 6, -8.1, 0.4) # using the specific method (faster)
         shader.set_parameter("myparam", 5.2, 6, -8.1, 0.4)        # using the general method

      :param str name: Name of the parameter in the shader
      :param float x: First component of the value to assign
      :param float y: Second component of the value to assign
      :param float z: Third component of the value to assign
      :param float w: Fourth component of the value to assign

   .. py:method:: set_vector2_parameter(name, vector)


      Change a 2-components vector parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 2x1 vector (vec2
      GLSL type).

      Example::

         uniform vec2 myparam; // this is the variable in the shader

      ::

         shader.set_vector2_parameter("myparam", sf.Vector2(5.2, 6)) # using the specific method (faster)
         shader.set_parameter("myparam", sf.Vector2(5.2, 6))         # using the general method
         shader.set_parameter("myparam", (5.2, 6))                   # using tuple works too

      :param str name: Name of the parameter in the shader
      :param sfml.system.Vector2 vector: Vector to assign

   .. py:method:: set_vector3_parameter(name, vector)

      Change a 3-components vector parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 3x1 vector (vec3
      GLSL type).

      Example::

         uniform vec3 myparam; // this is the variable in the shader

      ::

         shader.set_vector3_parameter("myparam", sf.Vector3(5.2, 6, -8.1)) # using the specific method (faster)
         shader.set_parameter("myparam", sf.Vector3(5.2, 6, -8.1))         # using the general method
         shader.set_parameter("myparam", (5.2, 6, -8.1))                   # using tuple works too

      :param str name: Name of the parameter in the shader
      :param sfml.system.Vector3 vector: Vector to assign

   .. py:method:: set_color_parameter(name, color)

      Change a color parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 4x1 vector (vec4
      GLSL type).

      It is important to note that the components of the color are
      normalized before being passed to the shader. Therefore, they are
      converted from range [0 .. 255] to range [0 .. 1]. For example,
      a sf.Color(255, 125, 0, 255) will be transformed to a
      vec4(1.0, 0.5, 0.0, 1.0) in the shader.

      Example::

         uniform vec4 color; // this is the variable in the shader

      ::

         shader.set_color_parameter("myparam", sf.Color(255, 128, 0, 255)) # using the specific method (faster)
         shader.set_parameter("myparam", sf.Color(255, 128, 0, 255))       # using the general method

      :param str name: Name of the parameter in the shader
      :param sfml.graphics.Color color: Color to assign

   .. py:method:: set_transform_parameter(name, transform)

      Change a matrix parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 4x4 matrix (mat4
      GLSL type).

      Example::

         uniform mat4 matrix; // this is the variable in the shader

      ::

         transform = sf.Transform()
         transform.translate(sf.Vector2(5, 10))

         shader.set_transform_parameter("matrix", transform) # using the specific method (faster)
         shader.set_parameter("matrix", transform)           # using the general method

      :param str name: Name of the parameter in the shader
      :param sfml.graphics.Transform transform: Transform to assign

   .. py:method:: set_texture_parameter(name, texture)

      Change a texture parameter of the shader.

      *name* is the name of the variable to change in the shader. The
      corresponding parameter in the shader must be a 2D texture
      (sampler2D GLSL type).

      Example::

         uniform sampler2D the_texture; // this is the variable in the shader

      ::

         texture = sf.Texture.create(50, 50)
         # ...

         shader.set_texture_parameter("the_texture", texture) # using the specific method (faster)
         shader.set_parameter("the_texture", texture)         # using the general method

      It is important to note that texture must remain alive as long as
      the shader uses it, no copy is made internally.

      To use the texture of the object being draw, which cannot be
      known in advance, use :meth:`set_currenttexturetype_parameter`.

      :param str name: Name of the parameter in the shader
      :param sfml.graphics.Texture texture: Texture to assign

   .. py:method:: set_currenttexturetype_parameter(name)

      Change a texture parameter of the shader.

      This overload maps a shader texture variable to the texture of
      the object being drawn, which cannot be known in advance. The
      corresponding parameter in the shader must be a 2D texture
      (sampler2D GLSL type).

      Example::

         uniform sampler2D current; // this is the variable in the shader

      ::

         shader.set_currenttexturetype_parameter("current") # using the specific method (faster)
         shader.set_parameter("current")                    # using the general method


   .. py:method:: bind()

      Bind the shader for rendering (activate it)

      This function is normally for internal use only, unless you want
      to use the shader with a custom OpenGL rendering instead of a
      pySFML drawable. ::

         window.active = True
         shader.bind()
         # ... render OpenGL geometry ...
         shader.unbind()


RenderStates
^^^^^^^^^^^^

.. py:class:: RenderStates

   Define the states used for drawing to a :class:`RenderTarget`.

   There are four global states that can be applied to the drawn
   objects:

       * the blend mode: how pixels of the object are blended with the background
       * the transform: how the object is positioned/rotated/scaled
       * the texture: what image is mapped to the object
       * the shader: what custom effect is applied to the object

   High-level objects such as sprites or text force some of these
   states when they are drawn. For example, a sprite will set its own
   texture, so that you don't have to care about it when drawing the
   sprite.

   The transform is a special case: sprites, texts and shapes (and it's
   a good idea to do it with your own drawable classes too) combine
   their transform with the one that is passed in the
   :class:`RenderStates` structure. So that you can use a "global"
   transform on top of each object's transform.

   Most objects, especially high-level drawables, can be drawn directly
   without defining render states explicitly -- the default set of
   states is ok in most cases. ::

      window.draw(sprite)

   If you want to use a single specific render state, for example a
   shader, you can pass it directly to the draw function. ::

      window.draw(sprite, shader)

   When you're inside the draw function of a drawable object (inherited
   from :class:`Drawable`), you can either pass the render states
   unmodified, or change some of them. For example, a transformable
   object will combine the current transform with its own transform. A
   sprite will set its texture. Etc.

   .. py:method:: RenderStates(blendmode=BLEND_ALPHA[, transform, [texture[, shader]]])

      Construct a default render states with custom values.

      :param blendmode: Blend mode to use
      :type blendmode: :class:`sfml.graphics.BlendMode`'s constant
      :param sfml.graphics.Transform transform: Transform to use
      :param sfml.graphics.Texture texture: Texture to use
      :param sfml.graphics.Shader shader: Shader to use
      :rtype: :class:`sfml.graphics.RenderStates`

   .. py:data:: DEFAULT

      Special instance holding the default render states.

   .. py:attribute:: blendmode

      Blending mode.

   .. py:attribute:: transform

      Transform.

   .. py:attribute:: texture

      Texture.

   .. py:attribute:: shader

      Shader.


Drawable
^^^^^^^^

.. py:class:: Drawable

   Abstract base class for objects that can be drawn to a render target.

   :class:`Drawable` is a very simple base class that allows objects
   of derived classes to be drawn to an :class:`RenderTarget`.

   All you have to do in your derived class is to override the draw
   virtual function.

   Note that inheriting from :class:`Drawable` is not mandatory, but
   it allows this nice syntax "window.draw(object)" rather than
   "object.draw(window)", which is more consistent with other pySFML
   classes.

   Example::

      class MyDrawable(sf.Drawable):
         def __init__(self):
            sf.Drawable.__init__(self)
            # ...

         def draw(self, target, states):
            # you can draw other high-level objects
            target.draw(self.sprite, states)

            # ... or use the low-level API
            states.texture = self.texture
            target.draw(self.vertices, states)

            # ... or draw with OpenGL directly
            glBegin(GL_QUADS)
               # ...
            glEnd()

   .. py:method:: draw(target, states):

      Draw the object to a render target.

      This is a virtual method that has to be implemented by the
      derived class to define how the drawable should be drawn.

      :param sfml.graphics.RenderTarget target: Render target to draw to
      :param sfml.graphics.RenderStates states: Current render states

Transformable
^^^^^^^^^^^^^

.. py:class:: Transformable

   Decomposed transform defined by a position, a rotation and a scale.

   This class is provided for convenience, on top of
   :class:`Transform`.

   :class:`Transform`, as a low-level class, offers a great level of
   flexibility but it is not always convenient to manage. Indeed, one
   can easily combine any kind of operation, such as a translation
   followed by a rotation followed by a scaling, but once the result
   transform is built, there's no way to go backward and, let's say,
   change only the rotation without modifying the translation and
   scaling. The entire transform must be recomputed, which means that
   you need to retrieve the initial translation and scale factors as
   well, and combine them the same way you did before updating the
   rotation. This is a tedious operation, and it requires to store all
   the individual components of the final transform.

   That's exactly what :class:`Transformable` was written for: it
   hides these variables and the composed transform behind an easy to
   use interface. You can set or get any of the individual components
   without worrying about the others. It also provides the composed
   transform (as an :class:`Transform`), and keeps it up-to-date.

   In addition to the position, rotation and scale,
   :class:`Transformable` provides an "origin" component, which
   represents the local origin of the three other components. Let's
   take an example with a 10x10 pixels sprite. By default, the sprite
   is positioned/rotated/scaled relatively to its top-left corner,
   because it is the local point (0, 0). But if we change the origin to
   be (5, 5), the sprite will be positioned/rotated/scaled around its
   center instead. And if we set the origin to (10, 10), it will be
   transformed around its bottom-right corner.

   To keep the :class:`Transformable` class simple, there's only one
   origin for all the components. You cannot position the sprite
   relatively to its top-left corner while rotating it around its
   center, for example. To do such things, use
   :class:`Transform` directly.

   :class:`Transformable` can be used as a base class. It is often
   combined with :class:`Drawable` -- that's what SFML's sprites,
   texts and shapes do. ::

      class MyEntity(sf.TransformableDrawable):
         def draw(self, target, states):
            sf.TransformableDrawable.draw(self, target, states)
            states.transform *= get_transform()
            target.draw(..., states)

      entity = MyEntity()
      entity.position = (10, 20)
      entity.rotation = 45
      window.draw(entity)

   .. py:method:: Transformable()

      Default constructor.

      :rtype: :class:`sfml.graphics.Transformable`

   .. py:attribute:: position

      Set/get the position of the object

      This attribute completely overwrites the previous position. See
      :func:`move` to apply an offset based on the previous position
      instead. The default position of a transformable object is (0, 0).

      :rtype: :class:`sfml.system.Vector2`

   .. py:attribute:: rotation

      Set/get the orientation of the object

      This attribute completely overwrites the previous rotation. See
      :func:`rotate` to add an angle based on the previous rotation
      instead. The default rotation of a transformable object is 0.

      :rtype: float

   .. py:attribute:: ratio

      Set/get the scale factors of the object

      This function completely overwrites the previous ratio. See
      :func:`scale` to add a factor based on the previous scale
      instead. The default scale of a transformable object is (1, 1).

      :rtype: :class:`sfml.system.Vector2`

   .. py:attribute:: origin

      Set/get the local origin of the object

      The origin of an object defines the center point for all
      transformations (position, scale, rotation). The coordinates of
      this point must be relative to the top-left corner of the object,
      and ignore all transformations (position, scale, rotation). The
      default origin of a transformable object is (0, 0).

      :rtype: :class:`sfml.system.Vector2`

   .. py:method:: move(offset)

      Move the object by a given offset.

      This function adds to the current position of the object, unlike
      :attr:`position` which overwrites it. Thus, it is equivalent to
      the following code::

         object.position = object.position + offset

      :param sfml.system.Vector2 offset: Offset

   .. py:method:: rotate(angle)

      Rotate the object.

      This function adds to the current rotation of the object, unlike
      :attr:`rotation` which overwrites it. Thus, it is equivalent to
      the following code::

         object.rotation = object.rotation + angle

   .. py:method:: scale(factor)

      Scale the object.

      This function multiplies the current scale of the object, unlike
      :attr:`ratio` which overwrites it. Thus, it is equivalent to the
      following code::

         object.ratio = object.ratio * factor

   .. py:attribute:: transform

      Get the combined transform of the object.

      :rtype: :class:`sfml.graphics.Transform`

   .. py:attribute:: inverse_transform

      Get the inverse of the combined transform of the object.

      :rtype: :class:`sfml.graphics.Transform`

Sprite
^^^^^^

.. py:class:: Sprite(sfml.graphics.Drawable, sfml.graphics.Transformable)

   :class:`Drawable` representation of a texture, with its own
   transformations, color, etc.

   :class:`Sprite` is a drawable class that allows to easily display
   a texture (or a part of it) on a render target.

   It inherits all the functions from :class:`Transformable`:
   position, rotation, scale, origin. It also adds sprite-specific
   properties such as the texture to use, the part of it to display,
   and some convenience functions to change the overall color of the
   sprite, or to get its bounding rectangle.

   :class:`Sprite` works in combination with the :class:`Texture`
   class, which loads and provides the pixel data of a given texture.

   The separation of :class:`Sprite` and :class:`Texture` allows
   more flexibility and better performances: indeed a
   :class:`Texture` is a heavy resource, and any operation on it is
   slow (often too slow for real-time applications). On the other side,
   an :class:`Sprite` is a lightweight object which can use the pixel
   data of an :class:`Texture` and draw it with its own
   transformation/color/blending attributes.

   It is important to note that the :class:`Sprite` instance doesn't
   copy the texture that it uses, it only keeps a reference to it.
   Thus, an :class:`Texture` must not be destroyed while it is used
   by an :class:`Sprite`.

   Usage examples::

      # declare and load a texture
      try: texture = sf.Texture.from_file("texture.png")
      except IOError: exit(1)

      # create a sprite
      sprite = sf.Sprite(texture)
      sprite.texture_rectangle = sf.Rect((10, 10), (50, 30))
      sprite.color = sf.Color(255, 255, 255, 200)
      sprite.position = sf.Vector2(100, 25)

      # draw it
      window.draw(sprite)


   .. py:method:: Sprite(texture[, rectangle])

      Construct the sprite from (a sub-rectangle of) a source texture.

      :param sfml.graphics.Texture texture: Source texture
      :param sfml.graphics.Rect rectangle: Sub-rectangle of the texture to assign to the sprite

   .. py:attribute:: texture

      Change the source texture of the sprite.

      The texture argument refers to a texture that must exist as long
      as the sprite uses it. Indeed, the sprite doesn't store its own
      copy of the texture, but rather keeps a pointer to the one that
      you passed to this function. If the source texture is destroyed
      and the sprite tries to use it, the behaviour is undefined. The
      :attr:`texture_rectangle` property of the sprite is automatically
      adjusted to the size of the new texture

      .. note::

         Note that in C++, you must explicitly tell you want the texture rectangle to be reset. Here, the texture rectangle is reset by default.

      :rtype: :class:`sfml.graphics.Texture`

   .. py:attribute:: texture_rectangle

      Set/get the sub-rectangle of the texture that the sprite will
      display.

      The texture rectangle is useful when you don't want to display
      the whole texture, but rather a part of it. By default, the
      texture rectangle covers the entire texture.

   .. py:attribute:: color

      Set/get the global color of the sprite.

      This color is modulated (multiplied) with the sprite's texture.
      It can be used to colorize the sprite, or change its global
      opacity. By default, the sprite's color is opaque white.

   .. py:attribute:: local_bounds

      Get the local bounding rectangle of the entity.

      The returned rectangle is in local coordinates, which means that
      it ignores the transformations (translation, rotation, scale,
      ...) that are applied to the entity. In other words, this
      function returns the bounds of the entity in the entity's
      coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:attribute:: global_bounds

      Get the global bounding rectangle of the entity.

      The returned rectangle is in global coordinates, which means that
      it takes in account the transformations (translation, rotation,
      scale, ...) that are applied to the entity. In other words, this
      function returns the bounds of the sprite in the global 2D
      world's coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

Text
^^^^

.. py:class:: Text(sfml.graphics.Drawable, sfml.graphics.Transformable)

      Graphical text that can be drawn to a render target.

      :class:`Text` is a drawable class that allows to easily
      display some text with custom style and color on a render target.

      It inherits all the functions from :class:`Transformable`:
      position, ratio, scale, origin. It also adds text-specific
      properties such as the font to use, the character size, the font
      style (bold, italic, underlined, strike through), the global color
      and the text to display of course.
      It also provides convenience functions to calculate the graphical size
      of the text, or to get the global position of a given character.

      :class:`Text` works in combination with the :class:`Font`
      class, which loads and provides the glyphs (visual characters) of
      a given font.

      The separation of :class:`Font` and :class:`Text` allows
      more flexibility and better performances: indeed a :class:`Font` is
      a heavy resource, and any operation on it is slow (often too slow
      for real-time applications). On the other side, a
      :class:`Text` is a lightweight object which can combine the
      glyphs data and metrics of an :class:`Font` to display any text
      on a render target.

      It is important to note that the :class:`Text` instance
      doesn't copy the font that it uses, it only keeps a reference to
      it. Thus, an :class:`Font` must not be destructed while it is
      used by an :class:`Text`.

      Usage example::

         # declare and load a font
         try: font = sf.Font.from_file("arial.ttf")
         except IOError: exit(1)

         # create a text
         text = sf.Text("hello")
         text.font = font
         text.character_size = 30
         text.style = sf.Text.BOLD
         text.color = sf.Color.RED

         # draw it
         window.draw(text)

      +----------------+------------------------------+
      | Style          | Description                  |
      +================+==============================+
      | REGULAR        | Regular characters, no style |
      +----------------+------------------------------+
      | BOLD           | Bold characters              |
      +----------------+------------------------------+
      | ITALIC         | Italic characters            |
      +----------------+------------------------------+
      | UNDERLINED     | Underlined characters        |
      +----------------+------------------------------+
      | STRIKE_THROUGH | Strike through characters    |
      +----------------+------------------------------+

   .. py:method:: Text([string[, font[, character_size=30]]])

      Construct the string, and optionally from a string, font and size.

      :param str: Text assigned to the string
      :type string: bytes or string
      :param sfml.graphics.Font font: Font used to draw the string
      :param integer character_size: Base size of characters, in pixels

   .. py:data:: REGULAR

      Regular characters, no style.

   .. py:data:: BOLD

      Bold characters.

   .. py:data:: ITALIC

      Italic characters.

   .. py:data:: UNDERLINED

      Underlined characters.

   .. py:data:: STRIKE_THROUGH

      Strike through characters.

   .. py:attribute:: string

      Set/get the text's string.

      :rtype: bytes or string

   .. py:attribute:: font

      Set/get the text's font.

      The font argument refers to a font that must exist as long as the
      text uses it. Indeed, the text doesn't store its own copy of the
      font, but rather keeps a reference to the one that you set to
      this attribute. If the font is destroyed and the text tries to
      use it, the behaviour is undefined.

      :rtype: :class:`sfml.graphics.Font`

   .. py:attribute:: character_size

      Set/get the character size.

      The default size is 30.

      :rtype: integer

   .. py:attribute:: style

      Set/get the text's style.

      You can pass a combination of one or more styles, for example ::

         text.style = sf.Text.BOLD | sf.Text.ITALIC

      The default style is :data:`REGULAR`.

      :rtype: integer

   .. py:attribute:: color

      Set/get the global color of the text.

      By default, the text's color is opaque white.

      :rtype: :class:`sfml.graphics.Color`

   .. py:attribute:: local_bounds

      Get the local bounding rectangle of the entity.

      The returned rectangle is in local coordinates, which means that
      it ignores the transformations (translation, rotation, scale,
      ...) that are applied to the entity. In other words, this
      property returns the bounds of the entity in the entity's
      coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:attribute:: global_bounds

      Get the global bounding rectangle of the entity.

      The returned rectangle is in global coordinates, which means that
      it takes in account the transformations (translation, rotation,
      scale, ...) that are applied to the entity. In other words, this
      property returns the bounds of the text in the global 2D world's
      coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:method:: find_character_pos(index)

      Return the position of the index-th character.

      This function computes the visual position of a character from
      its index in the string. The returned position is in global
      coordinates (translation, rotation, scale and origin are
      applied). If index is out of range, the position of the end of
      the string is returned.

      :param integer index: Index of the character
      :return: Position of the character
      :rtype: :class:`sfml.system.Vector2`


Shape
^^^^^

.. py:class:: Shape(sfml.graphics.Drawable, sfml.graphics.Transformable)

   Base class for textured shapes with outline.

   :class:`Shape` is a drawable class that allows to define and
   display a custom convex shape on a render target.

   It's only an abstract base, it needs to be specialized for concrete
   types of shapes (circle, rectangle, convex polygon, star, ...).

   In addition to the attributes provided by the specialized shape
   classes, a shape always has the following attributes:

       * a texture
       * a texture rectangle
       * a fill color
       * an outline color
       * an outline thickness

   Each feature is optional, and can be disabled easily:

       * the texture can be null
       * the fill/outline colors can be :const:`Color.TRANSPARENT`
       * the outline thickness can be zero


   .. py:method:: Shape()

      Shape is abstract, it would raise an error :exc:`NotImplementedError`

   .. py:attribute:: texture

      Change or get the source texture of the shape.

      The texture argument refers to a texture that must exist as long
      as the shape uses it. Indeed, the shape doesn't store its own
      copy of the texture, but rather keeps a pointer to the one that y
      ou passed to this function. If the source texture is destroyed
      and the shape tries to use it, the behaviour is undefined.
      texture can be *None* to disable texturing. The texture_rectangle
      property of the shape is automatically adjusted to the size of
      the new texture.

      .. note::

         Note that in C++, you must explicitly tell you want the texture rectangle to be reset. Here, the texture rectangle is reset by default.

      :rtype: :class:`sfml.graphics.Texture` or None

   .. py:attribute:: texture_rectangle

      Set/get the sub-rectangle of the texture that the shape will display.

      The texture rectangle is useful when you don't want to display
      the whole texture, but rather a part of it. By default, the
      texture rectangle covers the entire texture.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:attribute:: fill_color

      Set/get the fill color of the shape.

      This color is modulated (multiplied) with the shape's texture if
      any. It can be used to colorize the shape, or change its global
      opacity. You can use :const:`Color.TRANSPARENT` to make the
      inside of the shape transparent, and have the outline alone. By
      default, the shape's fill color is opaque white.

      :rtype: :class:`sfml.graphics.Color`

   .. py:attribute:: outline_color

      Set/get the outline color of the shape.

      You can use :const:`Color.TRANSPARENT` to disable the outline.
      By default, the shape's outline color is opaque white.

      :rtype: :class:`sfml.graphics.Color`

   .. py:attribute:: outline_thickness

      Set/get the thickness of the shape's outline.

      This number cannot be negative. Using zero disables the outline.
      By default, the outline thickness is 0.

      :rtype: float

   .. py:attribute:: local_bounds

      Get the local bounding rectangle of the entity.

      The returned rectangle is in local coordinates, which means that
      it ignores the transformations (translation, rotation, scale,
      ...) that are applied to the entity. In other words, this
      function returns the bounds of the entity in the entity's
      coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

   .. py:attribute:: global_bounds

      Get the global bounding rectangle of the entity.

      The returned rectangle is in global coordinates, which means that
      it takes in account the transformations (translation, rotation,
      scale, ...) that are applied to the entity. In other words, this
      function returns the bounds of the sprite in the global 2D
      world's coordinate system.

      :rtype: :class:`sfml.graphics.Rect`

CircleShape
^^^^^^^^^^^

.. py:class:: CircleShape(sfml.graphics.Shape)

   Specialized shape representing a circle.

   This class inherits all the functions of :class:`Transformable`
   (position, rotation, scale, bounds, ...) as well as the functions of
   :class:`Shape` (outline, color, texture, ...).

   Usage example::

      circle = sf.CircleShape()
      circle.radius = 150
      circle.outline_color = sf.Color.RED
      circle.outline_thickness = 5
      circle.position = (10, 20)
      # ...

      window.draw(circle)

   Since the graphics card can't draw perfect circles, we have to fake
   them with multiple triangles connected to each other. The "points
   count" property of :class:`CircleShape` defines how many of these
   triangles to use, and therefore defines the quality of the circle.

   The number of points can also be used for another purpose; with
   small numbers you can create any regular polygon shape: equilateral
   triangle, square, pentagon, hexagon, ...

   .. py:method:: CircleShape([radius[, point_count])

      Default constructor.

      :param float radius: Radius of the circle
      :param integer point_count: Number of points composing the circle

   .. py:attribute:: radius

      Set/get the radius of the circle.

      :rtype: float

   .. py:attribute:: point_count

      Set/get the number of points of the circle.

      :rtype: integer

   .. py:method:: get_point(index)

      Get a point of the shape.

      The result is undefined if index is out of the valid range.

      :param integer index: Index of the point to get, in range [0 .. :attr:`point_count` - 1]
      :return: Index-th point of the shape
      :rtype: :class:`sfml.system.Vector2`

ConvexShape
^^^^^^^^^^^

.. py:class:: ConvexShape(sfml.graphics.Shape)

   Specialized shape representing a convex polygon.

   This class inherits all the functions of :class:`Transformable`
   (position, rotation, scale, bounds, ...) as well as the functions of
   :class:`Shape` (outline, color, texture, ...).

   It is important to keep in mind that a convex shape must always
   be... convex, otherwise it may not be drawn correctly. Moreover, the
   points must be defined in order; using a random order would result
   in an incorrect shape.

   Usage example::

      polygon = sf.ConvexShape()
      polygon.point_count = 3
      polygon.set_point(0, (0, 0))
      polygon.set_point(1, (0, 10))
      polygon.set_point(2, (25, 5))
      polygon.outline_color = sf.Color.RED
      polygon.outline_thickness = 5
      polygon.position = (10, 20)
      # ...
      window.draw(polygon)

   .. py:method:: ConvexShape()

      Default constructor.

   .. py:attribute:: point_count

      Set/get the number of points of the polygon.

      *count* must be greater than 2 to define a valid shape.

      :rtype: integer

   .. py:method:: get_point(index)

      Get the position of a point.

      The result is undefined if index is out of the valid range.

      :param integer index: Index of the point to get, in range [0 .. :attr:`point_count` - 1]
      :return: Vector2 of the index-th point of the polygon
      :rtype: :class:`sfml.system.Vector2`

   .. py:method:: set_point(index, point)

      Set the position of a point.

      Don't forget that the polygon must remain convex, and the points
      need to stay ordered! :attr:`point_count` must be called first in
      order to set the total number of points. The result is undefined
      if index is out of the valid range.

      :param integer index: Index of the point to change, in range [0 .. :attr:`point_count` - 1]
      :param sfml.system.Vector2 point: New position of the point


RectangleShape
^^^^^^^^^^^^^^

.. py:class:: RectangleShape(sfml.graphics.Shape)

   Specialized shape representing a rectangle.

   This class inherits all the functions of :class:`Transformable`
   (position, rotation, scale, bounds, ...) as well as the functions of
   :class:`Shape` (outline, color, texture, ...).

   Usage example::

      rectangle = sf.RectangleShape()
      rectangle.size = (100, 50)
      rectangle.outline_color = sf.Color.RED
      rectangle.outline_thickness = 5
      rectangle.position = (10, 20)
      # ...

      window.draw(rectangle)

   .. py:method:: RectangleShape([size])

      Default constructor.

      :param sfml.system.Vector2 size: Size of the rectangle

   .. py:attribute:: size

      Set/get the size of the rectangle.

      :rtype: :class:`sfml.system.Vector2`

   .. py:attribute:: point_count

      Get the number of points defining the shape.

      :rtype: integer

   .. py:method:: get_point(index)

      Get the position of a point.

      The result is undefined if *index* is out of the valid range.

      :param integer index: Index of the point to get, in range [0 .. :attr:`point_count` - 1]
      :return: Vector2 of the index-th point of the shape
      :rtype: :class:`sfml.system.Vector2`


Vertex
^^^^^^

.. py:class:: Vertex

   Define a point with color and texture coordinates.

   A vertex is an improved point.

   It has a position and other extra attributes that will be used for
   drawing: in pySFML, vertices also have a color and a pair of
   texture coordinates.

   The vertex is the building block of drawing. Everything which is
   visible on screen is made of vertices. They are grouped as 2D
   primitives (triangles, quads, ...), and these primitives are
   grouped to create even more complex 2D entities such as sprites,
   texts, etc.

   If you use the graphical entities of pySFML (sprite, text, shape)
   you won't have to deal with vertices directly. But if you want to
   define your own 2D entities, such as tiled maps or particle
   systems, using vertices will allow you to get maximum performances.

   Example ::

      # define a 100x100 square, red, with a 10x10 texture mapped on it
      sf.Vertex(sf.Vector2(  0,   0), sf.Color.RED, sf.Vector2( 0,  0))
      sf.Vertex(sf.Vector2(  0, 100), sf.Color.RED, sf.Vector2( 0, 10))
      sf.Vertex(sf.Vector2(100, 100), sf.Color.RED, sf.Vector2(10, 10))
      sf.Vertex(sf.Vector2(100,   0), sf.Color.RED, sf.Vector2(10,  0))

      # all arguments are optional
      sf.Vertex()
      sf.Vertex(color=sf.Color.RED)
      sf.Vertex((50, 100), sf.Color.BLUE)
      sf.Vertex(tex_coords=(20, 20))

   Note: although texture coordinates are supposed to be an integer
   amount of pixels, their type is float because of some buggy
   graphics drivers that are not able to process integer coordinates
   correctly.

   .. py:method:: Vertex([position[, color[, tex_coords]]])

      Construct the vertex from its position, color and texture
      coordinates.

      :param sfml.system.Vector2 position: :class:`Vertex` position
      :param sfml.graphics.Color color: :class:`Vertex` color
      :param sfml.system.Vector2 tex_coords: :class:`Vertex` texture coordinates

   .. py:attribute:: position

      2D position of the vertex

      :rtype: :class:`sfml.system.Vector2`

   .. py:attribute:: color

      Color of the vertex.

      :rtype: :class:`sfml.graphics.Color`

   .. py:attribute:: tex_coords

      Coordinates of the texture's pixel to map to the vertex.

      :rtype: :class:`sfml.system.Vector2`

VertexArray
^^^^^^^^^^^

.. py:class:: VertexArray(sfml.graphics.Drawable)

   Define a set of one or more 2D primitives.

   :class:`VertexArray` is a very simple wrapper around a dynamic
   array of vertices and a primitives type.

   It inherits :class:`Drawable`, but unlike other drawables it is
   not transformable.

   Example::

      lines = sf.VertexArray(sf.PrimitiveType.LINES_STRIP, 2)
      lines[0].position = (10, 0)
      lines[1].position = (20, 0)

      lines.append(sf.Vertex((30, 5)))

      lines.resize(4)
      lines[3].position = (40, 2)

      window.draw(lines)

   .. py:method:: VertexArray([type[, vertex_count]])

      Construct the vertex array with a type and an initial number of
      vertices.

      :param sfml.graphics.PrimitiveType type: Type of primitives
      :param integer vertex_count: Initial number of vertices in the array

   .. py:method:: __len__()

      Return the vertex count.

   .. py:method:: __getitem__(index)

      Get an access to a vertex by its index.

   .. py:method:: __setitem__(index, vertex)

      Set a vertex by its index.

   .. py:method:: clear()

      Clear the vertex array.

      This method removes all the vertices from the array. It doesn't
      deallocate the corresponding memory, so that adding new vertices
      after clearing doesn't involve reallocating all the memory.

   .. py:method:: resize(vertex_count)

      Resize the vertex array.

      If *vertex_count* is greater than the current size, the previous
      vertices are kept and new (default-constructed) vertices are
      added. If *vertex_count* is less than the current size, existing
      vertices are removed from the array.

   .. py:method:: append()

      Add a vertex to the array.

   .. py:attribute:: primitive_type:

      Set/get the type of primitives to draw.

      This defines how the vertices must be interpreted when it's time
      to draw them:

         - As points
         - As lines
         - As triangles
         - As quads

      The default primitive type is :const:`POINTS`.

      :rtype: :class:`sfml.graphics.PrimitiveType`

   .. py:attribute:: bounds

      Compute the bounding rectangle of the vertex array.

      This returns the axis-aligned rectangle that contains all the
      vertices of the array.

      :rtype: :class:`sfml.graphics.Rect`


View
^^^^

.. class:: View

   2D camera that defines what region is shown on screen

   :class:`View` defines a camera in the 2D scene.

   This is a very powerful concept: you can scroll, rotate or zoom the
   entire scene without altering the way that your drawable objects are
   drawn.

   A view is composed of a source rectangle, which defines what part of
   the 2D scene is shown, and a target viewport, which defines where the
   contents of the source rectangle will be displayed on the render target
   (window or texture).

   The viewport allows to map the scene to a custom part of the render
   target, and can be used for split-screen or for displaying a minimap,
   for example. If the source rectangle has not the same size as the
   viewport, its contents will be stretched to fit in.

   To apply a view, you have to assign it to the render target. Then,
   every objects drawn in this render target will be affected by the view
   until you use another view.

   Usage example::

      view = sf.View()

      # initialize the view to a rectangle located at (100, 100) and with a size of 400x200
      view.reset(sf.Rect((100, 100), (400, 200)))

      # rotate it by 45 degrees
      view.rotate(45)

      # set its target viewport to be half of the window
      view.viewport = sf.Rect((0, 0), (0.5, 1))

      # apply it
      window.view = view

      # render stuff
      window.draw(some_sprites)

      # set the default view back
      window.view = window.default_view

      # render stuff not affected by the view
      window.draw(some_text)

   .. method:: View([rectangle])

      Construct the view, and optionally from a rectangle.

      :param sfml.graphics.Rect rectangle: Rectangle defining the zone to display

   .. attribute:: center

      Set/get the center of the view.

      :rtype: :class:`sfml.system.Vector2`

   .. attribute:: size

      Set/get the size of the view.

      :rtype: :class:`sfml.system.Vector2`

   .. attribute:: rotation

      Set/get the orientation of the view.

      The default rotation of a view is 0 degree.

      :rtype: float

   .. attribute:: viewport

      Set/get the target viewport.

      The viewport is the rectangle into which the contents of the view
      are displayed, expressed as a factor (between 0 and 1) of the
      size of the :class:`RenderTarget` to which the view is applied.
      For example, a view which takes the left side of the target would
      be defined with *view.viewport = (0, 0, 0.5, 1)*. By default, a
      view has a viewport which covers the entire target.

   .. method:: reset(rectangle)

      Reset the view to the given rectangle.

      Note that this function resets the rotation angle to 0.

      :param sfml.graphics.Rect rectangle: Rectangle defining the zone to display

   .. method:: move(offset)

      Move the view relatively to its current position.

      :param sfml.system.Vector2 offset: Move offset

   .. method:: rotate(angle)

      Rotate the view relatively to its current orientation.

      :param float angle: Angle to rotate, in degrees

   .. method:: zoom(factor)

      Resize the view rectangle relatively to its current size.

      Resizing the view simulates a zoom, as the zone displayed on
      screen grows or shrinks. factor is a multiplier:

          * 1 keeps the size unchanged
          * > 1 makes the view bigger (objects appear smaller)
          * < 1 makes the view smaller (objects appear bigger)

      :param float factor: Zoom factor to apply

   .. attribute:: transform

      Get the projection transform of the view.

      This function is meant for internal use only.

      :return: Projection transform defining the view
      :rtype: :class:`sfml.graphics.Transform`

   .. attribute:: inverse_transform

      Get the inverse projection transform of the view.

      This function is meant for internal use only.

      :return: Inverse of the projection transform defining the view
      :rtype: :class:`sfml.graphics.Transform`

RenderTarget
^^^^^^^^^^^^

.. py:class:: RenderTarget

   Base class for all render targets (window, texture, ...)

   :class:`RenderTarget` defines the common behaviour of all the
   2D render targets usable in the graphics module.

   It makes it possible to draw 2D entities like sprites, shapes,
   text without using any OpenGL command directly.

   A :class:`RenderTarget` is also able to use views
   (:class:`View`), which are a kind of 2D cameras. With views
   you can globally scroll, rotate or zoom everything that is drawn,
   without having to transform every single entity. See the
   documentation of :class:`View` for more details and sample
   pieces of code about this class.

   On top of that, render targets are still able to render direct
   OpenGL stuff. It is even possible to mix together OpenGL calls
   and regular SFML drawing commands. When doing so, make sure that
   OpenGL states are not messed up by calling the
   :func:`push_GL_states`/:func:`pop_GL_states` functions.

   .. py:method:: RenderTarget()

      This class is abstract.

   .. py:method:: clear([color=sfml.graphics.Color(0, 0, 0, 255)])

      Clear the entire target with a single color.

      This function is usually called once every frame, to clear the
      previous contents of the target.

      :param sfml.graphics.Color color: Fill color to use to clear the render target

   .. py:attribute:: view

      Change or get the current active view.

      The view is like a 2D camera, it controls which part of the 2D
      scene is visible, and how it is viewed in the render-target. The
      new view will affect everything that is drawn, until another view
      is set. The render target keeps its own copy of the view object,
      so it is not necessary to keep the original one alive after
      calling this function. To restore the original view of the
      target, you can set the result of :attr:`default_view` to this
      attribute.

      :rtype: :class:`sfml.graphics.View`

   .. py:attribute:: default_view

      Get the default view of the render target.

      The default view has the initial size of the render target, and
      never changes after the target has been created.

   .. py:method:: get_viewport(view)

      Get the viewport of a view, applied to this render target.

      The viewport is defined in the view as a ratio, this function
      simply applies this ratio to the current dimensions of the render
      target to calculate the pixels rectangle that the viewport
      actually covers in the target.

      :param sfml.graphics.View view: The view for which we want to compute the viewport
      :return: Viewport rectangle, expressed in pixels
      :rtype: :class:`sfml.graphics.Rect`

   .. py:method:: convert_coords(point[, view])

      Convert a point from target coordinates to view coordinates.

      Initially, a unit of the 2D world matches a pixel of the render
      target. But if you define a custom view, this assertion is not
      true anymore, ie. a point located at (10, 50) in your render
      target (for example a window) may map to the point (150, 75) in
      your 2D world -- for example if the view is translated by
      (140, 25).

      For render windows, this function is typically used to find which
      point (or object) is located below the mouse cursor.

      It uses a custom view for calculations if provided, otherwise, it
      uses the current view of the render target.

      :param sfml.system.Vector2 point: Point to convert, relative to the render target
      :param sfml.graphics.View view: The view to use for converting the point
      :return: The converted point, in "world" units
      :rtype: :class:`sfml.system.Vector2`

   .. py:method:: draw(drawable[, states])

      Draw a drawable object to the render-target.

      :param sfml.graphics.Drawable drawable: Object to draw
      :param sfml.graphics.RenderStates states: Render states to use for drawing

   .. py:attribute:: size

      Return the size of the rendering region of the target.

      :rtype: :class:`sfml.system.Vector2`

   .. py:attribute:: width

      Return the width of the rendering region of the target.

      :rtype: integer

   .. py:attribute:: height

      Return the height of the rendering region of the target.

      :rtype: integer

   .. py:method:: push_GL_states()

      Save the current OpenGL render states and matrices.

      This function can be used when you mix pySFML drawing and direct
      OpenGL rendering. Combined with :func:`pop_GL_states`, it ensures
      that:

          * pySFML's internal states are not messed up by your OpenGL code
          * your OpenGL states are not modified by a call to a pySFML function

      More specifically, it must be used around code that calls :func:`draw` functions. Example::

         # OpenGL code here...
         window.push_GL_state()
         window.draw(...)
         window.draw(...)
         window.pop_GL_states()
         # OpenGL code here...

      Note that this function is quite expensive, as it saves all the
      possible OpenGL states and matrices, even the ones you don't care
      about. Therefore it should be used wisely. It is provided for
      convenience, but the best results will be achieved if you handle
      OpenGL states yourself (because you know which states have really
      changed, and need to be saved and restored). Take a look at the
      :func:`reset_GL_states` function if you do so.

   .. py:method:: pop_GL_states()

      Restore the previously saved OpenGL render states and matrices.

      See the description of :func:`push_GL_states` to get a detailed
      description of these functions.

   .. py:method:: reset_GL_states()

      Reset the internal OpenGL states so that the target is ready for
      drawing.

      This function can be used when you mix pySFML drawing and direct
      OpenGL rendering, if you choose not to use
      :func:`push_GL_states`/:func:`pop_GL_states`. It makes sure that
      all OpenGL states needed by pySFML are set, so that subsequent
      :func:`draw` calls will work as expected.

         # OpenGL code here...
         glPushAttrib(...)
         window.reset_GL_states()
         window.draw(...)
         window.draw(...)
         glPopAttrib(...)
         # OpenGL code here...

RenderWindow
^^^^^^^^^^^^

.. py:class:: RenderWindow(sfml.graphics.Window, sfml.graphics.RenderTarget)

   :class:`.Window` that can serve as a target for 2D drawing.

   :class:`RenderWindow` is the main class of the graphics module.

   It defines an OS window that can be painted using the other classes
   of the graphics module.

   :class:`RenderWindow` is derived from :class:`.Window`, thus it
   inherits all its features: events, window management, OpenGL
   rendering, etc. See the documentation of :class:`.Window` for a
   more complete description of all these features, as well as code
   examples.

   On top of that, :class:`RenderWindow` adds more features related
   to 2D drawing with the graphics module (see its base class
   :class:`RenderTarget` for more details). Here is a typical
   rendering and event loop with an :class:`RenderWindow`

   .. py:method:: RenderWindow(mode, title[, style[, settings]])

      Construct a new window.

      This constructor creates the window with the size and pixel depth
      defined in mode. An optional style can be passed to customize the
      look and behaviour of the window (borders, title bar, resizable,
      closable, ...).

      The fourth parameter is an optional structure specifying advanced
      OpenGL context settings such as antialiasing, depth-buffer bits,
      etc. You shouldn't care about these parameters for a regular
      usage of the graphics module.

      :param sfml.window.VideoMode mode: Video mode to use (defines the width, height and depth of the rendering area of the window)
      :param str title: Title of the window
      :param style:	Window style
      :type style: :class:`sfml.window.Style`'s constant
      :param sfml.window.ContextSettings settings: Additional settings for the underlying OpenGL context

   .. py:method:: capture()

      Copy the current contents of the window to an image.

      This is a slow operation, whose main purpose is to make
      screenshots of the application. If you want to update an image
      with the contents of the window and then use it for drawing, you
      should rather use an :class:`Texture` and its
      :func:`Texture.update_from_window` function. You can also draw things directly
      to a texture with the :class:`RenderTexture` class.

      :return: Image containing the captured contents
      :rtype: :class:`sfml.graphics.Image`

RenderTexture
^^^^^^^^^^^^^

.. py:class:: RenderTexture(sfml.graphics.RenderTarget)

   Target for off-screen 2D rendering into an texture.

   :class:`RenderTexture` is the little brother of :class:`RenderWindow`.

   It implements the same 2D drawing and OpenGL-related functions (see
   their base class :class:`RenderTarget` for more details), the
   difference is that the result is stored in an off-screen texture
   rather than being show in a window.

   Rendering to a texture can be useful in a variety of situations:

       * precomputing a complex static texture (like a level's background from multiple tiles)
       * applying post-effects to the whole scene with shaders
       * creating a sprite from a 3D object rendered with OpenGL
       * etc.

   Usage example::

      # create a new render-window
      window = sf.RenderWindow(sf.VideoMode(800, 600), "pySFML - RenderWindow")

      # create a new render-texture
      texture = sf.RenderTexture.create(500, 500)

      # the main loop
      while window.is_open:

         # ...

         # clear the whole texture with red color
         texture.clear(sf.Color.RED)

         # draw stuff to the texture
         texture.draw(sprite)
         texture.draw(shape)
         texture.draw(text)

         # we're done drawing to the texture
         texture.display()

         # now we start rendering to the window, clear it first
         window.clear()

         # draw the texture
         sprite = sf.Sprite(texture.texture)
         window.draw(sprite)

         # end the current frame and display its content on screen
         window.display()

   .. py:method:: RenderTexture(width, height[, depth_buffer=False])

      Construct the render-texture.

      The last parameter, *depth_buffer*, is useful if you want to use
      the render-texture for 3D OpenGL rendering that requires a
      depth-buffer. Otherwise it is unnecessary, and you should leave
      this parameter to false (which is its default value).

      :param integer width: Width of the render-texture
      :param integer height: Height of the render-texture
      :param integer depth_buffer: Do you want this render-texture to have a depth buffer?
      :rtype: :class:`sfml.graphics.RenderTexture`

   .. py:attribute:: smooth

      Enable or disable texture smoothing.

      This property is similar to :attr:`Texture.smooth`. This
      parameter is disabled by default.

      :rtype: bool

   .. py:attribute:: active

      Activate of deactivate the render-texture for rendering.

      This function makes the render-texture's context current for
      future OpenGL rendering operations (so you shouldn't care about
      it if you're not doing direct OpenGL stuff). Only one context can
      be current in a thread, so if you want to draw OpenGL geometry to
      another render target (like an :class:`RenderWindow`) don't
      forget to activate it again.

      :rtype: bool

   .. py:method:: display()

      Update the contents of the target texture.

      This function updates the target texture with what has been drawn
      so far. Like for windows, calling this function is mandatory at
      the end of rendering. Not calling it may leave the texture in an
      undefined state.

   .. py:attribute:: texture

      Get a read-only reference to the target texture.

      After drawing to the render-texture and calling :func:`display`,
      you can retrieve the updated texture using this function, and
      draw it using a sprite (for example). The internal
      :class:`Texture` of a render-texture is always the same
      instance, so that it is possible to call this function once and
      keep a reference to the texture even after it is modified.

      :rtype: :class:`sfml.graphics.Texture`
