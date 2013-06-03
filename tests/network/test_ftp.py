# -*- coding: utf-8 -*-
import pytest
import sfml.network as sf

@pytest.fixture(scope='module')
def ftp():
    return sf.Ftp()

def test_connection(ftp):
    response = ftp.connect(sf.IpAddress.from_string('ftp.secureftp-test.com'))

    assert response.ok

def test_login(ftp):
    response = ftp.login('test', 'test')

    assert response.ok

def test_working_directory(ftp):
    response = ftp.get_working_directory()

    assert response.ok
    assert response.get_directory() == '/'
