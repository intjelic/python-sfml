#include <iostream>
#include <SFML/Audio.hpp>

class DerivableSoundRecorder : public sf::SoundRecorder
{
public :
	DerivableSoundRecorder();

protected:
	virtual bool onStart();
	virtual bool onProcessSamples(const sf::Int16* samples, std::size_t sampleCount);
	virtual void onStop();
};

DerivableSoundRecorder::DerivableSoundRecorder():
sf::SoundRecorder ()
{
};

bool DerivableSoundRecorder::onStart()
{
	std::cout << "onStart()" << std::endl;
	return true;
}

bool DerivableSoundRecorder::onProcessSamples(const sf::Int16* samples, std::size_t sampleCount)
{
	std::cout << "onProcessSamples()" << std::endl;
	return true;
}

void DerivableSoundRecorder::onStop()
{
	std::cout << "onStop()" << std::endl;
}

