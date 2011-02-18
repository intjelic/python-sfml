#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Title')
    window.framerate_limit = 60
    text = sf.Text('Text', sf.Font.DEFAULT_FONT, 100)
    text.color = sf.Color.BLACK
    text.style = sf.Text.UNDERLINED | sf.Text.BOLD | sf.Text.ITALIC
    text.x = window.width / 2.0 - text.rect.width / 2.0
    text.y = window.height / 2.0 - text.rect.height / 2.0
    running = True

    while running:
        for event in window.iter_events():
            if event.type == sf.Event.CLOSED:
                running = False

        window.clear(sf.Color.WHITE)
        window.draw(text)
        window.display()

    window.close()


if __name__ == '__main__':
    main()
