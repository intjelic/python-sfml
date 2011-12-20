#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Image example')
    window.framerate_limit = 60
    logo = sf.Image.load_from_file('python-logo.png')
    princess = sf.Image.load_from_file('princess.png')
    logo.copy(princess, 0, 0, sf.IntRect(0, 0, 0, 0), True)
    texture = sf.Texture.load_from_image(logo)
    sprite = sf.Sprite(texture)
    running = True

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
