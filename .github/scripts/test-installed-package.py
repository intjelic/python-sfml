#!/usr/bin/env python3

from __future__ import annotations

import os
from importlib import import_module, resources
from pathlib import Path


MODULES = [
    "sfml",
    "sfml.system",
    "sfml.window",
    "sfml.graphics",
    "sfml.audio",
    "sfml.network",
]


def configure_runtime_environment() -> None:
    if os.name != "nt":
        os.environ.setdefault("ALSOFT_DRIVERS", "null")


def main() -> int:
    configure_runtime_environment()

    loaded_modules = {name: import_module(name) for name in MODULES}
    sfml = loaded_modules["sfml"]
    system = loaded_modules["sfml.system"]
    window = loaded_modules["sfml.window"]
    graphics = loaded_modules["sfml.graphics"]
    audio = loaded_modules["sfml.audio"]
    network = loaded_modules["sfml.network"]

    package_root = Path(sfml.__file__).resolve().parent

    print(f"sfml package root: {package_root}")
    print(f"configured ALSOFT_DRIVERS: {os.environ.get('ALSOFT_DRIVERS')!r}")

    assert hasattr(system, "Time")
    assert hasattr(window, "VideoMode")
    assert hasattr(graphics, "Color")
    assert hasattr(audio, "Listener")
    assert hasattr(network, "IpAddress")

    clock = system.Clock()
    elapsed = clock.elapsed_time
    print(f"clock elapsed seconds: {elapsed.seconds}")

    video_mode = window.VideoMode(640, 480, 32)
    print(f"video mode: {video_mode.width}x{video_mode.height}x{video_mode.bits_per_pixel}")

    context_settings = window.ContextSettings(depth=24, stencil=8, antialiasing=0, major=3, minor=0)
    print(f"context depth bits: {context_settings.depth_bits}")

    color = graphics.Color(10, 20, 30, 255)
    rect = graphics.Rect((0, 0), (10, 20))
    print(f"graphics objects: color={tuple(color)} rect={tuple(rect)}")

    chunk = audio.Chunk(b"\x00\x00\x01\x00")
    chunk[0] = 0
    print(f"audio chunk samples: {len(chunk)}")

    ip_address = network.IpAddress.from_string("127.0.0.1")
    print(f"network address bytes: {ip_address.string!r}")

    sfml_package = resources.files("sfml")
    typing_artifacts = [
        "py.typed",
        "__init__.pyi",
        "audio.pyi",
        "graphics.pyi",
        "network.pyi",
        "sf.pyi",
        "system.pyi",
        "window.pyi",
    ]
    missing = [path for path in typing_artifacts if not sfml_package.joinpath(path).is_file()]
    if missing:
        raise RuntimeError(f"missing typing artifacts: {', '.join(missing)}")

    signature_line = next(iter((system.seconds.__doc__ or "").splitlines()), "")
    if not signature_line.startswith("seconds("):
        raise RuntimeError(f"unexpected system.seconds signature doc: {signature_line!r}")

    print("installed-package validation passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())