Network
=======
.. contents:: :local:
.. py:module:: sfml.network

IpAddress
^^^^^^^^^

.. class:: IpAddress()

   Encapsulate an IPv4 network address.
   
   :class:`sfml.network.IpAddress` is an utility class for manipulating network 
   addresses.
   
   It provides a set of class methods and conversion attributes to 
   easily build or transform an IP address from/to various 
   representations.

   Usage example::
   
      ip0 = sfml.network.IpAddress()                             # an invalid address
      ip1 = sfml.network.IpAddress.NONE                          # an invalid address (same as ip0)
      ip2 = sfml.network.IpAddress.from_string("127.0.0.1")      # the local host address
      ip3 = sfml.network.IpAddress.BROADCAST                     # the broadcast address
      ip4 = sfml.network.IpAddress.from_bytes(192, 168, 1, 56)   # a local address
      ip5 = sfml.network.IpAddress.from_string("my_computer")    # a local address created from a network name
      ip6 = sfml.network.IpAddress.from_string("89.54.1.169")    # a distant address
      ip7 = sfml.network.IpAddress.from_string("www.google.com") # a distant address created from a network name
      ip8 = sfml.network.IpAddress.get_local_address()           # my address on the local network
      ip9 = sfml.network.IpAddress.get_public_address()          # my address on the internet

   Note that :class:`sfml.network.IpAddress` currently doesn't support IPv6 nor 
   other types of network addresses.

   .. py:data:: NONE
   
      Value representing an empty/invalid address. 

   .. py:data:: LOCAL_HOST

      The "localhost" address (for connecting a computer to itself 
      locally) 
      
   .. py:data:: BROADCAST

      The "broadcast" address (for sending UDP messages to everyone on 
      a local network) 
	
   .. classmethod:: from_string(string)

      Construct the address from a string.

      Here address can be either a decimal address (ex: "192.168.1.56") 
      or a network name (ex: "localhost").
      
      :param string string: IP address or network name
      :rtype: :class:`sfml.network.IpAddress`
      
   .. classmethod:: from_integer(integer)
   
      Construct the address from an integer.

      This constructor uses the internal representation of the address 
      directly. It should be used for optimization purposes, and only 
      if you got that representation from :attr:`IpAddress.integer`.

      :param integer integer: 4 bytes of the address packed into a 32-bits integer
      :rtype: :class:`sfml.network.IpAddress`

   .. classmethod:: from_bytes(b0, b1, b2, b3)
      
      Construct the address from 4 bytes.

      Calling IpAddress.from_bytes(a, b, c, d) is equivalent to calling 
      IpAddress.from_string("a.b.c.d"), but safer as it doesn't have to 
      parse a string to get the address components.
      
      :param integer b0: First byte of the address 
      :param integer b1: Second byte of the address 
      :param integer b2: Third byte of the address 
      :param integer b3: Fourth byte of the address 
      :rtype: sfml.network.IpAddress
      
   .. attribute:: string
         
      Get a string representation of the address.

      The returned string is the decimal representation of the IP 
      address (like "192.168.1.56"), even if it was constructed from a 
      host name.

      :type: string 
      
   .. attribute:: integer
         
      Get an integer representation of the address.

      The returned number is the internal representation of the 
      address, and should be used for optimization purposes only (like 
      sending the address through a socket). The integer produced by 
      this function can then be converted back to a 
      :class:`sfml.network.IpAddress` with the proper constructor.

      :type: integer
      
   .. classmethod:: get_local_address()
   
      Get the computer's local address.

      The local address is the address of the computer from the LAN 
      point of view, i.e. something like 192.168.1.56. It is meaningful 
      only for communications over the local network. Unlike 
      :func:`get_public_address`, this function is fast and may be used 
      safely anywhere.

      :rtype: :class:`sfml.network.IpAddress`
      
   .. classmethod:: get_public_address([time])
         
      Get the computer's public address.

      The public address is the address of the computer from the 
      internet point of view, i.e. something like 89.54.1.169. It is 
      necessary for communications over the world wide web. The only 
      way to get a public address is to ask it to a distant website; as 
      a consequence, this function depends on both your network 
      connection and the server, and may be very slow. You should use 
      it as few as possible. Because this function depends on the 
      network connection and on a distant server, you may use a time 
      limit if you don't want your program to be possibly stuck waiting 
      in case there is a problem; this limit is deactivated by default.

      :param sfml.system.Time time: Maximum time to wait
      :rtype: :class:`sfml.network.IpAddress`


Socket
^^^^^^

.. py:class:: Socket()

      Base class for all the socket types.

      This class mainly defines internal stuff to be used by derived 
      classes.

      The only public features that it defines, and which is therefore 
      common to all the socket classes, is the blocking state. 
      All sockets can be set as blocking or non-blocking.

      In blocking mode, socket functions will hang until the operation 
      completes, which means that the entire program (well, in fact the 
      current thread if you use multiple ones) will be stuck waiting 
      for your socket operation to complete.

      In non-blocking mode, all the socket functions will return 
      immediately. If the socket is not ready to complete the requested 
      operation, the function simply returns the proper status code 
      (:const:`Socket.NOT_READY`).

      The default mode, which is blocking, is the one that is generally 
      used, in combination with threads or selectors. The non-blocking 
      mode is rather used in real-time applications that run an endless 
      loop that can poll the socket often enough, and cannot afford 
      blocking this loop.

   .. py:data:: DONE
   
      The socket has sent / received the data.
      
   .. py:data:: NOT_READY
   
      The socket is not ready to send / receive data yet.
      
   .. py:data:: DISCONNECTED
   
      The TCP socket has been disconnected.
      
   .. py:data:: ERROR

      An unexpected error happened.
      
   .. py:data:: ANY_PORT
   
      Special value that tells the system to pick any available port. 
      
   .. py:attribute:: blocking
   
         The socket's blocking state; blocking or non-blocking.

      :type: bool
      

TcpSocket
^^^^^^^^^

.. py:class:: TcpSocket(Socket)

      Specialized socket using the TCP protocol.

      TCP is a connected protocol, which means that a TCP socket can 
      only communicate with the host it is connected to.

      It can't send or receive anything if it is not connected.

      The TCP protocol is reliable but adds a slight overhead. It 
      ensures that your data will always be received in order and 
      without errors (no data corrupted, lost or duplicated).

      When a socket is connected to a remote host, you can retrieve 
      informations about this host with the :attr:`remote_address` and 
      :attr:`remote_port attributes`. You can also get the local port 
      to which the socket is bound (which is automatically chosen when 
      the socket is connected), with the :attr:`local_port` attribute.

      Sending and receiving data can use only the low-level functions. 
      The low-level functions process a raw sequence of bytes, 
      and cannot ensure that one call to :func:`send` will exactly 
      match one call to :func:`receive` at the other end of the socket.

      The high-level interface is not implemented yet.
      
      The socket is automatically disconnected when it is destroyed, 
      but if you want to explicitely close the connection while the 
      socket instance is still alive, you can call disconnect.

      Usage example::
      
         # --- the client ---
         # create a socket and connect it to 192.168.1.50 on port 55001
         socket = sfml.network.TcpSocket()
         socket.connect(sfml.network.IpAddress.from_string("192.168.1.50"), 55001)


         # send a message to the connected host
         message = "Hi, I am a client".encode('utf-8')
         socket.send(message)

         # receive an answer from the server
         answer = socket.receive(1024)
         print("The server said: {0}".format(answer.decode('utf-8')))


         # --- the server ---
         # create a listener to wait for incoming connections on port 55001
         listener = sfml.network.TcpListener()
         listener.listen(55001)

         # wait for a connection
         socket = listener.accept(socket)
         print("New client connected: {0}".format(socket.remote_address))

         # receive a message from the client
         message = socket.receive(1024)
         print("The client said: {0}".format(message.decode('utf-8')))

         # send an answer
         socket.send("Welcome, client".encode('utf-8'))
         
   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not connected, its value is 0.
      
      :type: integer
      
   .. py:attribute:: remote_address
   
      The address of the connected peer.
      
      It the socket is not connected, its value 
      :const:`sfml.network.IpAddress.NONE`.
      
      :type: :class:`sfml.network.IpAddress`
      
   .. py:attribute:: remote_port
   
      The port of the connected peer to which the socket is connected.
      
      If the socket is not connected, its value is 0.

      :type: integer
      
   .. py:method:: connect(remote_address, remote_port[, timeout])
   
      Connect the socket to a remote peer.
      
      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      In blocking mode, this function may take a while, especially if 
      the remote peer is not reachable. The last parameter allows you 
      to stop trying to connect after a given timeout. If the socket 
      was previously connected, it is first disconnected.
      
      :param sfml.network.IpAddress remote_address: Address of the remote peer 
      :param integer remote_port: Port of the remote peer 
      :param sfml.system.Time timeout: Optional maximum time to wait

   .. py:method:: disconnect()
   
      Disconnect the socket from its remote peer.
      
      This function gracefully closes the connection. If the socket is 
      not connected, this function has no effect.
      
   .. py:method:: send(data)
   
      Send raw data to the remote peer.
      
      This function will fail if the socket is not connected.

      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      :param bytes data: The sequence of bytes to send 
      
   .. py:method:: receive(size)
   
      Receive raw data from the remote peer.
      
      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      In blocking mode, this function will wait until some bytes are actually received. This function will fail if the socket is not connected.
      
      .. note:: The recieved data's length may be different from the asked length.
      
      :param integer size: Maximum number of bytes that can be received
      :return: A sequence of bytes
      :rtype: bytes


UdpSocket
^^^^^^^^^

.. py:class:: UdpSocket(Socket)
      
   Specialized socket using the UDP protocol.

   A UDP socket is a connectionless socket.

   Instead of connecting once to a remote host, like TCP sockets, it 
   can send to and receive from any host at any time.

   It is a datagram protocol: bounded blocks of data (datagrams) are 
   transfered over the network rather than a continuous stream of data 
   (TCP). Therefore, one call to send will always match one call to 
   receive (if the datagram is not lost), with the same data that was 
   sent.

   The UDP protocol is lightweight but unreliable. Unreliable means 
   that datagrams may be duplicated, be lost or arrive reordered. 
   However, if a datagram arrives, its data is guaranteed to be valid.

   UDP is generally used for real-time communication (audio or video 
   streaming, real-time games, etc.) where speed is crucial and lost 
   data doesn't matter much.

   Sending and receiving data can only use the low-level functions. The 
   low-level functions process a raw sequence of bytes. The high-level
   method is not implemented.
   
   It is important to note that :class:`sfml.network.UdpSocket` is unable to send 
   datagrams bigger than :attr:`MAX_DATAGRAM_SIZE`. In this case, it 
   returns an error and doesn't send anything.

   If the socket is bound to a port, it is automatically unbound from 
   it when the socket is destroyed. However, you can unbind the socket 
   explicitely with the :func:`unbind` function if necessary, to stop 
   receiving messages or make the port available for other sockets.

   Usage example::
   
      # --- the client ---
      # create a socket and bind it to the port 55001
      socket = sfml.network.UdpSocket()
      socket.bind(55001)

      # send a message to 192.168.1.50 on port 55002
      message = "Hi, I am {0}".format(sfml.network.IpAddress.get_local_address().string)
      socket.send(message.encode('utf-8'), sfml.network.IpAddress.from_string("192.168.1.50"), 55002)

      # receive an answer (most likely from 192.168.1.50, but could be anyone else)
      answer, sender, port = socket.receive(1024)
      print("{0} said: {1}".format(sender.string, answer.decode('utf-8')))

      # --- the server ---
      # create a socket and bind it to the port 55002
      socket = sfml.network.UdpSocket()
      socket.bind(55002)

      # receive a message from anyone
      message, sender, port = socket.receive(1024)
      print("{0} said: {1}".format(ip.string, message.decode('utf-8')))

      # send an answer
      answer = "Welcome {0}".format(sender.string)
      socket.send(answer, sender, port)

   .. py:data:: MAX_DATAGRAM_SIZE
      
      The maximum number of bytes that can be sent in a single UDP datagram.
      
   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not connected, its value is 0.

      :type: integer
      
   .. py:method:: bind(port)
   
      Bind the socket to a specific port.

      Binding the socket to a port is necessary for being able to 
      receive data on that port. You can use the special value 
      :attr:`Socket.ANY_PORT` to tell the system to automatically pick an 
      available port, and then get the chosen port via the attribute 
      local_port.
      
      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      :param integer port: Port to bind the socket to
      
   .. py:method:: unbind()
   
      Unbind the socket from the local port to which it is bound.

      The port that the socket was previously using is immediately 
      available after this function is called. If the socket is not 
      bound to a port, this function has no effect.
      
   .. py:method:: send(data, remote_address, port)

      Send raw data to a remote peer.

      Make sure that size is not greater than 
      :attr:`UdpSocket.MAX_DATAGRAM_SIZE`, otherwise this function will 
      fail and no data will be sent.

      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      :param bytes data: The sequence of bytes to send 
      :param sfml.network.IpAddress remote_address: Address of the receiver 
      :param integer port: Port of the receiver to send the data to
      
   .. py:method:: receive(size)
         
      Receive raw data from a remote peer.

      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      In blocking mode, this function will wait until some bytes are 
      actually received. Be careful to use a buffer which is large 
      enough for the data that you intend to receive, if it is too 
      small then an error will be returned and *all* the data will 
      be lost.
         
      :param integer size: Maximum number of bytes that can be received
      :return: A tuple with the sequence of bytes received, the remote address and the port used.
      :rtype: tuple (bytes, sfml.network.IpAddress, integer)
      

TcpListener
^^^^^^^^^^^

.. py:class:: TcpListener(Socket)

   :class:`Socket` that listens to new TCP connections.

   A listener socket is a special type of socket that listens to a 
   given port and waits for connections on that port.

   This is all it can do.

   When a new connection is received, you must call accept and the 
   listener returns a new instance of :class:`sfml.network.TcpSocket` that is 
   properly initialized and can be used to communicate with the new 
   client.

   Listener sockets are specific to the TCP protocol, UDP sockets are 
   connectionless and can therefore communicate directly. As a 
   consequence, a listener socket will always return the new 
   connections as sfml.network.TcpSocket instances.

   A listener is automatically closed on destruction, like all other 
   types of socket. However if you want to stop listening before the 
   socket is destroyed, you can call its :func:`close()` function.

   Usage example::
   
      # create a listener socket and make it wait for new connections on port 55001
      listener = sfml.network.TcpListener()
      listener.listen(55001)

      # endless loop that waits for new connections
      while running:
         try:
            client = listener.accept()
            
         except sfml.network.SocketException as error:
            print("An error occured! Error: {0}".format(error))
            exit()
            
         # a new client just connected!
         print("New connectionreceived from {0}".format(client.remote_address))
         do_something_with(client)

   .. py:attribute:: local_port
   
      The port to which the socket is bound locally.

      If the socket is not listening to a port, its value is 0.
      
      :type: integer
      
   .. py:method:: listen(port)
   
      Start listening for connections.

      This functions makes the socket listen to the specified port, 
      waiting for new connections. If the socket was previously 
      listening to another port, it will be stopped first and bound to 
      the new port.

      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      :param integer port: Port to listen for new connections
      
   .. py:method:: close()
   
      Stop listening and close the socket.

      This function gracefully stops the listener. If the socket is not 
      listening, this function has no effect.
      
   .. py:method:: accept()
         
      Accept a new connection.

      If the socket is in blocking mode, this function will not return 
      until a connection is actually received.
      
      This method raises an exception if something bad happened. 
      If the TCP socket has been disconnected, it will raise 
      sfml.network.SocketDisconnected. 
      If the socket is not ready to send/receive data yet, it will raise
      sfml.network.SocketNotReady. 
      If an unexpected error happened, it will raise sfml.network.SocketError. 
      You may want to catch any of them in one except statement, in 
      this case, you'll use sfml.network.SocketException which is their base.
      
      :return: :class:`Socket` that holds the new connection
      :rtype: :class:`sfml.network.TcpSocket`

SocketException
^^^^^^^^^^^^^^^

.. py:exception:: SocketException(Exception)
.. py:exception:: SocketNotReady(SocketException)
.. py:exception:: SocketDisconnect(SocketException)
.. py:exception:: SocketError(SocketException)

SocketSelector
^^^^^^^^^^^^^^

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



Ftp
^^^

.. py:class:: FtpResponse()

      Define a FTP response.
      
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

      This function is defined for convenience, it is equivalent to 
      testing if the status code is < 400.

   .. py:attribute:: status
   
      Get the status code of the response.
      
   .. py:attribute:: message
   
      Get the full message contained in the response.


.. py:class:: FtpDirectoryResponse(FtpResponse)

   .. py:method:: get_directory()
   
      Get the directory returned in the response.
      
      :rtype: str
   
.. py:class:: FtpListingResponse(FtpResponse)

   .. py:method:: get_filenames()

      :rtype: str

.. py:class:: Ftp()

      A FTP client.

      sf::Ftp is a very simple FTP client that allows you to communicate with a FTP server.

      The FTP protocol allows you to manipulate a remote file system (list files, upload, download, create, remove, ...).

      Using the FTP client consists of 4 parts:

          Connecting to the FTP server
          Logging in (either as a registered user or anonymously)
          Sending commands to the server
          Disconnecting (this part can be done implicitely by the destructor)

      Every command returns a FTP response, which contains the status code as well as a message from the server. Some commands such as getWorkingDirectory and getDirectoryListing return additional data, and use a class derived from sf::Ftp::Response to provide this data.

      All commands, especially upload and download, may take some time to complete. This is important to know if you don't want to block your application while the server is completing the task.

      Usage example::
         
         # create a new FTP client
         ftp = sfml.network.Ftp()

         # connect to the server
         response = ftp.connect(sfml.network.IpAddress.from_string("ftp.myserver.com"))
         if response.ok: print("Connected")

         # log in
         response = ftp.login("login", "password");
         if response.ok: print("Logged in")

         # print the working directory
         directory_response = ftp.get_working_directory()
         if directory_response.ok: print("Working directory: {0}".format(directory_response.direcotry))

         # create a new directory
         response = ftp.create_directory("files")
         if response.ok: print("Created new directory")

         # upload a file to this new directory
         response = ftp.upload("local-path/file.txt", "files", sfml.network.Ftp.ASCII)
         if response.ok: print("File uploaded")

         # disconnect from the server (optional)
         ftp.disconnect()

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



HTTP
^^^^

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
