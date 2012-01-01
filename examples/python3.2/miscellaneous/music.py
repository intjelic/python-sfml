import sfml.audio as sf


music = sf.Music.open_from_file(b"audio/data/mario.flac")

print("### sf.SoundSource data ###")
print("pitch: {0}".format(music.pitch))
print("volume: {0}".format(music.volume))
print("relative_to_listener: {0}".format(music.relative_to_listener))
print("min_distance: {0}".format(music.min_distance))
print("attenuation: {0}".format(music.attenuation))

print("### sf.SoundStream data ###")
print("channels_count: {0}".format(music.channels_count))
print("sample_rate: {0}".format(music.sample_rate))
print("status: {0}".format(music.status))
print("loop: {0}".format(music.loop))
music.loop = True

print("### sf.Music data ###")
print("duration: {0}".format(music.duration))

print("### Others ###")
music.play()
input("Press enter to get the playing offset")
print("playing_offset: {0}".format(music.playing_offset))
input("Press enter to get the playing offset")
print("playing_offset: {0}".format(music.playing_offset))
offset = int(input("Set playing offset:"))
music.playing_offset = offset


input("Press enter to stop the music")
music.stop()

