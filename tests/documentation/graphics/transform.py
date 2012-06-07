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

# define a translation transform
translation = sf.Transform()
translation.translate((20, 50))

# define a rotation transform
rotation = sf.Transform()
rotation.rotate(45)

# combine them
transform = translation * rotation

# use the result to transform stuff...
point = transform.transform_point((10, 20))
rectangle = transform.transform_rectangle(sf.Rectangle((0, 0), (10, 100)))
