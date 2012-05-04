#include "hacks.hpp"
#include <iostream>

PyDrawable::PyDrawable(void* pyThis):
sf::Drawable (),
m_pyThis     (static_cast<PyObject*>(pyThis))
{
    import_sfml__graphics__graphics(); // make sure the graphics module is imported
};


void PyDrawable::Render(sf::RenderTarget& target, sf::Renderer& renderer) const
{
    static char format[] = "(O, O)";
	static char methodName[] = "render";
    
    PyObject* pyTarget = (PyObject*)(wrap_render_target_instance(&target));
    PyObject* pyRenderer = (PyObject*)(wrap_renderer_instance(&renderer));
    
    PyObject_CallMethod(m_pyThis, methodName, format, pyTarget, pyRenderer);
}
