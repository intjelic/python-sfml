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

from cython.operator cimport preincrement as preinc, dereference as deref
from libcpp.vector cimport vector

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
    DONE = declnetwork.socket.Done
    NOT_READY = declnetwork.socket.NotReady
    DISCONNECTED = declnetwork.socket.Disconnected
    ERROR = declnetwork.socket.Error
    
    ANY_PORT = declnetwork.socket.AnyPort
    
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
        
    def __dealloc__(self):
        del self.thisptr
        
    def __str__(self):
        return "TcpSocket()"
        
    def connect(self, IpAddress ip, unsigned short port, declnetwork.Uint32 timeout=0):
        return (<declnetwork.TcpSocket*>self.thisptr).Connect(ip.thisptr[0], port, timeout)

    def disconnect(self):
        (<declnetwork.TcpSocket*>self.thisptr).Disconnect()

    def send(self, bytes data):
        return (<declnetwork.TcpSocket*>self.thisptr).Send(<char*>data, len(data))
        
    def receive(self, size_t length):
        cdef char* c_data = <char*>declnetwork.malloc(length * sizeof(char))
        cdef size_t received = 0
        
        cdef int status = (<declnetwork.TcpSocket*>self.thisptr).Receive(c_data, length, received)
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
    MAX_DATAGRAM_SIZE = declnetwork.udpsocket.MaxDatagramSize
    
    def __cinit__(self, *args, **kwargs):
        self.thisptr = <declnetwork.Socket*>new declnetwork.UdpSocket()
        
    def __dealloc__(self):
        del self.thisptr
        
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

    def __dealloc__(self):
        del self.thisptr
        
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
    
    def __dealloc__(self):
        del self.thisptr
        
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
    RESTART_MARKER_REPLY = declnetwork.ftp.response.RestartMarkerReply
    SERVICE_READY_SOON = declnetwork.ftp.response.ServiceReadySoon
    DATA_CONNECTION_ALREADY_OPENED = declnetwork.ftp.response.DataConnectionAlreadyOpened
    OPENING_DATA_CONNECTION = declnetwork.ftp.response.OpeningDataConnection
    OK = declnetwork.ftp.response.Ok
    POINTLESS_COMMAND = declnetwork.ftp.response.PointlessCommand
    SYSTEM_STATUS = declnetwork.ftp.response.SystemStatus
    DIRECTORY_STATUS = declnetwork.ftp.response.DirectoryStatus
    FILE_STATUS = declnetwork.ftp.response.FileStatus
    HELP_MESSAGE = declnetwork.ftp.response.HelpMessage
    SYSTEM_TYPE = declnetwork.ftp.response.SystemType
    SERVICE_READY = declnetwork.ftp.response.ServiceReady
    CLOSING_CONNECTION = declnetwork.ftp.response.ClosingConnection
    DATA_CONNECTION_OPENED = declnetwork.ftp.response.DataConnectionOpened
    CLOSING_DATA_CONNECTION = declnetwork.ftp.response.ClosingDataConnection
    ENTERING_PASSIVE_MODE = declnetwork.ftp.response.EnteringPassiveMode
    LOGGED_IN = declnetwork.ftp.response.LoggedIn
    FILE_ACTION_OK = declnetwork.ftp.response.FileActionOk
    DIRECTORY_OK = declnetwork.ftp.response.DirectoryOk
    NEED_PASSWORD = declnetwork.ftp.response.NeedPassword
    NEED_ACCOUNT_TO_LOG_IN = declnetwork.ftp.response.NeedAccountToLogIn
    NEED_INFORMATION = declnetwork.ftp.response.NeedInformation
    SERVICE_UNAVAILABLE = declnetwork.ftp.response.ServiceUnavailable
    DATA_CONNECTION_UNAVAILABLE = declnetwork.ftp.response.DataConnectionUnavailable
    TRANSFER_ABORTED = declnetwork.ftp.response.TransferAborted
    FILE_ACTION_ABORTED = declnetwork.ftp.response.FileActionAborted
    LOCAL_ERROR = declnetwork.ftp.response.LocalError
    INSUFFICIENT_STORAGE_SPACE = declnetwork.ftp.response.InsufficientStorageSpace
    COMMAND_UNKNOWN = declnetwork.ftp.response.CommandUnknown
    PARAMETERS_UNKNOWN = declnetwork.ftp.response.ParametersUnknown
    COMMAND_NOT_IMPLEMENTED = declnetwork.ftp.response.CommandNotImplemented
    BAD_COMMAND_SEQUENCE = declnetwork.ftp.response.BadCommandSequence
    PARAMETER_NOT_IMPLEMENTED = declnetwork.ftp.response.ParameterNotImplemented
    NOT_LOGGED_IN = declnetwork.ftp.response.NotLoggedIn
    NEED_ACCOUNT_TO_STORE = declnetwork.ftp.response.NeedAccountToStore
    FILE_UNAVAILABLE = declnetwork.ftp.response.FileUnavailable
    PAGE_TYPE_UNKNOWN = declnetwork.ftp.response.PageTypeUnknown
    NOT_ENOUGH_MEMORY = declnetwork.ftp.response.NotEnoughMemory
    FILENAME_NOT_ALLOWED = declnetwork.ftp.response.FilenameNotAllowed
    INVALID_RESPONSE = declnetwork.ftp.response.InvalidResponse
    CONNECTION_FAILED = declnetwork.ftp.response.ConnectionFailed
    CONNECTION_CLOSED = declnetwork.ftp.response.ConnectionClosed
    INVALID_FILE = declnetwork.ftp.response.InvalidFile

    cdef declnetwork.ftp.Response *thisptr
    
    def __dealloc__(self):
        del self.thisptr

    property ok:
        def __get__(self):
            return self.thisptr.IsOk()

    property status:
        def __get__(self):
            return <int>self.thisptr.GetStatus()
            
    property message:
        def __get__(self):
            return self.thisptr.GetMessage().c_str()
    
cdef class FtpDirectoryResponse(FtpResponse):
    cdef declnetwork.ftp.Response* deletethis
    
    def __dealloc__(self):
        del self.deletethis
        
    def get_directory(self):
        return (<declnetwork.ftp.DirectoryResponse*>self.thisptr).GetDirectory().c_str()
       
    
cdef class FtpListingResponse(FtpResponse):
    cdef declnetwork.ftp.Response* deletethis
    
    def __dealloc__(self):
        del self.deletethis
        
    def get_filenames(self):
        return NotImplemented
        #cdef list ret = []
        #cdef vector[declnetwork.string]& v = (<declnetwork.ftp.ListingResponse>self.thisptr).GetFilenames()
        #cdef vector[declnetwork.string].iterator it = v.begin()
        #cdef declnetwork.string current
        #cdef declnetwork.string *p_temp

        #while it != v.end():
            #current = deref(it)
            ##a = current.c_str()
            #ret.append(current.c_str())
            #p_temp = new
            #new declwindow.VideoMode(current.Width, current.Height,
                                        ##current.BitsPerPixel)
            ##ret.append(wrap_video_mode_instance(p_temp, True))
            ##preinc(it)

        #return ret

cdef wrap_ftpresponse_instance(declnetwork.ftp.Response* instance):
    cdef FtpResponse ret = FtpResponse.__new__(FtpResponse)
    ret.thisptr = instance
    return ret
    
    
cdef wrap_ftpdirectoryresponse_instance(declnetwork.ftp.DirectoryResponse* instance, declnetwork.ftp.Response* response):
    cdef FtpDirectoryResponse ret = FtpDirectoryResponse.__new__(FtpDirectoryResponse)
    ret.thisptr = <declnetwork.ftp.Response*>instance
    ret.deletethis = response
    return ret
    

cdef wrap_ftplistingresponse_instance(declnetwork.ftp.ListingResponse* instance, declnetwork.ftp.Response* response):
    cdef FtpListingResponse ret = FtpListingResponse.__new__(FtpListingResponse)
    ret.thisptr = <declnetwork.ftp.Response*>instance
    ret.deletethis = response
    return ret
    
    
cdef class Ftp:
    BINARY = declnetwork.ftp.Binary
    ASCII = declnetwork.ftp.Ascii
    EBCDIC = declnetwork.ftp.Ebcdic
    
    cdef declnetwork.Ftp *thisptr
    
    def __cinit__(self, *args, **kwargs):
        self.thisptr = new declnetwork.Ftp()
        
    def __dealloc__(self):
        del self.thisptr
        
    def connect(self, IpAddress server, unsigned short port=21, declnetwork.Uint32 timeout=0):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.Connect(server.thisptr[0], port, timeout)
        return wrap_ftpresponse_instance(response)
        
    def disconnect(self):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.Disconnect()
        return wrap_ftpresponse_instance(response)
        
    def login(self, bytes name=None, bytes message=b""):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        if name:
            response[0]= self.thisptr.Login(name, message)
        else:
            response[0]= self.thisptr.Login()
        return wrap_ftpresponse_instance(response)
        
    def keep_alive(self):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.KeepAlive()
        return wrap_ftpresponse_instance(response)
        
    def get_working_directory(self):
        # here Ftp::DirectoryResponse's constructors prevent us from
        # creating an empty object. We must cheat by passing an empty
        # Ftp::Reponse that we must destruct when the DirectoryResponse
        # is destroyed.
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        cdef declnetwork.ftp.DirectoryResponse* directory_response = new declnetwork.ftp.DirectoryResponse(response[0])
        directory_response[0] = self.thisptr.GetWorkingDirectory()
        return wrap_ftpdirectoryresponse_instance(directory_response, response)
    
    def get_directory_listing(self, bytes directory=b""):
        # here Ftp::ListingResponse's constructors prevent us from
        # creating an empty object. We must cheat by passing an empty
        # Ftp::Reponse and a false vector of char*. We must destruct
        # what we had allocated to cheat on when the ListingResponse
        # is destroyed.
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        cdef vector[char] falseList
        cdef declnetwork.ftp.ListingResponse* listing_response = new declnetwork.ftp.ListingResponse(response[0], falseList)
        listing_response[0] = self.thisptr.GetDirectoryListing(directory)
        return wrap_ftplistingresponse_instance(listing_response, response)
        
    def change_directory(self, bytes directory):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.ChangeDirectory(directory)
        return wrap_ftpresponse_instance(response)
 
    def parent_directory(self):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.ParentDirectory()
        return wrap_ftpresponse_instance(response)
        
    def create_directory(self, bytes name):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.CreateDirectory(name)
        return wrap_ftpresponse_instance(response)
        
    def delete_directory(self, bytes name):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.DeleteDirectory(name)
        return wrap_ftpresponse_instance(response)
        
    def rename_file(self, bytes file_name, bytes new_name):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.RenameFile(file_name, new_name)
        return wrap_ftpresponse_instance(response)
        
    def delete_file(self, bytes name):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.DeleteFile(name)
        return wrap_ftpresponse_instance(response)
        
    def download(self, bytes remote_file, bytes local_path, int mode=declnetwork.ftp.Binary):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.Download(remote_file, local_path, <declnetwork.ftp.TransferMode>mode)
        return wrap_ftpresponse_instance(response)
        
    def upload(self, bytes local_file, bytes remote_path, int mode=declnetwork.ftp.Binary):
        cdef declnetwork.ftp.Response* response = new declnetwork.ftp.Response()
        response[0] = self.thisptr.Upload(local_file, remote_path, <declnetwork.ftp.TransferMode>mode)
        return wrap_ftpresponse_instance(response)

cdef class HttpRequest:
    GET = declnetwork.http.request.Get
    POST = declnetwork.http.request.Post
    HEAD = declnetwork.http.request.Head
    
    cdef declnetwork.http.Request *thisptr
    
    def __cinit__(self, bytes uri=b"/", int method=declnetwork.http.request.Get, bytes body=b""):
        self.thisptr = new declnetwork.http.Request(<char*>uri, <declnetwork.http.request.Method>method, <char*>body)

    property field:
        def __set__(self, tuple v):
            cdef bytes field = v[0]
            cdef bytes value = v[1]
            self.thisptr.SetField(<char*>field, <char*>value)
            
    property method:
        def __set__(self, int method):
            self.thisptr.SetMethod(<declnetwork.http.request.Method>method)
            
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
    OK = declnetwork.http.response.Ok
    CREATED = declnetwork.http.response.Created
    ACCEPTED = declnetwork.http.response.Accepted
    NO_CONTENT = declnetwork.http.response.NoContent
    RESET_CONTENT = declnetwork.http.response.ResetContent
    PARTIAL_CONTENT = declnetwork.http.response.PartialContent
    MULTIPLE_CHOICES = declnetwork.http.response.MultipleChoices
    MOVED_PERMANENTLY = declnetwork.http.response.MovedPermanently
    MOVED_TEMPORARILY = declnetwork.http.response.MovedTemporarily
    NOT_MODIFIED = declnetwork.http.response.NotModified
    BAD_REQUEST = declnetwork.http.response.BadRequest
    UNAUTHORIZED = declnetwork.http.response.Unauthorized
    FORBIDDEN = declnetwork.http.response.Forbidden
    NOT_FOUND = declnetwork.http.response.NotFound
    RANGE_NOT_SATISFIABLE = declnetwork.http.response.RangeNotSatisfiable
    INTERNAL_SERVER_ERROR = declnetwork.http.response.InternalServerError
    NOT_IMPLEMENTED = declnetwork.http.response.NotImplemented
    BAD_GATEWAY = declnetwork.http.response.BadGateway
    SERVICE_NOT_AVAILABLE = declnetwork.http.response.ServiceNotAvailable
    GATEWAY_TIMEOUT = declnetwork.http.response.GatewayTimeout
    VERSION_NOT_SUPPORTED = declnetwork.http.response.VersionNotSupported
    INVALID_RESPONSE = declnetwork.http.response.InvalidResponse
    CONNECTION_FAILED = declnetwork.http.response.ConnectionFailed
    
    cdef declnetwork.http.Response *thisptr
    
    #def __cinit__(self, bytes uri=b"/", int method=declnetwork.request.Get, bytes body=b""):
        #self.thisptr = new declnetwork.Request(<char*>uri, <declnetwork.request.Method>method, <char*>body)

    property field:
        def __get__(self):
            #cdef char* data
            #self.thisptr.GetField(data)
            return None
            
    property status:
        def __get__(self):
            <declnetwork.http.response.Status>self.thisptr.GetStatus()
            
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
