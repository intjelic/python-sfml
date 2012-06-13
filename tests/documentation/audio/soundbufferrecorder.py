if sf.SoundBufferRecorder.is_available():
	# record some audio data
	recorder = sf.SoundBufferRecorder()
	recorder.start()
	...
	recorder.stop()
	
	# get the buffer containing the captured audio data
	buffer = recorder.buffer
	
	# save it to a file (for example...)
	buffer.save_to_file("my_record.ogg")
