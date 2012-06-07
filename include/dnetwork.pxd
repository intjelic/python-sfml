#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from libcpp.string cimport string
        
from dsystem cimport Int8, Int16, Int32, Int64
from dsystem cimport Uint8, Uint16, Uint32, Uint64

from dsystem cimport Time

cimport ipaddress, socket, udpsocket, ftp, http

	
cdef extern from "SFML/Network.hpp" namespace "sf":
	cdef cppclass IpAddress:
		IpAddress()
		IpAddress(string&)
		IpAddress(Uint8, Uint8, Uint8, Uint8)
		IpAddress(Uint32)
		string toString()
		Uint32 toInteger()

	cdef cppclass Socket:
		void setBlocking(bint)
		bint isBlocking() 

	cdef cppclass TcpListener:
		TcpListener()
		unsigned short getLocalPort()
		socket.Status listen(unsigned short)
		void close()
		socket.Status accept(TcpSocket&)

	cdef cppclass TcpSocket:
		TcpSocket()
		unsigned short getLocalPort()
		IpAddress getRemoteAddress()
		unsigned short getRemotePort()
		socket.Status connect(IpAddress&, unsigned short)
		socket.Status connect(IpAddress&, unsigned short, Time)
		void disconnect()
		socket.Status send(void*, size_t)
		socket.Status receive(void*, size_t, size_t&)

	cdef cppclass UdpSocket:
		UdpSocket()
		unsigned short getLocalPort()        
		socket.Status bind(unsigned short)
		void unbind()
		socket.Status send(void*, size_t, IpAddress&, unsigned short)
		socket.Status receive(void*, size_t, size_t&, IpAddress&, unsigned short&)

	cdef cppclass SocketSelector:
		SocketSelector()
		void add(Socket&)
		void remove(Socket&)
		void clear()
		bint wait()
		bint wait(Time)
		bint isReady(Socket&)

	cdef cppclass Ftp:
		Ftp()
		ftp.Response connect(IpAddress&)
		ftp.Response connect(IpAddress&, unsigned short)
		ftp.Response connect(IpAddress&, unsigned short, Time)
		ftp.Response disconnect()
		ftp.Response login()
		ftp.Response login(char*&, char*&)
		ftp.Response keepAlive()
		ftp.DirectoryResponse getWorkingDirectory()
		ftp.ListingResponse	getDirectoryListing()
		ftp.ListingResponse	getDirectoryListing(char*&)
		ftp.Response changeDirectory(char*&)
		ftp.Response parentDirectory()
		ftp.Response createDirectory(char*&)
		ftp.Response deleteDirectory(char*&)
		ftp.Response renameFile(char*&, char*&)
		ftp.Response deleteFile(char*&)
		ftp.Response download(char*&, char*&)
		ftp.Response download(char*&, char*&, ftp.TransferMode)
		ftp.Response upload(char*&, char*&)
		ftp.Response upload(char*&, char*&, ftp.TransferMode)

	cdef cppclass Http:
		Http()
		Http(string&)
		Http(string&, unsigned short)
		void setHost(string&)
		void setHost(string&, unsigned short)
		http.Response sendRequest(http.Request&)
		http.Response sendRequest(http.Request&, Time)
