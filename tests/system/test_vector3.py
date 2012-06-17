#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
import sfml as sf

class TestVector3(unittest.TestCase):

    def setUp(self):
        self.v = sf.Vector3(16.5, 24, -2)

    def test_x(self):
        self.assertEqual(self.v.x, 16.5)

    def test_y(self):
        self.assertEqual(self.v.y, 24)

    def test_z(self):
        self.assertEqual(self.v.z, -2)


class TestOverloadedOperators(unittest.TestCase):

    def setUp(self):
        self.v1 = sf.Vector3(2, 5, 1)
        self.v2 = sf.Vector3(5, 2, 6)

    def test_add(self):
        x, y, z = self.v1 + self.v2
        self.assertEqual((x, y, z), (7, 7, 7))

    def test_sub(self):
        x, y, z = self.v1 - self.v2
        self.assertEqual((x, y, z), (-3, 3, -5))

    def test_mul(self):
        x, y, z = self.v1 * self.v2
        self.assertEqual((x, y, z), (10, 10, 6))

    def test_div(self):
        x, y, z = self.v1 / self.v2
        self.assertEqual((x, y, z), (0.4, 2.5, 0.16))

    def test_iadd(self):
        self.v1 += self.v2
        x, y, z = self.v1
        self.assertEqual((x, y, z), (7, 7, 7))

    def test_isub(self):
        self.v1 -= self.v2
        x, y, z = self.v1
        self.assertEqual((x, y, z), (-3, 3, -5))

    def test_imul(self):
        self.v1 *= self.v2
        x, y, z = self.v1
        self.assertEqual((x, y, z), (10, 10, 6))

    def test_idiv(self):
        self.v1 /= self.v2
        x, y, z = self.v1
        self.assertEqual((x, y, z), (0.4, 2.5, 0.16))


if __name__ == '__main__':
    unittest.main()
