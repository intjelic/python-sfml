#ifndef DERIVABLE_RENDERWINDOW_HPP
#define DERIVABLE_RENDERWINDOW_HPP

#include "Python.h"
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>


class DerivableRenderWindow : public sf::RenderWindow
{
public :
	DerivableRenderWindow();
	DerivableRenderWindow(sf::VideoMode mode, const std::string& title, sf::Uint32 style = sf::Style::Default, const sf::ContextSettings& settings = sf::ContextSettings());
	explicit DerivableRenderWindow(sf::WindowHandle handle, const sf::ContextSettings& settings = sf::ContextSettings());

	void set_pyobj(void* pyobj);
	
protected:
	virtual void onCreate();
	virtual void onResize();
	
private:
	PyObject* m_pyobj; // the python object pointer
};


#endif // DERIVABLE_RENDERWINDOW_HPP
