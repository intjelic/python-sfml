import pytest
import sfml.system as sf

@pytest.fixture()
def clock():
    return sf.Clock()

def test_sleep(clock):
    sf.sleep(sf.seconds(1))
    assert clock.elapsed_time >= sf.seconds(1)

def test_restart(clock):
    clock.restart()

    assert clock.elapsed_time <= sf.milliseconds(10)
