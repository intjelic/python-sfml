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

t1 = sf.seconds(0.1)
milli = t1.milliseconds

t2 = sf.milliseconds(30)
micro = t2.microseconds

t3 = sf.microseconds(-800000)
sec = t3.seconds

def update(elapsed):
	position += speed * elapsed.seconds
	
update(sf.milliseconds(100))
