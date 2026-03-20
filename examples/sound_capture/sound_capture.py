from sfml import audio as sf_audio
from sfml import system as sf_system


def main():
    if not sf_audio.SoundRecorder.is_available():
        print("Sorry, audio capture is not supported by your system")
        return

    devices = sf_audio.SoundRecorder.get_available_devices()
    default_device = sf_audio.SoundRecorder.get_default_device()

    print("Available capture devices:\n")
    for index, device in enumerate(devices):
        suffix = " (default)" if device == default_device else ""
        print(f"{index}: {device}{suffix}")
    print()

    device_index = 0
    if len(devices) > 1:
        while True:
            choice = input(f"Please choose the capture device to use [0-{len(devices) - 1}]: ").strip()
            if not choice:
                break
            try:
                device_index = int(choice)
            except ValueError:
                continue
            if 0 <= device_index < len(devices):
                break

    sample_rate_text = input("Please choose the sample rate for sound capture (44100 is CD quality): ").strip()
    sample_rate = int(sample_rate_text or "44100")
    input("Press enter to start recording audio")

    recorder = sf_audio.SoundBufferRecorder()

    if devices and not recorder.set_device(devices[device_index]):
        raise RuntimeError("failed to select the capture device")

    if not recorder.start(sample_rate):
        raise RuntimeError("failed to start the recorder")
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
            print(f"\rPlaying... {sound.playing_offset.seconds:.2f} sec", end="", flush=True)
            sf_system.sleep(sf_system.milliseconds(100))
        print()

    print("\nDone!")
    input("Press enter to exit...")

if __name__ == "__main__":
    main()
