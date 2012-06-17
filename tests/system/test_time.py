#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Edwin Marshall <emarshall85@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import unittest
import sfml.system as sf

class TestSeconds(unittest.TestCase):

    def setUp(self):
        self.t = sf.seconds(5)

    def test_milliseconds(self):
        t_ms = self.t.milliseconds
        self.assertEqual(t_ms, 5000)

    def test_microseconds(self):
        t_us = self.t.microseconds
        self.assertEqual(t_us, 5000000)


class TestMilliSeconds(unittest.TestCase):

    def setUp(self):
        self.t = sf.milliseconds(5000)

    def test_seconds(self):
        t_ms = self.t.seconds
        self.assertEqual(t_ms, 5)

    def test_microseconds(self):
        t_us = self.t.microseconds
        self.assertEqual(t_us, 5000000)


class TestMicroSeconds(unittest.TestCase):

    def setUp(self):
        self.t = sf.microseconds(5000000)

    def test_seconds(self):
        t_ms = self.t.seconds
        self.assertEqual(t_ms, 5)

    def test_milliseconds(self):
        t_us = self.t.milliseconds
        self.assertEqual(t_us, 5000)


class TestOverloadedOperators(unittest.TestCase):

    def setUp(self):
        self.t1 = sf.seconds(5)
        self.t2 = sf.milliseconds(5000)
        self.t3 = sf.microseconds(5000000)

    def test_addition(self):
        t = self.t3 + self.t2 + self.t1
        self.assertEqual(t.seconds, 15)

    def test_subtraction(self):
        t = self.t3 - self.t2 - self.t1
        self.assertEqual(t.seconds, -5)

    @unittest.skip("Not Implemented")
    def test_multiplication(self):
        t = self.t3 * self.t2 * self.t1
        self.assertEqual(t.seconds, 125)

    @unittest.skip("Not Implemented")
    def test_division(self):
        t = self.t3 / self.t2 / self.t1
        self.assertEqual(t.seconds, 0.20)


if __name__ == '__main__':
    unittest.main()
