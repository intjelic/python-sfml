# -*- coding: utf-8 -*-

import sfml.network as sf

#TODO: Find a simple way to create an example ftp server to use for upload testing

def test_connection():
    ftp = sf.Ftp()
    response = ftp.connect(sf.IpAddress.from_string('ftp.secureftp-test.com'))

    assert response.ok
    return ftp

def test_disconnection(ftp):
    response = ftp.disconnect()
    assert response.status in (sf.FtpResponse.CLOSING_CONNECTION,
        sf.FtpResponse.CONNECTION_CLOSED)

def pytest_funcarg__ftp(request):
    return request.cached_setup(setup=test_connection,
        teardown=test_disconnection, scope='function')

def test_login(ftp):
    response = ftp.login('test', 'test')

    assert response.ok

def test_working_directory(ftp):
    test_login(ftp)
    response = ftp.get_working_directory()
    assert response.ok
    assert response.get_directory() == '/'
