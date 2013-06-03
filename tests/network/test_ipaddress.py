#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pytest
import unittest
import socket
import urllib2
import sfml.network as sf

@pytest.fixture
def ip():
    return sf.IpAddress.from_string('127.0.0.1')

def test_invalid_address(ip):
    invalid_ip = sf.IpAddress()

    assert str(invalid_ip) != str(ip)

def test_from_hostname(ip):
    hostname = sf.IpAddress.from_string('localhost')
    
    assert str(hostname) == str(ip)

def test_from_bytes(ip):
    bytes = sf.IpAddress.from_bytes(127, 0, 0, 1)
    assert str(bytes) == str(ip)

def test_local_address():
    local = sf.IpAddress.get_local_address()

    # standard library socket
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(('8.8.8.8', 80))
    stdlib = s.getsockname()[0]

    assert str(local) == str(stdlib)

def test_public_address():
    public = sf.IpAddress.get_public_address()
    stdlib = urllib2.urlopen('http://ip.42.pl/raw').read()

    assert str(public) == str(stdlib)
