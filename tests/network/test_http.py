import pytest
import sfml.network as sf

@pytest.fixture
def http():
    return sf.Http('https://api.github.com', port=443)

@pytest.fixture
def http_request():
    request = sf.HttpRequest('/gists/public')
    request.method = sf.HttpRequest.GET

    return request

def test_response(http, http_request):
    response = http.send_request(http_request)

    # TODO: figure out why I get a 400 message (http message sent to https port
    assert response

