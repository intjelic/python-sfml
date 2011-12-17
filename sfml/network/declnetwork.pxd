cdef extern from "stdlib.h":
    void free(void* ptr)
    void* malloc(size_t size)
    void* realloc(void* ptr, size_t size)


cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()
        
        
cdef extern from "SFML/System.hpp" namespace "sf":
    ctypedef short Int16
    ctypedef unsigned char Uint8
    ctypedef unsigned int Uint32


cdef extern from "SFML/Network.hpp" namespace "sf::IpAddress":
    cdef IpAddress GetLocalAddress()
    cdef IpAddress GetPublicAddress(Uint32 timeout)

    #IpAddress 	None
    #IpAddress 	LocalHost
    
    
cdef extern from "SFML/Network.hpp" namespace "sf::Socket":
    int Done
    int NotReady
    int Disconnected
    int Error
    
    
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
        #~Ftp()
        #ftp.Response Connect(IpAddress &server, unsigned short port=21, Uint32 timeout=0)
        ftp.Response Disconnect()
        ftp.Response Login()
        ftp.Response Login(char* &name, char* &password)
        ftp.Response KeepAlive()
        ftp.DirectoryResponse GetWorkingDirectory()
        #ftp.ListingResponse	GetDirectoryListing(const std::string &directory="")
        ftp.Response ChangeDirectory(char* &directory)
        ftp.Response ParentDirectory()
        ftp.Response CreateDirectory(char* &name)
        ftp.Response DeleteDirectory(char* &name)
        ftp.Response RenameFile(char* &file, char* &newName)
        ftp.Response DeleteFile(char* &name)
        #ftp.Response Download(char* &remoteFile, char* &localPath, ftp.TransferMode mode=Binary)
        #ftp.Response Upload(const std::string &localFile, const std::string &remotePath, TransferMode mode=Binary)

cimport http

cdef extern from "SFML/Network.hpp" namespace "sf":
    cdef cppclass Http:
        #Http()
        Http(char* &host, unsigned short port)
        #void SetHost(string &host, unsigned short port=0)
        http.Response SendRequest(http.Request &request, Uint32 timeout)

