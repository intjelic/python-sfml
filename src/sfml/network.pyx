#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML - Python bindings for SFML
# Copyright 2013, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the LGPLv3 license.
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

from cython.operator cimport dereference as deref
from cython.operator cimport preincrement as inc

from libc.stdlib cimport *
from libcpp.string cimport string
from libcpp.vector cimport vector

from pysfml.dsystem cimport Int8, Int16, Int32, Int64
from pysfml.dsystem cimport Uint8, Uint16, Uint32, Uint64

from pysfml cimport dsystem, dnetwork

from sfml.system import SFMLException, pop_error_message, push_error_message

cdef extern from "system.h":

	cdef class sfml.system.Time [object PyTimeObject]:
		cdef dsystem.Time *p_this
		

cdef class IpAddress:
	cdef dnetwork.IpAddress *p_this

	NONE = wrap_ipaddress(<dnetwork.IpAddress*>&dnetwork.ipaddress.None)
	LOCAL_HOST = wrap_ipaddress(<dnetwork.IpAddress*>&dnetwork.ipaddress.LocalHost)
	BROADCAST = wrap_ipaddress(<dnetwork.IpAddress*>&dnetwork.ipaddress.Broadcast)

	def __init__(self):
		self.p_this = new dnetwork.IpAddress()

	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return "sf.IpAddress({0})".format(self)
		
	def __str__(self):
		return self.string.decode('utf-8')
		
	def __richcmp__(IpAddress x, IpAddress y, int op):
		if op == 0:   return x.p_this[0] <  y.p_this[0]
		elif op == 2: return x.p_this[0] == y.p_this[0]
		elif op == 4: return x.p_this[0] >  y.p_this[0]
		elif op == 1: return x.p_this[0] <= y.p_this[0]
		elif op == 3: return x.p_this[0] != y.p_this[0]
		elif op == 5: return x.p_this[0] >= y.p_this[0]
		
	@classmethod
	def from_string(self, _string):
		cdef string encoded_string
		encoded_string_temporary = _string.encode('UTF-8')	
		encoded_string = string(<char*>encoded_string_temporary)
		
		cdef dnetwork.IpAddress *p = new dnetwork.IpAddress(encoded_string)
		return wrap_ipaddress(p)

	@classmethod
	def from_integer(self, Uint32 address):
		cdef dnetwork.IpAddress *p = new dnetwork.IpAddress(address)
		return wrap_ipaddress(p)
		
	@classmethod
	def from_bytes(self, Uint8 b1, Uint8 b2, Uint8 b3, Uint8 b4):
		cdef dnetwork.IpAddress *p = new dnetwork.IpAddress(b1, b2, b3, b4)
		return wrap_ipaddress(p)

	property string:
		def __get__(self):
			return self.p_this.toString().c_str()

	property integer:
		def __get__(self):
			return self.p_this.toInteger()
		
	@classmethod
	def get_local_address(self):
		cdef dnetwork.IpAddress* p = new dnetwork.IpAddress()
		p[0] = dnetwork.ipaddress.getLocalAddress()
		return wrap_ipaddress(p)

	@classmethod
	def get_public_address(self, Time timeout=None):
		cdef dnetwork.IpAddress* p = new dnetwork.IpAddress()
		if not timeout: p[0] = dnetwork.ipaddress.getPublicAddress()
		else: p[0] = dnetwork.ipaddress.getPublicAddress(timeout.p_this[0])
		return wrap_ipaddress(p)

cdef wrap_ipaddress(dnetwork.IpAddress* p):
	cdef IpAddress r = IpAddress.__new__(IpAddress)
	r.p_this = p
	return r

cdef class Socket:
	DONE = dnetwork.socket.Done
	NOT_READY = dnetwork.socket.NotReady
	DISCONNECTED = dnetwork.socket.Disconnected
	ERROR = dnetwork.socket.Error

	ANY_PORT = dnetwork.socket.AnyPort

	cdef dnetwork.Socket *p_socket

	def __init__(self):
		if self.__class__ == Socket:
			raise NotImplementedError('Socket is abstact')
		
	property blocking:
		def __get__(self):
			return self.p_socket.isBlocking()
			
		def __set__(self, bint blocking):
			self.p_socket.setBlocking(blocking)


class SocketException(Exception): pass
class SocketNotReady(SocketException): pass
class SocketDisconnected(SocketException): pass
class SocketError(SocketException): pass


cdef class TcpListener(Socket):
	cdef dnetwork.TcpListener *p_this
	
	def __init__(self):
		self.p_this = new dnetwork.TcpListener()
		self.p_socket = <dnetwork.Socket*>self.p_this
		
	def __dealloc__(self):
		del self.p_this
		
	def __repr__(self):
		return "sf.TcpListener({0})".format(self)
		
	def __str__(self):
		return str()

	property local_port:
		def __get__(self):
			return self.p_this.getLocalPort()
			
	def listen(self, unsigned short port):
		cdef dnetwork.socket.Status status = self.p_this.listen(port)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()

	def close(self):
		self.p_this.close()
		
	def accept(self):
		cdef TcpSocket socket = TcpSocket()
		cdef dnetwork.socket.Status status
		
		with nogil:
			status = self.p_this.accept(socket.p_this[0])
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()
				
		return socket


cdef class TcpSocket(Socket):
	cdef dnetwork.TcpSocket *p_this

	def __init__(self):
		self.p_this = new dnetwork.TcpSocket()
		self.p_socket = <dnetwork.Socket*>self.p_this
		
	def __dealloc__(self):
		del self.p_this

	def __repr__(self):
		return "TcpSocket({0})".format(self)

	def __str__(self):
		return str()

	property local_port:
		def __get__(self):
			return self.p_this.getLocalPort()
			
	property remote_address:
		def __get__(self):
			cdef dnetwork.IpAddress *p = new dnetwork.IpAddress()
			p[0] = self.p_this.getRemoteAddress()
			return wrap_ipaddress(p)
			
	property remote_port:
		def __get__(self):
			return self.p_this.getRemotePort()
			
	def connect(self, IpAddress remote_address, unsigned short remote_port, Time timeout=None):
		cdef dnetwork.socket.Status status

		if not timeout:
			with nogil:
				status = self.p_this.connect(remote_address.p_this[0], remote_port)
		else:
			with nogil:
				status = self.p_this.connect(remote_address.p_this[0], remote_port, timeout.p_this[0])
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()

	def disconnect(self):
		self.p_this.disconnect()

	def send(self, bytes data):
		cdef dnetwork.socket.Status status
		cdef char* cdata = <char*>data
		cdef size_t cdata_len = len(data)
		
		with nogil:
			status = self.p_this.send(cdata, cdata_len)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()

	def receive(self, size_t size):
		cdef char* data = <char*>malloc(size * sizeof(char))
		cdef size_t received = 0
		cdef dnetwork.socket.Status status
		
		with nogil:
			status = self.p_this.receive(data, size, received)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()
				
		return <bytes>(data)[:received]


cdef class UdpSocket(Socket):
	cdef dnetwork.UdpSocket *p_this
	
	MAX_DATAGRAM_SIZE = dnetwork.udpsocket.MaxDatagramSize

	def __init__(self):
		self.p_this = new dnetwork.UdpSocket()
		self.p_socket = <dnetwork.Socket*>self.p_this

	def __dealloc__(self):
		del self.p_this
		
	property local_port:
		def __get__(self):
			return self.p_this.getLocalPort()
	   
	def bind(self, unsigned short port):
		cdef dnetwork.socket.Status status = self.p_this.bind(port)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()
				
	def unbind(self):
		self.p_this.unbind()
		
	def send(self, bytes data, IpAddress remote_address, unsigned short remote_port):
		cdef dnetwork.socket.Status status = self.p_this.send(<char*>data, len(data), remote_address.p_this[0], remote_port)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()

	def receive(self, size_t size):
		cdef char* data = <char*>malloc(size * sizeof(char))
		cdef size_t received = 0
		cdef IpAddress remote_address = IpAddress()
		cdef unsigned short port = 0
		cdef dnetwork.socket.Status status = self.p_this.receive(data, size, received, remote_address.p_this[0], port)
		
		if status is not dnetwork.socket.Done:
			if status is dnetwork.socket.NotReady:
				raise SocketNotReady()
			elif status is dnetwork.socket.Disconnected:
				raise SocketDisconnected()
			elif status is dnetwork.socket.Error:
				raise SocketError()
				
		return (<bytes>(data)[:received], remote_address, port)


cdef class SocketSelector:
	cdef dnetwork.SocketSelector *p_this

	def __init__(self):
		self.p_this = new dnetwork.SocketSelector()

	def __dealloc__(self):
		del self.p_this
		
	def add(self, Socket socket):
		self.p_this.add(socket.p_socket[0])
		
	def remove(self, Socket socket):
		self.p_this.remove(socket.p_socket[0])
		
	def clear(self):
		self.p_this.clear()
		
	def wait(self, Time timeout=None):
		cdef bint ret
		
		if not timeout: 
			with nogil:
				ret = self.p_this.wait()
		else: 
			with nogil:
				ret = self.p_this.wait(timeout.p_this[0])
				
		return ret
		
	def is_ready(self, Socket socket):
		return self.p_this.isReady(socket.p_socket[0])


cdef class FtpResponse:
	RESTART_MARKER_REPLY = dnetwork.ftp.response.RestartMarkerReply
	SERVICE_READY_SOON = dnetwork.ftp.response.ServiceReadySoon
	DATA_CONNECTION_ALREADY_OPENED = dnetwork.ftp.response.DataConnectionAlreadyOpened
	OPENING_DATA_CONNECTION = dnetwork.ftp.response.OpeningDataConnection
	OK = dnetwork.ftp.response.Ok
	POINTLESS_COMMAND = dnetwork.ftp.response.PointlessCommand
	SYSTEM_STATUS = dnetwork.ftp.response.SystemStatus
	DIRECTORY_STATUS = dnetwork.ftp.response.DirectoryStatus
	FILE_STATUS = dnetwork.ftp.response.FileStatus
	HELP_MESSAGE = dnetwork.ftp.response.HelpMessage
	SYSTEM_TYPE = dnetwork.ftp.response.SystemType
	SERVICE_READY = dnetwork.ftp.response.ServiceReady
	CLOSING_CONNECTION = dnetwork.ftp.response.ClosingConnection
	DATA_CONNECTION_OPENED = dnetwork.ftp.response.DataConnectionOpened
	CLOSING_DATA_CONNECTION = dnetwork.ftp.response.ClosingDataConnection
	ENTERING_PASSIVE_MODE = dnetwork.ftp.response.EnteringPassiveMode
	LOGGED_IN = dnetwork.ftp.response.LoggedIn
	FILE_ACTION_OK = dnetwork.ftp.response.FileActionOk
	DIRECTORY_OK = dnetwork.ftp.response.DirectoryOk
	NEED_PASSWORD = dnetwork.ftp.response.NeedPassword
	NEED_ACCOUNT_TO_LOG_IN = dnetwork.ftp.response.NeedAccountToLogIn
	NEED_INFORMATION = dnetwork.ftp.response.NeedInformation
	SERVICE_UNAVAILABLE = dnetwork.ftp.response.ServiceUnavailable
	DATA_CONNECTION_UNAVAILABLE = dnetwork.ftp.response.DataConnectionUnavailable
	TRANSFER_ABORTED = dnetwork.ftp.response.TransferAborted
	FILE_ACTION_ABORTED = dnetwork.ftp.response.FileActionAborted
	LOCAL_ERROR = dnetwork.ftp.response.LocalError
	INSUFFICIENT_STORAGE_SPACE = dnetwork.ftp.response.InsufficientStorageSpace
	COMMAND_UNKNOWN = dnetwork.ftp.response.CommandUnknown
	PARAMETERS_UNKNOWN = dnetwork.ftp.response.ParametersUnknown
	COMMAND_NOT_IMPLEMENTED = dnetwork.ftp.response.CommandNotImplemented
	BAD_COMMAND_SEQUENCE = dnetwork.ftp.response.BadCommandSequence
	PARAMETER_NOT_IMPLEMENTED = dnetwork.ftp.response.ParameterNotImplemented
	NOT_LOGGED_IN = dnetwork.ftp.response.NotLoggedIn
	NEED_ACCOUNT_TO_STORE = dnetwork.ftp.response.NeedAccountToStore
	FILE_UNAVAILABLE = dnetwork.ftp.response.FileUnavailable
	PAGE_TYPE_UNKNOWN = dnetwork.ftp.response.PageTypeUnknown
	NOT_ENOUGH_MEMORY = dnetwork.ftp.response.NotEnoughMemory
	FILENAME_NOT_ALLOWED = dnetwork.ftp.response.FilenameNotAllowed
	INVALID_RESPONSE = dnetwork.ftp.response.InvalidResponse
	CONNECTION_FAILED = dnetwork.ftp.response.ConnectionFailed
	CONNECTION_CLOSED = dnetwork.ftp.response.ConnectionClosed
	INVALID_FILE = dnetwork.ftp.response.InvalidFile

	cdef dnetwork.ftp.Response *p_response

	def __repr__(self):
		return "sf.FtpResponse({0})".format(self)

	def __str__(self):
		return "Status: {0} - {1}".format(self.status, self.message)
		
	property ok:
		def __get__(self):
			return self.p_response.isOk()

	property status:
		def __get__(self):
			return self.p_response.getStatus()
			
	property message:
		def __get__(self):
			return self.p_response.getMessage().c_str()

cdef class FtpDirectoryResponse(FtpResponse):
	cdef dnetwork.ftp.DirectoryResponse *p_this

	def __init__(self):
		raise NotImplementedError("Not meant to be instantiated")
		
	def __dealloc__(self):
		del self.p_this
		
	def get_directory(self):
		return self.p_this.getDirectory().c_str()
	   
    
cdef class FtpListingResponse(FtpResponse):
	cdef dnetwork.ftp.ListingResponse *p_this

	def __init__(self):
		raise NotImplementedError("Not meant to be instantiated")
		
	def __dealloc__(self):
		del self.p_this
		
	property filenames:
		def __get__(self):
			cdef list r = []	
			cdef vector[string]* filenames = <vector[string]*>&self.p_this.getListing()
			cdef vector[string].iterator filename = filenames.begin()
			cdef string temp
			while filename != filenames.end():
				temp = deref(filename)
				r.append(temp.c_str())
				inc(filename)

			return tuple(r)

cdef wrap_ftpresponse(dnetwork.ftp.Response* p):
	cdef FtpResponse r = FtpResponse.__new__(FtpResponse)
	r.p_response = p
	return r


cdef wrap_ftpdirectoryresponse(dnetwork.ftp.DirectoryResponse* p):
	cdef FtpDirectoryResponse r = FtpDirectoryResponse.__new__(FtpDirectoryResponse)
	r.p_this = p
	r.p_response = <dnetwork.ftp.Response*>p
	return r


cdef wrap_ftplistingresponse(dnetwork.ftp.ListingResponse* p):
	cdef FtpListingResponse r = FtpListingResponse.__new__(FtpListingResponse)
	r.p_this = p
	r.p_response = <dnetwork.ftp.Response*>p
	return r

cdef class Ftp:
	BINARY = dnetwork.ftp.Binary
	ASCII = dnetwork.ftp.Ascii
	EBCDIC = dnetwork.ftp.Ebcdic

	cdef dnetwork.Ftp *p_this

	def __init__(self):
		self.p_this = new dnetwork.Ftp()
		
	def __dealloc__(self):
		del self.p_this
		
	def connect(self, IpAddress server, unsigned short port=21, Time timeout=None):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		if not timeout:
			with nogil: response[0] = self.p_this.connect(server.p_this[0], port)
		else:
			with nogil: response[0] = self.p_this.connect(server.p_this[0], port, timeout.p_this[0])
		
		return wrap_ftpresponse(response)
		
	def disconnect(self):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		response[0] = self.p_this.disconnect()
		return wrap_ftpresponse(response)
		
	def login(self, str name=None, str message=""):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_name_temporary = name.encode('UTF-8')
		encoded_message_temporary = message.encode('UTF-8')
		cdef char* encoded_name = encoded_name_temporary
		cdef char* encoded_message = encoded_message_temporary

		if not name:
			with nogil: response[0] = self.p_this.login()
		else: 
			with nogil: response[0] = self.p_this.login(encoded_name, encoded_message)
			
		return wrap_ftpresponse(response)

	def keep_alive(self):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		with nogil: 
			response[0] = self.p_this.keepAlive()
			
		return wrap_ftpresponse(response)
		
	def get_working_directory(self):
		# here Ftp::DirectoryResponse's constructors prevent us from
		# creating an empty object. We must cheat by passing an empty
		# Ftp::Reponse that we must destruct when the DirectoryResponse
		# is destroyed.
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		cdef dnetwork.ftp.DirectoryResponse* directory_response = new dnetwork.ftp.DirectoryResponse(response[0])
		del response
		
		with nogil:
			directory_response[0] = self.p_this.getWorkingDirectory()
			
		return wrap_ftpdirectoryresponse(directory_response)
		
	def get_directory_listing(self, str directory=""):
		# here Ftp::ListingResponse's constructors prevent us from
		# creating an empty object. We must cheat by passing an empty
		# Ftp::Reponse and a false vector of char*. We must destruct
		# what we had allocated to cheat on when the ListingResponse
		# is destroyed.
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		cdef vector[char] falseList
		cdef dnetwork.ftp.ListingResponse* listing_response = new dnetwork.ftp.ListingResponse(response[0], falseList)
		del response
		
		encoded_directory_temporary = directory.encode('UTF-8')
		cdef char* encoded_directory = encoded_directory_temporary
		
		with nogil:
			listing_response[0] = self.p_this.getDirectoryListing(encoded_directory)
			
		return wrap_ftplistingresponse(listing_response)
		
	def change_directory(self, str directory):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_directory_temporary = directory.encode('UTF-8')
		cdef char* encoded_directory = encoded_directory_temporary
		
		with nogil:
			response[0] = self.p_this.changeDirectory(encoded_directory)
			
		return wrap_ftpresponse(response)

	def parent_directory(self):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		with nogil:
			response[0] = self.p_this.parentDirectory()
			
		return wrap_ftpresponse(response)
		
	def create_directory(self, str name):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_name_temporary = name.encode('UTF-8')
		cdef char* encoded_name = encoded_name_temporary
		
		with nogil:
			response[0] = self.p_this.createDirectory(encoded_name)
			
		return wrap_ftpresponse(response)
		
	def delete_directory(self, str name):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_name_temporary = name.encode('UTF-8')
		cdef char* encoded_name = encoded_name_temporary
		
		with nogil:
			response[0] = self.p_this.deleteDirectory(encoded_name)
			
		return wrap_ftpresponse(response)
		
	def rename_file(self, str filename, str newname):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_filename_temporary = filename.encode('UTF-8')
		encoded_newname_temporary = newname.encode('UTF-8')
		cdef char* encoded_filename = encoded_filename_temporary
		cdef char* encoded_newname = encoded_newname_temporary
		
		with nogil:
			response[0] = self.p_this.renameFile(encoded_filename, encoded_newname)
			
		return wrap_ftpresponse(response)
		
	def delete_file(self, str name):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_name_temporary = name.encode('UTF-8')
		cdef char* encoded_name = encoded_name_temporary
		
		with nogil:
			response[0] = self.p_this.deleteFile(encoded_name)
			
		return wrap_ftpresponse(response)
		
	def download(self, str remotefile, str localpath, dnetwork.ftp.TransferMode mode=dnetwork.ftp.Binary):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_remotefile_temporary = remotefile.encode('UTF-8')
		encoded_localpath_temporary = localpath.encode('UTF-8')
		cdef char* encoded_remotefile = encoded_remotefile_temporary
		cdef char* encoded_localpath = encoded_localpath_temporary
		
		with nogil:
			response[0] = self.p_this.download(encoded_remotefile, encoded_localpath, mode)
			
		return wrap_ftpresponse(response)
		
	def upload(self, str localfile, str remotepath, dnetwork.ftp.TransferMode mode=dnetwork.ftp.Binary):
		cdef dnetwork.ftp.Response* response = new dnetwork.ftp.Response()
		
		encoded_localfile_temporary = localfile.encode('UTF-8')
		encoded_remotepath_temporary = remotepath.encode('UTF-8')
		cdef char* encoded_localfile = encoded_localfile_temporary
		cdef char* encoded_remotepath = encoded_remotepath_temporary
		
		with nogil:
			response[0] = self.p_this.upload(encoded_localfile, encoded_remotepath, mode)
			
		return wrap_ftpresponse(response)


cdef class HttpRequest:
	GET = dnetwork.http.request.Get
	POST = dnetwork.http.request.Post
	HEAD = dnetwork.http.request.Head

	cdef dnetwork.http.Request *p_this

	def __init__(self, bytes uri=b"/", dnetwork.http.request.Method method=dnetwork.http.request.Get, bytes body=b""):
		self.p_this = new dnetwork.http.Request(string(uri), method, string(body))

	def __dealloc__(self):
		del self.p_this
		
	property field:
		def __set__(self, tuple v):
			cdef bytes field = v[0]
			cdef bytes value = v[1]
			self.p_this.setField(string(field), string(value))

	property method:
		def __set__(self, dnetwork.http.request.Method method):
			self.p_this.setMethod(method)
			
	property uri:
		def __set__(self, bytes uri):
			self.p_this.setUri(string(uri))
			
	property http_version:
		def __set__(self, tuple value):
			cdef unsigned int major = value[0]
			cdef unsigned int minor = value[1]
			self.p_this.setHttpVersion(major, minor)
			
	property body:
		def __set__(self, bytes body):
			self.p_this.setBody(string(body))


cdef class HttpResponse:
	OK = dnetwork.http.response.Ok
	CREATED = dnetwork.http.response.Created
	ACCEPTED = dnetwork.http.response.Accepted
	NO_CONTENT = dnetwork.http.response.NoContent
	RESET_CONTENT = dnetwork.http.response.ResetContent
	PARTIAL_CONTENT = dnetwork.http.response.PartialContent
	MULTIPLE_CHOICES = dnetwork.http.response.MultipleChoices
	MOVED_PERMANENTLY = dnetwork.http.response.MovedPermanently
	MOVED_TEMPORARILY = dnetwork.http.response.MovedTemporarily
	NOT_MODIFIED = dnetwork.http.response.NotModified
	BAD_REQUEST = dnetwork.http.response.BadRequest
	UNAUTHORIZED = dnetwork.http.response.Unauthorized
	FORBIDDEN = dnetwork.http.response.Forbidden
	NOT_FOUND = dnetwork.http.response.NotFound
	RANGE_NOT_SATISFIABLE = dnetwork.http.response.RangeNotSatisfiable
	INTERNAL_SERVER_ERROR = dnetwork.http.response.InternalServerError
	NOT_IMPLEMENTED = dnetwork.http.response.NotImplemented
	BAD_GATEWAY = dnetwork.http.response.BadGateway
	SERVICE_NOT_AVAILABLE = dnetwork.http.response.ServiceNotAvailable
	GATEWAY_TIMEOUT = dnetwork.http.response.GatewayTimeout
	VERSION_NOT_SUPPORTED = dnetwork.http.response.VersionNotSupported
	INVALID_RESPONSE = dnetwork.http.response.InvalidResponse
	CONNECTION_FAILED = dnetwork.http.response.ConnectionFailed

	cdef dnetwork.http.Response *p_this

	def __init__(self):
		raise NotImplementedError("Not meant to be instantiated!")
		
	def __dealloc__(self):
		del self.p_this

	def get_field(self, bytes field):
		return self.p_this.getField(string(field)).c_str()

	property status:
		def __get__(self):
			return self.p_this.getStatus()

	property major_http_version:
		def __get__(self):
			return self.p_this.getMajorHttpVersion()

	property minor_http_version:
		def __get__(self):
			return self.p_this.getMinorHttpVersion()

	property body:
		def __get__(self):
			return self.p_this.getBody().c_str()

cdef wrap_httpresponse(dnetwork.http.Response *p):
	cdef HttpResponse r = HttpResponse.__new__(HttpResponse)
	r.p_this = p
	return r
	
cdef class Http:
	cdef dnetwork.Http *p_this

	def __init__(self, bytes host, unsigned short port=0):
		self.p_this = new dnetwork.Http(string(host), port)

	def __dealloc__(self):
		del self.p_this

	def send_request(self, HttpRequest request, Time timeout=None):
		cdef dnetwork.http.Response* p = new dnetwork.http.Response()
		
		if not timeout: 
			with nogil: p[0] = self.p_this.sendRequest(request.p_this[0])
		else: 
			with nogil: p[0] = self.p_this.sendRequest(request.p_this[0], timeout.p_this[0])
			
		return wrap_httpresponse(p)
