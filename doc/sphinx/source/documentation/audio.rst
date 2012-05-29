Audio
=====

.. module:: sf

.. class:: Vector

   .. attribute:: x
   .. attribute:: y
   .. attribute:: z

.. class:: Listener

   The audio listener is the point in the scene from where all the 
   sounds are heard.

   The audio listener defines the global properties of the audio 
   environment, it defines where and how sounds and musics are heard.

   If :class:`sf.View` is the eyes of the user, then 
   :class:`sf.Listener` is his ears (by the way, they are often linked 
   together -- same position, orientation, etc.).

   :class:`sf.Listener` is a simple interface, which allows to setup 
   the listener in the 3D audio environment (position and direction), 
   and to adjust the global volume.

   Because the listener is unique in the scene, :class:`sf.Listener`
   only contains class methods and doesn't have to be instanciated.

   Usage example::

      # move the listener to the position (1, 0, -5)
      sf.Listener.set_position((1, 0, -5))

      # make it face the right axis (1, 0, 0)
      sf.Listener.set_direction(sf.Vector(1, 0, 0))

      # reduce the global volume
      sf.Listener.set_global_volume = 50


   .. classmethod:: get_global_volume()

      Get the current value of the global volume.
      
      :return: Current global volume, in the range [0, 100]
      :rtype: float

   .. classmethod:: set_global_volume(volume)

      Change the global volume of all the sounds and musics.

      The volume is a number between 0 and 100; it is combined with 
      the individual volume of each sound / music. The default value 
      for the volume is 100 (maximum).
      
      :param float volume: New global volume, in the range [0, 100]
      
   .. classmethod:: get_position()

      Get the current position of the listener in the scene.
      
      :return: Listener's position
      :rtype: :class:`sf.Vector`
      
   .. classmethod:: set_position(position)

      Set the position of the listener in the scene.

      The default listener's position is (0, 0, 0).
      
      :param position: New listener's position
      :type position: :class:`sf.Vector` or tuple		

   .. classmethod:: get_direction()

      Get the current orientation of the listener in the scene.
      
      :return: Listener's orientation
      :rtype: :class:`sf.Vector`
      
   .. classmethod:: set_direction(direction)

      Set the orientation of the listener in the scene.
      
      The orientation defines the 3D axes of the listener (left, up, 
      front) in the scene. The orientation vector doesn't have to be 
      normalized. The default listener's orientation is (0, 0, -1).

      :param direction: New listener's orientation
      :type position: :class:`sf.Vector` or tuple	

.. class:: Chunk


.. class:: SoundBuffer

   Storage for audio samples defining a sound.

   A sound buffer holds the data of a sound, which is an array of 
   audio samples.

   A sample is a 16 bits signed integer that defines the amplitude of 
   the sound at a given time. The sound is then restituted by playing 
   these samples at a high rate (for example, 44100 samples per second 
   is the standard rate used for playing CDs). In short, audio samples 
   are like texture pixels, and a :class:`sf.SoundBuffer` is similar 
   to a :class:`sf.Texture`.

   A sound buffer can be loaded from a file (see 
   :func:`load_from_file()' for the complete list of supported 
   formats), from memory or directly from an array of samples. It can 
   also be saved back to a file.

   Sound buffers alone are not very useful: they hold the audio data 
   but cannot be played. To do so, you need to use the 
   :class:`sf.Sound` class, which provides functions to 
   play/pause/stop the sound as well as changing the way it is 
   outputted (volume, pitch, 3D position, ...). This separation allows 
   more flexibility and better performances: indeed a 
   :class:`sf.SoundBuffer` is a heavy resource, and any operation on 
   it is slow (often too slow for real-time applications). On the 
   other side, a :class:`sf.Sound` is a lightweight object, which can 
   use the audio data of a sound buffer and change the way it is 
   played without actually modifying that data. Note that it is also 
   possible to bind several :class:`sf.Sound` instances to the same 
   :class:`sf.SoundBuffer`.

   It is important to note that the :class:`sf.Sound` instance doesn't 
   copy the buffer that it uses, it only keeps a reference to it. 
   Thus, a :class:`sf.SoundBuffer` must not be destructed while it is 
   used by a :class:`sf.Sound` (i.e. never write a function that uses 
   a local :class:`sf.SoundBuffer` instance for loading a sound).

   Usage example::
   
      # load a new sound buffer from a file
      try: buffer = sf.SoundBuffer.load_from_file("data/sound.wav")
      except sf.SFMLException as error:
         # error...
         print("error?")
         exit()

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


   .. attribute:: channels_count
         
      Get the number of channels used by the sound.

      If the sound is mono then the number of channels will be 1, 2 for stereo, etc.
      
   .. attribute:: duration
   
      Get the total duration of the sound.
      
   .. attribute:: sample_rate
         
      Get the sample rate of the sound.

      The sample rate is the number of samples played per second. The higher, the better the quality (for example, 44100 samples/s is CD quality).
      
   .. attribute:: samples
         
      Get the array of audio samples stored in the buffer.

      The total number of samples in this array is given by the :py:attr:`samples_count` property.

   .. attribute:: samples_count
         
      Get the number of samples stored in the buffer.

      The array of samples can be accessed with the :py:attr:`samples` property.

   .. py:classmethod:: load_from_file(filename)
      
      Load the sound buffer from a file.

      Here is a complete list of all the supported audio formats: ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
         
      :param str filename: Path of the sound file to load
      :rtype: sf.SoundBuffer
      
   .. classmethod:: load_from_memory(data)
      
      Load the sound buffer from a file in memory.
      
      :param bytes data: The file data
      :rtype: sf.SoundBuffer
      
      Here is a complete list of all the supported audio formats: ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.

   .. classmethod:: load_from_samples(samples, channels_count, sample_rate)
   
      Load the sound buffer from an array of audio samples.

      :param list samples: The array of samples
      :param integer channels_count: Number of channels (1 = mono, 2 = stereo, ...)
      :param integer sample_rate: Sample rate (number of samples to play per second)
      :rtype: sf.SoundBuffer

   .. method:: save_to_file(filename)

      Save the sound buffer to an audio file.

      Here is a complete list of all the supported audio formats: ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.

      :param str filename: Path of the sound file to write
      
      
.. class:: SoundSource

   .. py:attribute:: STOPPED
   
      Sound is not playing. 
      
   .. py:attribute:: PAUSED
   
      Sound is paused.
   
   .. py:attribute:: PLAYING
   
      Sound is playing.
   
   .. attribute:: pitch
   
      The pitch of the sound.

      The pitch represents the perceived fundamental frequency of a sound; thus you can make a sound more acute or grave by changing its pitch. A side effect of changing the pitch is to modify the playing speed of the sound as well. The default value for the pitch is 1.

   .. attribute:: volume
         
      Set the volume of the sound.

      The volume is a value between 0 (mute) and 100 (full volume). The default value for the volume is 100.
      
   .. attribute:: position
         
      The 3D position of the sound in the audio scene.

      Only sounds with one channel (mono sounds) can be spatialized. The default position of a sound is (0, 0, 0).
      
   .. attribute:: relative_to_listener
   
      Make the sound's position relative to the listener or absolute.

      Making a sound relative to the listener will ensure that it will always be played the same way regardless the position of the listener. This can be useful for non-spatialized sounds, sounds that are produced by the listener, or sounds attached to it. The default value is false (position is absolute).

   .. attribute:: min_distance
   
      The minimum distance of the sound.

      The "minimum distance" of a sound is the maximum distance at which it is heard at its maximum volume. Further than the minimum distance, it will start to fade out according to its attenuation factor. A value of 0 ("inside the head of the listener") is an invalid value and is forbidden. The default value of the minimum distance is 1.
   
   .. attribute:: attenuation
      
      The attenuation factor of the sound.

      The attenuation is a multiplicative factor which makes the sound more or less loud according to its distance from the listener. An attenuation of 0 will produce a non-attenuated sound, i.e. its volume will always be the same whether it is heard from near or from far. On the other hand, an attenuation value such as 100 will make the sound fade out very quickly as it gets further from the listener. The default value of the attenuation is 1.


.. class:: Sound([SoundBuffer buffer])

   Regular sound that can be played in the audio environment.

   sf.Sound is the class to use to play sounds.

   It provides:
       - Control (play, pause, stop)
       - Ability to modify output parameters in real-time (pitch, volume, ...)
       - 3D spatial features (position, attenuation, ...).

   sf.Sound is perfect for playing short sounds that can fit in memory and require no latency, like foot steps or gun shots. For longer sounds, like background musics or long speeches, rather see sf.Music (which is based on streaming).

   In order to work, a sound must be given a buffer of audio data to play. Audio data (samples) is stored in sf.SoundBuffer, and attached to a sound with the :py:attr:`buffer` property. The buffer object attached to a sound must remain alive as long as the sound uses it. Note that multiple sounds can use the same sound buffer at the same time.

   Usage example::

      try:
         buffer = sf.SoundBuffer.load_from_file("sound.wav")
      except sf.SFMLException as error:
         print(str(error))
         exit(1)
         
      sound = sf.Sound(buffer)
      sound.play();

   .. attribute:: buffer
   
      The source buffer containing the audio data to play.

      It is important to note that the sound buffer is not copied, thus the sf.SoundBuffer instance must remain alive as long as it is attached to the sound.

   .. attribute:: loop
   
      Set/tell whether or not the sound should loop after reaching the end.

      If set, the sound will restart from beginning after reaching the end and so on, until it is stopped or SetLoop(false) is called. The default looping state for sound is false.
      
   .. attribute:: playing_offset
   
      Change the current playing position of the sound in milliseconds.

      The playing position can be changed when the sound is either paused or playing.
      
   .. attribute:: status

      Get the current status of the sound (stopped, paused, playing) 

   .. method:: play()
   
      Start or resume playing the sound.

      This function starts the stream if it was stopped, resumes it if it was paused, and restarts it from beginning if it was it already playing. This function uses its own thread so that it doesn't block the rest of the program while the sound is played.

   .. method:: pause()
         
      Pause the sound.

      This function pauses the sound if it was playing, otherwise (sound already paused or stopped) it has no effect.

   .. method:: stop()
   
      Stop playing the sound.

      This function stops the sound if it was playing or paused, and does nothing if it was already stopped. It also resets the playing position (unlike :py:func:`pause`).


.. class:: SoundStream

      Abstract base class for streamed audio sources.

      Unlike audio buffers (see :py:class:`SoundBuffer`), audio streams are never completely loaded in memory.

      Instead, the audio data is acquired continuously while the stream is playing. This behaviour allows to play a sound with no loading delay, and keeps the memory consumption very low.

      Sound sources that need to be streamed are usually big files (compressed audio musics that would eat hundreds of MB in memory) or files that would take a lot of time to be received (sounds played over the network).

      sf.SoundStream is a base class that doesn't care about the stream source, which is left to the derived class. SFML provides a built-in specialization for big files (see :py:class:`Music`). No network stream source is provided, but you can write your own by combining this class with the network module.

      A derived class has to override two virtual functions:
         - OnGetData fills a new chunk of audio data to be played
         - OnSeek changes the current playing position in the source

      It is important to note that each SoundStream is played in its own separate thread, so that the streaming loop doesn't block the rest of the program. In particular, the OnGetData and OnSeek virtual functions may sometimes be called from this separate thread. It is important to keep this in mind, because you may have to take care of synchronization issues if you share data between threads.

      Usage example::

         class CustomStream(sf.SoundStream):
            @classmethod
            def open(cls, location):
               # open the source and get audio settings
               channels_count = ...
               sample_rate = ...
               
               # create our new custom sound stream
               ret = cls.__new__(cls)
               
               # initialize it -- important!
               ret.initialized(channels_count, sample_rate)
               
               return ret

            def on_get_data(self, data):
               # fill the chunk with audio data from the stream source
               data.samples = ...
               data.nb_samples = ...
               
               # return true to continue playing
               return True

            def void on_seek(self, time_offset):
               # change the current position in the stream source
               ...

         # usage
         stream = CustomStream.open("path/to/stream")
         stream.play()

   .. attribute:: channels_count
         
      Return the number of channels of the stream.

      1 channel means a mono sound, 2 means stereo, etc.

   .. attribute:: sample_rate
   
      Get the stream sample rate of the stream.

      The sample rate is the number of audio samples played per second. The higher, the better the quality.

   .. attribute:: status

      Get the current status of the stream (stopped, paused, playing) 
      
   .. attribute:: playing_offset  
       
      Change the current playing position of the stream in milliseconds.

      The playing position can be changed when the stream is either paused or playing.
      
   .. attribute:: loop
   
      Set/tell whether or not the sound should loop after reaching the end.

      If set, the sound will restart from beginning after reaching the end and so on, until it is stopped or SetLoop(false) is called. The default looping state for sound is false.
      
      
   .. method:: play()
         
      Start or resume playing the audio stream.

      This function starts the stream if it was stopped, resumes it if it was paused, and restarts it from beginning if it was it already playing. This function uses its own thread so that it doesn't block the rest of the program while the stream is played.
      
   .. method:: pause()
         
      Pause the audio stream.

      This function pauses the stream if it was playing, otherwise (stream already paused or stopped) it has no effect.
         
   .. method:: stop()
   
      Stop playing the sound.

      This function stops the sound if it was playing or paused, and does nothing if it was already stopped. It also resets the playing position (unlike :py:func:`pause`).
   
   
.. class:: Music

      Streamed music played from an audio file.

      Musics are sounds that are streamed rather than completely loaded in memory.

      This is especially useful for compressed musics that usually take hundreds of MB when they are uncompressed: by streaming it instead of loading it entirely, you avoid saturating the memory and have almost no loading delay.

      Apart from that, a sf.Music has almost the same features as the sf.SoundBuffer / sf.Sound pair: you can play/pause/stop it, request its parameters (channels, sample rate), change the way it is played (pitch, volume, 3D position, ...), etc.

      As a sound stream, a music is played in its own thread in order not to block the rest of the program. This means that you can leave the music alone after calling Play(), it will manage itself very well.

      Usage example::

         # declare a new music
         try:
            music = sf.Music.open_from_file("music.ogg")
         except sf.SFMLException:
            # error...

         # change some parameters
         music.position = (0, 1, 10) # change its 3D position
         music.pitch = 2             # increase the pitch
         music.volume = 50           # reduce the volume
         music.loop = True           # make it loop

         # play it
         music.play()

   .. attribute:: duration
   
      Get the total duration of the music in milliseconds
      
   .. classmethod:: open_from_file(filename)
   
      Open a music from an audio file.

      This function doesn't start playing the music (call Play() to do so). Here is a complete list of all the supported audio formats: ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.
      
      :param str filename: Path of the music file to open
      :rtype: sf.Music

   .. classmethod:: open_from_memory(str data)
   
      Open a music from an audio file in memory.

      This function doesn't start playing the music (call :py:meth:`play` to do so). Here is a complete list of all the supported audio formats: ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64.

      :param bytes data: The file data
      :rtype: sf.Music
