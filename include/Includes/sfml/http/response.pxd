# PySFML - Python bindings for SFML
# Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML and is available under the zlib license.

cdef extern from "SFML/Network.hpp" namespace "sf::Http::Response":
    cdef enum Status "sf::Http::Response::Status":
        Ok "sf::Http::Response::Status::Ok"
        Created "sf::Http::Response::Status::Created"
        Accepted "sf::Http::Response::Status::Accepted"
        NoContent "sf::Http::Response::Status::NoContent"
        ResetContent "sf::Http::Response::Status::ResetContent"
        PartialContent "sf::Http::Response::Status::PartialContent"
        MultipleChoices "sf::Http::Response::Status::MultipleChoices"
        MovedPermanently "sf::Http::Response::Status::MovedPermanently"
        MovedTemporarily "sf::Http::Response::Status::MovedTemporarily"
        NotModified "sf::Http::Response::Status::NotModified"
        BadRequest "sf::Http::Response::Status::BadRequest"
        Unauthorized "sf::Http::Response::Status::Unauthorized"
        Forbidden "sf::Http::Response::Status::Forbidden"
        NotFound "sf::Http::Response::Status::NotFound"
        RangeNotSatisfiable "sf::Http::Response::Status::RangeNotSatisfiable"
        InternalServerError "sf::Http::Response::Status::InternalServerError"
        NotImplemented "sf::Http::Response::Status::NotImplemented"
        BadGateway "sf::Http::Response::Status::BadGateway"
        ServiceNotAvailable "sf::Http::Response::Status::ServiceNotAvailable"
        GatewayTimeout "sf::Http::Response::Status::GatewayTimeout"
        VersionNotSupported "sf::Http::Response::Status::VersionNotSupported"
        InvalidResponse "sf::Http::Response::Status::InvalidResponse"
        ConnectionFailed "sf::Http::Response::Status::ConnectionFailed"
