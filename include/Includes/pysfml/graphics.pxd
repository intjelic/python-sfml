# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

cimport sfml as sf
from pysfml.system cimport Vector2
from pysfml.system cimport NumericObject

cdef extern from "pysfml/graphics/graphics.h":
    cdef class sfml.graphics.Rect [object PyRectObject]:
        cdef sf.Rect[NumericObject] *p_this

    cdef class sfml.graphics.Color [object PyColorObject]:
        cdef sf.Color *p_this

    cdef class sfml.graphics.BlendMode [object PyBlendModeObject]:
        cdef sf.BlendMode *p_this

    cdef class sfml.graphics.Image [object PyImageObject]:
        cdef sf.Image *p_this

    cdef class sfml.graphics.Texture [object PyTextureObject]:
        cdef sf.Texture *p_this
        cdef bint delete_this

    cdef class sfml.graphics.Drawable [object PyDrawableObject]:
        cdef sf.Drawable *p_drawable

    cdef class sfml.graphics.TransformableDrawable(Drawable) [object PyTransformableDrawableObject]:
        cdef sf.Transformable *p_transformable

    cdef class sfml.graphics.Sprite(TransformableDrawable) [object PySpriteObject]:
        cdef sf.Sprite *p_this
        cdef Texture m_texture

    cdef class sfml.graphics.Shape(TransformableDrawable) [object PyShapeObject]:
        cdef sf.Shape *p_shape
        cdef Texture m_texture

    cdef class sfml.graphics.ConvexShape(Shape) [object PyConvexShapeObject]:
        cdef sf.ConvexShape *p_this

    cdef class sfml.graphics.RenderTarget [object PyRenderTargetObject]:
        cdef sf.RenderTarget *p_rendertarget

    cdef class sfml.graphics.RenderStates [object PyRenderStatesObject]:
        pass

cdef extern from "pysfml/graphics/graphics_api.h":
    cdef void import_sfml__graphics()

    cdef Color wrap_color(sf.Color *p)

    cdef Rect wrap_rect(sf.Rect[NumericObject]*)
    cdef Rect wrap_intrect(sf.IntRect*)
    cdef Rect wrap_floatrect(sf.FloatRect*)
    cdef sf.FloatRect to_floatrect(object)
    cdef sf.IntRect to_intrect(object)

    cdef BlendMode wrap_blendmode(sf.BlendMode*)
    cdef Image wrap_image(sf.Image*)
    cdef Texture wrap_texture(sf.Texture*, bint)
    cdef RenderStates wrap_renderstates(sf.RenderStates*, bint)
    cdef object wrap_convexshape(sf.ConvexShape*)
    cdef object wrap_rendertarget(sf.RenderTarget*)
