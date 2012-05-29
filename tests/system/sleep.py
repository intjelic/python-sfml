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

print("Wait 2 seconds")
sf.sleep(sf.seconds(2))
print("Wait 1000 milliseconds")
sf.sleep(sf.milliseconds(1000))
print("Wait 500000 microseconds")
sf.sleep(sf.microseconds(500000))
