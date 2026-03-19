from sfml import audio as sf_audio
from sfml import system as sf_system

def main():
    if not sf_audio.SoundRecorder.is_available():
        print("Sorry, audio capture is not supported by your system")
        return

    sample_rate_text = input("Please choose the sample rate for sound capture (44100 is CD quality): ").strip()
    sample_rate = int(sample_rate_text or "44100")
    input("Press enter to start recording audio")

    recorder = sf_audio.SoundBufferRecorder()

    recorder.start(sample_rate)
    input("Recording... press enter to stop")
    recorder.stop()

    buffer = recorder.buffer

    print("Sound information:")
    print("{0} seconds".format(buffer.duration))
    print("{0} samples / seconds".format(buffer.sample_rate))
    print("{0} channels".format(buffer.channel_count))

    choice = input("What do you want to do with captured sound (p = play, s = save) ? ").strip().lower()

    if choice == 's':
        filename = input("Choose the file to create: ").strip()
        buffer.to_file(filename)
    else:
        sound = sf_audio.Sound(buffer)
        sound.play()

        while sound.status == sf_audio.Status.PLAYING:
            sf_system.sleep(sf_system.milliseconds(100))

    print("Done!")

if __name__ == "__main__":
    main()
