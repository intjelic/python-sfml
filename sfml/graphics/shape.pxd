########################################################################
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>   #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################


from declsystem cimport Vector2f, FloatRect
from declgraphics cimport Color, Shape


cdef extern from "SFML/Graphics.hpp" namespace "sf::Shape":
    cdef Shape Line(float, float, float, float, float, Color&, float)
    cdef Shape Line(float, float, float, float, float, Color&, float, Color&)
    cdef Shape Line(Vector2f&, Vector2f&, float, Color&, float, Color&)
    cdef Shape Rectangle(float, float, float, float, Color&, float)
    cdef Shape Rectangle(float, float, float, float, Color&, float, Color&)
    cdef Shape Rectangle(FloatRect&, Color&, float, Color&)
    cdef Shape Circle(float, float, float, Color&, float)
    cdef Shape Circle(float, float, float, Color&, float, Color&)
    cdef Shape Circle(Vector2f&, float, Color&, float, Color&)
