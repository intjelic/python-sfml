#include "derivablerenderwindow.hpp"


DerivableRenderWindow::DerivableRenderWindow():
sf::RenderWindow ()
{
}

DerivableRenderWindow::DerivableRenderWindow(sf::VideoMode mode, const std::string& title, sf::Uint32 style, const sf::ContextSettings& settings):
sf::RenderWindow (mode, title, style, settings)
{
}

DerivableRenderWindow::DerivableRenderWindow(sf::WindowHandle handle, const sf::ContextSettings& settings):
sf::RenderWindow (handle, settings)
{
}

void DerivableRenderWindow::onCreate()
{
	static char method[] = "on_create";
    PyObject_CallMethod(m_pyobj, method, NULL);
}

void DerivableRenderWindow::onResize()
{
	static char method[] = "on_resize";
    PyObject_CallMethod(m_pyobj, method, NULL);
}

void DerivableRenderWindow::set_pyobj(void* pyobj)
{
	m_pyobj = static_cast<PyObject*>(pyobj);
}
