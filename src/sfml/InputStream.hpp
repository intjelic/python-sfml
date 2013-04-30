////////////////////////////////////////////////////////////////////////////////
//
// pySFML - Python bindings for SFML
// Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
//
// This software is released under the LGPLv3 license.
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////

#ifndef PYSFML_INPUTSTREAM_HPP
#define PYSFML_INPUTSTREAM_HPP


////////////////////////////////////////////////////////////////////////////////
// Headers
////////////////////////////////////////////////////////////////////////////////
#include <Python.h>
#include <SFML/System.hpp>

class InputStream : public sf::InputStream
{
public :
    InputStream(PyObject* stream);

    sf::Int64 read(void* data, sf::Int64 size);
    sf::Int64 seek(sf::Int64 position);

    sf::Int64 tell();
    sf::Int64 getSize();

private :
	PyObject* m_stream;
};


#endif // PYSFML_INPUTSTREAM_HPP
