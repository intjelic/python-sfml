# load a new sound buffer from a file
try: buffer = sf.SoundBuffer.load_from_file("data/sound.wav")
except sf.SFMLException as error: exit()

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
