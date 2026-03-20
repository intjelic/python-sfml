from __future__ import annotations

from typing import Any, ClassVar

from .system import Time


def __getattr__(name: str) -> Any: ...


class IpAddress:
    ANY: ClassVar[IpAddress]
    NONE: ClassVar[IpAddress]
    LOCAL_HOST: ClassVar[IpAddress]
    BROADCAST: ClassVar[IpAddress]

    def __init__(self) -> None: ...
    @classmethod
    def from_string(cls, string: str) -> IpAddress: ...
    @classmethod
    def from_integer(cls, address: int) -> IpAddress: ...
    @classmethod
    def from_bytes(cls, b1: int, b2: int, b3: int, b4: int) -> IpAddress: ...
    @property
    def string(self) -> bytes: ...
    @property
    def integer(self) -> int: ...
    @classmethod
    def get_local_address(cls) -> IpAddress | None: ...
    @classmethod
    def get_public_address(cls, timeout: Time | None = None) -> IpAddress | None: ...


class Socket:
    DONE: ClassVar[int]
    NOT_READY: ClassVar[int]
    PARTIAL: ClassVar[int]
    DISCONNECTED: ClassVar[int]
    ERROR: ClassVar[int]
    ANY_PORT: ClassVar[int]

    @property
    def blocking(self) -> bool: ...
    @blocking.setter
    def blocking(self, blocking: bool) -> None: ...
    def __getattr__(self, name: str) -> Any: ...


class SocketException(Exception): ...


class SocketNotReady(SocketException): ...


class SocketDisconnected(SocketException): ...


class SocketError(SocketException): ...


class TcpListener(Socket):
    @property
    def local_port(self) -> int: ...
    def listen(self, port: int, address: IpAddress | None = None) -> None: ...
    def close(self) -> None: ...
    def accept(self) -> TcpSocket: ...


class TcpSocket(Socket):
    @property
    def local_port(self) -> int: ...
    @property
    def remote_address(self) -> IpAddress: ...
    @property
    def remote_port(self) -> int: ...
    def connect(
        self,
        remote_address: IpAddress,
        remote_port: int,
        timeout: Time | None = None,
    ) -> None: ...
    def disconnect(self) -> None: ...
    def send(self, data: bytes) -> int: ...
    def receive(self, size: int) -> bytes: ...


class UdpSocket(Socket):
    MAX_DATAGRAM_SIZE: ClassVar[int]

    @property
    def local_port(self) -> int: ...
    def bind(self, port: int, address: IpAddress | None = None) -> None: ...
    def unbind(self) -> None: ...
    def send(self, data: bytes, remote_address: IpAddress, remote_port: int) -> None: ...
    def receive(self, size: int) -> tuple[bytes, IpAddress, int]: ...


class SocketSelector:
    def add(self, socket: Socket) -> None: ...
    def remove(self, socket: Socket) -> None: ...
    def clear(self) -> None: ...
    def wait(self, timeout: Time | None = None) -> bool: ...
    def is_ready(self, socket: Socket) -> bool: ...


class FtpResponse:
    RESTART_MARKER_REPLY: ClassVar[int]
    SERVICE_READY_SOON: ClassVar[int]
    DATA_CONNECTION_ALREADY_OPENED: ClassVar[int]
    OPENING_DATA_CONNECTION: ClassVar[int]
    OK: ClassVar[int]
    POINTLESS_COMMAND: ClassVar[int]
    SYSTEM_STATUS: ClassVar[int]
    DIRECTORY_STATUS: ClassVar[int]
    FILE_STATUS: ClassVar[int]
    HELP_MESSAGE: ClassVar[int]
    SYSTEM_TYPE: ClassVar[int]
    SERVICE_READY: ClassVar[int]
    CLOSING_CONNECTION: ClassVar[int]
    DATA_CONNECTION_OPENED: ClassVar[int]
    CLOSING_DATA_CONNECTION: ClassVar[int]
    ENTERING_PASSIVE_MODE: ClassVar[int]
    LOGGED_IN: ClassVar[int]
    FILE_ACTION_OK: ClassVar[int]
    DIRECTORY_OK: ClassVar[int]
    NEED_PASSWORD: ClassVar[int]
    NEED_ACCOUNT_TO_LOG_IN: ClassVar[int]
    NEED_INFORMATION: ClassVar[int]
    SERVICE_UNAVAILABLE: ClassVar[int]
    DATA_CONNECTION_UNAVAILABLE: ClassVar[int]
    TRANSFER_ABORTED: ClassVar[int]
    FILE_ACTION_ABORTED: ClassVar[int]
    LOCAL_ERROR: ClassVar[int]
    INSUFFICIENT_STORAGE_SPACE: ClassVar[int]
    COMMAND_UNKNOWN: ClassVar[int]
    PARAMETERS_UNKNOWN: ClassVar[int]
    COMMAND_NOT_IMPLEMENTED: ClassVar[int]
    BAD_COMMAND_SEQUENCE: ClassVar[int]
    PARAMETER_NOT_IMPLEMENTED: ClassVar[int]
    NOT_LOGGED_IN: ClassVar[int]
    NEED_ACCOUNT_TO_STORE: ClassVar[int]
    FILE_UNAVAILABLE: ClassVar[int]
    PAGE_TYPE_UNKNOWN: ClassVar[int]
    NOT_ENOUGH_MEMORY: ClassVar[int]
    FILENAME_NOT_ALLOWED: ClassVar[int]
    INVALID_RESPONSE: ClassVar[int]
    CONNECTION_FAILED: ClassVar[int]
    CONNECTION_CLOSED: ClassVar[int]
    INVALID_FILE: ClassVar[int]
    @property
    def ok(self) -> bool: ...
    @property
    def status(self) -> int: ...
    @property
    def message(self) -> bytes: ...


class FtpDirectoryResponse(FtpResponse):
    def get_directory(self) -> bytes: ...


class FtpListingResponse(FtpResponse):
    @property
    def filenames(self) -> tuple[bytes, ...]: ...


class Ftp:
    BINARY: ClassVar[int]
    ASCII: ClassVar[int]
    EBCDIC: ClassVar[int]

    def connect(
        self,
        server: IpAddress,
        port: int = 21,
        timeout: Time | None = None,
    ) -> FtpResponse: ...
    def disconnect(self) -> FtpResponse: ...
    def login(self, name: str | None = None, password: str = "") -> FtpResponse: ...
    def keep_alive(self) -> FtpResponse: ...
    def get_working_directory(self) -> FtpDirectoryResponse: ...
    def get_directory_listing(self, directory: str = "") -> FtpListingResponse: ...
    def change_directory(self, directory: str) -> FtpResponse: ...
    def parent_directory(self) -> FtpResponse: ...
    def create_directory(self, name: str) -> FtpResponse: ...
    def delete_directory(self, name: str) -> FtpResponse: ...
    def rename_file(self, filename: str, newname: str) -> FtpResponse: ...
    def delete_file(self, name: str) -> FtpResponse: ...
    def download(self, remotefile: str, localpath: str, mode: int = ...) -> FtpResponse: ...
    def upload(
        self,
        localfile: str,
        remotepath: str,
        mode: int = ...,
        append: bool = False,
    ) -> FtpResponse: ...
    def send_command(self, command: str, parameter: str = "") -> FtpResponse: ...
    def __getattr__(self, name: str) -> Any: ...


class HttpRequest:
    GET: ClassVar[int]
    POST: ClassVar[int]
    HEAD: ClassVar[int]
    PUT: ClassVar[int]
    DELETE: ClassVar[int]

    def __init__(self, uri: bytes = b"/", method: int = ..., body: bytes = b"") -> None: ...
    def set_field(self, field: bytes, value: bytes) -> None: ...
    def set_method(self, method: int) -> None: ...
    def set_uri(self, uri: bytes) -> None: ...
    def set_http_version(self, major: int, minor: int) -> None: ...
    def set_body(self, body: bytes) -> None: ...


class HttpResponse:
    OK: ClassVar[int]
    CREATED: ClassVar[int]
    ACCEPTED: ClassVar[int]
    NO_CONTENT: ClassVar[int]
    RESET_CONTENT: ClassVar[int]
    PARTIAL_CONTENT: ClassVar[int]
    MULTIPLE_CHOICES: ClassVar[int]
    MOVED_PERMANENTLY: ClassVar[int]
    MOVED_TEMPORARILY: ClassVar[int]
    NOT_MODIFIED: ClassVar[int]
    BAD_REQUEST: ClassVar[int]
    UNAUTHORIZED: ClassVar[int]
    FORBIDDEN: ClassVar[int]
    NOT_FOUND: ClassVar[int]
    RANGE_NOT_SATISFIABLE: ClassVar[int]
    INTERNAL_SERVER_ERROR: ClassVar[int]
    NOT_IMPLEMENTED: ClassVar[int]
    BAD_GATEWAY: ClassVar[int]
    SERVICE_NOT_AVAILABLE: ClassVar[int]
    GATEWAY_TIMEOUT: ClassVar[int]
    VERSION_NOT_SUPPORTED: ClassVar[int]
    INVALID_RESPONSE: ClassVar[int]
    CONNECTION_FAILED: ClassVar[int]

    @property
    def status(self) -> int: ...
    @property
    def major_http_version(self) -> int: ...
    @property
    def minor_http_version(self) -> int: ...
    @property
    def body(self) -> bytes: ...
    def get_field(self, field: bytes) -> bytes: ...


class Http:
    def __init__(self, host: bytes | None = None, port: int = 0) -> None: ...
    def set_host(self, host: bytes, port: int = 0) -> None: ...
    def send_request(self, request: HttpRequest, timeout: Time | None = None) -> HttpResponse: ...
    def __getattr__(self, name: str) -> Any: ...
