#include "derivablewindow.hpp"


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
