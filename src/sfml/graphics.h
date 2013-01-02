#ifndef __PYX_HAVE__sfml__graphics
#define __PYX_HAVE__sfml__graphics

struct PyTextureObject;
struct PyDrawableObject;
struct PyRenderTargetObject;

/* "sfml/graphics.pyx":570
 * 
 * 
 * cdef public class Texture[type PyTextureType, object PyTextureObject]:             # <<<<<<<<<<<<<<
 * 	NORMALIZED = dgraphics.texture.Normalized
 * 	PIXELS = dgraphics.texture.Pixels
 */
struct PyTextureObject {
  PyObject_HEAD
  sf::Texture *p_this;
  int delete_this;
};

/* "sfml/graphics.pyx":1228
 * 
 * 
 * cdef public class Drawable[type PyDrawableType, object PyDrawableObject]:             # <<<<<<<<<<<<<<
 * 	cdef dgraphics.Drawable *p_drawable
 * 
 */
struct PyDrawableObject {
  PyObject_HEAD
  sf::Drawable *p_drawable;
};

/* "sfml/graphics.pyx":1832
 * 
 * 
 * cdef public class RenderTarget[type PyRenderTargetType, object PyRenderTargetObject]:             # <<<<<<<<<<<<<<
 * 	cdef dgraphics.RenderTarget *p_rendertarget
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

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyTextureType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyDrawableType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyRenderTargetType;

#endif /* !__PYX_HAVE_API__sfml__graphics */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initgraphics(void);
#else
PyMODINIT_FUNC PyInit_graphics(void);
#endif

#endif /* !__PYX_HAVE__sfml__graphics */
