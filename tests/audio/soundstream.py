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

class CustomStream(sf.SoundStream):
	def __init__(self):
		sf.SoundStream.__init__(self)
		
		self.initialize(1, 44100)
		
	def open(self, location): pass
		
	def on_get_data(self, data):
		return True
		
	def on_seek(self, time_offset):
		pass


mystream = CustomStream()
mystream.play()
input()
