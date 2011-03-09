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



.. class:: Sound(SoundBuffer buffer=None, loop=False, pitch=1.0, volume=100.0,\
                 position=(0,0,0))

   .. attribute:: attenuation
   .. attribute:: buffer
   .. attribute:: loop
   .. attribute:: min_distance
   .. attribute:: pitch
   .. attribute:: playing_offset
   .. attribute:: position
   .. attribute:: relative_to_listener
   .. attribute:: status

      Can be one of:

      * sf.Sound.STOPPED
      * sf.Sound.PAUSED
      * sf.Sound.PLAYING

   .. attribute:: volume

   .. method:: pause()
   .. method:: play()
   .. method:: stop()
