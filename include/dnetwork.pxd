#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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
		bint operator==(IpAddress&)
		bint operator!=(IpAddress&)
		bint operator<(IpAddress&)
		bint operator>(IpAddress&)
		bint operator<=(IpAddress&)
		bint operator>=(IpAddress&)
		
	cdef cppclass Socket:
		void setBlocking(bint)
		bint isBlocking() 

	cdef cppclass TcpListener:
		TcpListener()
		unsigned short getLocalPort()
		socket.Status listen(unsigned short)
		void close()
		socket.Status accept(TcpSocket&) nogil

	cdef cppclass TcpSocket:
		TcpSocket()
		unsigned short getLocalPort()
		IpAddress getRemoteAddress()
		unsigned short getRemotePort()
		socket.Status connect(IpAddress&, unsigned short) nogil
		socket.Status connect(IpAddress&, unsigned short, Time) nogil
		void disconnect()
		socket.Status send(void*, size_t) nogil
		socket.Status receive(void*, size_t, size_t&) nogil

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
		bint wait() nogil
		bint wait(Time) nogil
		bint isReady(Socket&)

	cdef cppclass Ftp:
		Ftp()
		ftp.Response connect(IpAddress&) nogil
		ftp.Response connect(IpAddress&, unsigned short) nogil
		ftp.Response connect(IpAddress&, unsigned short, Time) nogil
		ftp.Response disconnect()
		ftp.Response login() nogil
		ftp.Response login(char*&, char*&) nogil
		ftp.Response keepAlive() nogil
		ftp.DirectoryResponse getWorkingDirectory() nogil
		ftp.ListingResponse	getDirectoryListing() nogil
		ftp.ListingResponse	getDirectoryListing(char*&) nogil
		ftp.Response changeDirectory(char*&) nogil
		ftp.Response parentDirectory() nogil
		ftp.Response createDirectory(char*&) nogil
		ftp.Response deleteDirectory(char*&) nogil
		ftp.Response renameFile(char*&, char*&) nogil
		ftp.Response deleteFile(char*&) nogil
		ftp.Response download(char*&, char*&) nogil
		ftp.Response download(char*&, char*&, ftp.TransferMode) nogil
		ftp.Response upload(char*&, char*&) nogil
		ftp.Response upload(char*&, char*&, ftp.TransferMode) nogil

	cdef cppclass Http:
		Http()
		Http(string&)
		Http(string&, unsigned short)
		void setHost(string&)
		void setHost(string&, unsigned short)
		http.Response sendRequest(http.Request&) nogil
		http.Response sendRequest(http.Request&, Time) nogil
