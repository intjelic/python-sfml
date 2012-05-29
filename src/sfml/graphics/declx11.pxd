cdef extern from "X11/Xlib.h":
	ctypedef struct Display

	Display *XOpenDisplay(char* display_name)
	void XFlush(Display* display)
