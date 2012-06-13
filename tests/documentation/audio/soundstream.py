class CustomStream(sf.SoundStream):
	def __init__(self):
		sf.SoundStream.__init__(self) # don't forget this
		
	def open(location):
		# open the source and get audio settings
		...
		channel_count = ...
		sample_rate = ...
		
		# initialize the stream -- important!
		self.initialize(channel_count, sample_rate)
		
	def on_get_data(self, data):
		# fill the chunk with audio data from the stream source
		data += another_chunk
		
		# return true to continue playing
		return True
		
	def on_seek(self, time_offset):
		# change the current position in the stream source
		...
		
# usage
stream = CustomStream()
stream.open("path/to/stream")
stream.play()
