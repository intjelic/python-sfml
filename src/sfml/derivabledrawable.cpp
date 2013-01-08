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


#include "pysfml/derivabledrawable.hpp"
#include <iostream>

DerivableDrawable::DerivableDrawable(void* pyobj):
sf::Drawable (),
m_pyobj      (static_cast<PyObject*>(pyobj))
{
	import_sfml__graphics(); // make sure the graphics module is imported
};

void DerivableDrawable::draw(sf::RenderTarget& target, sf::RenderStates states) const
{
    static char format[] = "(O, O)";
	static char methodName[] = "draw";
    
    PyObject* pyTarget = (PyObject*)(wrap_rendertarget(&target));
    PyObject* pyStates = (PyObject*)(api_wrap_renderstates(&states));
    
    PyObject_CallMethod(m_pyobj, methodName, format, pyTarget, pyStates);
    
	Py_DECREF(pyTarget);
	Py_DECREF(pyStates);
}
