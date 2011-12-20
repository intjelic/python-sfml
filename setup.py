########################################################################
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>   #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################


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
    
ext_modules = [graphics_mod, audio_mod]

with open('README.txt', 'r') as f:
    long_description = f.read()

kwargs = dict(name='SFML2',
              ext_modules=ext_modules,
              version='0.0.1',
              description='A non-official Python binding for SFML 2',
              long_description=long_description,
              author=u'Jonathan De Wachter',
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
