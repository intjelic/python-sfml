#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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

    def test_add(self):
        t = self.t1 + self.t2
        self.assertEqual(t.seconds, 10)

    def test_sub(self):
        t = self.t1 - self.t2
        self.assertEqual(t.seconds, 0)

    def test_mul(self):
        t = self.t1 * self.t2
        self.assertEqual(t.seconds, 25)

    def test_div(self):
        t = self.t1 / self.t2
        self.assertEqual(t.seconds, 1)

    def test_iadd(self):
        self.t1 += self.t2
        self.assertEqual(self.t1.seconds, 10)

    def test_isub(self):
        self.t1 -= self.t2
        self.assertEqual(self.t1.seconds, 0)

    def test_imul(self):
        self.t1 *= self.t2
        self.assertEqual(self.t1.seconds, 25)

    def test_idiv(self):
        self.t1 /= self.t2
        self.assertEqual(self.t1.seconds, 1)


if __name__ == '__main__':
    unittest.main()
