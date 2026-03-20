import os
import operator
import pytest
from pathlib import Path
import subprocess
import sys

import sfml.graphics as sf
import sfml.system as sf_system


EXAMPLES_DIR = Path(__file__).resolve().parents[1] / "examples"
TEST_FONT = EXAMPLES_DIR / "shader" / "data" / "sansation.ttf"
TEST_SHADER = EXAMPLES_DIR / "shader" / "data" / "pixelate.frag"
PROJECT_ROOT = Path(__file__).resolve().parents[1]


def run_graphics_subprocess(script):
    result = subprocess.run(
        [sys.executable, "-c", script],
        cwd=PROJECT_ROOT,
        env=os.environ.copy(),
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, (
        f"subprocess exited with {result.returncode}\n"
        f"stdout:\n{result.stdout}\n"
        f"stderr:\n{result.stderr}"
    )

    return result


def test_legacy_renderwindow_capture_and_handledwindow_are_not_public_graphics_apis():
    assert not hasattr(sf.RenderWindow, "capture")
    assert not hasattr(sf, "HandledWindow")


def test_rect_color_and_transform_behaviors_are_deterministic():
    rect = sf.Rect((0, 0), (4, 4))
    intersection = rect.find_intersection((2, 2, 4, 4))
    compatibility_intersection = rect.intersects((2, 2, 4, 4))
    miss = rect.find_intersection((10, 10, 1, 1))

    assert tuple(rect.position) == (0, 0)
    assert tuple(rect.size) == (4, 4)

    assert rect.contains((1, 1)) is True
    assert rect.contains((5, 5)) is False
    assert tuple(intersection) == (2, 2, 2, 2)
    assert tuple(compatibility_intersection) == (2, 2, 2, 2)
    assert miss is None

    rect.position = (3, 5)
    rect.size = (6, 7)

    assert tuple(rect) == (3, 5, 6, 7)

    color = sf.Color(10, 20, 30, 40) + sf.Color(1, 2, 3, 4)
    multiplied = sf.Color(255, 128, 64, 32) * sf.Color(128, 255, 128, 255)
    packed_color = sf.Color(1, 2, 3, 4)

    assert tuple(color) == (11, 22, 33, 44)
    assert tuple(multiplied) == (128, 128, 32, 32)
    assert int(packed_color) == 0x01020304
    assert operator.index(packed_color) == 0x01020304

    transform = sf.Transform()

    assert transform.translate((3, 4)) is transform
    assert transform.scale((2, 3)) is transform
    assert transform.rotate(15) is transform


def test_render_texture_uses_explicit_activation_api_and_exposes_texture():
    render_texture = sf.RenderTexture(8, 8)

    assert tuple(render_texture.size) == (8, 8)
    assert callable(render_texture.set_active)
    assert render_texture.set_active(False) is True
    assert isinstance(render_texture.texture, sf.Texture)
    assert isinstance(render_texture.srgb, bool)


def test_renderstates_retain_texture_and_defaults_are_stable():
    image = sf.Image.create(2, 2, sf.Color.RED)
    texture = sf.Texture.from_image(image)
    states = sf.RenderStates()

    assert isinstance(states.blend_mode, sf.BlendMode)
    assert isinstance(states.stencil_mode, sf.StencilMode)
    assert isinstance(states.transform, sf.Transform)
    assert states.coordinate_type == sf.CoordinateType.PIXELS
    assert states.texture is None
    assert states.shader is None

    states.texture = texture

    assert states.texture is texture


def test_renderstates_expose_stencil_and_coordinate_type_controls():
    stencil_mode = sf.StencilMode(
        sf.StencilComparison.NOT_EQUAL,
        sf.StencilUpdateOperation.REPLACE,
        sf.StencilValue(3),
        sf.StencilValue(0x0F),
        True,
    )
    states = sf.RenderStates(
        blend_mode=sf.BLEND_ADD,
        stencil_mode=stencil_mode,
        coordinate_type=sf.CoordinateType.NORMALIZED,
    )

    assert states.blend_mode == sf.BLEND_ADD
    assert states.coordinate_type == sf.CoordinateType.NORMALIZED
    assert states.stencil_mode.comparison == sf.StencilComparison.NOT_EQUAL
    assert states.stencil_mode.update_operation == sf.StencilUpdateOperation.REPLACE
    assert states.stencil_mode.reference.value == 3
    assert states.stencil_mode.mask.value == 0x0F
    assert states.stencil_mode.stencil_only is True


def test_drawable_subclass_draws_into_rendertexture_without_display_server():
    class Probe(sf.Drawable):
        def __init__(self):
            super().__init__()
            self.calls = 0
            self.target_types = []
            self.state_types = []

        def draw(self, target, states):
            self.calls += 1
            self.target_types.append(type(target).__name__)
            self.state_types.append(type(states).__name__)

    render_texture = sf.RenderTexture(8, 8)
    probe = Probe()

    render_texture.draw(probe)
    render_texture.display()

    assert probe.calls == 1
    assert probe.target_types == ['RenderTarget']
    assert probe.state_types == ['RenderStates']


def test_transformable_drawable_python_subclass_survives_transform_access_and_draw():
    run_graphics_subprocess(
        """
import sfml.graphics as sf


class Probe(sf.TransformableDrawable):
    def __init__(self):
        super().__init__()
        self.calls = 0

    def draw(self, target, states):
        self.calls += 1


probe = Probe()
probe.position = (3, 4)
probe.scale = (2, 5)
probe.rotate(15)

assert tuple(probe.position) == (3.0, 4.0)
assert tuple(probe.scale) == (2.0, 5.0)

render_texture = sf.RenderTexture(8, 8)
render_texture.draw(probe)
render_texture.display()

assert probe.calls == 1
print("ok")
"""
    )


def test_transformable_property_wrapper_is_non_owning_for_wrapped_instances():
    run_graphics_subprocess(
        """
import gc
import sfml.graphics as sf


image = sf.Image.create(1, 1, sf.Color.WHITE)
texture = sf.Texture.from_image(image)
sprite = sf.Sprite(texture)

wrapped_transformable = sprite.transformable
assert tuple(wrapped_transformable.position) == (0.0, 0.0)

del wrapped_transformable
gc.collect()

assert tuple(sprite.position) == (0.0, 0.0)
print("ok")
"""
    )


def test_transformable_scale_property_and_scale_by_method_are_the_runtime_contract():
    transformable = sf.Transformable()

    assert tuple(transformable.scale) == (1.0, 1.0)

    transformable.scale = (2, 3)
    transformable.scale_by((4, 5))

    assert tuple(transformable.scale) == (8.0, 15.0)


def test_rotation_surfaces_accept_angles_and_return_public_angle_objects():
    transform = sf.Transform()

    assert transform.rotate(sf_system.degrees(90)) is transform
    assert tuple(transform.transform_point((1, 0))) == pytest.approx((0.0, 1.0), abs=1e-6)

    transformable = sf.Transformable()
    transformable.rotation = sf_system.degrees(45)

    assert isinstance(transformable.rotation, sf_system.Angle)
    assert transformable.rotation.degrees == pytest.approx(45.0)

    transformable.rotate(15)
    transformable.rotate(sf_system.degrees(30))

    assert transformable.rotation.degrees == pytest.approx(90.0)

    view = sf.View((0, 0, 10, 20))
    view.rotation = 10

    assert isinstance(view.rotation, sf_system.Angle)
    assert view.rotation.degrees == pytest.approx(10.0)

    view.rotate(sf_system.degrees(20))

    assert view.rotation.degrees == pytest.approx(30.0)


def test_view_and_vertexarray_behaviors_are_deterministic():
    view = sf.View((0, 0, 10, 20))

    assert tuple(view.center) == (5.0, 10.0)
    assert tuple(view.size) == (10.0, 20.0)
    assert tuple(view.viewport) == (0.0, 0.0, 1.0, 1.0)

    view.move(3, 4)
    view.zoom(2)
    view.viewport = (0.1, 0.2, 0.5, 0.5)
    view.scissor = (0.25, 0.25, 0.5, 0.5)

    assert tuple(view.center) == (8.0, 14.0)
    assert tuple(view.size) == (20.0, 40.0)
    assert tuple(view.viewport) == pytest.approx((0.1, 0.2, 0.5, 0.5))
    assert tuple(view.scissor) == pytest.approx((0.25, 0.25, 0.5, 0.5))

    vertex_array = sf.VertexArray(sf.PrimitiveType.LINES, 2)
    vertex_array[0] = sf.Vertex((1, 2), sf.Color.RED)
    vertex_array[1] = sf.Vertex((4, 6), sf.Color.GREEN)

    assert len(vertex_array) == 2
    assert vertex_array.primitive_type == sf.PrimitiveType.LINES
    assert tuple(vertex_array[0].position) == (1.0, 2.0)
    assert tuple(vertex_array[1].position) == (4.0, 6.0)
    assert tuple(vertex_array.bounds) == pytest.approx((1.0, 2.0, 3.0, 4.0))


def test_image_and_texture_pixel_update_paths_round_trip_pixels():
    red_pixels = bytes([
        255, 0, 0, 255,
        255, 0, 0, 255,
        255, 0, 0, 255,
        255, 0, 0, 255,
    ])
    blue_pixels = bytes([
        0, 0, 255, 255,
        0, 0, 255, 255,
        0, 0, 255, 255,
        0, 0, 255, 255,
    ])

    image = sf.Image.from_pixels(2, 2, red_pixels)
    texture = sf.Texture.create(2, 2, srgb=True)

    assert tuple(image[0, 0]) == (255, 0, 0, 255)
    assert texture.srgb is True

    texture.update_from_pixels(red_pixels, 2, 2, 0, 0)
    copied = texture.copy_to_image()

    assert tuple(texture.size) == (2, 2)
    assert texture.width == 2
    assert texture.height == 2
    assert tuple(copied[0, 0]) == (255, 0, 0, 255)

    blue_image = sf.Image.from_pixels(2, 2, blue_pixels)
    texture.update_from_image(blue_image)
    copied_after = texture.to_image()

    assert tuple(copied_after[1, 1]) == (0, 0, 255, 255)
    assert isinstance(texture.generate_mipmap(), bool)


def test_render_target_scissor_and_stencil_clear_surfaces_are_available():
    render_texture = sf.RenderTexture(100, 80)
    view = sf.View((0, 0, 50, 40))
    view.scissor = (0.25, 0.25, 0.5, 0.5)

    render_texture.view = view
    render_texture.clear_stencil(sf.StencilValue(3))
    render_texture.clear(sf.Color.BLUE, sf.StencilValue(1))

    assert tuple(render_texture.get_scissor(view)) == (25, 20, 50, 40)


def test_vertex_buffer_upload_and_draw_helpers_work_without_display_server():
    if not sf.VertexBuffer.is_available():
        pytest.skip("vertex buffers are unavailable in this environment")

    render_texture = sf.RenderTexture(16, 16)
    vertex_buffer = sf.VertexBuffer(sf.PrimitiveType.POINTS, sf.VertexBufferUsage.DYNAMIC)
    point = sf.Vertex((8, 8), sf.Color.RED)
    raw_point = sf.Vertex((4, 4), sf.Color.GREEN)

    assert vertex_buffer.create(1) is True
    assert vertex_buffer.update([point]) is True
    assert len(vertex_buffer) == 1
    assert vertex_buffer.primitive_type == sf.PrimitiveType.POINTS
    assert vertex_buffer.usage == sf.VertexBufferUsage.DYNAMIC

    render_texture.clear(sf.Color.BLACK)
    render_texture.draw(vertex_buffer)
    render_texture.draw_vertices([raw_point], sf.PrimitiveType.POINTS)
    render_texture.draw_vertex_buffer(vertex_buffer, first_vertex=0, vertex_count=1)
    render_texture.display()

    image = render_texture.texture.copy_to_image()

    if tuple(image[8, 8]) == tuple(sf.Color.BLACK) and tuple(image[4, 4]) == tuple(sf.Color.BLACK):
        pytest.xfail("headless GL backend did not rasterize raw vertex primitives or vertex buffers")

    assert tuple(image[8, 8]) == tuple(sf.Color.RED)
    assert tuple(image[4, 4]) == tuple(sf.Color.GREEN)


def test_text_uses_font_first_constructor_and_fill_outline_surface():
    font = sf.Font.from_file(str(TEST_FONT))
    text = sf.Text(font, "Hello SFML", 24)

    text.style = sf.TextStyle.BOLD
    text.fill_color = sf.Color.GREEN
    text.outline_color = sf.Color.BLUE
    text.outline_thickness = 2.5
    text.line_spacing = 1.25
    text.letter_spacing = 1.5

    assert text.font is font
    assert text.string == "Hello SFML"
    assert text.character_size == 24
    assert text.style == sf.TextStyle.BOLD
    assert tuple(text.fill_color) == tuple(sf.Color.GREEN)
    assert tuple(text.outline_color) == tuple(sf.Color.BLUE)
    assert text.outline_thickness == pytest.approx(2.5)
    assert text.line_spacing == pytest.approx(1.25)
    assert text.letter_spacing == pytest.approx(1.5)


def test_shader_uniform_api_accepts_explicit_current_texture_sentinel():
    sf.RenderTexture(8, 8)

    if not sf.Shader.is_available():
        pytest.skip("shader support is unavailable in this environment")

    try:
        shader = sf.Shader.from_file(fragment=str(TEST_SHADER))
    except IOError as exc:
        pytest.skip(f"shader compilation is unavailable in this environment: {exc}")

    shader.set_uniform("texture", sf.CurrentTexture)
    shader.set_uniform("pixel_threshold", 4.0)
