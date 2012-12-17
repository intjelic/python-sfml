import pytest
import sfml.system as sf

@pytest.fixture(scope='function')
def time():
    return dict(
        micro=sf.microseconds(5000000),
        milli=sf.milliseconds(5000),
        sec=sf.seconds(5))

def test_to_micro(time):
    assert time['milli'].microseconds == time['sec'].microseconds == 5000000

def test_to_milli(time):
    assert time['micro'].milliseconds == time['sec'].milliseconds == 5000

def test_to_sec(time):
    assert time['micro'].seconds == time['milli'].seconds == 5

def test_zero(time):
    for t in time.values():
        t.reset()

    assert all(t == sf.Time() == sf.Time.ZERO for t in time.values())

