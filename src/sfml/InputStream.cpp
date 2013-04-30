////////////////////////////////////////////////////////////////////////////////
//
// pySFML - Python bindings for SFML
// Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////


#include <Python.h>
#include "InputStream.hpp"
#include <iostream>


#if PY_VERSION_HEX >= 0x03020000
InputStream::InputStream(PyObject* stream) :
m_stream   (stream)
{
	Py_INCREF(m_stream);
	std::cout << m_stream << std::endl;
}

sf::Int64 InputStream::read(void* data, sf::Int64 size)
{
	std::cout << "read" << std::endl;
	std::cout << m_stream << std::endl;
	Py_INCREF(m_stream);
	PyObject* bytes = PyObject_CallMethod(m_stream, "read", "(L)" , PyLong_FromLong(size));
	data = PyBytes_AsString(bytes);

	return PyBytes_Size(bytes);
}

sf::Int64 InputStream::seek(sf::Int64 position)
{
	std::cout << "seek" << std::endl;
	PyObject* actualPos = PyObject_CallMethod(m_stream, "seek", "O" , PyLong_FromLong(position));

	return PyLong_AsLong(actualPos);
}


sf::Int64 InputStream::tell()
{
	std::cout << "tell" << std::endl;
	PyObject* position = PyObject_CallMethod(m_stream, "tell", NULL);

	return PyLong_AsLong(position);
}

sf::Int64 InputStream::getSize()
{
// TODO: Improve translation of this Python code
//
//	try:
//		size = len(stream)
//	except AttributeError:
//		cur_pos = stream.tell()
//		stream.seek(0, io.SEEK_END)
//		size = stream.tell()
//		stream.seek(cur_pos)
//	else:
//		raise NotImplementedError(
//			"Derived classes of sf.InputStream have to override __len__ method")

	//int size = -1;

	//size = PyObject_Size(m_stream)
	//if (size == -1)
		//PyErr_Clear();

	//sf::Int64 currentPos = tell();
	//PyObject_CallMethod(m_stream, "seek", "(O, O)" , PyInt_FromLong(0), PyInt_FromLong(2));	// io.SEEK_END = 2
	//int size = tell();
	std::cout << "getSize" << std::endl;
	return -1;

}
#else

InputStream::InputStream(PyObject* stream) :
m_stream   (stream)
{
}

sf::Int64 InputStream::read(void* data, sf::Int64 size)
{
	std::cout << "read" << std::endl;
	PyObject* bytes = PyObject_CallMethod(m_stream, "read", "O" , PyInt_FromLong(size));
	data = PyString_AsString(bytes);

	return PyString_Size(bytes);
}

sf::Int64 InputStream::seek(sf::Int64 position)
{
	std::cout << "seek" << std::endl;
	PyObject* actualPos = PyObject_CallMethod(m_stream, "seek", "O" , PyInt_FromLong(position));

	return PyInt_AsLong(actualPos);
}


sf::Int64 InputStream::tell()
{
	std::cout << "tell" << std::endl;
	PyObject* position = PyObject_CallMethod(m_stream, "tell", NULL);

	return PyInt_AsLong(position);
}

sf::Int64 InputStream::getSize()
{
// TODO: Improve translation of this Python code
//
//	try:
//		size = len(stream)
//	except AttributeError:
//		cur_pos = stream.tell()
//		stream.seek(0, io.SEEK_END)
//		size = stream.tell()
//		stream.seek(cur_pos)
//	else:
//		raise NotImplementedError(
//			"Derived classes of sf.InputStream have to override __len__ method")

	//int size = -1;

	//size = PyObject_Size(m_stream)
	//if (size == -1)
		//PyErr_Clear();

	//sf::Int64 currentPos = tell();
	//PyObject_CallMethod(m_stream, "seek", "(O, O)" , PyInt_FromLong(0), PyInt_FromLong(2));	// io.SEEK_END = 2
	//int size = tell();
	std::cout << "getSize" << std::endl;
	return -1;

}
#endif
