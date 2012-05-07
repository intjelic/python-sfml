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
  
    x11_libs = ['X11']
    x11_mod = Extension('sfml.x11', ['src/sfml/x11/x11.pyx'], libraries=x11_libs)

    graphics_dir = ['src/sfml/system', 'src/sfml/window']
    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    graphics_mod = Extension('sfml.graphics.graphics', ['src/sfml/graphics/graphics.pyx', 'src/sfml/graphics/hacks.cpp'], graphics_dir, language='c++', libraries=graphics_libs)

    audio_dir = ['src/sfml/system']
    audio_libs = ['sfml-audio']
    audio_mod = Extension('sfml.audio.audio', ['src/sfml/audio/audio.pyx'], audio_dir, language='c++', libraries=audio_libs)

    network_dir = ['src/sfml/system']
    network_libs = ['sfml-network']
    network_mod = Extension('sfml.network.network', ['src/sfml/network/network.pyx'], network_dir, language='c++', libraries=network_libs)
    
else:
    input()
    x11_libs = ['X11']
    x11_mod = Extension('sfml.sfml.x11', ['src/x11/x11.cpp'], libraries=x11_libs)

    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    graphics_mod = Extension('sfml.graphics.graphics', ['src/graphics/graphics.cpp', 'src/graphics/hacks.cpp'], libraries=graphics_libs)

    audio_libs = ['sfml-audio']
    audio_mod = Extension('sfml.audio.audio', ['src/audio/audio.cpp'], libraries=audio_libs)

    network_libs = ['sfml-network']
    network_mod = Extension('sfml.network.network', ['src/network/network.cpp'], libraries=network_libs)
    
ext_modules = [x11_mod, graphics_mod, audio_mod, network_mod]

with open('README', 'r') as f:
    long_description = f.read()
    
major, minor, micro, releaselevel, serial = sys.version_info
    
if major == 2:      
  kwargs = dict(name='SFML2',
                ext_modules=ext_modules,
                package_dir={'': 'src'},
                packages=['sfml', 'sfml.x11', 'sfml.system', 'sfml.window', 'sfml.graphics', 'sfml.audio', 'sfml.network'],
                version='0.9.0',
                description='A non-official Python binding for SFML 2',
                long_description=long_description,
                author='Jonathan De Wachter'.decode(),
                author_email='dewachter.jonathan@gmail.com',
                url='http://dewachterjonathan.be/python-sfml2',
                license='GPLv3',
                classifiers=[
                    'Development Status :: 3 - Alpha',
                    'Intended Audience :: Developers',
                    'Operating System :: OS Independent',
                    'Programming Language :: Cython',
                    'Topic :: Games/Entertainment',
                    'Topic :: Multimedia',
                    'Topic :: Software Development :: Libraries :: Python Modules'
                    ])

  if USE_CYTHON:
      kwargs.update(cmdclass={'build_ext': Cython.Distutils.build_ext})

  setup(**kwargs)

else:
  kwargs = dict(name='SFML2',
                ext_modules=ext_modules,
                package_dir={'': 'src'},
                packages=['sfml', 'sfml.x11', 'sfml.system', 'sfml.window', 'sfml.graphics', 'sfml.audio', 'sfml.network'],
                version='0.9.0',
                description='A non-official Python binding for SFML 2',
                long_description=long_description,
                author='Jonathan De Wachter',
                author_email='dewachter.jonathan@gmail.com',
                url='https://dewachterjonathan.be/python3-sfml2',
                license='GPLv3',
                classifiers=[
                    'Development Status :: 3 - Alpha',
                    'Intended Audience :: Developers',
                    'Operating System :: OS Independent',
                    'Programming Language :: Cython',
                    'Topic :: Games/Entertainment',
                    'Topic :: Multimedia',
                    'Topic :: Software Development :: Libraries :: Python Modules'
                    ])

  if USE_CYTHON:
      kwargs.update(cmdclass={'build_ext': Cython.Distutils.build_ext})

  setup(**kwargs)
