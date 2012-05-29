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

clock = sf.Clock()
input()
a = clock.elapsed_time
input()
b = clock.elapsed_time
input()
c = clock.elapsed_time

print(a)
print(b)
print(c)

assert type(a) == sf.Time
assert type(b) == sf.Time
assert type(c) == sf.Time

input()
d = clock.restart()
print(d)
assert type(d) == sf.Time
