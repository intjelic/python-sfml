#ifndef __PYX_HAVE__sfml__window
#define __PYX_HAVE__sfml__window

struct PyVideoModeObject;
struct PyContextSettingsObject;
struct PyPixelsObject;
struct PyWindowObject;

/* "sfml/window.pyx":472
 * 
 * 
 * cdef public class VideoMode[type PyVideoModeType, object PyVideoModeObject]:             # <<<<<<<<<<<<<<
 * 	cdef dwindow.VideoMode *p_this
 * 	cdef bint delete_this
 */
struct PyVideoModeObject {
  PyObject_HEAD
  sf::VideoMode *p_this;
  int delete_this;
};

/* "sfml/window.pyx":563
 * 
 * 
 * cdef public class ContextSettings[type PyContextSettingsType, object PyContextSettingsObject]:             # <<<<<<<<<<<<<<
 * 	cdef dwindow.ContextSettings *p_this
 * 
 */
struct PyContextSettingsObject {
  PyObject_HEAD
  sf::ContextSettings *p_this;
};

/* "sfml/window.pyx":622
 * 
 * 
 * cdef public class Pixels[type PyPixelsType, object PyPixelsObject]:             # <<<<<<<<<<<<<<
 * 	cdef Uint8*			 p_array
 * 	cdef unsigned int	 m_width
 */
struct PyPixelsObject {
  PyObject_HEAD
  sf::Uint8 *p_array;
  unsigned int m_width;
  unsigned int m_height;
};

/* "sfml/window.pyx":651
 * 
 * 
 * cdef public class Window[type PyWindowType, object PyWindowObject]:             # <<<<<<<<<<<<<<
 * 	cdef dwindow.Window *p_window
 * 	cdef bint			 m_visible
 */
struct PyWindowObject {
  PyObject_HEAD
  sf::Window *p_window;
  int m_visible;
  int m_vertical_synchronization;
};

#ifndef __PYX_HAVE_API__sfml__window

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyVideoModeType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyContextSettingsType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyPixelsType;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyWindowType;

__PYX_EXTERN_C DL_IMPORT(struct PyPixelsObject) *wrap_pixels(sf::Uint8 *, unsigned int, unsigned int);

#endif /* !__PYX_HAVE_API__sfml__window */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initwindow(void);
#else
PyMODINIT_FUNC PyInit_window(void);
#endif

#endif /* !__PYX_HAVE__sfml__window */
