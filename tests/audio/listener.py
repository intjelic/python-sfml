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

print("sf.Listener constructors")

try:
	listener = sf.Listener()
	raise UserWarning("sf.Listener can't be instantiated!")
	
except UserWarning:
	pass

print("sf.Listener.global_volume")
global_volume = sf.Listener.get_global_volume()
assert type(global_volume) == float

sf.Listener.set_global_volume(50)
assert sf.Listener.get_global_volume() == 50.

print("sf.Listener.position")
position = sf.Listener.get_position()
assert type(position) == sf.Vector3

sf.Listener.set_position(sf.Vector3(10, 20, 30))
assert sf.Listener.get_position() == (10, 20, 30)

sf.Listener.set_position((20, 30, 40))
assert sf.Listener.get_position() == sf.Vector3(20, 30, 40)

print("sf.Listener.direction")
direction = sf.Listener.get_direction()
assert type(direction) == sf.Vector3

sf.Listener.set_direction(sf.Vector3(10, 20, 30))
assert sf.Listener.get_direction() == (10, 20, 30)

sf.Listener.set_direction((20, 30, 40))
assert sf.Listener.get_direction() == sf.Vector3(20, 30, 40)
