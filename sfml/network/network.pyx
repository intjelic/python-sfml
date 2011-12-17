# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cimport declnetwork


cdef class IpAddress:
    cdef declnetwork.IpAddress *thisptr
    
    #cdef public IpAddress NONE = declnetwork.None
    #LOCAL_HOST = declnetwork.LocalHost

    def __cinit__(self, *args, **kwargs):
        self.thisptr = new declnetwork.IpAddress()

    def __dealloc__(self):
        del self.thisptr

    def __str__(self):
        return "IpAddress({0})".format(self.thisptr.ToString().c_str())
        
    @classmethod
    def from_integer(self, declnetwork.Uint32 value):
        cdef declnetwork.IpAddress *p = new declnetwork.IpAddress(value)
        return wrap_ipaddress_instance(p)
        
    @classmethod
    def from_string(self, bytes value):
        cdef declnetwork.IpAddress *p = new declnetwork.IpAddress(<char*>value)
        return wrap_ipaddress_instance(p)
        
    @classmethod
    def from_bytes(self, declnetwork.Uint8 b1, declnetwork.Uint8 b2, declnetwork.Uint8 b3, declnetwork.Uint8 b4):
        cdef declnetwork.IpAddress *p = new declnetwork.IpAddress(b1, b2, b3, b4)
        return wrap_ipaddress_instance(p)
        
    @classmethod
    def from_tuple(self, tuple value):
        b1, b2, b3, b4 = value
        
        cdef declnetwork.IpAddress *p = new declnetwork.IpAddress(b1, b2, b3, b4)
        return wrap_ipaddress_instance(p)
       
    @classmethod
    def local_address(self):
        return IpAddress.from_integer(declnetwork.GetLocalAddress().ToInteger())

    @classmethod
    def public_address(self, declnetwork.Uint32 timeout=0):
        return IpAddress.from_integer(declnetwork.GetPublicAddress(timeout).ToInteger())

cdef wrap_ipaddress_instance(declnetwork.IpAddress* instance):
    cdef IpAddress ret = IpAddress.__new__(IpAddress)
    ret.thisptr = instance
    return ret
    
cdef class Socket:
    DONE = declnetwork.Done
    NOT_READY = declnetwork.NotReady
    DISCONNECTED = declnetwork.Disconnected
    ERROR = declnetwork.Error
    
    cdef declnetwork.Socket *thisptr
    
    def __cinit__(self, *args, **kwargs):
        if self.__class__ == Socket:
            raise NotImplementedError('Socket is abstact')
            
    property blocking:
        def __get__(self):
            return self.thisptr.IsBlocking()
            
        def __set__(self, value):
            if value: self.thisptr.SetBlocking(True)
            else: self.thisptr.SetBlocking(False)  

cdef class TcpSocket(Socket):
    def __cinit__(self, *args, **kwargs):
        self.thisptr = <declnetwork.Socket*>new declnetwork.TcpSocket()
        
    def __str__(self):
        return "TcpSocket()"
        
    def connect(self, IpAddress ip, unsigned short port, declnetwork.Uint32 timeout=0):
        return (<declnetwork.TcpSocket*>self.thisptr).Connect(ip.thisptr[0], port, timeout)

    def disconnect(self):
        (<declnetwork.TcpSocket*>self.thisptr).Disconnect()

    def send(self, bytes data):
        return (<declnetwork.TcpSocket*>self.thisptr).Send(<char*>data, len(data))
        
    def recieve(self, size_t length):
        cdef char* c_data = <char*>declnetwork.malloc(length * sizeof(char))
        cdef size_t recieved = 0
        
        cdef int status = (<declnetwork.TcpSocket*>self.thisptr).Receive(c_data, length, recieved)
        cdef bytes data = c_data
        return (status, data)
        
    property local_port:
        def __get__(self):
            return (<declnetwork.TcpSocket*>self.thisptr).GetLocalPort()
            
    property remote_address:
        def __get__(self):
            return IpAddress((<declnetwork.TcpSocket*>self.thisptr).GetRemoteAddress().ToInteger())
            
    property remote_port:
        def __get__(self):
            return (<declnetwork.TcpSocket*>self.thisptr).GetRemotePort()

cdef wrap_tcpsocket_instance(declnetwork.TcpSocket* instance):
    cdef TcpSocket ret = TcpSocket.__new__(TcpSocket)
    ret.thisptr = <declnetwork.Socket*>instance
    return ret
    
cdef class UdpSocket(Socket):
    def __cinit__(self, *args, **kwargs):
        self.thisptr = <declnetwork.Socket*>new declnetwork.UdpSocket()
        
    def bind(self, unsigned short port):
        (<declnetwork.UdpSocket*>self.thisptr).Bind(port)
        
    def unbind(self):
        (<declnetwork.UdpSocket*>self.thisptr).Unbind()
        
    def send(self, bytes data, IpAddress ip, unsigned short port):
        return (<declnetwork.UdpSocket*>self.thisptr).Send(<char*>data, len(data), ip.thisptr[0], port)
        
    def receive(self, size_t length):
        cdef char* data = <char*>declnetwork.malloc(length * sizeof(char))
        cdef size_t received = 0
        ip = IpAddress()
        cdef unsigned short port = 0
        cdef int status = (<declnetwork.UdpSocket*>self.thisptr).Receive(data, length, received, ip.thisptr[0], port)
        
        return (status, data, ip, port)
        
    property local_port:
        def __get__(self):
            return (<declnetwork.UdpSocket*>self.thisptr).GetLocalPort()
        
cdef class TcpListener(Socket):
    def __cinit__(self, *args, **kwargs):
        self.thisptr = <declnetwork.Socket*>new declnetwork.TcpListener()
        
    def __str__(self):
        pass
        
    def listen(self, unsigned short port):
        return (<declnetwork.TcpListener*>self.thisptr).Listen(port)
        
    def close(self):
        (<declnetwork.TcpListener*>self.thisptr).Close()
        
    def accept(self):
        socket = TcpSocket()
        cdef int status = (<declnetwork.TcpListener*>self.thisptr).Accept((<declnetwork.TcpSocket*>socket.thisptr)[0])
        
        return (status, socket)
        
    property local_port:
        def __get__(self):
            return (<declnetwork.TcpListener*>self.thisptr).GetLocalPort()


cdef class SocketSelector:
    cdef declnetwork.SocketSelector *thisptr
    
    def __cinit__(self, *args, **kwargs):
        self.thisptr = new declnetwork.SocketSelector()
    
    def add(self, Socket socket):
        self.thisptr.Add(socket.thisptr[0])
        
    def remove(self, Socket socket):
        self.thisptr.Remove(socket.thisptr[0])
        
    def clear(self):
        self.thisptr.Clear()
        
    def wait(self, declnetwork.Uint32 timeout=0):
        return self.thisptr.Wait(timeout)
        
    def is_ready(self, Socket socket):
        return self.thisptr.IsReady(socket.thisptr[0])


cdef class FtpResponse:
    cdef declnetwork.ftp.Response *thisptr
    
    def __cinit__(self, int code=declnetwork.ftp.ftp_response.InvalidResponse, bytes message=b""):
        self.thisptr = new declnetwork.ftp.Response(<declnetwork.ftp.Status>code, <char*>message)
        
    property ok:
        def __get__(self):
            return self.thisptr.IsOk()
            
    #property status:
        #def __get__(self):
            #return <declnetwork.ftp.ftp_response.Status>self.thisptr.GetStatus()
            
    #property message:
        #def __get__(self):
            #return self.thisptr.GetMessage()


cdef class FtpDirectoryResponse(FtpResponse):
    def __cinit__(self, FtpResponse response):
        self.thisptr = <declnetwork.ftp.Response*>new declnetwork.ftp.DirectoryResponse(response.thisptr[0])
    
    def get_directory(self):
        pass
       
        
cdef class ListingResponse(FtpResponse):
    def __cinit__(self, FtpResponse response, ):
        self.thisptr = <declnetwork.ftp.Response*>new declnetwork.ftp.ListingResponse()
    
    def get_filenames:
        pass


cdef class Ftp:
    def connect(self):
        pass
        
    def disconnect(self):
        pass
        
    def login(self):
        pass
        
    def keep_alive(self):
        pass
        
    def get_working_directory(self):
        pass
        
    def get_directory_listing(self):
        pass
        
    def change_directory(self):
        pass
 
    def parent_directory(self):
        pass
        
    def create_directory(self):
        pass
        
    def delete_directory(self):
        pass
        
    def rename_file(self):
        pass
        
    def delete_file(self):
        pass
        
    def download(self):
        pass
        
    def upload(self):
        pass


cdef class HttpRequest:
    GET = declnetwork.http.http_request.Get
    POST = declnetwork.http.http_request.Post
    HEAD = declnetwork.http.http_request.Head
    
    cdef declnetwork.http.Request *thisptr
    
    def __cinit__(self, bytes uri=b"/", int method=declnetwork.http.http_request.Get, bytes body=b""):
        self.thisptr = new declnetwork.http.Request(<char*>uri, <declnetwork.http.http_request.Method>method, <char*>body)

    property field:
        def __set__(self, tuple v):
            cdef bytes field = v[0]
            cdef bytes value = v[1]
            self.thisptr.SetField(<char*>field, <char*>value)
            
    property method:
        def __set__(self, int method):
            self.thisptr.SetMethod(<declnetwork.http.http_request.Method>method)
            
    property uri:
        def __set__(self, bytes uri):
            self.thisptr.SetUri(<char*>uri)
            
    property http_version:
        def __set__(self, tuple value):
            cdef unsigned int major = value[0]
            cdef unsigned int minor = value[1]
            self.thisptr.SetHttpVersion(major, minor)
            
    property body:
        def __set__(self, bytes body):
            self.thisptr.SetBody(<char*>body)

cdef class HttpResponse:
    OK = declnetwork.http.http_response.Ok
    CREATED = declnetwork.http.http_response.Created
    ACCEPTED = declnetwork.http.http_response.Accepted
    NO_CONTENT = declnetwork.http.http_response.NoContent
    RESET_CONTENT = declnetwork.http.http_response.ResetContent
    PARTIAL_CONTENT = declnetwork.http.http_response.PartialContent
    MULTIPLE_CHOICES = declnetwork.http.http_response.MultipleChoices
    MOVED_PERMANENTLY = declnetwork.http.http_response.MovedPermanently
    MOVED_TEMPORARILY = declnetwork.http.http_response.MovedTemporarily
    NOT_MODIFIED = declnetwork.http.http_response.NotModified
    BAD_REQUEST = declnetwork.http.http_response.BadRequest
    UNAUTHORIZED = declnetwork.http.http_response.Unauthorized
    FORBIDDEN = declnetwork.http.http_response.Forbidden
    NOT_FOUND = declnetwork.http.http_response.NotFound
    RANGE_NOT_SATISFIABLE = declnetwork.http.http_response.RangeNotSatisfiable
    INTERNAL_SERVER_ERROR = declnetwork.http.http_response.InternalServerError
    NOT_IMPLEMENTED = declnetwork.http.http_response.NotImplemented
    BAD_GATEWAY = declnetwork.http.http_response.BadGateway
    SERVICE_NOT_AVAILABLE = declnetwork.http.http_response.ServiceNotAvailable
    GATEWAY_TIMEOUT = declnetwork.http.http_response.GatewayTimeout
    VERSION_NOT_SUPPORTED = declnetwork.http.http_response.VersionNotSupported
    INVALID_RESPONSE = declnetwork.http.http_response.InvalidResponse
    CONNECTION_FAILED = declnetwork.http.http_response.ConnectionFailed
    
    cdef declnetwork.http.Response *thisptr
    
    #def __cinit__(self, bytes uri=b"/", int method=declnetwork.http_request.Get, bytes body=b""):
        #self.thisptr = new declnetwork.Request(<char*>uri, <declnetwork.http_request.Method>method, <char*>body)

    property field:
        def __get__(self):
            #cdef char* data
            #self.thisptr.GetField(data)
            return None
            
    property status:
        def __get__(self):
            <declnetwork.http.http_response.Status>self.thisptr.GetStatus()
            
    property major_http_version:
        def __get__(self):
            return self.thisptr.GetMajorHttpVersion()
            
    property minor_http_version:
        def __get__(self):
            return self.thisptr.GetMinorHttpVersion()
            
    #property body:
        #def __get__(self):
            #return self.thisptr.GetBody()

cdef class Http:
    cdef declnetwork.Http *thisptr
    
    def __cinit__(self, bytes host, unsigned short port=0):
        self.thisptr = new declnetwork.Http(<char*>host, port)

    def send_request(self, HttpRequest request, declnetwork.Uint32 timeout=0):
        self.thisptr.SendRequest(request.thisptr[0], timeout)
