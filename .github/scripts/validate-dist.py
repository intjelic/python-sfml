#!/usr/bin/env python3

from __future__ import annotations

import argparse
import sys
import tarfile
import zipfile
from pathlib import Path


REQUIRED_TYPING_ARTIFACTS = {
    "sfml/py.typed",
    "sfml/__init__.pyi",
    "sfml/audio.pyi",
    "sfml/graphics.pyi",
    "sfml/network.pyi",
    "sfml/sf.pyi",
    "sfml/system.pyi",
    "sfml/window.pyi",
}

SDIST_TYPING_ARTIFACTS = {f"src/{path}" for path in REQUIRED_TYPING_ARTIFACTS}


def wheel_members(path: Path) -> set[str]:
    with zipfile.ZipFile(path) as archive:
        return set(archive.namelist())


def sdist_members(path: Path) -> set[str]:
    with tarfile.open(path, "r:gz") as archive:
        members = set()
        for member in archive.getnames():
            parts = member.split("/", 1)
            if len(parts) == 2:
                members.add(parts[1])
        return members


def validate_members(path: Path, members: set[str]) -> list[str]:
    required_paths = SDIST_TYPING_ARTIFACTS if path.suffixes[-2:] == [".tar", ".gz"] else REQUIRED_TYPING_ARTIFACTS
    missing = sorted(required for required in required_paths if required not in members)
    errors: list[str] = []

    if missing:
        errors.append(f"missing typing artifacts: {', '.join(missing)}")

    if path.suffix == ".whl" and not any(name.startswith("sfml/") and (name.endswith(".so") or name.endswith(".pyd")) for name in members):
        errors.append("wheel does not contain a compiled extension module under sfml/")

    return errors


def validate_artifact(path: Path) -> int:
    if path.suffix == ".whl":
        members = wheel_members(path)
    elif path.suffixes[-2:] == [".tar", ".gz"]:
        members = sdist_members(path)
    else:
        print(f"unsupported artifact type: {path}", file=sys.stderr)
        return 1

    errors = validate_members(path, members)
    if errors:
        print(f"artifact validation failed for {path}:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1

    print(f"validated {path}")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate PySFML wheel and sdist contents")
    parser.add_argument("artifacts", nargs="+", help="wheel and/or sdist paths")
    args = parser.parse_args()

    exit_code = 0
    for artifact in args.artifacts:
        exit_code |= validate_artifact(Path(artifact))
    return exit_code


if __name__ == "__main__":
    raise SystemExit(main())