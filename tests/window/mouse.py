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

assert type(sf.Mouse.get_position()) == sf.Vector2

window = sf.RenderWindow(sf.VideoMode(640, 480), "pySFML2 - sf.Mouse")

window.position = (200, 200)

assert type(sf.Mouse.get_position(window)) == sf.Vector2

input()
sf.Mouse.set_position((0, 0))
input()
sf.Mouse.set_position((500, 500))
