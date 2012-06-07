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

p1 = sf.Position(16.5, 24)
p1.x = 18.2
y = p1.y

p2 = p1 * (5, 1)
p3 = p1 + p2

different = p2 != p3
