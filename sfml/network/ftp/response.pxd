# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cdef extern from "SFML/Graphics.hpp" namespace "sf::Ftp::Response":
    cdef cppclass Status
    
    int RestartMarkerReply
    int ServiceReadySoon
    int DataConnectionAlreadyOpened
    int OpeningDataConnection
    int Ok
    int PointlessCommand
    int SystemStatus
    int DirectoryStatus
    int FileStatus
    int HelpMessage
    int SystemType
    int ServiceReady
    int ClosingConnection
    int DataConnectionOpened
    int ClosingDataConnection
    int EnteringPassiveMode
    int LoggedIn
    int FileActionOk
    int DirectoryOk
    int NeedPassword
    int NeedAccountToLogIn
    int NeedInformation
    int ServiceUnavailable
    int DataConnectionUnavailable
    int TransferAborted
    int FileActionAborted
    int LocalError
    int InsufficientStorageSpace
    int CommandUnknown
    int ParametersUnknown
    int CommandNotImplemented
    int BadCommandSequence
    int ParameterNotImplemented
    int NotLoggedIn
    int NeedAccountToStore
    int FileUnavailable
    int PageTypeUnknown
    int NotEnoughMemory
    int FilenameNotAllowed
    int InvalidResponse
    int ConnectionFailed
    int ConnectionClosed
    int InvalidFile
