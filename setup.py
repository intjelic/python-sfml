#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>,
#                 Edwin Marshall <emarshall85@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import sys
import os
from setuptools import setup
from setuptools.command.test import test
from setuptools.extension import Extension

# python 2.* compatability
try: input = raw_input 
except NameError: pass

# check if cython is needed (if c++ files are generated or not)
NEED_CYTHON = False
NEED_CYTHON = not os.path.exists('src/sfml/x11.cpp')      or NEED_CYTHON
NEED_CYTHON = not os.path.exists('src/sfml/system.cpp')   or NEED_CYTHON
NEED_CYTHON = not os.path.exists('src/sfml/window.cpp')   or NEED_CYTHON
NEED_CYTHON = not os.path.exists('src/sfml/graphics.cpp') or NEED_CYTHON
NEED_CYTHON = not os.path.exists('src/sfml/audio.cpp')    or NEED_CYTHON
NEED_CYTHON = not os.path.exists('src/sfml/network.cpp')  or NEED_CYTHON

# use cython if cython is needed
USE_CYTHON = False
USE_CYTHON = NEED_CYTHON or USE_CYTHON

# use cython if explicitly asked for
USE_CYTHON = "build_ext" in sys.argv or USE_CYTHON
USE_CYTHON = "--cython" in sys.argv    or USE_CYTHON

# remove cython argument as it's not standard
try:
	sys.argv.remove("--cython")
except ValueError:
	pass

if USE_CYTHON:
	try:
		# in order to proceed we need to import cython module
		import Cython.Distutils

	except ImportError:
		# maybe cython is installed in another python version, so let's 
		# try to compile at hand
		from subprocess import call
		try:
			print("Cython couldn't be found in this version, try others...")
			print("Cython is trying to compile x11.pyx...")
			call(["cython", "--cplus", "src/sfml/x11.pyx", "-Iinclude"])
			print("Cython is compiling system.pyx...")
			call(["cython", "--cplus", "src/sfml/system.pyx", "-Iinclude"])
			print("Cython is compiling window.pyx...")
			call(["cython", "--cplus", "src/sfml/window.pyx", "-Iinclude"])
			print("Cython is compiling graphics.pyx...")
			call(["cython", "--cplus", "src/sfml/graphics.pyx", "-Iinclude"])
			print("Cython is compiling audio.pyx...")
			call(["cython", "--cplus", "src/sfml/audio.pyx", "-Iinclude"])
			print("Cython is compiling network.pyx...")
			call(["cython", "--cplus", "src/sfml/network.pyx", "-Iinclude"])
			print("Consider installing Cython for this Python version")
			# cython compilation succeeded, we no longer need cython
			USE_CYTHON = False
		except OSError:
			sys.exit("Couldn't find cython, please install it first")
			
class PyTest(test):
	def finalize_options(self):
		test.finalize_options(self)
		self.test_args = []
		self.test_suite = True

	def run_tests(self):
		import pytest
		errno = pytest.main(self.test_args)
		sys.exit(errno)


if USE_CYTHON:
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
			name='sfml',
			ext_modules=[x11, system, window, graphics, audio, network],
			package_dir={'': 'src'},
			packages=['sfml'],
			version='1.2.0',
			description='Python bindings for SFML',
			long_description=long_description,
			author='Jonathan de Wachter, Edwin O Marshall',
			author_email='dewachter.jonathan@gmail.com, emarshall85@gmail.com',
			url='http://python-sfml.org',
			license='LGPLv3',
			classifiers=['Development Status :: 5 - Production/Stable',
						'Intended Audience :: Developers',
						'License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)',
						'Operating System :: OS Independent',
						'Programming Language :: Cython',
						'Programming Language :: C++',
						'Programming Language :: Python',
						'Topic :: Games/Entertainment',
						'Topic :: Multimedia',
						'Topic :: Software Development :: Libraries :: Python Modules'],
			tests_require=['pytest>=2.3'],
			cmdclass = {'test': PyTest})

if USE_CYTHON:
	kwargs['cmdclass'].update({'build_ext': Cython.Distutils.build_ext})

setup(**kwargs)
