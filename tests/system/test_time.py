# -*- coding: utf-8 -*-
import sfml.system as sf

def pytest_funcarg__time(request):
    return {
        'sec': sf.seconds(5),
        'mil': sf.milliseconds(5000),
        'mic': sf.microseconds(5000000)}

def test_seconds_to_milliseconds(time):
    ms = time['sec'].milliseconds
    assert ms == 5000

def test_seconds_to_microseconds(time):
    us = time['sec'].microseconds
    assert us == 5000000

def test_miliseconds_to_seconds(time):
    s = time['mil'].seconds
    assert s == 5

def test_milliseconds_to_microseconds(time):
    us = time['mil'].microseconds
    assert us == 5000000

def test_microseconds_to_seconds(time):
    s = time['mic'].seconds
    assert s == 5

def test_microseconds_to_milliseconds(time):
    ms = time['mic'].milliseconds
    assert ms == 5000

def test_add(time):
    t = time['sec'] + time['mil']
    assert t.seconds == 10

def test_subtract(time):
    t = time['sec'] - time['mil']
    assert t.seconds == 0

def test_iadd(time):
    time['sec'] += time['mil']
    assert time['sec'].seconds == 10

def test_isub(time):
    time['sec'] -= time['mil']
    assert time['sec'].seconds == 0
