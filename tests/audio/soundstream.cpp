#include <iostream>
#include <SFML/Audio.hpp>

class DerivableSoundStream : public sf::SoundStream
{
public :
	DerivableSoundStream();

	//void initialize(unsigned int channelCount, unsigned int sampleRate);
	
protected:
	virtual bool onGetData(sf::SoundStream::Chunk &data);
	virtual void onSeek(sf::Time timeOffset);
};

DerivableSoundStream::DerivableSoundStream():
sf::SoundStream  ()
{
	sf::SoundStream::initialize(1, 44100);
};

bool DerivableSoundStream::onGetData(sf::SoundStream::Chunk &data)
{
	std::cout << "onGetData()" << std::endl;
	return true;
}

void DerivableSoundStream::onSeek(sf::Time timeOffset)
{
	std::cout << "onSeek()" << std::endl;
}

int main()
{
	DerivableSoundStream stream;
	stream.play();
	
	return EXIT_SUCCESS;
}
