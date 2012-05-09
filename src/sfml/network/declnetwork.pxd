#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cdef extern from "stdlib.h":
    void free(void* ptr)
    void* malloc(size_t size)
    void* realloc(void* ptr, size_t size)


cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()
        

from declsystem cimport Int16,  Uint8, Uint32


cdef extern from "SFML/Network.hpp" namespace "sf::IpAddress":
    cdef IpAddress GetLocalAddress()
    cdef IpAddress GetPublicAddress(Uint32 timeout)

    #IpAddress 	None
    #IpAddress 	LocalHost


cimport socket
cimport udpsocket


cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass IpAddress:
        IpAddress()
        IpAddress(char *address)
        IpAddress(Uint8 byte0, Uint8 byte1, Uint8 byte2, Uint8 byte3)
        IpAddress(Uint32 address)
        string ToString()
        Uint32 ToInteger()

    cdef cppclass Socket:
        void SetBlocking(bint)
        bint IsBlocking() 
        
    cdef cppclass TcpSocket:
        TcpSocket()
        unsigned short GetLocalPort()
        IpAddress GetRemoteAddress()
        unsigned short GetRemotePort()
        int Connect(IpAddress &remoteAddress, unsigned short remotePort, Uint32 timeout)
        void Disconnect()
        int Send(char *data, int size)
        int Receive(char *data, size_t size, size_t &received)

    cdef cppclass UdpSocket:
        UdpSocket()
        unsigned short GetLocalPort()        
        int Bind(unsigned short port)
        void Unbind()
        int Send(char *data, size_t size, IpAddress &remoteAddress, unsigned short remotePort)
        int Receive(char *data, size_t size, size_t &received, IpAddress &remoteAddress, unsigned short &remotePort)

    cdef cppclass TcpListener:
        TcpListener()
        unsigned short GetLocalPort()
        int Listen(unsigned short port)
        void Close()
        int Accept(TcpSocket &socket)

    cdef cppclass SocketSelector:
        SocketSelector()
        # SocketSelector(const SocketSelector &copy)
        # ~SocketSelector()
        void Add(Socket &socket)
        void Remove(Socket &socket)
        void Clear()
        bint Wait(Uint32 timeout)
        bint IsReady(Socket &socket)


cimport ftp

cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass Ftp:
        Ftp()
        ftp.Response Connect(IpAddress &server, unsigned short port, Uint32 timeout)
        ftp.Response Disconnect()
        ftp.Response Login()
        ftp.Response Login(char* &name, char* &password)
        ftp.Response KeepAlive()
        ftp.DirectoryResponse GetWorkingDirectory()
        ftp.ListingResponse	GetDirectoryListing(char* &directory)
        ftp.Response ChangeDirectory(char* &directory)
        ftp.Response ParentDirectory()
        ftp.Response CreateDirectory(char* &name)
        ftp.Response DeleteDirectory(char* &name)
        ftp.Response RenameFile(char* &file, char* &newName)
        ftp.Response DeleteFile(char* &name)
        ftp.Response Download(char* &remoteFile, char* &localPath, ftp.TransferMode)
        ftp.Response Upload(char* &localFile, char* &remotePath, ftp.TransferMode)

cimport http

cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass Http:
        #Http()
        Http(char* &host, unsigned short port)
        #void SetHost(string &host, unsigned short port=0)
        http.Response SendRequest(http.Request &request, Uint32 timeout)

