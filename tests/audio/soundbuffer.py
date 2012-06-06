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

print("sf.SoundBuffer constructor")
try:
	listener = sf.Listener()
	raise UserWarning("sf.SoundBuffer can only be instantiated with its specific constructors")
	
except UserWarning:
	pass
	
print("sf.SoundBuffer.load_from_file()")
a = sf.SoundBuffer.load_from_file("data/canary.wav")

try: c = sf.SoundBuffer.load_from_file("unexistingfile.ogg")
except IOError: pass
	
print("sf.SoundBuffer.load_from_memory()")
with open("data/orchestral.ogg", "rb") as f:
	b = sf.SoundBuffer.load_from_memory(f.read())
	
try: c = sf.SoundBuffer.load_from_memory(b"eajmeamoieafnokmjml")
except IOError: pass

print("sf.SoundBuffer.load_from_samples()")
c = sf.SoundBuffer.load_from_samples(a.samples, a.channel_count, a.sample_rate)
d = sf.SoundBuffer.load_from_samples(b.samples, b.channel_count, b.sample_rate)

print("sf.SoundBuffer.save_to_file()")
a.save_to_file("results/0.ogg")
b.save_to_file("results/1.wav")
c.save_to_file("results/2.flac")
d.save_to_file("results/3.aiff")
a.save_to_file("results/4.au")
b.save_to_file("results/5.raw")
c.save_to_file("results/6.paf")
d.save_to_file("results/7.svx")
a.save_to_file("results/8.nist")
b.save_to_file("results/9.voc")
c.save_to_file("results/10.ircam")
d.save_to_file("results/11.w64")
a.save_to_file("results/12.mat4")
b.save_to_file("results/13.mat5")
c.save_to_file("results/14.pvf")
d.save_to_file("results/15.htk")
a.save_to_file("results/16.sds")
b.save_to_file("results/17.avr")
c.save_to_file("results/18.sd2")
d.save_to_file("results/19.caf")
a.save_to_file("results/20.wve")
b.save_to_file("results/21.mpc2k")
c.save_to_file("results/22.rf64")

print("sf.SoundBuffer.samples")
def samples(sound_buffer):
	samples = sound_buffer.samples
	assert type(samples)  == sf.Chunk
	print(samples)
	
print("sf.SoundBuffer.sample_rate")
def sample_rate(sound_buffer):
	sample_rate = sound_buffer.sample_rate
	assert type(sample_rate) == int
	
sample_rate(a)
sample_rate(b)
sample_rate(c)
sample_rate(d)

print("sf.SoundBuffer.channel_count")
def channel_count(sound_buffer):
	channel_count = sound_buffer.channel_count
	assert type(channel_count) == int
	
channel_count(a)
channel_count(b)
channel_count(c)
channel_count(d)

print("sf.SoundBuffer.duration")
def duration(sound_buffer):
	duration = sound_buffer.duration
	assert type(duration) == sf.Time
	
duration(a)
duration(b)
duration(c)
duration(d)
