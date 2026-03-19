from pathlib import Path

from sfml import audio as sf_audio
from sfml import system as sf_system


DATA_DIR = Path(__file__).resolve().parent / "data"


def wait_until_stopped(sound_source):
    while sound_source.status == sf_audio.Status.PLAYING:
        sf_system.sleep(sf_system.milliseconds(100))

def play_sound():
    buffer = sf_audio.SoundBuffer.from_file(str(DATA_DIR / "canary.wav"))

    print("canary.wav:")
    print("{0} seconds".format(buffer.duration))
    print("{0} samples / sec".format(buffer.sample_rate))
    print("{0} channels".format(buffer.channel_count))

    sound = sf_audio.Sound(buffer)
    sound.play()
    wait_until_stopped(sound)

def play_music():
    music = sf_audio.Music.from_file(str(DATA_DIR / "orchestral.ogg"))

    print("orchestral.ogg:")
    print("{0} seconds".format(music.duration))
    print("{0} samples / sec".format(music.sample_rate))
    print("{0} channels".format(music.channel_count))

    music.play()
    wait_until_stopped(music)

if __name__ == "__main__":
    play_sound()
    play_music()
