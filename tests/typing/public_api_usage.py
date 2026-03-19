from __future__ import annotations

import sfml.audio as audio
import sfml.graphics as graphics
import sfml.network as network
import sfml.system as system
import sfml.window as window


clock: system.Clock = system.Clock()
elapsed: system.Time = clock.elapsed_time
seconds_value: float = elapsed.seconds

video_mode: window.VideoMode = window.VideoMode(640, 480, 32)
context_settings: window.ContextSettings = window.ContextSettings(
    depth=24,
    stencil=8,
    antialiasing=0,
    major=3,
    minor=0,
    attributes=window.Attribute.DEFAULT,
)
attribute_flags: int = context_settings.attribute_flags

color: graphics.Color = graphics.Color(10, 20, 30, 255)
rect: graphics.Rect = graphics.Rect((0, 0), (10, 20))
texture: graphics.Texture = graphics.Texture.create(1, 1)
texture_width: int | float = texture.width

chunk: audio.Chunk = audio.Chunk(b"\x00\x00\x01\x00")
chunk[0] = 0
sample_count: int = len(chunk)

ip_address: network.IpAddress = network.IpAddress.from_string("127.0.0.1")
address_bytes: bytes = ip_address.string


def use_values() -> tuple[float, int, int | float, int, bytes, graphics.Color, graphics.Rect, window.VideoMode]:
    return (
        seconds_value,
        attribute_flags,
        texture_width,
        sample_count,
        address_bytes,
        color,
        rect,
        video_mode,
    )