#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.	If not, see <http://www.gnu.org/licenses/>.

import sys
import os
from setuptools import setup
from setuptools.command.test import test
from setuptools.extension import Extension

class PyTest(test):
	def finalize_options(self):
		test.finalize_options(self)
		self.test_args = []
		self.test_suite = True

	def run_tests(self):
		import pytest
		errno = pytest.main(self.test_args)
		sys.exit(errno)


if os.environ.get('USE_CYTHON'):
	import Cython.Distutils

	x11_source = 'src/sfml/x11.pyx'
	system_source = 'src/sfml/system.pyx'
	window_source = 'src/sfml/window.pyx'
	graphics_source = 'src/sfml/graphics.pyx'
	audio_source = 'src/sfml/audio.pyx'
	network_source = 'src/sfml/network.pyx'

else:
	x11_source = 'src/sfml/x11.cpp'
	system_source = 'src/sfml/system.cpp'
	window_source = 'src/sfml/window.cpp'
	graphics_source = 'src/sfml/graphics.cpp'
	audio_source = 'src/sfml/audio.cpp'
	network_source = 'src/sfml/network.cpp'

extension = lambda name, files, libs: Extension(
	'sfml.' + name,
	files,
	['include', 'src/sfml'], language='c++',
	libraries=libs)

x11 = extension('x11', [x11_source], ['X11'])

system = extension(
	'system',
	[system_source, 'src/sfml/error.cpp'],
	['sfml-system', 'sfml-graphics'])

window = extension(
	'window', [window_source, 'src/sfml/derivablewindow.cpp'],
	['sfml-system', 'sfml-window'])

graphics = extension(
	'graphics',
	[graphics_source, 'src/sfml/derivablerenderwindow.cpp', 'src/sfml/derivabledrawable.cpp'],
	['sfml-system', 'sfml-window', 'sfml-graphics'])

audio = extension(
	'audio',
	[audio_source, 'src/sfml/derivablesoundrecorder.cpp', 'src/sfml/derivablesoundstream.cpp'],
	['sfml-system', 'sfml-audio'])

network = extension(
	'network',
	[network_source],
	['sfml-system', 'sfml-network'])

with open('README.rst', 'r') as f:
	long_description = f.read()

kwargs = dict(
			name=u'pySFML2',
			ext_modules=[x11, system, window, graphics, audio, network],
			package_dir={'': 'src'},
			packages=['sfml'],
			version=u'1.2.0',
			description=u'The unofficial Python binding for SFML2',
			long_description=long_description,
			author=u'Jonathan de Wachter, Edwin O Marshall',
			author_email=u'dewachter.jonathan@gmail.com, emarshall85@gmail.com',
			url=u'http://openhelbreath.be/python-sfml2',
			license=u'LGPLv3',
			classifiers=[u'Development Status :: 5 - Production/Stable',
						u'Intended Audience :: Developers',
						u'License :: OSI Approved :: GNU General Public License v3 (LGPLv3)',
						u'Operating System :: OS Independent',
						u'Programming Language :: Cython',
						u'Topic :: Games/Entertainment',
						u'Topic :: Multimedia',
						u'Topic :: Software Development :: Libraries :: Python Modules'],
			tests_require=['pytest>=2.3'],
			cmdclass = {'test': PyTest})

if os.environ.get('USE_CYTHON'):
	kwargs['cmdclass'].update({'build_ext': Cython.Distutils.build_ext})

setup(**kwargs)
