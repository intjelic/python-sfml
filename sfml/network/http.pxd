cimport http_request
cimport http_response

cdef extern from "SFML/Network.hpp" namespace "sf::Http":
    cdef cppclass Request:
        Request(char* &uri, http_request.Method method, char* &body)
        void SetField(char* &field, char* &value)
        void SetMethod(http_request.Method method)
        void SetUri(char* &uri)
        void SetHttpVersion(unsigned int major, unsigned int minor)
        void SetBody(char* &body)
        
    cdef cppclass Response:
        Response()
        char* & GetField(char* &field)
        http_response.Status GetStatus()
        unsigned int GetMajorHttpVersion()
        unsigned int GetMinorHttpVersion()
        char* & GetBody()
