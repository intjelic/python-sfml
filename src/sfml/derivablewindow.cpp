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


#include "pysfml/derivablewindow.hpp"


DerivableWindow::DerivableWindow():
sf::Window ()
{
}

DerivableWindow::DerivableWindow(sf::VideoMode mode, const std::string& title, sf::Uint32 style, const sf::ContextSettings& settings):
sf::Window (mode, title, style, settings)
{
}

DerivableWindow::DerivableWindow(sf::WindowHandle handle, const sf::ContextSettings& settings):
sf::Window (handle, settings)
{
}

void DerivableWindow::onCreate()
{
	static char method[] = "on_create";
    PyObject_CallMethod(m_pyobj, method, NULL);
}

void DerivableWindow::onResize()
{
	static char method[] = "on_resize";
    PyObject_CallMethod(m_pyobj, method, NULL);
}

void DerivableWindow::set_pyobj(void* pyobj)
{
	m_pyobj = static_cast<PyObject*>(pyobj);
}
