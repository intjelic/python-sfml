#ifndef ERROR_HPP
#define ERROR_HPP

#include "Python.h"

#include <iostream>
#include <sstream>
#include <string>

#include <SFML/System.hpp>

void replace_error_handler();
std::string get_last_error_message();

#endif // ERROR_HPP
