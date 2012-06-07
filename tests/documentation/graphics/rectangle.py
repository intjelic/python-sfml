#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.system as sf

# define a rectangle, located at (0, 0) with a size of 20x5
r1 = sf.Rectangle(sf.Position(0, 0), sf.Size(20, 5))
# or r1 = sf.Rectangle((0, 0), (20, 5))

# define another rectangle, located at (4, 2) with a size of 18x10
position = sf.Position(4, 2)
size = sf.Size(18, 10)

r2 = sf.Rectangle(position, size)

# test intersections with the point (3, 1)
b1 = r1.contains(sf.Position(3, 1)); # True
b2 = r2.contains((3, 1)); # False

# test the intersection between r1 and r2
result = r1.intersects(r2) # True

# as there's an intersection, the result is not None but sf.Rectangle(4, 2, 16, 3)
assert result == sf.Rectangle((4, 2), (16, 3)) 
