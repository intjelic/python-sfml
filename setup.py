#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys
from distutils.core import setup
from distutils.extension import Extension

USE_CYTHON = True

if USE_CYTHON:
	import Cython.Distutils

	x11_source = 'src/sfml/graphics/x11.pyx'
	graphics_source = 'src/sfml/graphics/graphics.pyx'
	audio_source = 'src/sfml/audio/audio.pyx'
	network_source = 'src/sfml/network/network.pyx'
	
else:
	x11_source = 'src/sfml/graphics/x11.cpp'
	graphics_source = 'src/sfml/graphics/graphics.cpp'
	audio_source = 'src/sfml/audio/audio.cpp'
	network_source = 'src/sfml/network/network.cpp'
	
x11 = Extension('sfml.graphics.x11', 
				[x11_source],
				language='c++',
				libraries=['X11'])

graphics = Extension('sfml.graphics.graphics', 
					[graphics_source, 'src/sfml/graphics/derivablewindow.cpp', 'src/sfml/graphics/derivablerenderwindow.cpp', 'src/sfml/graphics/derivabledrawable.cpp'], 
					['src/sfml/system', 'src/sfml/window'], 
					language='c++', 
					libraries=['sfml-system', 'sfml-window', 'sfml-graphics'])

audio = Extension('sfml.audio.audio', 
					[audio_source, 'src/sfml/audio/derivablesoundrecorder.cpp'], 
					['src/sfml/system'], 
					language='c++',
					libraries=['sfml-system', 'sfml-audio'])

network = Extension('sfml.network.network', 
					[network_source], 
					['src/sfml/system'], 
					language='c++', 
					libraries=['sfml-system', 'sfml-network'])

with open('README', 'r') as f:
	long_description = f.read()
    
major, minor, micro, releaselevel, serial = sys.version_info
    
kwargs = dict(name='pySFML2',
			ext_modules=[x11, graphics, audio, network],
			package_dir={'': 'src'},
			packages=['sfml', 'sfml.system', 'sfml.window', 'sfml.graphics', 'sfml.audio', 'sfml.network'],
			version='1.0.0',
			description='A non-official Python binding for SFML2',
			long_description=long_description,
			author_email='dewachter.jonathan@gmail.com',
			url='http://openhelbreath.be/python-sfml2',
			license='GPLv3',
			classifiers=['Development Status :: 5 - Production/Stable',
						'Intended Audience :: Developers',
						'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
						'Operating System :: OS Independent',
						'Programming Language :: Cython',
						'Topic :: Games/Entertainment',
						'Topic :: Multimedia',
						'Topic :: Software Development :: Libraries :: Python Modules'])    
    
if major == 2:
	kwargs.update(author='Jonathan De Wachter'.decode())
else:
	kwargs.update(author='Jonathan De Wachter')

if USE_CYTHON:
	kwargs.update(cmdclass={'build_ext': Cython.Distutils.build_ext})

setup(**kwargs)
