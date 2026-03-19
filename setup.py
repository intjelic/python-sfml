import sys
import os
import platform
import os.path
import shutil
from glob import glob
from setuptools import setup, Extension
from setuptools.command.build_ext import build_ext

try:
    from Cython.Build import cythonize
except ImportError:
    print("Please install Cython and try again.")
    exit(1)

SFML_HEADERS = os.getenv('SFML_HEADERS')
SFML_LIBRARIES = os.getenv('SFML_LIBRARIES')
REPOSITORY_ROOT = os.path.abspath(os.path.dirname(__file__))
DEFAULT_SFML_PREFIX = os.path.join(REPOSITORY_ROOT, '.deps', 'sfml-2.6.2-install')


def resolve_sfml_path(explicit_path, *relative_parts):
    if explicit_path:
        return os.path.normpath(explicit_path)

    candidate = os.path.join(DEFAULT_SFML_PREFIX, *relative_parts)
    if os.path.isdir(candidate):
        return os.path.normpath(candidate)

    return None


SFML_HEADERS = resolve_sfml_path(SFML_HEADERS, 'include')
SFML_LIBRARIES = resolve_sfml_path(SFML_LIBRARIES, 'lib')
WINDOWS_USE_SHARED_SFML = platform.system() == 'Windows'

def stage_generated_headers(build_temp):
    staged_headers = []

    for module in ('system', 'window', 'graphics', 'audio', 'network'):
        header_files = glob(os.path.join('src', 'sfml', module, '*.hpp'))
        header_files.append(os.path.join('src', 'sfml', module, module + '.h'))
        header_files.append(os.path.join('src', 'sfml', module, module + '_api.h'))

        destination = os.path.join(build_temp, 'include', 'pysfml', module)
        os.makedirs(destination, exist_ok=True)

        copied_files = []
        for header_file in header_files:
            if os.path.isfile(header_file):
                destination_file = os.path.join(destination, os.path.basename(header_file))
                shutil.copy(header_file, destination_file)
                copied_files.append(destination_file)

        if copied_files:
            staged_headers.append((module, copied_files))

    return staged_headers


class CythonBuildExt(build_ext):
    def build_extensions(self):
        staged_headers = stage_generated_headers(self.build_temp)
        self.include_dirs.append(os.path.join(self.build_temp, 'include'))
        self.compiler.include_dirs.append(os.path.join(self.build_temp, 'include'))

        for module, files_to_install in staged_headers:
            install_directory = os.path.join('include', 'pysfml', module)
            data_files.append((install_directory, files_to_install))

        super().build_extensions()

include_dirs = []
library_dirs = []

include_dirs.append(os.path.join('include', 'Includes'))
if SFML_HEADERS:
    include_dirs.append(SFML_HEADERS)

if SFML_LIBRARIES:
    library_dirs.append(SFML_LIBRARIES)

def extension(name, files, libs): return Extension(
        name='sfml.' + name,
        sources=[os.path.join('src', 'sfml', name, filename) for filename in files],
        include_dirs=include_dirs,
        library_dirs=library_dirs,
        language='c++',
        libraries=libs,
        define_macros=[('SFML_STATIC', '1')] if platform.system() == 'Windows' and not WINDOWS_USE_SHARED_SFML else []
    )

if platform.system() == 'Windows':
    system_libs = [
        'sfml-system'
    ]
    window_libs = [
        'sfml-system',
        'sfml-window'
    ]
    graphics_libs = [
        'sfml-system',
        'sfml-window',
        'sfml-graphics'
    ]
    audio_libs = [
        'sfml-system',
        'sfml-audio'
    ]
    network_libs = [
        'ws2_32',
        'sfml-system',
        'sfml-network'
    ]
else:
    system_libs   = ['sfml-system']
    window_libs   = ['sfml-system', 'sfml-window']
    graphics_libs = ['sfml-system', 'sfml-window', 'sfml-graphics']
    audio_libs    = ['sfml-system', 'sfml-audio']
    network_libs  = ['sfml-system', 'sfml-network']

system = extension(
    'system',
    ['system.pyx', 'error.cpp', 'hacks.cpp', 'NumericObject.cpp'],
    system_libs
)

window = extension(
    'window',
    ['window.pyx', 'DerivableWindow.cpp'],
    window_libs
)

graphics = extension(
    'graphics',
    ['graphics.pyx', 'DerivableRenderWindow.cpp', 'DerivableDrawable.cpp', 'NumericObject.cpp'],
    graphics_libs)

audio = extension(
    'audio',
    ['audio.pyx', 'DerivableSoundRecorder.cpp', 'DerivableSoundStream.cpp'],
    audio_libs
)

network = extension(
    'network',
    ['network.pyx'],
    network_libs
)

ext_modules = cythonize(
    [system, window, graphics, audio, network],
    include_path=[os.path.join('include', 'Includes')],
    compiler_directives={
        'embedsignature': True,
        'language_level': '3',
    },
)

data_files = []

setup(
    ext_modules=ext_modules,
    data_files=data_files,
    cmdclass={'build_ext': CythonBuildExt}
)
