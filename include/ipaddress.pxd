#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from dsystem cimport Time
from dnetwork cimport IpAddress

cdef extern from "SFML/Network.hpp" namespace "sf::IpAddress":
    cdef IpAddress getLocalAddress()
    cdef IpAddress getPublicAddress()
    cdef IpAddress getPublicAddress(Time)

    IpAddress None
    IpAddress LocalHost
    IpAddress Broadcast
