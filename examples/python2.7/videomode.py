#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import sf


def main():
    desktop_mode = sf.VideoMode.get_desktop_mode()
    print 'The current desktop mode is:', desktop_mode
    fullscreen_modes = sf.VideoMode.get_fullscreen_modes()
    print 'The available fullscreen modes are:'

    for mode in fullscreen_modes:
        print ' ', mode

    format = raw_input('Please enter a video mode format (e.g. 1024x768x32): ')
    values = [int(item) for item in format.split('x')]
    mode = sf.VideoMode(*values)

    if mode.is_valid():
        print 'The mode {0} is valid!'.format(mode)
    else:
        print 'The mode {0} is not valid!'.format(mode)


if __name__ == '__main__':
    main()
