import sfml.system as sf

def pytest_funcarg__secs(request):
    return sf.seconds(5)

def pytest_funcarg__mills(request):
    return sf.milliseconds(5000)

def pytest_funcarg__micros(request):
    return sf.microseconds(5000000)

def test_seconds_to_milliseconds(secs):
    ms = secs.milliseconds
    assert ms == 5000

def test_seconds_to_microseconds(secs):
    us = secs.microseconds
    assert us == 5000000

def test_miliseconds_to_seconds(mills):
    s = mills.seconds
    assert s == 5

def test_milliseconds_to_microseconds(mills):
    us = mills.microseconds
    assert us == 5000000

def test_microseconds_to_seconds(micros):
    s = micros.seconds
    assert s == 5

def test_microseconds_to_milliseconds(micros):
    ms = micros.milliseconds
    assert ms == 5000

def test_add(secs, mills):
    t = secs + mills
    assert t.seconds == 10

def test_subtract(secs, mills):
    t = secs - mills
    assert t.seconds == 0

def test_iadd(secs, mills):
    secs += mills
    assert secs.seconds == 10

def test_isub(secs, mills):
    secs -= mills
    assert secs.seconds == 0
