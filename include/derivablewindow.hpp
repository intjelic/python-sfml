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


#ifndef DERIVABLE_WINDOW_HPP
#define DERIVABLE_WINDOW_HPP

#include "Python.h"
#include <SFML/Window.hpp>


class DerivableWindow : public sf::Window
{
public :
	DerivableWindow();
	DerivableWindow(sf::VideoMode mode, const std::string& title, sf::Uint32 style = sf::Style::Default, const sf::ContextSettings& settings = sf::ContextSettings());
	explicit DerivableWindow(sf::WindowHandle handle, const sf::ContextSettings& settings = sf::ContextSettings());

	void set_pyobj(void* pyobj);
	
protected:
	virtual void onCreate();
	virtual void onResize();
	
private:
	PyObject* m_pyobj; // the python object pointer
};


#endif // DERIVABLE_WINDOW_HPP
