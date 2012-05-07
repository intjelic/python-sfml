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


from declsystem cimport Vector2f
from declgraphics cimport Matrix3


cdef extern from "SFML/Graphics.hpp" namespace "sf::Matrix3":
    cdef Matrix3 Transformation(Vector2f&, Vector2f&, float, Vector2f&)
    cdef Matrix3 Projection(Vector2f&, Vector2f&, float)
    cdef Matrix3 Identity
