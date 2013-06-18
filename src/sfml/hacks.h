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

extern "C" {

    #if PY_VERSION_HEX >= 0x03000000
        Py_ssize_t PyUnicode_AsWideChar(PyObject* o, wchar_t *w, Py_ssize_t size);
    #else
        Py_ssize_t PyUnicode_AsWideChar(PyUnicodeObject* o, wchar_t *w, Py_ssize_t size);
    #endif
}
