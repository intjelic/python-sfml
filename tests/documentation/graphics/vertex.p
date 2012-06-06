#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.graphics as sf

# define a 100x100 square, red, with a 10x10 texture mapped on it
	sf.Vertex(sf.Position(  0,   0), sf.Color.RED, sf.Position( 0,  0))
	sf.Vertex(sf.Position(  0, 100), sf.Color.RED, sf.Position( 0, 10))
	sf.Vertex(sf.Position(100, 100), sf.Color.RED, sf.Position(10, 10))
	sf.Vertex(sf.Position(100,   0), sf.Color.RED, sf.Position(10,  0))
	)

# draw it
window.draw_(vertices)
