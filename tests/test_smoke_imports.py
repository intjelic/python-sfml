import importlib

import pytest


MODULES = [
    "sfml",
    "sfml.system",
    "sfml.window",
    "sfml.graphics",
    "sfml.audio",
    "sfml.network",
]


@pytest.mark.parametrize("module_name", MODULES)
def test_module_imports(module_name):
    module = importlib.import_module(module_name)
    assert module is not None


def test_expected_symbols_are_exposed():
    import sfml.audio
    import sfml.graphics
    import sfml.network
    import sfml.system
    import sfml.window

    assert hasattr(sfml.system, "Time")
    assert hasattr(sfml.window, "VideoMode")
    assert hasattr(sfml.graphics, "Color")
    assert hasattr(sfml.audio, "Listener")
    assert hasattr(sfml.network, "IpAddress")