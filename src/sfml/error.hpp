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


#ifndef PYSFML_ERROR_HPP
#define PYSFML_ERROR_HPP

#include "Python.h"

void restorePythonErrorBuffer();
PyObject* getLastErrorMessage();

#endif // PYSFML_ERROR_HPP
