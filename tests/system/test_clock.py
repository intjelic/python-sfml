#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
import sfml.system as sf

class TestClock(unittest.TestCase):
    def setUp(self):
        self.c = sf.Clock()

    def test_elapsed(self):
        sf.sleep(sf.seconds(1))
        elapsed = self.c.elapsed_time
        self.assertGreaterEqual(elapsed, sf.seconds(1))

    def test_restart(self):
        self.c.restart()
        elapsed = self.c.elapsed_time
        self.assertLessEqual(elapsed, sf.milliseconds(100))


if __name__ == '__main__':
    unittest.main()
