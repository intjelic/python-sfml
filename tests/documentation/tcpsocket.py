#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml as sf

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
