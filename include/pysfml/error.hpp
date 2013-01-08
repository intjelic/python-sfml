////////////////////////////////////////////////////////////////////////////////
//
// pySFML - Python bindings for SFML
// Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////


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
