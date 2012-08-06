# -*- coding: utf-8 -*-

try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen
import socket
import sfml.network as sf

def pytest_funcarg__ip(request):
    ip = {'local': sf.IpAddress.from_string('127.0.0.1'),
        'remote': sf.IpAddress.from_string('74.125.224.208')}

    return ip

def test_invalid_address():
    ip = sf.IpAddress()
    assert str(ip) == '0.0.0.0'

def test_from_hostname(ip):
    host = sf.IpAddress.from_string('localhost')
    assert str(host) == str(ip['local'])


def test_from_bytes(ip):
    byte = sf.IpAddress.from_bytes(127, 0, 0, 1)
    assert str(byte) == str(ip['local'])

def test_from_url(ip):
    url = sf.IpAddress.from_string('www.google.com')
    assert str(url).split('.')[:-2] == str(ip['remote']).split('.')[:-2]


def test_local_address():
    sfip = sf.IpAddress.get_local_address()
    pyip = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    pyip.connect(('8.8.8.8', 80))
    pyip = pyip.getsockname()[0]

    assert str(sfip) == str(pyip)

def test_remote_address():
    sfip = sf.IpAddress.get_public_address()
    pyip = urlopen('http://ip.42.pl/raw').read()

    assert str(sfip) == str(pyip)

if __name__ == '__main__':
    unittest.main()
