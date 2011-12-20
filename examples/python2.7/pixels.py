#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import struct

import sf


# This example shows how you can manipulate the raw string given by
# sf.Image.get_pixels().


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Pixels test')
    window.framerate_limit = 60
    princess = sf.Image.load_from_file('princess.png')
    new_image = sf.Image(princess.width, princess.height)
    pixels = princess.get_pixels()
    unpacker = struct.Struct('BBBB')

    for i in xrange(princess.width):
        for j in xrange(princess.height):
            k = i * 4 + j * princess.width * 4
            s = pixels[k:k+4]

            if s:
                color = sf.Color(*unpacker.unpack(s))
                new_image[i,j] = color
            else:
                pass

    texture = sf.Texture.load_from_image(new_image)
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
