#pragma once

#include <SFML/Network.hpp>

#include <optional>
#include <string>

namespace pysfml::network_compat
{
inline bool resolveIpAddress(const std::string& address, sf::IpAddress& result)
{
    if (const auto resolved = sf::IpAddress::resolve(address))
    {
        result = *resolved;
        return true;
    }

    return false;
}

inline bool getLocalAddress(sf::IpAddress& result)
{
    if (const auto address = sf::IpAddress::getLocalAddress())
    {
        result = *address;
        return true;
    }

    return false;
}

inline bool getPublicAddress(sf::IpAddress& result)
{
    if (const auto address = sf::IpAddress::getPublicAddress())
    {
        result = *address;
        return true;
    }

    return false;
}

inline bool getPublicAddressWithTimeout(const sf::Time& timeout, sf::IpAddress& result)
{
    if (const auto address = sf::IpAddress::getPublicAddress(timeout))
    {
        result = *address;
        return true;
    }

    return false;
}

inline bool getRemoteAddress(const sf::TcpSocket& socket, sf::IpAddress& result)
{
    if (const auto address = socket.getRemoteAddress())
    {
        result = *address;
        return true;
    }

    return false;
}

inline sf::Socket::Status receiveUdp(sf::UdpSocket&    socket,
                                     void*             data,
                                     std::size_t       size,
                                     std::size_t&      received,
                                     sf::IpAddress&    remoteAddress,
                                     unsigned short&   remotePort)
{
    std::optional<sf::IpAddress> address;
    const auto status = socket.receive(data, size, received, address, remotePort);

    if (address)
    {
        remoteAddress = *address;
    }

    return status;
}
}