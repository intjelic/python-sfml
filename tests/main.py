#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import random
import unittest

import sf


class TestColor(unittest.TestCase):
    def random_color(self):
        return sf.Color(random.randint(0, 255),
                        random.randint(0, 255),
                        random.randint(0, 255),
                        random.randint(0, 255))

    def test_eq(self):
        equal = [(sf.Color(i, i, i, i), sf.Color(i, i, i, i))
                 for i in range(256)]

        for c1, c2 in equal:
            self.assertEqual(c1, c2)

    def test_neq(self):
        non_equal = [(sf.Color(0, 0, 0, 1), sf.Color(0, 1, 0, 0)),
                     (sf.Color(255, 255, 255, 255),
                      sf.Color(254, 255, 255, 255))]

        for c1, c2 in non_equal:
            self.assertNotEqual(c1, c2)


if __name__ == '__main__':
    unittest.main()
