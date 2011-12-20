#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Sprite example')
    window.framerate_limit = 60
    running = True
    texture = sf.Texture.load_from_file('python-logo.png')
    sprite = sf.Sprite(texture)

    while running:
        for event in window.iter_events():
            if event.type == sf.Event.CLOSED:
                running = False

        window.clear(sf.Color.WHITE)
        window.draw(sprite)
        window.display()
    window.close()


if __name__ == '__main__':
    main()
