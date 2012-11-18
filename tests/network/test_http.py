import unittest
import sfml.network as sf

def pytest_funcarg_http(request):
    return request.cached_setup(
        setup=lambda: sf.Http('https://api.github.com'),
        scope='function')

def test_request():
    request = sf.HttpRequest('/gists/public')
    request.method = sf.HttpRequest.GET

    # don't do this!
    return request

def test_response(http):
    response = http.send_request(test_request)

    print(response.body)
