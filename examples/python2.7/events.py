#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Events example')
    window.framerate_limit = 60
    running = True

    while running:
        for event in window.iter_events():
            # Print all events
            print event

            # Stop running if the application is closed
            # or if the user presses Escape
            if (event.type == sf.Event.CLOSED or
                (event.type == sf.Event.KEY_PRESSED and
                 event.code == sf.Keyboard.ESCAPE)):
                running = False

    window.close()


if __name__ == '__main__':
    main()
