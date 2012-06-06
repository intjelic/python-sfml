#include "error.hpp"

void replace_error_handler()
{
	static std::stringbuf errorbuffer;
	sf::err().rdbuf(&errorbuffer);
}

// This function should return PyObject* but as, i don't know why, 
// using PyString_FromString triggers 'was not declared in this scope',
// I temporarly return a std::string.
std::string get_last_error_message()
{
	// get the stream buffer
	std::stringbuf* errorbuffer;
	errorbuffer = static_cast<std::stringbuf*>(sf::err().rdbuf());
	
	// get the error message
	static std::string errormessage;
	errormessage = errorbuffer->str();
	
	//PyObject* pyerrormessage = PyString_FromString(errormessage.c_str());
	std::string pyerrormessage = errormessage;
	
	// clean the stream buffer to welcome the next error message
	errormessage.clear();
	errorbuffer->str(errormessage);
	
	return pyerrormessage;
}