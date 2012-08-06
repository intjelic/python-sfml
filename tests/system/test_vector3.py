# -*- coding: utf-8 -*-
from __future__ import division
import sfml as sf

def pytest_funcarg__v(request):
    return [sf.Vector3(2, 5, 0), sf.Vector3(5, 2, 7)]

def test_x(v):
    assert v[0].x == 2

def test_y(v):
    assert v[0].y == 5

def test_z(v):
    assert v[0].z == 0

def test_add(v):
    assert v[0] + v[1] == (7, 7, 7)

def test_sub(v):
    assert v[0] - v[1] == (-3, 3, -7)

def test_mul(v):
    assert v[0] * v[1] == (10, 10, 0)

def test_div(v):
    assert v[0] / v[1] == (0.4, 2.5, 0)

def test_iadd(v):
    v[0]+= v[1]
    assert v[0] == (7, 7, 7)

def test_isub(v):
    v[0]-= v[1]
    assert v[0] == (-3, 3, -7)

def test_imul(v):
    v[0]*= v[1]
    assert v[0] == (10, 10, 0)

def test_idiv(v):
    v[0]/= v[1]
    assert v[0] == (0.4, 2.5, 0)
