import os
import sys
from pathlib import Path


_dll_directories = []


def _candidate_repo_prefixes(package_dir: Path):
	repo_deps_dir = package_dir.parent.parent / ".deps"
	for prefix_name in ("sfml-3.0.2-install", "sfml-3-install", "sfml-2.6.2-install"):
		yield repo_deps_dir / prefix_name


def _candidate_dll_directories():
	package_dir = Path(__file__).resolve().parent
	candidates = []

	install_prefix = os.environ.get("SFML_INSTALL_PREFIX")
	if install_prefix:
		prefix_dir = Path(install_prefix)
		candidates.append(prefix_dir / "bin")
		candidates.append(prefix_dir / "lib")

	sfml_libraries = os.environ.get("SFML_LIBRARIES")
	if sfml_libraries:
		library_dir = Path(sfml_libraries)
		candidates.append(library_dir)
		candidates.append(library_dir.parent / "bin")

	for repo_prefix in _candidate_repo_prefixes(package_dir):
		candidates.append(repo_prefix / "bin")
		candidates.append(repo_prefix / "lib")
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
