Audio
=====
.. module:: sfml.audio
.. contents:: :local:

Listener
^^^^^^^^

.. class:: Listener

   The audio listener is the point in the scene from where all the
   sounds are heard.

   The audio listener defines the global properties of the audio
   environment, it defines where and how sounds and musics are heard.

   If :class:`.View` is the eyes of the user, then
   :class:`Listener` is his ears (by the way, they are often linked
   together -- same position, orientation, etc.).

   :class:`Listener` is a simple interface, which allows to setup
   the listener in the 3D audio environment (position and direction),
   and to adjust the global volume.

   Because the listener is unique in the scene, :class:`Listener`
   only contains class methods and doesn't have to be instantiated.

   Usage example::

      # move the listener to the position (1, 0, -5)
      sf.Listener.set_position(sfml.system.Vector3(1, 0, -5))

      # make it face the right axis (1, 0, 0)
      sf.Listener.set_direction(sfml.system.Vector3(1, 0, 0))

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
      :rtype: :class:`sfml.system.Vector3`

   .. classmethod:: set_position(position)

      Set the position of the listener in the scene.

      The default listener's position is (0, 0, 0).

      :param position: New listener's position
      :type position: :class:`sfml.system.Vector3` or tuple

   .. classmethod:: get_direction()

      Get the current orientation of the listener in the scene.

      :return: Listener's orientation
      :rtype: :class:`sfml.system.Vector3`

   .. classmethod:: set_direction(direction)

      Set the forward vector of the listener in the scene.

      The direction (also called "at vector") is the vector pointing forward
      from the listener's perspective. Together with the up vector, it defines
      the 3D orientation of the listener in the scene. The direction vector
      doesn't have to be normalized. The default listener's direction is
      (0, 0, -1).

      :param direction: New listener's forward vector (not normalized)
      :type direction: :class:`sfml.system.Vector3` or tuple

   .. classmethod:: get_up_vector()

      Get the current upward vector of the listener in the scene.

      :return: Listener's upward vector (not normalized)
      :rtype: :class:`sfml.system.Vector3`

   .. classmethod:: set_up_vector(up_vector)

      Set the upward vector of the listener in the scene.

      The up vector is the vector that points upward from the listener's
      perspective. Together with the direction, it defines the 3D orientation
      of the listener in the scene. The up vector doesn't have to be normalized.
      The default listener's up vector is (0, 1, 0). It is usually not necessary
      to change it, especially in 2D scenarios.

      :param up_vector: New listener's up vector
      :type up_vector: :class:`sfml.system.Vector3` or tuple

Chunk
^^^^^

.. class:: Chunk

   :class:`Chunk` represents internally an array of **Int16** which
   are sound samples.

   It provides utilities to manipulate such an array in Python and a
   property :attr:`data` to access the underlying data representation.

   .. py:method:: __len__()

      Return the number of sample.

   .. py:method:: __getitem__(index)

      Get an access to a sample by its index.

   .. py:method:: __setitem__(index, vertex)

      Set a sample value by its index.

   .. py:attribute:: data

      Get a **copy** of the data inside. This returns a byte array twice
      larger than the chunck's lenght.

      Set a new array of sample. This array is an array of bytes (which
      will be converted internally in an array of **Int16**) and its
      lenght must be an even number.

      :rtype: bytes or string

SoundBuffer
^^^^^^^^^^^

.. class:: SoundBuffer

   Storage for audio samples defining a sound.

   A sound buffer holds the data of a sound, which is an array of
   audio samples.

   A sample is a 16 bits signed integer that defines the amplitude of
   the sound at a given time. The sound is then restituted by playing
   these samples at a high rate (for example, 44100 samples per second
   is the standard rate used for playing CDs). In short, audio samples
   are like texture pixels, and an :class:`SoundBuffer` is similar
   to an :class:`.Texture`.

   A sound buffer can be loaded from a file (see
   :func:`from_file()` for the complete list of supported
   formats), from memory or directly from an array of samples. It can
   also be saved back to a file.

   Sound buffers alone are not very useful: they hold the audio data
   but cannot be played. To do so, you need to use the
   :class:`Sound` class, which provides functions to
   play/pause/stop the sound as well as changing the way it is
   outputted (volume, pitch, 3D position, ...). This separation allows
   more flexibility and better performances: indeed a
   :class:`SoundBuffer` is a heavy resource, and any operation on
   it is slow (often too slow for real-time applications). On the
   other side, an :class:`Sound` is a lightweight object, which can
   use the audio data of a sound buffer and change the way it is
   played without actually modifying that data. Note that it is also
   possible to bind several :class:`Sound` instances to the same
   :class:`SoundBuffer`.

   It is important to note that the :class:`Sound` instance doesn't
   copy the buffer that it uses, it only keeps a reference to it.
   Thus, an :class:`SoundBuffer` must not be destructed while it is
   used by an :class:`Sound` (i.e. never write a function that uses
   a local :class:`SoundBuffer` instance for loading a sound).

   Usage example::

      # load a new sound buffer from a file
      try: buffer = sf.SoundBuffer.from_file("data/sound.wav")
      except IOError as error: exit()

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

   .. method:: SoundBuffer([buffer])

      If you try to instantiate an :class:`SoundBuffer` directly, it
      will raise an error saying that you have to use its specific
      constructors: `from_file`, `from_memory` or
      `from_samples`

   .. py:classmethod:: from_file(filename)

      Load the sound buffer from a file.

      Here is a complete list of all the supported audio formats: **ogg,
      wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4,
      mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64**.

      :raise: :exc:`IOError` - The SoundBuffer failed to load
      :param str filename: Path of the sound file to load
      :rtype: :class:`sfml.audio.SoundBuffer`

   .. classmethod:: from_memory(data)

      Load the sound buffer from a file in memory.

      Here is a complete list of all the supported audio formats: ogg,
      wav, **flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4,
      mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64**.

      :raise: :exc:`IOError` - The SoundBuffer failed to load
      :param bytes data: The file data
      :rtype: :class:`sfml.audio.SoundBuffer`

   .. classmethod:: from_samples(samples, channel_count, sample_rate)

      Load the sound buffer from an array of audio samples.

      :raise: :exc:`IOError` - The SoundBuffer failed to load
      :param sfml.audio.Chunk samples: The samples
      :param integer channel_count: Number of channels (1 = mono, 2 = stereo, ...)
      :param integer sample_rate: Sample rate (number of samples to play per second)
      :rtype: :class:`sfml.audio.SoundBuffer`

   .. method:: to_file(filename)

      Save the sound buffer to an audio file.

      Here is a complete list of all the supported audio formats: **ogg,
      wav, flac, aiff, au, raw, paf, svx, nist, voc, ircam, w64, mat4,
      mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k, rf64**.

      :raise: :exc:`IOError` - The SoundBuffer failed to save
      :param str filename: Path of the sound file to write

   .. attribute:: channels_count

      Get the number of channels used by the sound.

      If the sound is mono then the number of channels will be 1, 2 for
      stereo, etc.

      :rtype: integer

   .. attribute:: duration

      Get the total duration of the sound.

      :rtype: :class:`sfml.system.Time`

   .. attribute:: sample_rate

      Get the sample rate of the sound.

      The sample rate is the number of samples played per second. The
      higher, the better the quality (for example, 44100 samples/s is
      CD quality).

      :rtype: integer

   .. attribute:: samples

      Get the audio samples stored in the buffer.

      :rtype: :class:`sfml.audio.Chunk`

SoundSource
^^^^^^^^^^^

.. class:: SoundSource

   Base class defining a sound's properties.

   :class:`SoundSource` is not meant to be used directly, it only
   serves as a common base for all audio objects that can live in the
   audio environment.

   It defines several properties for the sound: pitch, volume,
   position, attenuation, etc. All of them can be changed at any time
   with no impact on performances.

   .. py:data:: STOPPED

      Sound is not playing.

   .. py:data:: PAUSED

      Sound is paused.

   .. py:data:: PLAYING

      Sound is playing.

   .. attribute:: pitch

      Get/set the pitch of the sound.

      The pitch represents the perceived fundamental frequency of a
      sound; thus you can make a sound more acute or grave by changing
      its pitch. A side effect of changing the pitch is to modify the
      playing speed of the sound as well. The default value for the
      pitch is 1.

      :rtype: float

   .. attribute:: volume

      Get/set the volume of the sound.

      The volume is a value between 0 (mute) and 100 (full volume). The
      default value for the volume is 100.

      :rtype: float

   .. attribute:: position

      Get/set the 3D position of the sound in the audio scene.

      Only sounds with one channel (mono sounds) can be spatialized.
      The default position of a sound is (0, 0, 0).

      :rtype: :class:`sfml.system.Vector3`

   .. attribute:: relative_to_listener

      Make the sound's position relative to the listener or absolute.

      Making a sound relative to the listener will ensure that it will
      always be played the same way regardless the position of the
      listener. This can be useful for non-spatialized sounds, sounds
      that are produced by the listener, or sounds attached to it. The
      default value is false (position is absolute).

      :rtype: bool

   .. attribute:: min_distance

      The minimum distance of the sound.

      The "minimum distance" of a sound is the maximum distance at
      which it is heard at its maximum volume. Further than the minimum
      distance, it will start to fade out according to its attenuation
      factor. A value of 0 ("inside the head of the listener") is an
      invalid value and is forbidden. The default value of the minimum
      distance is 1.

   .. attribute:: attenuation

      Get/set the attenuation factor of the sound.

      The attenuation is a multiplicative factor which makes the sound
      more or less loud according to its distance from the listener.
      An attenuation of 0 will produce a non-attenuated sound, i.e. its
      volume will always be the same whether it is heard from near or
      from far. On the other hand, an attenuation value such as 100
      will make the sound fade out very quickly as it gets further from
      the listener. The default value of the attenuation is 1.

      :rtype: float

Sound
^^^^^

.. class:: Sound(SoundSource)

   Regular sound that can be played in the audio environment.

   :class:`Sound` is the class to use to play sounds.

   It provides:

       * Control (play, pause, stop)
       * Ability to modify output parameters in real-time (pitch, volume, ...)
       * 3D spatial features (position, attenuation, ...).

   :class:`Sound` is perfect for playing short sounds that can fit
   in memory and require no latency, like foot steps or gun shots. For
   longer sounds, like background musics or long speeches, rather see
   :class:`Music` (which is based on streaming).

   In order to work, a sound must be given a buffer of audio data to
   play. Audio data (samples) is stored in :class:`SoundBuffer`, and
   attached to a sound with the :func:`SoundBuffer.buffer` function.
   The buffer object attached to a sound must remain alive as long as
   the sound uses it, so don't delete it explicitly with the operator
   **del**. Note that multiple sounds can use the same sound buffer at
   the same time.

   Usage example::

      try: buffer = sf.SoundBuffer.from_file("sound.wav")
      except IOError: exit(1)

      sound = sf.Sound()
      sound.buffer = buffer
      sound.play()

   .. method:: Sound([buffer])

      Construct the sound with a buffer or if not provided construct an
      empty sound.

      :param sfml.audio.SoundBuffer buffer: Sound buffer containing the audio data to play with the sound

   .. method:: play()

      Start or resume playing the sound.

      This function starts the stream if it was stopped, resumes it if
      it was paused, and restarts it from beginning if it was it
      already playing. This function uses its own thread so that it
      doesn't block the rest of the program while the sound is played.

   .. method:: pause()

      Pause the sound.

      This function pauses the sound if it was playing, otherwise
      (sound already paused or stopped) it has no effect.

   .. method:: stop()

      Stop playing the sound.

      This function stops the sound if it was playing or paused, and
      does nothing if it was already stopped. It also resets the
      playing position (unlike :func:`pause`).

   .. attribute:: buffer

      Get/set the source buffer containing the audio data to play.

      It is important to note that the sound buffer is not copied, thus
      the :class:`SoundBuffer` instance must remain alive as long as it is
      attached to the sound (don't explicitly delete it with the operator
      **del**).

      :rtype: :class:`sfml.audio.SoundBuffer`

   .. attribute:: loop

      Set/tell whether or not the sound should loop after reaching the
      end.

      If set, the sound will restart from beginning after reaching the
      end and so on, until it is stopped or `loop` is set at false
      again. The default looping state for sound is false.

      :rtype: bool

   .. attribute:: playing_offset

      Change the current playing position of the sound.

      The playing position can be changed when the sound is either
      paused or playing.

      :rtype: :class:`sfml.system.Time`

   .. attribute:: status

      Get the current status of the sound (stopped, paused, playing)

      :rtype: a constant from :class:`sfml.audio.SoundSource`

SoundStream
^^^^^^^^^^^

.. class:: SoundStream(SoundSource)

   Abstract base class for streamed audio sources.

   Unlike audio buffers (see :class:`SoundBuffer`), audio streams
   are never completely loaded in memory.

   Instead, the audio data is acquired continuously while the stream is
   playing. This behaviour allows to play a sound with no loading
   delay, and keeps the memory consumption very low.

   Sound sources that need to be streamed are usually big
   files (compressed audio musics that would eat hundreds of MB in
   memory) or files that would take a lot of time to be received
   (sounds played over the network).

   :class:`SoundStream` is a base class that doesn't care about the
   stream source, which is left to the derived class. pySFML provides a
   built-in specialization for big files (see :class:`Music`). No
   network stream source is provided, but you can write your own by
   combining this class with the network module.

   A derived class has to override two virtual functions:

       - :meth:`on_get_data` fills a new chunk of audio data to be played
       - :meth:`on_seek` changes the current playing position in the source

   It is important to note that each :class:`SoundStream` is played in
   its own separate thread, so that the streaming loop doesn't block
   the rest of the program. In particular, the :func:`on_get_data` and
   :func:`on_seek` virtual functions may sometimes be called from this
   separate thread. It is important to keep this in mind, because you
   may have to take care of synchronization issues if you share data
   between threads.

   Usage example::

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

   .. method:: play()

      Start or resume playing the audio stream.

      This function starts the stream if it was stopped, resumes it if
      it was paused, and restarts it from beginning if it was it
      already playing. This function uses its own thread so that it
      doesn't block the rest of the program while the stream is played.

   .. method:: pause()

      Pause the audio stream.

      This function pauses the stream if it was playing, otherwise
      (stream already paused or stopped) it has no effect.

   .. method:: stop()

      Stop playing the audio stream.

      This function stops the stream if it was playing or paused, and
      does nothing if it was already stopped. It also resets the
      playing position (unlike :func:`pause`).

   .. attribute:: channel_count

      Return the number of channels of the stream.

      1 channel means a mono sound, 2 means stereo, etc.

      :rtype: integer

   .. attribute:: sample_rate

      Get the stream sample rate of the stream.

      The sample rate is the number of audio samples played per second.
      The higher, the better the quality.

      :rtype: integer

   .. attribute:: loop

      Set/tell whether or not the stream should loop after reaching the
      end.

      If set, the stream will restart from beginning after reaching the
      end and so on, until it is stopped or :attr:`loop` is set at
      false again. The default looping state for streams is false.

      :rtype: bool

   .. attribute:: playing_offset

      Change the current playing position of the stream.

      The playing position can be changed when the stream is either
      paused or playing.

      :rtype: :class:`sfml.system.Time`

   .. attribute:: status

      Get the current status of the stream (stopped, paused, playing)

      :rtype: a constant from :class:`sfml.audio.SoundSource`

   .. method:: initialize(channel_count, sample_rate)

      Define the audio stream parameters.

      This function must be called by derived classes as soon as they
      know the audio settings of the stream to play. Any attempt to
      manipulate the stream (:func:`play`, ...) before calling this
      function will fail. It can be called multiple times if the
      settings of the audio stream change, but only when the stream is
      stopped.

      :param integer channel_count: Number of channels of the stream
      :param integer sample_rate: Sample rate, in samples per second

   .. method:: on_get_data(data)

      Request a new chunk of audio samples from the stream source.

      This function must be overridden by derived classes to provide the
      audio samples to play. It is called continuously by the streaming
      loop, in a separate thread. The source can choose to stop the
      streaming loop at any time, by returning false to the caller.

      :param sfml.audio.Chunk data: Chunk data to fill
      :return: True to continue playback, false to stop

   .. method:: on_seek(time_offset)

      Change the current playing position in the stream source.

      This function must be overridden by derived classes to allow
      random seeking into the stream source.

      :param sfml.system.Time time_offset: New playing position, relative to the beginning of the stream

Music
^^^^^

.. class:: Music(SoundStream)

   Streamed music played from an audio file.

   Musics are sounds that are streamed rather than completely loaded in
   memory.

   This is especially useful for compressed musics that usually take
   hundreds of MB when they are uncompressed: by streaming it instead
   of loading it entirely, you avoid saturating the memory and have
   almost no loading delay.

   Apart from that, an :class:`Music` has almost the same features as
   the :class:`SoundBuffer` / :class:`Sound` pair: you can
   play/pause/stop it, request its parameters (channels, sample rate),
   change the way it is played (pitch, volume, 3D position, ...), etc.

   As a sound stream, a music is played in its own thread in order not
   to block the rest of the program. This means that you can leave the
   music alone after calling :meth:`~SoundStream.play`, it will manage
   itself very well.

      Usage example::

         # declare a new music
         music = sf.Music()

         try: music = sf.Music.from_file("music.ogg")
         except IOError: exit(1)

         # change some parameters
         music.position = (0, 1, 10) # change its 3D position
         music.pitch = 2             # increase the pitch
         music.volume = 50           # reduce the volume
         music.loop = True           # make it loop

         # play it
         music.play()

   .. method:: Music()

      If you try to instantiate an :class:`Music` directly, it will
      raise an error saying that you must use its specific constructors:
      :meth:`from_file` or :meth:`from_memory`.

   .. classmethod:: from_file(filename)

      Open a music from an audio file.

      This function doesn't start playing the music (call :func:`play`
      to do so). Here is a complete list of all the supported audio
      formats: **ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc,
      ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k,
      rf64**.

      :raise: :exc:`IOError` - If loading failed.
      :param str filename: Path of the music file to open
      :rtype: :class:`sfml.audio.Music`

   .. classmethod:: from_memory(data)

      Open a music from an audio file in memory.

      This function doesn't start playing the music (call :func:`play`
      to do so). Here is a complete list of all the supported audio
      formats: **ogg, wav, flac, aiff, au, raw, paf, svx, nist, voc,
      ircam, w64, mat4, mat5 pvf, htk, sds, avr, sd2, caf, wve, mpc2k,
      rf64**.

      :raise: :exc:`IOError` - If loading failed.
      :param bytes data: The file data in memory
      :rtype: :class:`sfml.audio.Music`

   .. attribute:: duration

      Get the total duration of the music

      :rtype: :class:`sfml.system.Time`

SoundRecorder
^^^^^^^^^^^^^

.. class:: SoundRecorder

   Abstract base class for capturing sound data.

   :class:`SoundBuffer` provides a simple interface to access the
   audio recording capabilities of the computer (the microphone).

   As an abstract base class, it only cares about capturing sound
   samples, the task of making something useful with them is left to
   the derived class. Note that pySFML provides a built-in
   specialization for saving the captured data to a sound buffer (see
   :class:`SoundBufferRecorder`).

   A derived class has only one method to override:

      - :func:`on_process_samples` provides the new chunks of audio samples while the capture happens

   Moreover, two additional method can be overridden as well if necessary:

       - :func:`on_start` is called before the capture happens, to perform custom initializations
       - :func:`on_stop` is called after the capture ends, to perform custom cleanup

   The audio capture feature may not be supported or activated on every
   platform, thus it is recommended to check its availability with the
   :func:`is_available` function. If it returns false, then any attempt
   to use an audio recorder will fail.

   If you have multiple sound input devices connected to your computer (for
   example: microphone, external soundcard, webcam mic, ...), you can get a
   list of all available devices throught then :meth:`get_available_devices`
   function. You can then select a device by calling :meth:`set_device` with
   the appropiate device. Otherwise the default capturing device will be used.

   It is important to note that the audio capture happens in a separate
   thread, so that it doesn't block the rest of the program. In
   particular, the :func:`on_process_samples` method (but not :func:`on_start`
   and not :func:`on_stop`) will be called from this separate thread.
   It is important to keep this in mind, because you may have to take
   care of synchronization issues if you share data between threads.

   Usage example::

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


   .. method:: start([sample_rate=44100])

      Start the capture.

      The *sample_rate* parameter defines the number of audio samples
      captured per second. The higher, the better the quality (for
      example, 44100 samples/sec is CD quality). This function uses its
      own thread so that it doesn't block the rest of the program while
      the capture runs. Please note that only one capture can happen at
      the same time. You can select which capture device will be used, by
      passing the name to the :meth:`set_device` method. If none was selected
      before, the default capture device will be used. You can get a list of
      the names of all available capture devices by calling
      :meth:`get_available_devices`.

      You can select which capture device will be used, by passing the name
      to the :meth:`set_device` method. If none was selected before, the default
      capture device will be used. You can get a list of the names of all
      available capture devices by calling :meth:`get_available_devices`.

      :param integer sample_rate: Desired capture rate, in number of samples per second
      :return: True, if start of capture was successful
      :rtype: boolean

   .. method:: stop()

      Stop the capture.

   .. attribute:: sample_rate

      Get the sample rate.

      The sample rate defines the number of audio samples captured per
      second. The higher, the better the quality (for example, 44100
      samples/sec is CD quality).

   .. classmethod:: get_available_devices()

      Get a list of the names of all availabe audio capture devices.

      This function returns a tuple of strings, containing the names of all
      availabe audio capture devices.

      :return: A tuple of strings containing the names
      :rtype: tuple

   .. classmethod:: get_default_device()

      Get the name of the default audio capture device.

      This function returns the name of the default audio capture device. If
      none is available, None is returned.

      :return: The name of the default audio capture device
      :rtype: string (or None)

   .. method:: set_device(name)

      Set the audio capture device.

      This function sets the audio capture device to the device with the given
      name. It can be called on the fly (i.e: while recording).

      If you do so while recording and opening the device fails, it stops the
      recording.

      :param str name: The name of the audio capture device
      :return: True, if it was able to set the requested device
      :rtype: boolean

   .. method:: get_device()

      Get the name of the current audio capture device.

      :return: The name of the current audio capture device
      :rtype: str

   .. classmethod:: is_available()

      Check if the system supports audio capture.

      This function should always be called before using the audio
      capture features. If it returns false, then any attempt to use
      :class:`SoundRecorder` or one of its derived classes will fail.

      :return: Whether audio capture is supported or not
      :rtype: bool

   .. method:: on_start()

      Start capturing audio data.

      This method may be overridden by a derived class if something has
      to be done every time a new capture starts. If not, this method
      can be ignored; the default implementation does nothing.

      :return: True to start the capture, or false to abort it

   .. method:: on_process_samples(samples)

      Process a new chunk of recorded samples.

      This method is called every time a new chunk of recorded data is
      available. The derived class can then do whatever it wants with
      it (storing it, playing it, sending it over the network, etc.).

      :param sfml.audio.Chunk samples: The new chunk of recorded samples
      :return: True to continue the capture, or false to stop it

   .. method:: on_stop()

      Stop capturing audio data.

      This method may be overridden by a derived class if something has
      to be done every time the capture ends. If not, this method can
      be ignored; the default implementation does nothing.

SoundBufferRecorder
^^^^^^^^^^^^^^^^^^^

.. class:: SoundBufferRecorder(SoundRecorder)

   Specialized :class:`SoundRecorder` which stores the captured audio
   data into a sound buffer.

   :class:`SoundBufferRecorder` allows to access a recorded sound
   through an :class:`SoundBuffer`, so that it can be played, saved
   to a file, etc.

   It has the same simple interface as its base class (:meth:`start`,
   :meth:`stop`) and adds a property to retrieve the recorded sound
   buffer (:attr:`buffer`).

   As usual, don't forget to call the :func:`is_available` function
   before using this class (see :class:`SoundRecorder` for more
   details about this).

   Usage example::

      if sf.SoundBufferRecorder.is_available():
         # record some audio data
         recorder = sf.SoundBufferRecorder()
         recorder.start()
         ...
         recorder.stop()

         # get the buffer containing the captured audio data
         buffer = recorder.buffer

         # save it to a file (for example...)
         buffer.to_file("my_record.ogg")


   .. method:: SoundBufferRecorder()

      Construct a :class:`SoundBufferRecorder`.

   .. attribute:: buffer

      Get the sound buffer containing the captured audio data.

      The sound buffer is valid only after the capture has ended. This
      attribute provides a read-only access to the internal sound
      buffer, but it can be copied if you need to make any modification
      to it.

      :rtype: :class:`sfml.audio.SoundBuffer`

