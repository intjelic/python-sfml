# -*- coding: utf-8 -*-

import platform
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

debug = False
enable_warnings = False

extra_compile_args = []

if platform.system() == 'Linux':
    if enable_warnings:
        for option in ('-Wall',  '-Wextra', '-pedantic'):
            extra_compile_args.append(option)

    if debug:
        extra_compile_args.append('-g')
        extra_compile_args.append('-ggdb')

libs = ['sfml-graphics', 'sfml-window', 'sfml-system']
ext_modules = [Extension('sf', ['sf.pyx'],
                         language='c++',
                         libraries=libs,
                         extra_compile_args=extra_compile_args)]

setup(
  name = 'PySFML',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)
