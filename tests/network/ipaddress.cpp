#include <iostream>
#include <SFML/Network.hpp>

int main()
{
	sf::IpAddress ip = sf::IpAddress::getPublicAddress();
	std::cout << ip.toString() << std::endl;
	
	return EXIT_SUCCESS;
}
