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

# load a new sound buffer from a file
try: buffer = sf.SoundBuffer.load_from_file("data/sound.wav")
except sf.SFMLException as error:
	# error...
	print("error?")
	exit()

# create a sound source and bind it to the buffer
sound1 = sf.Sound()
sound1.buffer = buffer

# play the sound
sound1.play();
input()

# create another sound source bound to the same buffer
sound2 = sf.Sound(buffer)

# play it with higher pitch -- the first sound remains unchanged
sound2.pitch = 2
sound2.play()
input()
