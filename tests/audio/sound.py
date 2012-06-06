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
from soundsource import test_sound_source

print("sf.Sound constructor")
buffer = sf.SoundBuffer.load_from_file("data/canary.wav")
a = sf.Sound()
b = sf.Sound(buffer)

print("sf.Sound.buffer")
a.buffer = buffer


print("sf.SoundSource")
test_sound_source(a)
test_sound_source(b)

print("sf.Sound.play()")
a.play()
sf.sleep(sf.seconds(2))

print("sf.Sound.pause()")
a.pause()
sf.sleep(sf.seconds(0.5))
a.play()
sf.sleep(sf.seconds(2))

print("sf.Sound.stop()")
a.stop()
sf.sleep(sf.seconds(0.5))
a.play()
sf.sleep(sf.seconds(2))

print("sf.Sound.loop")
loop = a.loop
assert type(loop) == bool
a.loop = not loop

print("sf.Sound.playing_offset")
a.stop()
a.play()
sf.sleep(sf.milliseconds(500))
a.play()
playing_offset = a.playing_offset
sf.sleep(sf.milliseconds(500))
a.playing_offset = sf.Time.ZERO
a.play()

print("sf.Sound.status")
assert type(a.status) == int



