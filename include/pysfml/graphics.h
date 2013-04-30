#ifndef __PYX_HAVE__sfml__graphics
#define __PYX_HAVE__sfml__graphics

struct PyRectangleObject;
struct PyColorObject;
struct PyImageObject;
struct PyTextureObject;
struct PyRenderStatesObject;
struct PyDrawableObject;
struct PyTransformableDrawableObject;
struct PySpriteObject;
struct PyShapeObject;
struct PyConvexShapeObject;
struct PyRenderTargetObject;

/* "sfml/graphics.pyx":93
 * 
 * 
 * cdef public class Rectangle [type PyRectangleType, object PyRectangleObject]:             # <<<<<<<<<<<<<<
 * 	cdef public Vector2 position
 * 	cdef public Vector2 size
 */
struct PyRectangleObject {
  PyObject_HEAD
  struct PyVector2Object *position;
  struct PyVector2Object *size;
};

/* "sfml/graphics.pyx":202
 * 
 * 
 * cdef public class Color [type PyColorType, object PyColorObject]:             # <<<<<<<<<<<<<<
 * 	BLACK = Color(0, 0, 0)
 * 	WHITE = Color(255, 255, 255)
 */
struct PyColorObject {
  PyObject_HEAD
  sf::Color *p_this;
};

/* "sfml/graphics.pyx":387
 * 
 * 
 * cdef public class Image[type PyImageType, object PyImageObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.Image *p_this
 * 
 */
struct PyImageObject {
  PyObject_HEAD
  sf::Image *p_this;
};

/* "sfml/graphics.pyx":519
 * 
 * 
 * cdef public class Texture[type PyTextureType, object PyTextureObject]:             # <<<<<<<<<<<<<<
 * 	NORMALIZED = sf.texture.Normalized
 * 	PIXELS = sf.texture.Pixels
 */
struct PyTextureObject {
  PyObject_HEAD
  sf::Texture *p_this;
  int delete_this;
};

/* "sfml/graphics.pyx":1029
 * 
 * 
 * cdef public class RenderStates[type PyRenderStatesType, object PyRenderStatesObject]:             # <<<<<<<<<<<<<<
 * 	DEFAULT = wrap_renderstates(<sf.RenderStates*>&sf.renderstates.Default, False)
 * 
 */
struct PyRenderStatesObject {
  PyObject_HEAD
  sf::RenderStates *p_this;
  int delete_this;
  struct __pyx_obj_4sfml_8graphics_Transform *m_transform;
  struct PyTextureObject *m_texture;
  struct __pyx_obj_4sfml_8graphics_Shader *m_shader;
};

/* "sfml/graphics.pyx":1106
 * 
 * 
 * cdef public class Drawable[type PyDrawableType, object PyDrawableObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.Drawable *p_drawable
 * 
 */
struct PyDrawableObject {
  PyObject_HEAD
  sf::Drawable *p_drawable;
};

/* "sfml/graphics.pyx":1175
 * 			return wrap_transform(p)
 * 
 * cdef public class TransformableDrawable(Drawable)[type PyTransformableDrawableType, object PyTransformableDrawableObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.Transformable *p_transformable
 * 
 */
struct PyTransformableDrawableObject {
  struct PyDrawableObject __pyx_base;
  sf::Transformable *p_transformable;
};

/* "sfml/graphics.pyx":1239
 * 
 * 
 * cdef public class Sprite(TransformableDrawable)[type PySpriteType, object PySpriteObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.Sprite *p_this
 * 	cdef Texture           m_texture
 */
struct PySpriteObject {
  struct PyTransformableDrawableObject __pyx_base;
  sf::Sprite *p_this;
  struct PyTextureObject *m_texture;
};

/* "sfml/graphics.pyx":1377
 * 
 * 
 * cdef public class Shape(TransformableDrawable)[type PyShapeType, object PyShapeObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.Shape *p_shape
 * 	cdef Texture          m_texture
 */
struct PyShapeObject {
  struct PyTransformableDrawableObject __pyx_base;
  sf::Shape *p_shape;
  struct PyTextureObject *m_texture;
};

/* "sfml/graphics.pyx":1477
 * 			self.p_this.setPointCount(count)
 * 
 * cdef public class ConvexShape(Shape)[type PyConvexShapeType, object PyConvexShapeObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.ConvexShape *p_this
 * 
 */
struct PyConvexShapeObject {
  struct PyShapeObject __pyx_base;
  sf::ConvexShape *p_this;
};

/* "sfml/graphics.pyx":1718
 * 
 * 
 * cdef public class RenderTarget[type PyRenderTargetType, object PyRenderTargetObject]:             # <<<<<<<<<<<<<<
 * 	cdef sf.RenderTarget *p_rendertarget
 * 
 */
struct PyRenderTargetObject {
  PyObject_HEAD
  sf::RenderTarget *p_rendertarget;
};

#ifndef __PYX_HAVE_API__sfml__graphics

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyRectangleType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyColorType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyImageType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyTextureType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyRenderStatesType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyDrawableType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyTransformableDrawableType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PySpriteType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyShapeType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyConvexShapeType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyRenderTargetType;

#endif /* !__PYX_HAVE_API__sfml__graphics */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initgraphics(void);
#else
PyMODINIT_FUNC PyInit_graphics(void);
#endif

#endif /* !__PYX_HAVE__sfml__graphics */
