#ifndef H_HACKS
#define H_HACKS

#include "Python.h"
#include <SFML/Graphics.hpp>
#include "graphics_api.h"


// See this class like Shape, Sprite and Text. They have already defined
// their Render method and if we want to make Drawable derivable with 
// python, this virtual method has to be defined too which can not be
// done with cython. Therefore this class is needed to call the suitable
// python method; render(self, target, renderer)
class PyDrawable : public sf::Drawable
{
public :
  PyDrawable(void* pyThis);

private :
	virtual void Render(sf::RenderTarget& target, sf::Renderer& renderer) const;

	PyObject* m_pyThis; // the python object pointer
};


#endif
