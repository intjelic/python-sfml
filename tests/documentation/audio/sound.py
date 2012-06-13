try: buffer = sf.SoundBuffer.load_from_file("sound.wav")
except IOError: exit(1)

sound = sf.Sound()
sound.buffer = buffer
sound.play()
