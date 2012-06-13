# declare a new music
music = sf.Music()

try: music = sf.Music.open_from_file("music.ogg")
except IOError: exit(1)

# change some parameters
music.position = (0, 1, 10) # change its 3D position
music.pitch = 2             # increase the pitch
music.volume = 50           # reduce the volume
music.loop = True           # make it loop

# play it
music.play()
