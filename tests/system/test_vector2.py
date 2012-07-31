from __future__ import division
import sfml as sf

def pytest_funcarg__v1(request):
    return sf.Vector2(2, 5)

def pytest_funcarg__v2(request):
    return sf.Vector2(5, 2)

def test_x(v1):
    assert v1.x == 2

def test_y(v1):
    assert v1.y == 5

def test_add(v1, v2):
    assert v1 + v2 == (7, 7)

def test_sub(v1, v2):
    assert v1 - v2 == (-3, 3)

def test_mul(v1, v2):
    assert v1 * v2 == (10, 10)

def test_div(v1, v2):
    assert v1 / v2 == (0.4, 2.5)

def test_iadd(v1, v2):
    v1 += v2
    assert v1 == (7, 7)

def test_isub(v1, v2):
    v1 -= v2
    assert v1 == (-3, 3)

def test_imul(v1, v2):
    v1 *= v2
    assert v1 == (10, 10)

def test_idiv(v1, v2):
    v1 /= v2
    assert v1 == (0.4, 2.5)
