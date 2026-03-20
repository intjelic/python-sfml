from importlib import resources
from pathlib import Path

import sfml.system


def test_typing_artifacts_are_packaged():
    sfml_package = resources.files("sfml")

    assert sfml_package.joinpath("py.typed").is_file()
    assert sfml_package.joinpath("__init__.pyi").is_file()
    assert sfml_package.joinpath("audio.pyi").is_file()
    assert sfml_package.joinpath("graphics.pyi").is_file()
    assert sfml_package.joinpath("network.pyi").is_file()
    assert sfml_package.joinpath("sf.pyi").is_file()
    assert sfml_package.joinpath("system.pyi").is_file()
    assert sfml_package.joinpath("window.pyi").is_file()


def test_embedded_runtime_signatures_are_available():
    signature_line = (sfml.system.seconds.__doc__ or "").splitlines()[0]

    assert signature_line.startswith("seconds(")


def test_angle_and_window_stub_surfaces_are_shipped():
    sfml_package = resources.files("sfml")
    system_stub = sfml_package.joinpath("system.pyi").read_text(encoding="utf-8")
    graphics_stub = sfml_package.joinpath("graphics.pyi").read_text(encoding="utf-8")
    network_stub = sfml_package.joinpath("network.pyi").read_text(encoding="utf-8")
    window_stub = sfml_package.joinpath("window.pyi").read_text(encoding="utf-8")

    assert "class Angle:" in system_stub
    assert "def degrees(amount: float) -> Angle: ..." in system_stub
    assert "def rotation(self) -> Angle: ..." in graphics_stub
    assert "def scale_by(self, factor: Vector2Like) -> None: ..." in graphics_stub
    assert "class StencilMode:" in graphics_stub
    assert "def set_uniform(self, name: str, value: Any, *extra_values: Any) -> None: ..." in graphics_stub
    assert "CurrentTexture: CurrentTextureType" in graphics_stub
    assert "class TextStyle(IntEnum):" in graphics_stub
    assert "def fill_color(self) -> Color: ..." in graphics_stub
    assert "def clear(self, color: Color | None = None, stencil_value: StencilValue | int | None = None) -> None: ..." in graphics_stub
    assert "def clear_stencil(self, value: StencilValue | int = 0) -> None: ..." in graphics_stub
    assert "def get_scissor(self, view: View) -> Rect: ..." in graphics_stub
    assert "def generate_mipmap(self) -> bool: ..." in graphics_stub
    assert "def srgb(self) -> bool: ..." in graphics_stub
    assert "def position(self) -> Vector2: ..." in graphics_stub
    assert "def find_intersection(self, rectangle: RectLike) -> Rect | None: ..." in graphics_stub
    assert "class VertexBufferUsage(IntEnum):" in graphics_stub
    assert "class VertexBuffer(Drawable):" in graphics_stub
    assert "def draw_vertices(self, vertices: list[Vertex] | tuple[Vertex, ...], primitive_type: int, states: RenderStates | None = None) -> None: ..." in graphics_stub
    assert "def draw_vertex_buffer(" in graphics_stub
    assert "def active(self) -> NoReturn: ..." not in graphics_stub
    assert "def ratio(self) -> Vector2: ..." not in graphics_stub
    assert "def set_parameter(self, *args: Any, **kwargs: Any) -> None: ..." not in graphics_stub
    assert "def capture(self) -> Image: ..." not in graphics_stub
    assert "class HandledWindow(RenderTarget):" not in graphics_stub
    assert "class KeyEvent:" not in window_stub
    assert "def scancode(self) -> int: ..." in window_stub
    assert "def wait_event(self, timeout: Time | None = None) -> Event | None: ..." in window_stub
    assert "def set_title(self, title: str) -> None: ..." in window_stub
    assert "def set_visible(self, visible: bool) -> None: ..." in window_stub
    assert "def set_mouse_cursor(self, cursor: Cursor) -> None: ..." in window_stub
    assert "def set_framerate_limit(self, limit: int) -> None: ..." in window_stub
    assert "def set_joystick_threshold(self, threshold: float) -> None: ..." in window_stub
    assert "class Clipboard:" in window_stub
    assert "class CursorType(IntEnum):" in window_stub
    assert "class Cursor:" in window_stub
    assert "def get_string() -> str: ..." in window_stub
    assert "def from_system(cursor_type: int) -> Cursor: ..." in window_stub
    assert "class Scancode(IntEnum):" in window_stub
    assert "def localize(scancode: int) -> int: ..." in window_stub
    assert "def get_description(scancode: int) -> str: ..." in window_stub
    assert "def get_active_context() -> Context | None: ..." in window_stub
    assert "def srgb_capable(self) -> bool: ..." in window_stub
    assert "MOUSE_WHEEL_MOVED" not in window_stub
    assert "def title(self) -> NoReturn: ..." not in window_stub
    assert "def visible(self) -> NoReturn: ..." not in window_stub
    assert "def active(self) -> NoReturn: ..." not in window_stub
    assert "ANY: ClassVar[IpAddress]" in network_stub
    assert "PARTIAL: ClassVar[int]" in network_stub
    assert "def listen(self, port: int, address: IpAddress | None = None) -> None: ..." in network_stub
    assert "def send(self, data: bytes) -> int: ..." in network_stub
    assert "def set_field(self, field: bytes, value: bytes) -> None: ..." in network_stub
    assert "def set_http_version(self, major: int, minor: int) -> None: ..." in network_stub
    assert "PUT: ClassVar[int]" in network_stub
    assert "DELETE: ClassVar[int]" in network_stub
    assert "NOT_MODIFIED: ClassVar[int]" in network_stub
    assert "BAD_REQUEST: ClassVar[int]" in network_stub
    assert "def set_host(self, host: bytes, port: int = 0) -> None: ..." in network_stub
    assert "def send_command(self, command: str, parameter: str = \"\") -> FtpResponse: ..." in network_stub
    assert "def field(self) -> NoReturn: ..." not in network_stub
    assert "def uri(self) -> NoReturn: ..." not in network_stub


def test_shipped_cython_include_mirror_tracks_graphics_rect_and_vertex_buffer_surface():
    include_mirror = Path(__file__).resolve().parents[1] / "include" / "Includes" / "sfml" / "sfml.pxd"
    pxd_text = include_mirror.read_text(encoding="utf-8")

    assert "optional[Rect[T]] findIntersection(const Rect[T]&) const" in pxd_text
    assert "cdef enum VertexBufferUsage:" in pxd_text
    assert 'Stream "sf::VertexBuffer::Usage::Stream"' in pxd_text
    assert "QUADS" not in pxd_text