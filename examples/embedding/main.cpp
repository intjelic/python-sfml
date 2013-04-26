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

// Including Python.h first is mandatory!
#include <Python.h>

#include <unistd.h>
#include <iostream>

// Make sure to include the SFML headers before the pySFML ones
#include <SFML/Graphics.hpp>
#include <pysfml/graphics_api.h>

int main(int argc, char *argv[])
{
    // Initialization (mandatory stuff)
    Py_SetProgramName(argv[0]);
    Py_Initialize();

    // Add the current path to sys.path to find our script
    char cwd[1024];
    if (!getcwd(cwd, sizeof(cwd))) {
        std::cout << "Couldn't get the current path" << std::endl;
        return EXIT_FAILURE; }
    PyObject *sys = PyImport_ImportModule("sys");
    PyObject *path = PyObject_GetAttrString(sys, "path");
    PyList_Append(path, PyString_FromString(cwd));

    // Import our script that creates a texture
    PyObject* script = PyImport_ImportModule("script");
    if(!script)
        PyErr_Print();

    // Retrieve the texture
    PyTextureObject *texture;
    texture = (PyTextureObject*)PyObject_GetAttrString(script, "texture");

    // Create a window and display the texture for five seconds
    sf::RenderWindow window(sf::VideoMode(640, 480), "pySFMl - Embedding Python");

    window.clear();
    window.draw(sf::Sprite(*texture->p_this));
    window.display();

    sf::sleep(sf::seconds(5));

    // Then, terminate properly...
    Py_Finalize();

    return EXIT_SUCCESS;
}
