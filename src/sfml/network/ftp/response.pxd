#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cdef extern from "SFML/Graphics.hpp" namespace "sf::Ftp::Response":
	cdef enum Status:
		RestartMarkerReply
		ServiceReadySoon
		DataConnectionAlreadyOpened
		OpeningDataConnection
		Ok
		PointlessCommand
		SystemStatus
		DirectoryStatus
		FileStatus
		HelpMessage
		SystemType
		ServiceReady
		ClosingConnection
		DataConnectionOpened
		ClosingDataConnection
		EnteringPassiveMode
		LoggedIn
		FileActionOk
		DirectoryOk
		NeedPassword
		NeedAccountToLogIn
		NeedInformation
		ServiceUnavailable
		DataConnectionUnavailable
		TransferAborted
		FileActionAborted
		LocalError
		InsufficientStorageSpace
		CommandUnknown
		ParametersUnknown
		CommandNotImplemented
		BadCommandSequence
		ParameterNotImplemented
		NotLoggedIn
		NeedAccountToStore
		FileUnavailable
		PageTypeUnknown
		NotEnoughMemory
		FilenameNotAllowed
		InvalidResponse
		ConnectionFailed
		ConnectionClosed
		InvalidFile
