#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for pySFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from pysfml.system cimport Vector2
from pysfml cimport dgraphics

cdef extern from "pysfml/graphics.h":
	cdef class sfml.graphics.Rectangle [object PyRectangleObject]:
		cdef public Vector2 position
		cdef public Vector2 size
	
	cdef class sfml.graphics.Color [object PyColorObject]:
		cdef dgraphics.Color *p_this
	
	cdef class sfml.graphics.Image [object PyImageObject]:
		cdef dgraphics.Image *p_this

	cdef class sfml.graphics.Drawable [object PyDrawableObject]:
		cdef dgraphics.Drawable *p_drawable
		
	cdef class sfml.graphics.TransformableDrawable(Drawable) [object PyTransformableDrawableObject]:
		cdef dgraphics.Transformable *p_transformable
		
	cdef class sfml.graphics.Sprite(TransformableDrawable) [object PySpriteObject]:
		cdef dgraphics.Sprite *p_this
		cdef Texture           m_texture
		
	cdef class sfml.graphics.Shape(TransformableDrawable) [object PyShapeObject]:
		cdef dgraphics.Shape *p_shape
		cdef Texture          m_texture
		
	cdef class sfml.graphics.ConvexShape(Shape) [object PyConvexShapeObject]:
		cdef dgraphics.ConvexShape *p_this
	
	cdef class sfml.graphics.RenderTarget [object PyRenderTargetObject]:
		cdef dgraphics.RenderTarget *p_rendertarget
		
	cdef class sfml.graphics.RenderStates [object PyRenderStatesObject]:
		pass

cdef inline Color wrap_color(dgraphics.Color *p):
	cdef Color r = Color.__new__(Color)
	r.p_this = p
	return r
