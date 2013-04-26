#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Edwin Marshall <emarshall85@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


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
    time['sec'].seconds = 0
    time['milli'].milliseconds = 0
    time['micro'].microseconds = 0

    assert all(t == sf.Time() == sf.Time.ZERO for t in time.values())
