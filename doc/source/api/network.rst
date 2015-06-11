Network
=======
.. module:: sfml.network
.. contents:: :local:

IpAddress
^^^^^^^^^

.. class:: IpAddress()

   Encapsulate an IPv4 network address.

   :class:`IpAddress` is an utility class for manipulating network
   addresses.

   It provides a set of class methods and conversion attributes to
   easily build or transform an IP address from/to various
   representations.

   Usage example::

      ip0 = sf.IpAddress()                             # an invalid address
      ip1 = sf.IpAddress.NONE                          # an invalid address (same as ip0)
      ip2 = sf.IpAddress.from_string("127.0.0.1")      # the local host address
      ip3 = sf.IpAddress.BROADCAST                     # the broadcast address
      ip4 = sf.IpAddress.from_bytes(192, 168, 1, 56)   # a local address
      ip5 = sf.IpAddress.from_string("my_computer")    # a local address created from a network name
      ip6 = sf.IpAddress.from_string("89.54.1.169")    # a distant address
      ip7 = sf.IpAddress.from_string("www.google.com") # a distant address created from a network name
      ip8 = sf.IpAddress.get_local_address()           # my address on the local network
      ip9 = sf.IpAddress.get_public_address()          # my address on the internet

   Note that :class:`IpAddress` currently doesn't support IPv6 nor
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

      :param str string: IP address or network name
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
      :class:`IpAddress` with the proper constructor.

      :type: integer

   .. classmethod:: get_local_address()

      Get the computer's local address.

      The local address is the address of the computer from the LAN
      point of view, i.e. something like 192.168.1.56. It is meaningful
      only for communications over the local network. Unlike
      :func:`get_public_address`, this function is fast and may be used
      safely anywhere.

      :rtype: :class:`sfml.network.IpAddress`

   .. classmethod:: get_public_address([timeout])

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

      :param sfml.system.Time timeout: Maximum time to wait
      :rtype: :class:`sfml.network.IpAddress`

SocketException
^^^^^^^^^^^^^^^
.. py:exception:: SocketException(Exception)

   Main exception defined for all socket exceptions. Most of socket's
   method can potentially raise one of the three following exceptions
   and you'll use this one to catch any of them in one except statement.

.. py:exception:: SocketDisconnected(SocketException)

   In **blocking mode**, the socket may raise this exception to warm
   you it has been disconnected.

.. py:exception:: SocketNotReady(SocketException)

   In **non-blocking mode**, the socket will raise this exception if
   the socket is not ready to send/receive data yet.

.. py:exception:: SocketError(SocketException)

   In ** blocking mode**, the socket may raise this exception to warm
   you an unexpected error happened.


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
      operation, the function simply raises the exception :exc:`SocketNotReady`.

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
      :attr:`remote_port` attributes. You can also get the local port
      to which the socket is bound (which is automatically chosen when
      the socket is connected), with the :attr:`local_port` attribute.

      Sending and receiving data can use only the low-level functions.
      The low-level functions process a raw sequence of bytes,
      and cannot ensure that one call to :func:`send` will exactly
      match one call to :func:`receive` at the other end of the socket.

      The high-level interface is not implemented yet.

      The socket is automatically disconnected when it is destroyed,
      but if you want to explicitly close the connection while the
      socket instance is still alive, you can call disconnect.

      Usage example::

         # --- the client ---
         # create a socket and connect it to 192.168.1.50 on port 55001
         socket = sf.TcpSocket()
         socket.connect(sf.IpAddress.from_string("192.168.1.50"), 55001)


         # send a message to the connected host
         message = "Hi, I am a client".encode('utf-8')
         socket.send(message)

         # receive an answer from the server
         answer = socket.receive(1024)
         print("The server said: {0}".format(answer.decode('utf-8')))


         # --- the server ---
         # create a listener to wait for incoming connections on port 55001
         listener = sf.TcpListener()
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
      :const:`IpAddress.NONE`.

      :type: :class:`sfml.network.IpAddress`

   .. py:attribute:: remote_port

      The port of the connected peer to which the socket is connected.

      If the socket is not connected, its value is 0.

      :type: integer

   .. py:method:: connect(remote_address, remote_port[, timeout])

      Connect the socket to a remote peer.

      In blocking mode, this function may take a while, especially if
      the remote peer is not reachable. The last parameter allows you
      to stop trying to connect after a given timeout. If the socket
      was previously connected, it is first disconnected.

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
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

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
      :param bytes data: The sequence of bytes to send

   .. py:method:: receive(size)

      Receive raw data from the remote peer.

      In blocking mode, this function will wait until some bytes are
      actually received. This function will fail if the socket is not
      connected.

      .. note::

         The received data's length may be different from the asked length.

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
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
   transferred over the network rather than a continuous stream of data
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

   It is important to note that :class:`UdpSocket` is unable to send
   datagrams bigger than :attr:`MAX_DATAGRAM_SIZE`. In this case, it
   returns an error and doesn't send anything.

   If the socket is bound to a port, it is automatically unbound from
   it when the socket is destroyed. However, you can unbind the socket
   explicitly with the :func:`unbind` function if necessary, to stop
   receiving messages or make the port available for other sockets.

   Usage example::

      # --- the client ---
      # create a socket and bind it to the port 55001
      socket = sf.UdpSocket()
      socket.bind(55001)

      # send a message to 192.168.1.50 on port 55002
      message = "Hi, I am {0}".format(sf.IpAddress.get_local_address().string)
      socket.send(message.encode('utf-8'), sf.IpAddress.from_string("192.168.1.50"), 55002)

      # receive an answer (most likely from 192.168.1.50, but could be anyone else)
      answer, sender, port = socket.receive(1024)
      print("{0} said: {1}".format(sender.string, answer.decode('utf-8')))

      # --- the server ---
      # create a socket and bind it to the port 55002
      socket = sf.UdpSocket()
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

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
      :param integer port: Port to bind the socket to

   .. py:method:: unbind()

      Unbind the socket from the local port to which it is bound.

      The port that the socket was previously using is immediately
      available after this function is called. If the socket is not
      bound to a port, this function has no effect.

   .. py:method:: send(data, remote_address, port)

      Send raw data to a remote peer.

      Make sure that size is not greater than
      :attr:`MAX_DATAGRAM_SIZE`, otherwise this function will
      fail and no data will be sent.

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
      :param bytes data: The sequence of bytes to send
      :param sfml.network.IpAddress remote_address: Address of the receiver
      :param integer port: Port of the receiver to send the data to

   .. py:method:: receive(size)

      Receive raw data from a remote peer.

      In blocking mode, this function will wait until some bytes are
      actually received. Be careful to use a buffer which is large
      enough for the data that you intend to receive, if it is too
      small then an error will be returned and *all* the data will
      be lost.

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
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
   listener returns a new instance of :class:`TcpSocket` that is
   properly initialized and can be used to communicate with the new
   client.

   Listener sockets are specific to the TCP protocol, UDP sockets are
   connectionless and can therefore communicate directly. As a
   consequence, a listener socket will always return the new
   connections as :class:`TcpSocket` instances.

   A listener is automatically closed on destruction, like all other
   types of socket. However if you want to stop listening before the
   socket is destroyed, you can call its :func:`close()` function.

   Usage example::

      # create a listener socket and make it wait for new connections on port 55001
      listener = sf.TcpListener()
      listener.listen(55001)

      # endless loop that waits for new connections
      while running:
         try:
            client = listener.accept()

         except sf.SocketException as error:
            print("An error occurred! Error: {0}".format(error))
            exit(1)

         # a new client just connected!
         print("New connection received from {0}".format(client.remote_address))
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

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
      :param integer port: Port to listen for new connections

   .. py:method:: close()

      Stop listening and close the socket.

      This function gracefully stops the listener. If the socket is not
      listening, this function has no effect.

   .. py:method:: accept()

      Accept a new connection.

      If the socket is in blocking mode, this function will not return
      until a connection is actually received.

      :raise: :exc:`SocketDisconnected`, :exc:`SocketNotReady` or :exc:`SocketError`
      :return: :class:`Socket` that holds the new connection
      :rtype: :class:`sfml.network.TcpSocket`
