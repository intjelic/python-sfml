#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.network as sf


def run_tcp_server(port):
    """ Launch a server. The server waits for an incoming connection, 
    sends a message and waits for the answer. """
    
    # create a server socket to accept new connections
    listener = sf.TcpListener()
    
    # listen to the given port for incoming connections
    status = listener.listen(port)
    
    if status != sf.Socket.DONE:
        return
    print("Server is listening to port {0}, waiting for connections...".format(port))
    
    # wait for a connection
    status, socket = listener.accept()
    if status != sf.Socket.DONE:
        return
    print("Client connected: {0}".format(socket.remote_address))
    message = b"Hi, I'm the server"
    # send a message to the connected client
    status = socket.send(message)
    print("Message sent to the client: {0}".format(message))
    
    # recieve a message back from the client
    status, message = socket.receive(128)
    if status != sf.Socket.DONE:
        return
    print("Answer received from the client: {0}".format(message))

def run_tcp_client(port):
    """ Create a client. The client is connected to a server, displays 
    the welcome message and sends an answer. """
    
    server = input("Type the address or name of the server to connect to:").encode('UTF-8')
    server = sf.IpAddress.from_string(server)
    
    # create a socket for communicating with the server
    socket = sf.TcpSocket()
    
    # connect to the server
    status = socket.connect(server, port)
    if status != sf.Socket.DONE:
        return
    print("Connected to server {0}".format(server))
    
    # recieve a message from the server
    status, message = socket.receive(128)
    if status != sf.Socket.DONE:
        return
    print("Message received from the server: {0}".format(message))
    
    # send an answer to the server
    message = b"Hi, I'm a client"
    status = socket.send(message)
    if status != sf.Socket.DONE:
        return
    print("Message sent to the server: {0}".format(message))
    
    
def run_udp_server(port):
    """ Launch a server. The server waits for a message then sends an
    answer. """
    
    # create a socket to receive a message from anyone
    socket = sf.UdpSocket()
    
    # listen to messages on the specified port
    status = socket.bind(port)
    if status != sf.Socket.DONE:
        return
    print("Server is listening to port {0}, waiting for message...".format(port))
    
    # wait for a message
    status, data, ip, port = socket.receive(128)
    if status != sf.Socket.DONE:
        return
    print("Message received from client {0}: {1}".format(ip, data))
    
    # send an answer to the client
    message = b"Hi, I'm the server"
    status = socket.send(message)
    if status != sf.Socket.DONE:
        return
    print("Message sent to the client: {0}".format(message))

def run_udp_client(port):
    """ Send a message to the server, wait for the answer. """
    
    # ask for the server address
    server = input("Type the address or name of the server to connect to:").encode('UTF-8')
    server = sf.IpAddress.from_string(server)
    
    # create a socket for communicating with the server
    socket = sf.UdpSocket()
    
    # send a message to the server
    message = b"Hi, I'm a client"
    status = socket.send(message, server, port)
    if status != sf.Socket.DONE:
        return
    print("Message sent to the server: {0}".format(message))
    
    # receive an answer from anyone (but most likely from the server)
    status, data, ip, port = socket.receive(128)
    if status != sf.Socket.DONE:
        return
    print("Message received from {0}: {1}".format(ip, data))
    
if __name__ == "__main__":
    # choose an arbitrary port for opening sockets
    port = 50002
    
    # TCP or UDP ?
    print("Do you want to use TCP (t) or UDP (u) ?")
    protocol = input()
    
    # client or server ?
    print("Do you want to be a server (s) or a client (c) ?")
    who = input()
    
    if protocol == 't':
        if who == 's':
            run_tcp_server(port)
        else:
            run_tcp_client(port)
    else:
        if who == 's':
            run_udp_server(port)
        else:
            run_udp_client(port)
            
    input("Press any key to exit...")
