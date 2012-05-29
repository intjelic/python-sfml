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
