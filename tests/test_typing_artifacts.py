from importlib import resources

import sfml.system


def test_typing_artifacts_are_packaged():
    sfml_package = resources.files("sfml")

    assert sfml_package.joinpath("py.typed").is_file()
    assert sfml_package.joinpath("__init__.pyi").is_file()
    assert sfml_package.joinpath("audio.pyi").is_file()
    assert sfml_package.joinpath("graphics.pyi").is_file()
    assert sfml_package.joinpath("network.pyi").is_file()
    assert sfml_package.joinpath("sf.pyi").is_file()
    assert sfml_package.joinpath("system.pyi").is_file()
    assert sfml_package.joinpath("window.pyi").is_file()


def test_embedded_runtime_signatures_are_available():
    signature_line = (sfml.system.seconds.__doc__ or "").splitlines()[0]

    assert signature_line.startswith("seconds(")