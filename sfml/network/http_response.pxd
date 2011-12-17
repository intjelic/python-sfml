cdef extern from "SFML/Graphics.hpp" namespace "sf::Http::Response":
    cdef cppclass Status:
        pass
        
cdef extern from "SFML/Network.hpp" namespace "sf::Http::Response":
    int Ok
    int Created
    int Accepted
    int NoContent
    int ResetContent
    int PartialContent
    int MultipleChoices
    int MovedPermanently
    int MovedTemporarily
    int NotModified
    int BadRequest
    int Unauthorized
    int Forbidden
    int NotFound
    int RangeNotSatisfiable
    int InternalServerError
    int NotImplemented
    int BadGateway
    int ServiceNotAvailable
    int GatewayTimeout
    int VersionNotSupported
    int InvalidResponse
    int ConnectionFailed
