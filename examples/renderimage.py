#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf
import sys


def main():
    if not sf.RenderImage.IS_AVAILABLE:
        print "Your system doesn't support RenderImage"
        sys.exit(1)
    
    window = sf.RenderWindow(sf.VideoMode(640, 480), 'Shape example')
    window.framerate_limit = 60
    running = True
    image = sf.Image.load_from_file('python-logo.png')
    circle0 = sf.circle(50, 50, 50, sf.Color.YELLOW)
    circle0.position = 100, 100
    
    rect0 = sf.rectangle(5, 5, 90, 50, sf.Color.GREEN, 2, sf.Color.BLUE)
    
    rect1 = sf.rectangle_from_rect(sf.FloatRect(20.0, 30.0, 50.0, 50.0),
                                   sf.Color.CYAN)
    ri = sf.RenderImage(110, 110)
    ri.clear(sf.Color(0, 0, 0, 0))
    ri.draw(rect0)
    ri.draw(rect1)
    ri.display()
    s = sf.Sprite(ri.image)
    s.origin = 55, 55
    s.position = 320, 240

    while running:
        for event in window.iter_events():
            if event.type == sf.Event.CLOSED:
                running = False

        window.clear(sf.Color.WHITE)
        s.rotate(5)
        window.draw(s)
        window.display()
    window.close()


if __name__ == '__main__':
    main()
