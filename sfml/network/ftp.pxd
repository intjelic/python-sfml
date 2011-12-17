from libcpp.vector cimport vector

cdef extern from "SFML/Graphics.hpp" namespace "sf::Ftp::Response":
    cdef cppclass Status:
        pass
        
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
    
cdef extern from "SFML/Network.hpp" namespace "sf::Ftp":
    cdef cppclass TransferMode:
        pass
        
    int Binary
    int Ascii
    int Ebcdic
    
    cdef cppclass Response:
        Response(Status code, char* &message)
        bint IsOk()
        Status GetStatus()
        char* & GetMessage()
    
    cdef cppclass DirectoryResponse:
        DirectoryResponse(Response &response)
        char* & GetDirectory()     
        
    cdef cppclass ListingResponse:
        ListingResponse (Response &response, vector[char] &data)
        vector[char*] &	GetFilenames ()
    
