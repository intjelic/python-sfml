import time
import sfml.audio as sf


def play_sound():
    # load a sound buffer from a wav file
    buffer = sf.SoundBuffer.load_from_file("data/canary.wav")
    
    # display sound informations
    print("canary.wav:")
    print("{0} seconds".format(buffer.duration))
    print("{0} samples / sec".format(buffer.sample_rate))
    print("{0} channels".format(buffer.channels_count))

    # create a sound instance and play it
    sound = sf.Sound(buffer)
    sound.play();

    # loop while the sound is playing
    while sound.status == sf.Sound.PLAYING:
        # leave some CPU time for other processes
        time.sleep(0.1);

        # display the playing position
        #std::cout << "\rPlaying... " << std::fixed << std::setprecision(2) << sound.GetPlayingOffset() << " sec   ";

def play_music():
    # load an ogg music file    
    music = sf.Music.open_from_file(b"data/orchestral.ogg")
    
    # display music informations
    print("orchestral.ogg:")
    print("{0} seconds".format(music.duration))
    print("{0} samples / sec".format(music.sample_rate))
    print("{0} channels".format(music.channels_count))
    
    # play it
    music.play();

    # loop while the music is playing
    while music.status == sf.Music.PLAYING:
        # leave some CPU time for other processes
        time.sleep(0.1)

        # display the playing position
        #std::cout << "\rPlaying... " << std::fixed << std::setprecision(2) << music.GetPlayingOffset() << " sec   ";
        

if __name__ == "__main__":
    play_sound()
    play_music()
    
    input("Press enter to exit...")
