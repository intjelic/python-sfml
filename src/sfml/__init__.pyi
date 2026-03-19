from __future__ import annotations

from typing import Any

from . import audio, graphics, network, system, window

def __getattr__(name: str) -> Any: ...
