import os

import pytest

import sfml.graphics as sf
import sfml.window as sw


requires_display = pytest.mark.skipif(
    not os.environ.get("DISPLAY"),
    reason="requires an X11 display or xvfb-run",
)


class ProbeDrawable(sf.Drawable):
    def __init__(self):
        super().__init__()
        self.calls = 0
        self.state_types = []

    def draw(self, target, states):
        self.calls += 1
        self.state_types.append(type(states).__name__)


@requires_display
def test_renderwindow_draw_mapping_and_capture_work_under_display():
    window = sf.RenderWindow(sw.VideoMode(96, 72), "PySFML Graphics Xvfb")

    try:
        drawable = ProbeDrawable()

        window.clear(sf.Color.BLACK)
        window.draw(drawable)
        window.display()

        assert drawable.calls == 1
        assert drawable.state_types == ['RenderStates']

        mapped_coords = window.map_pixel_to_coords((10, 15))
        mapped_pixels = window.map_coords_to_pixel((10, 15))
        captured = window.capture()
        current_size = tuple(window.size)

        assert mapped_coords.x == pytest.approx(10.0)
        assert mapped_coords.y == pytest.approx(15.0)
        assert abs(mapped_pixels.x - 10) <= 1
        assert abs(mapped_pixels.y - 15) <= 1
        assert isinstance(captured, sf.Image)
        assert tuple(captured.size) == current_size
    finally:
        if window.is_open:
            window.close()