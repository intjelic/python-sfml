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


if __name__ == '__main__':
    main()
