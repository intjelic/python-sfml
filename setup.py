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

USE_CYTHON = False

if USE_CYTHON:
    import Cython.Distutils
  
    x11_dir = ['src/sfml/x11']
    x11_libs = ['X11']
    x11_mod = Extension('sfml.x11', ['src/sfml/x11/x11.pyx'], x11_dir, libraries=x11_libs)

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
    x11_libs = ['X11']
    x11_mod = Extension('sfml.sfml.x11', ['src/sfml/x11/x11.c'], libraries=x11_libs)

    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    graphics_mod = Extension('sfml.graphics.graphics', ['src/sfml/graphics/graphics.cpp', 'src/sfml/graphics/hacks.cpp'], libraries=graphics_libs)

    audio_libs = ['sfml-audio']
    audio_mod = Extension('sfml.audio.audio', ['src/sfml/audio/audio.cpp'], libraries=audio_libs)

    network_libs = ['sfml-network']
    network_mod = Extension('sfml.network.network', ['src/sfml/network/network.cpp'], libraries=network_libs)
    
ext_modules = [x11_mod, graphics_mod, audio_mod, network_mod]

with open('README', 'r') as f:
    long_description = f.read()

major, minor, micro, releaselevel, serial = sys.version_info
    
if major == 2: 
    author='Jonathan De Wachter'.decode()
else:
    author='Jonathan De Wachter'

kwargs = dict(name='pySFML2',
            ext_modules=ext_modules,
            package_dir={'': 'src'},
            packages=['sfml', 'sfml.x11', 'sfml.system', 'sfml.window', 'sfml.graphics', 'sfml.audio', 'sfml.network'],
            version='0.9.0',
            description='A non-official Python binding for SFML2',
            long_description=long_description,
            author=author,
            author_email='dewachter.jonathan@gmail.com',
            url='http://openhelbreath.be/python-sfml2',
            license='GPLv3',
            classifiers=[
                'Development Status :: 5 - Production/Stable',
                'Intended Audience :: Developers',
                'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',                   
                'Operating System :: OS Independent',
                'Programming Language :: Cython',
                'Topic :: Games/Entertainment',
                'Topic :: Multimedia',
                'Topic :: Software Development :: Libraries :: Python Modules'
                ])

if USE_CYTHON:
  kwargs.update(cmdclass={'build_ext': Cython.Distutils.build_ext})

setup(**kwargs)
