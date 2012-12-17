from __future__ import division
import pytest
import sfml as sf

@pytest.fixture
def vector():
    return [sf.Vector2(2, 5), sf.Vector2(5, 2)]

def test_x(vector):
    assert vector[0].x == 2

def test_y(vector):
    assert vector[0].y == 5
