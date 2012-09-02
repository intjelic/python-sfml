# -*- coding: utf-8 -*-

import sfml.network as sf

def test_connection():
    ftp = sf.Ftp()
    response = ftp.connect(sf.IpAddress.from_string('ftp.secureftp-test.com'))

    assert response.ok
    return ftp


def pytest_funcarg__ftp(request):
    return request.cached_setup(setup=test_connection, scope='function')

def test_login(ftp):
    response = ftp.login('test', 'test')

    assert response.ok

def test_working_directory(ftp):
    test_login(ftp)
    response = ftp.get_working_directory()
    assert response.ok
    assert response.get_directory() == '/'
