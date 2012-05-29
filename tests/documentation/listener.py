#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml as sf

# move the listener to the position (1, 0, -5)
sf.Listener.set_position((1, 0, -5))

# make it face the right axis (1, 0, 0)
sf.Listener.set_direction(sf.Vector(1, 0, 0))

# reduce the global volume
sf.Listener.set_global_volume = 50
