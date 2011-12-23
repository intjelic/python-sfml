Network
=======

.. module:: sf.network

.. class:: IpAddress()

   Encapsulate an IPv4 network address.

   sf.IpAddress is a utility class for manipulating network addresses.

   It provides static methods and conversion functions to easily build or transform an IP address from/to various representations.

   Usage example::
   
      ip0 = sf.IpAddress()                             # an invalid address
      ip1 = sf.IpAddress.from_string("127.0.0.1")      # the local host address
      ip2 = sf.IpAddress.from_string("my_computer")    # a local address created from a network name
      ip3 = sf.IpAddress.from_string("89.54.1.169")    # a distant address
      ip4 = sf.IpAddress.from_string("www.google.com") # a distant address created from a network name
      ip5 = sf.IpAddress.local_address()               # my address on the local network
      ip6 = sf.IpAddress.public_address()              # my address on the internet

   Note that sf.IpAddress currently doesn't support IPv6 nor other types of network addresses.

   .. classmethod:: from_string(string)
   .. classmethod:: from_integer(integer)
   
   .. classmethod:: local_address()
   .. classmethod:: public_address()


.. py:class:: Socket()

   Base class for all the socket types.

   This class mainly defines internal stuff to be used by derived classes.

   The only public features that it defines, and which is therefore common to all the socket classes, is the blocking state. All sockets can be set as blocking or non-blocking.

   In blocking mode, socket functions will hang until the operation completes, which means that the entire program (well, in fact the current thread if you use multiple ones) will be stuck waiting for your socket operation to complete.

   In non-blocking mode, all the socket functions will return immediately. If the socket is not ready to complete the requested operation, the function simply returns the proper status code (Socket.NOTREADY).

   The default mode, which is blocking, is the one that is generally used, in combination with threads or selectors. The non-blocking mode is rather used in real-time applications that run an endless loop that can poll the socket often enough, and cannot afford blocking this loop.

   .. py:data:: DONE
   
      The socket has sent / received the data.
      
   .. py:data:: NOTREADY
   
      The socket is not ready to send / receive data yet.
      
   .. py:data:: DISCONNECTED
   
      The TCP socket has been disconnected.
      
   .. py:data:: ERROR

      An unexpected error happened.
      
   .. py:attribute:: blocking
   
         The socket's blocking state; blocking or non-blocking.


.. py:class:: Socket()

   .. py:attribute:: blocking
   
         The socket's blocking state; blocking or non-blocking.


.. py:class:: TcpSocket()

   .. py:method:: connect(ip, port[, timeout=0])
   
      Connect the socket to a remote peer.
      
      In blocking mode, this function may take a while, especially if the remote peer is not reachable. The last parameter allows you to stop trying to connect after a given timeout. If the socket was previously connected, it is first disconnected.
      
      :param sf.IpAddress ip: Address of the remote peer 
      :param integer port: Port of the remote peer 
      :param integer timeout: Optional maximum time to wait, in milliseconds
      :rtype: sf.Socket.STATUS
      
   .. py:method:: disconnect()
   
      Disconnect the socket from its remote peer.
      
      This function gracefully closes the connection. If the socket is not connected, this function has no effect.

   .. py:method:: send(data)
   
      Send raw data to the remote peer.
      
      This function will fail if the socket is not connected.
      
      :param bytes data: The sequence of bytes to send 
      :rtype: sf.Socket.STATUS
      
   .. py:method:: recieve(length)
   
      Receive raw data from the remote peer.
      
      In blocking mode, this function will wait until some bytes are actually received. This function will fail if the socket is not connected.
      
      .. note:: The recieved data's length may be different from the asked length.
      
      :param integer length: Maximum number of bytes that can be received
      :rtype: (sf.Socket.STATUS, bytes data)
      
   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not connected, its value is 0.
      
   .. py:attribute:: remote_address
   
      The address of the connected peer.
      
      It the socket is not connected, its value sf.IpAddress.NONE.
      
   .. py:attribute:: remote_port
   
      The port of the connected peer to which the socket is connected.
      
      If the socket is not connected, its value is 0.


.. py:class:: UdpSocket()
      
   .. py:method:: bind(port)
   
      Bind the socket to a specific port.

      Binding the socket to a port is necessary for being able to receive data on that port. You can use the special value Socket.ANYPORT to tell the system to automatically pick an available port, and then get the chosen port via the attribute local_port.
      
      :param integer port: Port to bind the socket to
      :rtype: sf.Socket.STATUS
      
   .. py:method:: unbind()
   
      Unbind the socket from the local port to which it is bound.

      The port that the socket was previously using is immediately available after this function is called. If the socket is not bound to a port, this function has no effect.
      
   .. py:method:: send(data, ip, port)

      Send raw data to a remote peer.

      Make sure that size is not greater than sf.UdpSocket.MAX_DATAGRAM_SIZE, otherwise this function will fail and no data will be sent.

      :param bytes data: The sequence of bytes to send 
      :param sf.IpAddress ip: Address of the receiver 
      :param integer port: Port of the receiver to send the data to
      :rtype: sf.Socket.STATUS
      
   .. py:method:: recieve(length)
         
      Receive raw data from a remote peer.

      In blocking mode, this function will wait until some bytes are actually received. Be careful to use a buffer which is large enough for the data that you intend to receive, if it is too small then an error will be returned and *all* the data will be lost.
         
      :param integer length: Maximum number of bytes that can be received
      :rtype: (sf.Socket.STATUS, bytes data, sf.IpAddress ip, integer port)
      
   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not connected, its value is 0.

.. py:class:: TcpListener()

   .. py:method:: listen(port)
   
      Start listening for connections.

      This functions makes the socket listen to the specified port, waiting for new connections. If the socket was previously listening to another port, it will be stopped first and bound to the new port.

      :param integer port: Port to listen for new connections
      :rtype: sf.Socket.STATUS
      
   .. py:method:: close()
   
      Stop listening and close the socket.

      This function gracefully stops the listener. If the socket is not listening, this function has no effect.
      
   .. py:method:: accept()
         
      Accept a new connection.

      If the socket is in blocking mode, this function will not return until a connection is actually received.
      
      :rtype: (sf.Socket.STATUS, sf.TcpSocket socket)
      
   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not listening to a port, its value is 0.
      

.. py:class:: SocketSelector()

   .. py:method:: add(socket)
         
      Add a new socket to the selector.
      
   .. py:method:: remove(socket)
   
      Remove a socket from the selector.
      
   .. py:method:: clear()
   
      Remove all the sockets stored in the selector.
       
   .. py:method:: wait([timeout=0])
   
      Wait until one or more sockets are ready to receive.

      This function returns as soon as at least one socket has some data available to be received. To know which sockets are ready, use the is_ready() function. If you use a timeout and no socket is ready before the timeout is over, the function returns false.

   .. py:method:: is_ready(socket)

      Test a socket to know if it is ready to receive data. 
   
      This function must be used after a call to wait(), to know which sockets are ready to receive data. If a socket is ready, a call to receive() will never block because we know that there is data available to read.
      Note that if this function returns true for a TcpListener, this means that it is ready to accept a new connection.


.. py:class:: FtpResponse()

      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | Status                         | Code | Description                                                                                             |
      +================================+======+=========================================================================================================+
      | RESTART_MARKER_REPLY           | 110  | Restart marker reply.                                                                                   |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | SERVICE_READY_SOON             | 120  | Service ready in N minutes.                                                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | DATA_CONNECTION_ALREADY_OPENED | 125  | Data connection already opened, transfer starting.                                                      |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | OPENING_DATA_CONNECTION        | 150  | File status ok, about to open data connection.                                                          |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | OK                             | 200  | Command ok.                                                                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | POINTLESS_COMMAND              | 202  | Command not implemented.                                                                                |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | SYSTEM_STATUS                  | 211  | System status, or system help reply.                                                                    |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | DIRECTORY_STATUS               | 212  | Directory status. .                                                                                     |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | FILE_STATUS                    | 213  | File status.                                                                                            |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | HELP_MESSAGE                   | 214  | Help message.                                                                                           |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | SYSTEM_TYPE                    | 215  | NAME system type, where NAME is an official system name from the list in the Assigned Numbers document. |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | SERVICE_READY                  | 220  | Service ready for new user.                                                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | CLOSING_CONNECTION             | 221  | Service closing control connection.                                                                     |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | DATA_CONNECTION_OPENED         | 225  | Data connection open, no transfer in progress.                                                          |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | CLOSING_DATA_CONNECTION        | 226  | Closing data connection, requested file action successful.                                              |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | ENTERING_PASSIVE_MODE          | 227  | Entering passive mode.                                                                                  |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | LOGGED_IN                      | 230  | User logged in, proceed. Logged out if appropriate.                                                     |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | FILE_ACTION_OK                 | 250  | Requested file action ok.                                                                               |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | DIRECTORY_OK                   | 257  | PATHNAME created.                                                                                       |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NEED_PASSWORD                  | 331  | User name ok, need password.                                                                            |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NEED_ACCOUNT_TO_LOG_IN         | 332  | Need account for login.                                                                                 |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NEED_INFORMATION               | 350  | Requested file action pending further information.                                                      |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | SERVICE_UNAVAILABLE            | 421  | Service not available, closing control connection.                                                      |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | DATA_CONNECTION_UNAVAILABLE    | 425  | Can't open data connection.                                                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | TRANSFER_ABORTED               | 426  | Connection closed, transfer aborted.                                                                    |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | FILE_ACTION_ABORTED            | 450  | Requested file action not taken.                                                                        | 
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | LOCAL_ERROR                    | 451  | Requested action aborted, local error in processing.                                                    |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | INSUFFICIENT_STORAGE_SPACE     | 452  | Requested action not taken; insufficient storage space in system, file unavailable.                     |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | COMMAND_UNKNOWN                | 500  | Syntax error, command unrecognized.                                                                     |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | PARAMETERS_UNKNOWN             | 501  | Syntax error in parameters or arguments.                                                                |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | COMMAND_NOT_IMPLEMENTED        | 502  | Command not implemented.                                                                                |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | BAD_COMMAND_SEQUENCE           | 503  | Bad sequence of commands.                                                                               |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | PARAMETER_NOT_IMPLEMENTED      | 504  | Command not implemented for that parameter.                                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NOT_LOGGED_IN                  | 530  | Not logged in.                                                                                          |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NEED_ACCOUNT_TO_STORE          | 532  | Need account for storing files.                                                                         |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | FILE_UNAVAILABLE               | 550  | Requested action not taken, file unavailable.                                                           |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | PAGE_TYPE_UNKNOWN              | 551  | Requested action aborted, page type unknown.                                                            |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | NOT_ENOUGH_MEMORY              | 552  | Requested file action aborted, exceeded storage allocation.                                             |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | FILENAME_NOT_ALLOWED           | 553  | Requested action not taken, file name not allowed.                                                      |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | INVALID_RESPONSE               | 1000 | Response is not a valid FTP one.                                                                        |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | CONNECTION_FAILED              | 1001 | Connection with server failed.                                                                          |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | CONNECTION_CLOSED              | 1002 | Connection with server closed.                                                                          |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+
      | INVALID_FILE                   | 1003 | Invalid file to upload / download.                                                                      |
      +--------------------------------+------+---------------------------------------------------------------------------------------------------------+

   .. py:attribute:: ok
         
      Check if the status code means a success.

      This function is defined for convenience, it is equivalent to testing if the status code is < 400.

   .. py:attribute:: status
   
      Get the status code of the response.
      
   .. py:attribute:: message
   
      Get the full message contained in the response.


.. py:class:: FtpDirectoryResponse()

   .. py:method:: get_directory()
   
.. py:class:: FtpListingResponse()

   .. py:method:: get_filenames()


.. py:class:: Ftp()

      +--------------+----------------------------------------------------------+
      | TransferMode | Description                                              |
      +==============+==========================================================+
      | BINARY       | Binary mode (file is transfered as a sequence of bytes). |
      +--------------+----------------------------------------------------------+
      | ASCII        | Text mode using ASCII encoding.                          |
      +--------------+----------------------------------------------------------+
      | EBCDIC       | Text mode using EBCDIC encoding.                         |
      +--------------+----------------------------------------------------------+
      
   .. py:method:: connect()
   
   .. py:method:: disconnect()
   
   .. py:method:: keep_alive()
   
   .. py:method:: get_working_directory()
   
   .. py:method:: get_directory_listing()
   
   .. py:method:: change_directory()
   
   .. py:method:: parent_directory()
   
   .. py:method:: create_directory()
   
   .. py:method:: delete_directory()
   
   .. py:method:: rename_file()
   
   .. py:method:: delete_file()
   
   .. py:method:: download()
   
   .. py:method:: upload()


.. py:class:: HttpRequest()

      +--------+----------------------------------------------------------+
      | Method | Description                                              |
      +========+==========================================================+
      | GET    | Request in get mode, standard method to retrieve a page. |
      +--------+----------------------------------------------------------+
      | POST   | Request in post mode, usually to send data to a page.    |
      +--------+----------------------------------------------------------+
      | HEAD   | Request a page's header only.                            |
      +--------+----------------------------------------------------------+
      
   .. py:attribute:: field
   
   .. py:attribute:: method
   
   .. py:attribute:: uri
   
   .. py:attribute:: http_version
   
   .. py:attribute:: body


.. py:class:: HttpResponse()

      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | Status                | Description                                                                                            |
      +=======================+========================================================================================================+
      | OK                    | Most common code returned when operation was successful.                                               |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | CREATED               | The resource has successfully been created.                                                            |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | ACCEPTED              | The request has been accepted, but will be processed later by the server.                              |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | NO_CONTENT            | The server didn't send any data in return.                                                             |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | RESET_CONTENT         | The server informs the client that it should clear the view (form) that caused the request to be sent. |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | PARTIAL_CONTENT       | The server has sent a part of the resource, as a response to a partial GET request.                    |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | MULTIPLE_CHOICES      | The requested page can be accessed from several locations.                                             |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | MOVED_PERMANENTLY     | The requested page has permanently moved to a new location.                                            |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | MOVED_TEMPORARILY     | The requested page has temporarily moved to a new location.                                            |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | NOT_MODIFIED          | For conditionnal requests, means the requested page hasn't changed and doesn't need to be refreshed.   |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | BAD_REQUEST           | The server couldn't understand the request (syntax error).                                             |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | UNAUTHORIZED          | The requested page needs an authentification to be accessed.                                           |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | FORBIDDEN             | The requested page cannot be accessed at all, even with authentification.                              |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | NOT_FOUND             | The requested page doesn't exist.                                                                      |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | RANGE_NOT_SATISFIABLE | The server can't satisfy the partial GET request (with a "Range" header field).                        |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | INTERNAL_SERVER_ERROR | The server encountered an unexpected error.                                                            |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | NOT_IMPLEMENTED       | The server doesn't implement a requested feature.                                                      |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | BAD_GATEWAY           | The gateway server has received an error from the source server.                                       |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | SERVICE_NOT_AVAILABLE | The server is temporarily unavailable (overloaded, in maintenance, ...).                               |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | GATEWAY_TIMEOUT       | The gateway server couldn't receive a response from the source server.                                 |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | VERSION_NOT_SUPPORTED | The server doesn't support the requested HTTP version.                                                 |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | INVALID_RESPONSE      | Response is not a valid HTTP one.                                                                      |
      +-----------------------+--------------------------------------------------------------------------------------------------------+
      | CONNECTION_FAILED     | Connection with server failed.                                                                         |
      +-----------------------+--------------------------------------------------------------------------------------------------------+

   .. py:attribute:: field
   
   .. py:attribute:: status
   
   .. py:attribute:: major_http_version
   
   .. py:attribute:: minor_http_version
   
   .. py:attribute:: body


.. py:class:: Http(host[, port=0])

   .. py:method:: send_request(request[, timeout=0])
