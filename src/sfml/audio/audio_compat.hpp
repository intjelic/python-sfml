#pragma once

#include <SFML/Audio.hpp>

#include <cstdint>
#include <string>
#include <vector>

namespace pysfml::audio_compat
{
struct ConeData
{
    sf::Angle innerAngle;
    sf::Angle outerAngle;
    float     outerGain{};
};

inline std::vector<sf::SoundChannel> defaultChannelMap(const unsigned int channelCount)
{
    if (channelCount == 1)
    {
        return {sf::SoundChannel::Mono};
    }

    if (channelCount == 2)
    {
        return {sf::SoundChannel::FrontLeft, sf::SoundChannel::FrontRight};
    }

    return std::vector<sf::SoundChannel>(channelCount, sf::SoundChannel::Unspecified);
}

inline bool loadSoundBufferFromSamples(sf::SoundBuffer&       buffer,
                                       const std::int16_t*    samples,
                                       const std::size_t      sampleCount,
                                       const unsigned int     channelCount,
                                       const unsigned int     sampleRate,
                                       const std::vector<sf::SoundChannel>& channelMap)
{
    return buffer.loadFromSamples(samples, sampleCount, channelCount, sampleRate, channelMap);
}

inline std::vector<std::string> getAvailablePlaybackDevices()
{
    return sf::PlaybackDevice::getAvailableDevices();
}

inline std::string getDefaultPlaybackDevice()
{
    const auto device = sf::PlaybackDevice::getDefaultDevice();
    return device ? *device : std::string{};
}

inline bool setPlaybackDevice(const std::string& name)
{
    return sf::PlaybackDevice::setDevice(name);
}

inline std::string getPlaybackDevice()
{
    const auto device = sf::PlaybackDevice::getDevice();
    return device ? *device : std::string{};
}

inline ConeData getListenerCone()
{
    const auto cone = sf::Listener::getCone();
    return {cone.innerAngle, cone.outerAngle, cone.outerGain};
}

inline void setListenerCone(const ConeData& cone)
{
    sf::Listener::setCone(sf::Listener::Cone{cone.innerAngle, cone.outerAngle, cone.outerGain});
}

inline ConeData getSoundSourceCone(const sf::SoundSource& soundSource)
{
    const auto cone = soundSource.getCone();
    return {cone.innerAngle, cone.outerAngle, cone.outerGain};
}

inline void setSoundSourceCone(sf::SoundSource& soundSource, const ConeData& cone)
{
    soundSource.setCone(sf::SoundSource::Cone{cone.innerAngle, cone.outerAngle, cone.outerGain});
}

inline sf::Time getMusicLoopOffset(const sf::Music& music)
{
    return music.getLoopPoints().offset;
}

inline sf::Time getMusicLoopLength(const sf::Music& music)
{
    return music.getLoopPoints().length;
}

inline void setMusicLoopPoints(sf::Music& music, sf::Time offset, sf::Time length)
{
    music.setLoopPoints({offset, length});
}

inline void setListenerPosition(const sf::Vector3f& position)
{
    sf::Listener::setPosition(position);
}

inline void setListenerDirection(const sf::Vector3f& direction)
{
    sf::Listener::setDirection(direction);
}

inline void setListenerVelocity(const sf::Vector3f& velocity)
{
    sf::Listener::setVelocity(velocity);
}

inline void setListenerUpVector(const sf::Vector3f& upVector)
{
    sf::Listener::setUpVector(upVector);
}
}