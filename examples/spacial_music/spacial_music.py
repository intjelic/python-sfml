#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml as sf

def main(song):
    window = sf.RenderWindow(sf.VideoMode(800, 800), "pySFML - Spacial Music")
    window.framerate_limit = 60
    
    # load a song and make sure it can be spacialized
    try:
        music = sf.Music.open_from_file(song)
        
    except sf.SFMLException as error:
        print("An error occured during the loading data process:\n" + str(error))
        exit()

    if music.channel_count != 1:
        print("Only sounds with one channel (mono sounds) can be spatialized.")
        print("This song ({0}) has {1} channels.".format(SONG, music.channels_count))
        exit()

    # by default, the music is not relative to the listener
    #music.relative_to_listener = True
    
    hears_position = (25, 25, 0)
    speaker_position = (350, 348, 0)
    
    x, y, z = hears_position
    sf.Listener.set_position((x, y, z))
    music.position = speaker_position
    
    try:
        hears_texture = sf.Texture.load_from_file("data/head_kid.png")
        speaker_texture = sf.Texture.load_from_file("data/speaker.gif")
        
    except sf.SFMLException as error:
        print("An error occured during the loading data process:\n" + str(error))
        exit()
        
    hears = sf.Sprite(hears_texture)
    x, y, z = hears_position
    hears.position = (x, y)
    
    speaker = sf.Sprite(speaker_texture)
    x, y, z = speaker_position
    speaker.position = (x, y)
    
    music.min_distance = 200
    music.attenuation = 1
    
    music.loop = True
    music.play()
    
    loop = True
    while loop:
        for event in window.events:
            if event.type == sf.Event.CLOSED:
                loop = False
            elif event.type == sf.Event.KEY_PRESSED:
                if event.code is sf.Keyboard.UP:
                    x, y, z = hears_position
                    y -= 5
                    
                    hears_position = (x, y, z)
                    sf.Listener.set_position((x, y, z))
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.DOWN:
                    x, y, z = hears_position
                    y += 5
                    
                    hears_position = (x, y, z)
                    sf.Listener.set_position((x, y, z))
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.LEFT:
                    x, y, z = hears_position
                    x -= 5
                    
                    hears_position = (x, y, z)
                    sf.Listener.set_position((x, y, z))
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.RIGHT:
                    x, y, z = hears_position
                    x += 5
                    
                    hears_position = (x, y, z)
                    sf.Listener.set_position((x, y, z))
                    hears.position = (x, y)


        window.clear(sf.Color.WHITE)
        window.draw(speaker)
        window.draw(hears)
        window.display()
        
    window.close()
    
    
if __name__ == "__main__":
    main("data/mario.flac")
