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

# create a listener socket and make it wait for new connections on port 55001
listener = sf.TcpListener()
listener.listen(55001)

# endless loop that waits for new connections
while running:
	try:
		client = listener.accept()
		
	except sf.SocketException as error:
		print("An error occured! Error: {0}".format(error))
		exit()
		
	# a new client just connected!
	print("New connectionreceived from {0}".format(client.remote_address))
	do_something_with(client)
