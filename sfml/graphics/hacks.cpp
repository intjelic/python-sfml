#include "hacks.hpp"


PyDrawable::PyDrawable(void* obj):
sf::Drawable (),
m_obj (obj)
{
};

void PyDrawable::Render(sf::RenderTarget& target, sf::Renderer& renderer) const
{
    PyObject* pyTarget = (PyObject*)(wrap_render_target_instance(&target));
    PyObject* pyRenderer = (PyObject*)(wrap_renderer_instance(&renderer));
    
    PyObject_CallMethod(static_cast<PyObject*>(m_obj), "render", "(O, O)", pyTarget, pyRenderer);
}

