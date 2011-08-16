#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Sprite example')
    window.framerate_limit = 60
    running = True
    image = sf.Image.load_from_file('python-logo.png')
    sprite = sf.Sprite(image)
    sprite2 = sf.Sprite(image)
    sprite2.position = 0, 300
    
    shader = sf.Shader.load_from_file('blur.sfx')
    shader.set_current_texture('texture')
    shader.set_parameter('offset', 0.0)
    
    shader2 = sf.Shader.load_from_file('edge.sfx')
    shader2.set_current_texture('texture')

    while running:
        for event in window.iter_events():
            if event.type == sf.Event.CLOSED:
                running = False

        window.clear(sf.Color.WHITE)
        window.draw(sprite, shader)
        window.draw(sprite2, shader2)
        window.display()

    window.close()


if __name__ == '__main__':
    main()
