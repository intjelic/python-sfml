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

# display the list of all the video modes available for fullscreen
i = 0
modes = sf.VideoMode.get_fullscreen_modes()
for mode in modes:
	print("Mode #{0}: {1}".format(i, mode))
	i += 1
	
# create a window with the same pixel depth as the desktop
desktop = sf.VideoMode.get_desktop_mode()
width, bpp = desktop
window = sf.Window(sf.VideoMode(1024, 768, bpp), "pySFML Window")
