#ifndef __PYX_HAVE__sfml__system
#define __PYX_HAVE__sfml__system

struct PyVector2Object;
struct PyVector3Object;
struct PyTimeObject;

/* "sfml/system.pyx":43
 * 
 * 
 * cdef public class Vector2[type PyVector2Type, object PyVector2Object]:             # <<<<<<<<<<<<<<
 * 	cdef public object x
 * 	cdef public object y
 */
struct PyVector2Object {
  PyObject_HEAD
  PyObject *x;
  PyObject *y;
};

/* "sfml/system.pyx":184
 * 		return cls(x, y)
 * 
 * cdef public class Vector3[type PyVector3Type, object PyVector3Object]:             # <<<<<<<<<<<<<<
 * 	cdef public object x
 * 	cdef public object y
 */
struct PyVector3Object {
  PyObject_HEAD
  PyObject *x;
  PyObject *y;
  PyObject *z;
};

/* "sfml/system.pyx":304
 * 
 * 
 * cdef public class Time[type PyTimeType, object PyTimeObject]:             # <<<<<<<<<<<<<<
 * 	ZERO = wrap_time(<dsystem.Time*>&dsystem.time.Zero)
 * 
 */
struct PyTimeObject {
  PyObject_HEAD
  sf::Time *p_this;
};

#ifndef __PYX_HAVE_API__sfml__system

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyVector2Type;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyVector3Type;
__PYX_EXTERN_C DL_IMPORT(PyTypeObject) PyTimeType;

#endif /* !__PYX_HAVE_API__sfml__system */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initsystem(void);
#else
PyMODINIT_FUNC PyInit_system(void);
#endif

#endif /* !__PYX_HAVE__sfml__system */
