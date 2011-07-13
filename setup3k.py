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
USE_CYTHON = False


from distutils.core import setup
from distutils.extension import Extension

if USE_CYTHON:
    from Cython.Distutils import build_ext

libs = ['sfml-graphics', 'sfml-window', 'sfml-audio', 'sfml-system']

if USE_CYTHON:
    ext_modules = [Extension('sf', ['sf.pyx'],
                             language='c++',
                             libraries=libs)]
else:
    ext_modules = [Extension('sf', ['sf.cpp'],
                             libraries=libs)]


if USE_CYTHON:
    setup(
        name = 'PySFML 2',
        cmdclass = {'build_ext': build_ext},
        ext_modules = ext_modules,
        version='0.0.1',
        description='A Python binding for SFML 2',
        author='Bastien Léonard',
        author_email='bastien.leonard@gmail.com',
        url='https://github.com/bastienleonard/pysfml2-cython'
        )
else:
    setup(
        name = 'PySFML 2',
        ext_modules = ext_modules,
        version='0.0.1',
        description='A Python binding for SFML 2',
        author='Bastien Léonard',
        author_email='bastien.leonard@gmail.com',
        url='https://github.com/bastienleonard/pysfml2-cython'
        )
