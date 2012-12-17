from __future__ import division
import pytest
import sfml.system as sf

@pytest.fixture()
def vector():
    return [sf.Vector3(2, 5, 0), sf.Vector3(5, 2, 7)]

def test_x(vector):
    assert vector[0].x == 2

def test_y(vector):
    assert vector[0].y == 5

def test_z(vector):
    assert vector[0].z == 0
