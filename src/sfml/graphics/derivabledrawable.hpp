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
