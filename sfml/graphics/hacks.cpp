#include "hacks.hpp"
#include <iostream>

PyDrawable::PyDrawable(void* obj):
sf::Drawable (),
m_obj (obj)
{
    import_sfml__graphics__graphics(); // make sure the graphics module imported
};

void PyDrawable::Render(sf::RenderTarget& target, sf::Renderer& renderer) const
{
    PyObject* pyTarget = (PyObject*)(wrap_render_target_instance(&target));
    PyObject* pyRenderer = (PyObject*)(wrap_renderer_instance(&renderer));
    
    PyObject_CallMethod(static_cast<PyObject*>(m_obj), "render", "(O, O)", pyTarget, pyRenderer);
}

