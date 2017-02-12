# PySFML - Python bindings for SFML
# Copyright (c) 2012-2017, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This file is part of PySFML project and is available under the zlib
# license.

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
