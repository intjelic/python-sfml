#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2012-2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from libcpp.sfml cimport Vector3f

cdef extern from "SFML/Audio.hpp" namespace "sf::Listener":
    cdef void setGlobalVolume(float)
    cdef float getGlobalVolume()
    cdef void setPosition(float, float, float)
    cdef void setPosition(const Vector3f&)
    cdef Vector3f getPosition()
    cdef void setDirection(float, float, float)
    cdef void setDirection(const Vector3f&)
    cdef Vector3f getDirection()
