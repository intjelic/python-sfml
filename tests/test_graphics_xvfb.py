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
def test_renderwindow_draw_mapping_surfaces_work_under_display():
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
        current_size = tuple(window.size)

        assert mapped_coords.x == pytest.approx(10.0)
        assert mapped_coords.y == pytest.approx(15.0)
        assert abs(mapped_pixels.x - 10) <= 1
        assert abs(mapped_pixels.y - 15) <= 1
        assert not hasattr(window, "capture")
        assert current_size == (96, 72)
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_renderwindow_scissor_and_vertex_buffer_helpers_work_under_display():
    if not sf.VertexBuffer.is_available():
        pytest.skip("vertex buffers are unavailable in this environment")

    window = sf.RenderWindow(sw.VideoMode(96, 72), "PySFML Graphics VertexBuffer Xvfb")

    try:
        view = window.default_view
        view.scissor = (0.25, 0.25, 0.5, 0.5)
        window.view = view

        vertex_buffer = sf.VertexBuffer(sf.PrimitiveType.TRIANGLES, sf.VertexBufferUsage.STATIC)
        red_triangle = [
            sf.Vertex((40, 28), sf.Color.RED),
            sf.Vertex((56, 28), sf.Color.RED),
            sf.Vertex((48, 44), sf.Color.RED),
        ]
        green_triangle = [
            sf.Vertex((28, 24), sf.Color.GREEN),
            sf.Vertex((36, 24), sf.Color.GREEN),
            sf.Vertex((32, 36), sf.Color.GREEN),
        ]

        assert vertex_buffer.create(3) is True
        assert vertex_buffer.update(red_triangle) is True

        window.clear(sf.Color.BLACK)
        window.draw_vertex_buffer(vertex_buffer)
        window.draw_vertices(green_triangle, sf.PrimitiveType.TRIANGLES)
        window.display()

        current_size = tuple(window.size)
        expected_scissor = (
            round(current_size[0] * 0.25),
            round(current_size[1] * 0.25),
            round(current_size[0] * 0.5),
            round(current_size[1] * 0.5),
        )

        actual_scissor = tuple(window.get_scissor(view))
        red_sample = window.map_coords_to_pixel((48, 34))
        green_sample = window.map_coords_to_pixel((32, 28))

        assert abs(actual_scissor[0] - expected_scissor[0]) <= 1
        assert abs(actual_scissor[1] - expected_scissor[1]) <= 1
        assert abs(actual_scissor[2] - expected_scissor[2]) <= 1
        assert abs(actual_scissor[3] - expected_scissor[3]) <= 1
        assert not hasattr(window, "capture")
        assert 0 <= red_sample.x < current_size[0]
        assert 0 <= red_sample.y < current_size[1]
        assert 0 <= green_sample.x < current_size[0]
        assert 0 <= green_sample.y < current_size[1]
    finally:
        if window.is_open:
            window.close()