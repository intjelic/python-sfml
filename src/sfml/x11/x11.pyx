cimport declx11


# This function is needed to flush the screen when we integrate pySFML 
# to PyQt
def flush_screen(int d):
	# cdef declx11.Display* myDisplay = declx11.XOpenDisplay(":0")
	cdef declx11.Display* myDisplay = <declx11.Display*>d
	declx11.XFlush(myDisplay)
