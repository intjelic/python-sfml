#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


cimport libcpp.sfml as sf
from pysfml.system cimport Vector2

cdef extern from "pysfml/graphics.h":
	cdef class sfml.graphics.Rectangle [object PyRectangleObject]:
		cdef public Vector2 position
		cdef public Vector2 size

	cdef class sfml.graphics.Color [object PyColorObject]:
		cdef sf.Color *p_this

	cdef class sfml.graphics.Image [object PyImageObject]:
		cdef sf.Image *p_this

	cdef class sfml.graphics.Texture [object PyTextureObject]:
		cdef sf.Texture *p_this
		cdef bint               delete_this

	cdef class sfml.graphics.Drawable [object PyDrawableObject]:
		cdef sf.Drawable *p_drawable

	cdef class sfml.graphics.TransformableDrawable(Drawable) [object PyTransformableDrawableObject]:
		cdef sf.Transformable *p_transformable

	cdef class sfml.graphics.Sprite(TransformableDrawable) [object PySpriteObject]:
		cdef sf.Sprite *p_this
		cdef Texture           m_texture

	cdef class sfml.graphics.Shape(TransformableDrawable) [object PyShapeObject]:
		cdef sf.Shape *p_shape
		cdef Texture          m_texture

	cdef class sfml.graphics.ConvexShape(Shape) [object PyConvexShapeObject]:
		cdef sf.ConvexShape *p_this

	cdef class sfml.graphics.RenderTarget [object PyRenderTargetObject]:
		cdef sf.RenderTarget *p_rendertarget

	cdef class sfml.graphics.RenderStates [object PyRenderStatesObject]:
		pass

cdef inline sf.FloatRect to_floatrect(rectangle):
	l, t, w, h = rectangle
	return sf.FloatRect(l, t, w, h)

cdef inline sf.IntRect to_intrect(rectangle):
	l, t, w, h = rectangle
	return sf.IntRect(l, t, w, h)

cdef inline Rectangle intrect_to_rectangle(sf.IntRect* intrect):
	return Rectangle((intrect.left, intrect.top), (intrect.width, intrect.height))

cdef inline Rectangle floatrect_to_rectangle(sf.FloatRect* floatrect):
	return Rectangle((floatrect.left, floatrect.top), (floatrect.width, floatrect.height))

cdef inline Color wrap_color(sf.Color *p):
	cdef Color r = Color.__new__(Color)
	r.p_this = p
	return r

cdef inline ConvexShape wrap_convexshape(sf.ConvexShape *p):
	cdef ConvexShape r = ConvexShape.__new__(ConvexShape)
	r.p_this = p
	r.p_drawable = <sf.Drawable*>p
	r.p_transformable = <sf.Transformable*>p
	r.p_shape = <sf.Shape*>p

	return r
