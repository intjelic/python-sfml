#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Edwin Marshall <emarshall85@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.	If not, see <http://www.gnu.org/licenses/>.


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
