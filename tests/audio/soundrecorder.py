import sfml as sf

class MySoundRecorder(sf.SoundRecorder):
	def __init__(self):
		sf.SoundRecorder.__init__(self)

	def on_start(self):
		print("on_start")
		return True
		
	def on_process_samples(self, chunk):
		print("on_process_samples")
		print(type(chunk))
		return True
		
	def on_stop(self):
		print("on_stop")
		
foo = MySoundRecorder()

input()
foo.start(44100)
input("a")
print("b")
foo.stop()
input("foo")
input("bar")
