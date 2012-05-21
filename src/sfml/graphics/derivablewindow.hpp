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
