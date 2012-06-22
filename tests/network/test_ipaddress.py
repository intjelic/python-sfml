#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
import socket
import urllib2
import sfml.network as sf

class TestIpAddress(unittest.TestCase):

    def setUp(self):
        self.local_ip = sf.IpAddress.from_string('127.0.0.1')
        self.remote_ip = sf.IpAddress.from_string('74.125.224.208')

    def test_invalid_address(self):
        ip = sf.IpAddress()

        self.assertNotEqual(str(ip), str(self.local_ip))

    def test_from_hostname(self):
        ip = sf.IpAddress.from_string('localhost')

        self.assertEqual(str(ip), str(self.local_ip))

    def test_from_bytes(self):
        ip = sf.IpAddress.from_bytes(127, 0, 0, 1)

        self.assertEqual(str(ip), str(self.local_ip))

    def test_from_url(self):
        ip = sf.IpAddress.from_string('www.google.com')
        ip_bytes = str(self.remote_ip).split('.')
        remote_bytes = str(self.remote_ip).split('.')
        self.assertEqual(ip_bytes[:2], remote_bytes[:2])

    def test_local_address(self):
        ip = sf.IpAddress.get_local_address()

        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        stdlib_ip = s.getsockname()[0]

        self.assertEqual(str(ip), str(stdlib_ip))

    def test_remote_address(self):
        ip = sf.IpAddress.get_public_address()
        stdlib_ip = urllib2.urlopen('http://ip.42.pl/raw').read()

        self.assertEqual(str(ip), stdlib_ip)


if __name__ == '__main__':
    unittest.main()
