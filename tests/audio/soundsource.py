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

print("sf.SoundSource constructor")
try:
	listener = sf.Listener()
	raise UserWarning("sf.SoundSource is not meant to be used directly!")
	exit(1)
	
except UserWarning:
	pass
	
	
def test_sound_source(sound_source):
	print("sf.SoundSource.pitch")
	pitch = sound_source.pitch
	assert type(pitch) == float

	sound_source.pitch = 2
	assert sound_source.pitch == 2.
	
	print("sf.SoundSource.volume")
	volume = sound_source.volume
	assert type(volume) == float
	
	sound_source.volume = 50
	assert sound_source.volume == 50.
	
	print("sf.SoundSource.position")
	position = sound_source.position
	assert type(position) == sf.Vector3
	
	sound_source.position = sf.Vector3(10, 20, 30)
	assert sound_source.position == (10, 20, 30)
	
	sound_source.position = (30, 40, 50)
	assert sound_source.position == sf.Vector3(30, 40, 50)
	
	print("sf.SoundSource.relative_to_listener")
	relative_to_listener = sound_source.relative_to_listener
	assert type(relative_to_listener) == bool
	sound_source.relative_to_listener = not relative_to_listener
	assert sound_source.relative_to_listener != relative_to_listener
	
	print("sf.SoundSource.min_distance")
	min_distance = sound_source.min_distance
	assert type(min_distance) == float
	
	sound_source.min_distance = 0.5
	assert sound_source.min_distance == 0.5
	
	print("sf.SoundSource.attenuation")
	attenuation = sound_source.attenuation
	assert type(attenuation) == float
	
	sound_source.attenuation = 0.5
	assert sound_source.attenuation == 0.5
