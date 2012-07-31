import sfml.system as sf

def pytest_funcarg__clock(request):
    return sf.Clock()

def test_elapsed(clock):
    sf.sleep(sf.seconds(1))
    assert clock.elapsed_time >= sf.seconds(1)

def test_restart(clock):
    clock.restart()

    assert clock.elapsed_time <= sf.milliseconds(10)
