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
        music = sf.Music.from_file(song)
        
    except IOError as error:
        print("An error occured during the loading data process:\n" + str(error))
        exit()

    if music.channel_count != 1:
        print("Only sounds with one channel (mono sounds) can be spatialized.")
        print("This song ({0}) has {1} channels.".format(SONG, music.channels_count))
        exit()

    # by default, the music is not relative to the listener
    #music.relative_to_listener = True
    
    hears_position = sf.Vector3(25, 25, 0)
    speaker_position = sf.Vector3(350, 348, 0)
    
    sf.Listener.set_position(hears_position)
    music.position = speaker_position
    
    try:
        hears_texture = sf.Texture.from_file("data/head_kid.png")
        speaker_texture = sf.Texture.from_file("data/speaker.gif")
        
    except IOError as error:
        print("An error occured during the loading data process:\n" + str(error))
        exit()
        
    hears = sf.Sprite(hears_texture)
    x, y, _ = hears_position
    hears.position = sf.Vector2(x, y)
    
    speaker = sf.Sprite(speaker_texture)
    x, y, _ = speaker_position
    speaker.position = sf.Vector2(x, y)
    
    music.min_distance = 200
    music.attenuation = 1
    
    music.loop = True
    music.play()
    
    loop = True
    while loop:
        for event in window.events:
            if type(event) is sf.CloseEvent:
                loop = False
                
            elif type(event) is sf.KeyEvent and event.pressed:
                if event.code is sf.Keyboard.UP:
                    hears_position.y -= 5
                    sf.Listener.set_position(hears_position)
                    
                    x, y, _ = hears_position
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.DOWN:
                    hears_position.y += 5
                    sf.Listener.set_position(hears_position)
                    
                    x, y, _ = hears_position
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.LEFT:
                    hears_position.x -= 5
                    sf.Listener.set_position(hears_position)
                    
                    x, y, _ = hears_position
                    hears.position = (x, y)
                    
                elif event.code is sf.Keyboard.RIGHT:
                    hears_position.x += 5
                    sf.Listener.set_position(hears_position)
                    
                    x, y, _ = hears_position
                    hears.position = (x, y)


        window.clear(sf.Color.WHITE)
        window.draw(speaker)
        window.draw(hears)
        window.display()
        
    window.close()
    
    
if __name__ == "__main__":
    main("data/mario.flac")
