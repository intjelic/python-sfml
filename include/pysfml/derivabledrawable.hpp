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


#ifndef DERIVABLE_DRAWABLE_HPP
#define DERIVABLE_DRAWABLE_HPP

#include "Python.h"
#include <SFML/Graphics.hpp>
#include "graphics_api.h"


class DerivableDrawable : public sf::Drawable
{
public :
	DerivableDrawable(void* pyThis);

protected:
	virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const;
	
	PyObject* m_pyobj;
};


#endif // DERIVABLE_DRAWABLE_HPP
