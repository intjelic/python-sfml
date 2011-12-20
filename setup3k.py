# -*- coding: utf-8 -*-

# Copyright 2010, 2011 Bastien Léonard. All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:

#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.

#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.

# THIS SOFTWARE IS PROVIDED BY BASTIEN LÉONARD ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BASTIEN LÉONARD OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.


# Set to False if you don't have Cython installed. The script will
# then build the extension module from the sf.cpp file, like a regular
# extension.
USE_CYTHON = True


from distutils.core import setup
from distutils.extension import Extension

if USE_CYTHON:
    import Cython.Distutils
    
    
if USE_CYTHON:
    graphics_dir = ['sfml/system', 'sfml/window']
    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    graphics_mod = Extension('sfml.graphics.graphics', ['sfml/graphics/graphics.pyx', 'sfml/graphics/hacks.cpp'], language='c++', libraries=graphics_libs)

    audio_libs = ['sfml-audio']
    audio_mod = Extension('sfml.audio.audio', ['sfml/audio/audio.pyx'], language='c++', libraries=audio_libs)

    network_libs = ['sfml-network']
    network_mod = Extension('sfml.network.network', ['sfml/network/network.pyx'], language='c++', libraries=network_libs)
    
else:
    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    graphics_mod = Extension('sfml.graphics.graphics', ['sfml/graphics/graphics.cpp', 'sfml/graphics/hacks.cpp'], libraries=graphics_libs)

    audio_libs = ['sfml-audio']
    audio_mod = Extension('sfml.audio.audio', ['sfml/audio/audio.cpp'], libraries=audio_libs)

    network_libs = ['sfml-network']
    network_mod = Extension('sfml.network.network', ['sfml/network/network.cpp'], libraries=network_libs)
    
ext_modules = [graphics_mod]#, audio_mod]


with open('README', 'r') as f:
    long_description = f.read()

kwargs = dict(name='SFML2',
              packages=['sfml', 'sfml.system', 'sfml.window', 'sfml.graphics', 'sfml.audio', 'sfml.network'],
              ext_modules=ext_modules,
              version='0.0.1',
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
