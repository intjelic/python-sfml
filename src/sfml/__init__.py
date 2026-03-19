import os
import sys
from pathlib import Path


_dll_directories = []


def _candidate_dll_directories():
	package_dir = Path(__file__).resolve().parent
	candidates = []

	install_prefix = os.environ.get("SFML_INSTALL_PREFIX")
	if install_prefix:
		candidates.append(Path(install_prefix) / "bin")

	sfml_libraries = os.environ.get("SFML_LIBRARIES")
	if sfml_libraries:
		library_dir = Path(sfml_libraries)
		candidates.append(library_dir)
		candidates.append(library_dir.parent / "bin")

	repo_prefix = package_dir.parent.parent / ".deps" / "sfml-2.6.2-install"
	candidates.append(repo_prefix / "bin")
	candidates.append(package_dir)

	seen = set()
	for candidate in candidates:
		resolved = str(candidate)
		if resolved in seen:
			continue
		seen.add(resolved)
		yield candidate


if sys.platform == "win32" and hasattr(os, "add_dll_directory"):
	for dll_directory in _candidate_dll_directories():
		if dll_directory.is_dir():
			_dll_directories.append(os.add_dll_directory(str(dll_directory)))


import sfml.system
import sfml.window
import sfml.graphics
import sfml.audio
import sfml.network
