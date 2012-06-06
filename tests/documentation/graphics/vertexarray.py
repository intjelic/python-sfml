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

lines = sf.VertexArray(sf.PrimitiveType.LINES_STRIP, 4)
lines[0].position = (10, 0)
lines[1].position = (20, 0)
lines[2].position = (30, 5)
lines[3].position = (40, 2)

window.draw(lines)
