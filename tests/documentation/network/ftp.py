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

# create a new FTP client
ftp = sf.Ftp()

# connect to the server
response = ftp.connect(sf.IpAddress.from_string("ftp.myserver.com"))
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
response = ftp.upload("local-path/file.txt", "files", sf.Ftp.ASCII)
if response.ok: print("File uploaded")

# disconnect from the server (optional)
ftp.disconnect()
