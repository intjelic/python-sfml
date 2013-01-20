#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>,
#				  Edwin Marshall <emarshall85@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import sys
import os
import platform
from glob import glob
from subprocess import call
from distutils.core import setup, Command, Extension

# python 2.* compatability
try: input = raw_input
except NameError: pass

class PyTest(Command):
	user_options = []

	def initialize_options(self): pass
	def finalize_options(self): pass
	def run(self):
		errno = call([sys.executable, 'runtests.py'])
		raise SystemExit(errno)

try:
	from Cython.Distutils import build_ext as Cython
except ImportError:
	class Cython(Command):
		""" Minimal command that runs 'cython' from the command line,
			rather than importing the version-specific distutils module
			included with Cython.
		"""
		user_options = []

		def initialize_options(self): pass
		def finalize_options(self): pass
		def run(self):
			srcdir = 'src/sfml/'
			modules = glob(srcdir + '*.pyx')
			errno = 1
			if platform.system() == 'Windows': modules.remove('x11.pyx')

			for module in modules:
				try:
					errno = call('cython --cplus {0}{1} -Iinclude'.format(srcdir, module),
								shell=True)
				except OSError:
					print("Please install cython and try again.")
				finally:
					raise SystemExit(errno)


sources = dict(
	x11 = 'src/sfml/x11.cpp',
	system = 'src/sfml/system.cpp',
	window = 'src/sfml/window.cpp',
	graphics = 'src/sfml/graphics.cpp',
	audio = 'src/sfml/audio.cpp',
	network = 'src/sfml/network.cpp')

# check if cython is needed (if c++ files are generated or not)
NEED_CYTHON = not all(map(os.path.exists, sources.values()))

try:
	USE_CYTHON = NEED_CYTHON or bool(int(os.environ.get('USE_CYTHON', 0)))
except ValueError:
	USE_CYTHON = NEED_CYTHON or bool(os.environ.get('USE_CYTHON'))

if USE_CYTHON:
	sources = {k: v.replace('cpp', 'pyx') for k, v in sources.items()}

extension = lambda name, files, libs: Extension(
	'sfml.' + name,
	files,
	['include', 'src/sfml'], language='c++',
	libraries=libs)

x11 = extension('x11', [sources['x11']], ['X11'])

system = extension(
	'system',
	[sources['system'], 'src/sfml/error.cpp'],
	['sfml-system', 'sfml-graphics'])

window = extension(
	'window', [sources['window'], 'src/sfml/derivablewindow.cpp'],
	['sfml-system', 'sfml-window'])

graphics = extension(
	'graphics',
	[sources['graphics'], 'src/sfml/derivablerenderwindow.cpp', 'src/sfml/derivabledrawable.cpp'],
	['sfml-system', 'sfml-window', 'sfml-graphics'])

audio = extension(
	'audio',
	[sources['audio'], 'src/sfml/derivablesoundrecorder.cpp', 'src/sfml/derivablesoundstream.cpp'],
	['sfml-system', 'sfml-audio'])

network = extension(
	'network',
	[sources['network']],
	['sfml-system', 'sfml-network'])


# install the C/Cython API in the python directory (its location varies)
# on Windows: C:\PythonXY\include\pysfml\*.pxd and *.h
# on Unix:    /usr/include/pythonX.Y/sfml/*.pxd and *.h

# define the include directory
headers = glob('src/sfml/*.h')
if platform.system() == 'Windows':
	include_dir = os.path.join(sys.prefix, 'include', 'pysfml')
	headers.pop('x11.h')
else:
	major, minor, _, _ , _ = sys.version_info
	include_dir = os.path.join(
		sys.prefix, 'include', 'python{0}.{1}'.format(major, minor), 'pysfml')

# list all relevant headers (find in include/ and src/sfml/)
# key: directory, value: list of headers to place in the directory
files = {root: [os.path.join(root, fname) for fname in fnames]
		 for root, dirs, fnames in os.walk('include')}
files['include'] += glob('src/sfml/*.h')
files = [(k.replace('include', include_dir), v) for k, v in files.items()]

with open('README.rst', 'r') as f:
	long_description = f.read()

ext_modules=[x11, system, window, graphics, audio, network]
if platform.system() == 'Windows': ext_modules.pop(x11)

kwargs = dict(
			name='pySFML',
			ext_modules=ext_modules,
			package_dir={'': 'src'},
			packages=['sfml'],
			data_files=files,
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
			cmdclass={'test': PyTest, 'build_ext': Cython})

setup(**kwargs)
