class CustomRecorder(sf.SoundRecorder):
	def __init__(self):
		sf.SoundRecorder.__init__(self)
		
	def on_start(self): # optional
		# initialize whatever has to be done before the capture starts
		...

		# return true to start playing
		return True
		
		
	def on_process_samples(self, samples):
	 # do something with the new chunk of samples (store them, send them, ...)
	 ...

	 # return true to continue playing
	 return True
	 
	def on_stop(): # optional
		# clean up whatever has to be done after the capture ends
		...

# usage
if CustomRecorder.is_available():
	recorder = CustomRecorder()
	recorder.start()
	...
	recorder.stop()
