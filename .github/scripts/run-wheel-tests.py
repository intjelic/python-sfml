#!/usr/bin/env python3

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path


TEST_FILES = [
    "tests/test_smoke_imports.py",
    "tests/test_typing_artifacts.py",
]


def sanitized_env() -> dict[str, str]:
    env = os.environ.copy()

    for name in ("SFML_HEADERS", "SFML_LIBRARIES", "PKG_CONFIG_PATH", "LD_LIBRARY_PATH", "DYLD_LIBRARY_PATH"):
        env.pop(name, None)

    if os.name == "nt":
        blocked = ("c:/cibw-sfml-2.6.2/bin", "c:\\cibw-sfml-2.6.2\\bin")
        path_parts = env.get("PATH", "").split(os.pathsep)
        env["PATH"] = os.pathsep.join(
            part
            for part in path_parts
            if part and all(token not in part.lower() for token in blocked)
        )

    return env


def main() -> int:
    project_dir = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path.cwd()
    command = [sys.executable, "-m", "pytest", "-q", *[str(project_dir / test_file) for test_file in TEST_FILES]]
    return subprocess.run(command, cwd=project_dir, env=sanitized_env(), check=False).returncode


if __name__ == "__main__":
    raise SystemExit(main())
