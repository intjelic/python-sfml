Audio
=====

.. currentmodule:: sf


.. class:: SoundBuffer

   The constructor will raise ``NotImplementedError``. Use one of the class
   methods instead.

   .. attribute:: channels_count
   .. attribute:: duration
   .. attribute:: sample_rate
   .. attribute:: samples
   .. attribute:: samples_count

   .. classmethod:: load_from_file(filename)
   .. classmethod:: load_from_memory(str data)
   .. classmethod:: load_from_samples(list samples, int channels_count,\
                                      int sample_rate)

   .. method:: save_to_file(filename)



.. class:: Sound([SoundBuffer buffer])

   .. attribute:: attenuation
   .. attribute:: buffer
   .. attribute:: loop
   .. attribute:: min_distance
   .. attribute:: pitch
   .. attribute:: playing_offset
   .. attribute:: position
   .. attribute:: relative_to_listener
   .. attribute:: status

      Read-only. Can be one of:

      * sf.Sound.STOPPED
      * sf.Sound.PAUSED
      * sf.Sound.PLAYING

   .. attribute:: volume

   .. method:: pause()
   .. method:: play()
   .. method:: stop()




.. class:: Music

   Will raise ``NotImplementedError`` if the constructor is called. Use class
   methods instead.

   .. attribute:: attenuation
   .. attribute:: channels_count
   .. attribute:: duration
   .. attribute:: loop
   .. attribute:: min_distance
   .. attribute:: pitch
   .. attribute:: playing_offset
   .. attribute:: position
   .. attribute:: relative_to_listener
   .. attribute:: sample_rate
   .. attribute:: status

      Read-onlt. Can be one of:

      * sf.Music.STOPPED
      * sf.Music.PAUSED
      * sf.Music.PLAYING

   .. attribute:: volume

   .. classmethod:: open_from_file(filename)
   .. classmethod:: open_from_memory(str data)

   .. method:: pause()
   .. method:: play()
   .. method:: stop()
