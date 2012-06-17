#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
import sfml as sf

class TestVector2(unittest.TestCase):

    def setUp(self):
        self.v = sf.Vector2(16.5, 24)

    def test_x(self):
        self.assertEqual(self.v.x, 16.5)

    def test_y(self):
        self.assertEqual(self.v.y, 24)


class TestOverloadedOperators(unittest.TestCase):

    def setUp(self):
        self.v1 = sf.Vector2(2, 5)
        self.v2 = sf.Vector2(5, 2)

    def test_add(self):
        x, y = self.v1 + self.v2
        self.assertEqual((x, y), (7, 7))

    def test_sub(self):
        x, y = self.v1 - self.v2
        self.assertEqual((x, y), (-3, 3))

    def test_mul(self):
        x, y = self.v1 * self.v2
        self.assertEqual((x, y), (10, 10))

    def test_div(self):
        x, y = self.v1 / self.v2
        self.assertEqual((x, y), (0.4, 2.5))

    def test_iadd(self):
        self.v1 += self.v2
        x, y = self.v1
        self.assertEqual((x, y), (7, 7))

    def test_isub(self):
        self.v1 -= self.v2
        x, y = self.v1
        self.assertEqual((x, y), (-3, 3))

    def test_imul(self):
        self.v1 *= self.v2
        x, y = self.v1
        self.assertEqual((x, y), (10, 10))

    def test_idiv(self):
        self.v1 /= self.v2
        x, y = self.v1
        self.assertEqual((x, y), (0.4, 2.5))


if __name__ == '__main__':
    unittest.main()
