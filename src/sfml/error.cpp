////////////////////////////////////////////////////////////////////////////////
//
// pySFML - Python bindings for SFML
// Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Headers
////////////////////////////////////////////////////////////////////////////////
#include "error.hpp"
#include <sstream>
#include <SFML/System.hpp>

static std::stringbuf buffer;

// Insert our own buffer to retrieve and forward errors to Python
// exceptions. This function allows to restore the Python buffer in case people
// would interface Python with C++ code and so reredirect the error output.
void restorePythonErrorBuffer()
{
	sf::err().rdbuf(&buffer);
}

// Return the last error (if any) then clear the buffer to welcome the next one.
PyObject* getLastErrorMessage()
{
	// Get the error message then clean the buffer
	PyObject* error = PyString_FromString(buffer.str().c_str());
	buffer.str("");

	return error;
}
