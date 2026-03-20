from pathlib import Path

from sfml import audio as sf_audio
from sfml import system as sf_system


DATA_DIR = Path(__file__).resolve().parent / "data"


def wait_until_stopped(sound_source):
    while sound_source.status == sf_audio.Status.PLAYING:
        print(f"\rPlaying... {sound_source.playing_offset.seconds:.2f} sec", end="", flush=True)
        sf_system.sleep(sf_system.milliseconds(100))
    print()

def play_sound():
    buffer = sf_audio.SoundBuffer.from_file(str(DATA_DIR / "killdeer.wav"))

    print("killdeer.wav:")
    print("{0} seconds".format(buffer.duration))
    print("{0} samples / sec".format(buffer.sample_rate))
    print("{0} channels".format(buffer.channel_count))

    sound = sf_audio.Sound(buffer)
    sound.play()
    wait_until_stopped(sound)

def play_music():
    for filename in ("doodle_pop.ogg", "ding.flac", "ding.mp3"):
        music = sf_audio.Music.from_file(str(DATA_DIR / filename))

        print(f"{filename}:")
        print("{0} seconds".format(music.duration))
        print("{0} samples / sec".format(music.sample_rate))
        print("{0} channels".format(music.channel_count))

        music.play()
        wait_until_stopped(music)

if __name__ == "__main__":
    play_sound()
    play_music()
    input("Press enter to exit...")
