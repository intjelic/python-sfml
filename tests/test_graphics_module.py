import pytest

import sfml.graphics as sf


def test_rect_color_and_transform_behaviors_are_deterministic():
    rect = sf.Rect((0, 0), (4, 4))
    intersection = rect.intersects((2, 2, 4, 4))

    assert rect.contains((1, 1)) is True
    assert rect.contains((5, 5)) is False
    assert tuple(intersection) == (2, 2, 2, 2)

    color = sf.Color(10, 20, 30, 40) + sf.Color(1, 2, 3, 4)
    multiplied = sf.Color(255, 128, 64, 32) * sf.Color(128, 255, 128, 255)

    assert tuple(color) == (11, 22, 33, 44)
    assert tuple(multiplied) == (128, 128, 32, 32)

    transform = sf.Transform()

    assert transform.translate((3, 4)) is transform
    assert transform.scale((2, 3)) is transform
    assert transform.rotate(15) is transform


def test_render_texture_active_is_write_only_and_texture_is_available():
    render_texture = sf.RenderTexture(8, 8)

    assert tuple(render_texture.size) == (8, 8)

    with pytest.raises(AttributeError, match="not readable"):
        _ = render_texture.active

    render_texture.active = False
    assert isinstance(render_texture.texture, sf.Texture)


def test_renderstates_retain_texture_and_defaults_are_stable():
    image = sf.Image.create(2, 2, sf.Color.RED)
    texture = sf.Texture.from_image(image)
    states = sf.RenderStates()

    assert isinstance(states.blendmode, sf.BlendMode)
    assert isinstance(states.transform, sf.Transform)
    assert states.texture is None
    assert states.shader is None

    states.texture = texture

    assert states.texture is texture


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


def test_transformable_ratio_is_the_runtime_scale_property_name():
    transformable = sf.Transformable()

    assert tuple(transformable.ratio) == (1.0, 1.0)

    transformable.ratio = (2, 3)

    assert tuple(transformable.ratio) == (2.0, 3.0)


def test_view_and_vertexarray_behaviors_are_deterministic():
    view = sf.View((0, 0, 10, 20))

    assert tuple(view.center) == (5.0, 10.0)
    assert tuple(view.size) == (10.0, 20.0)
    assert tuple(view.viewport) == (0.0, 0.0, 1.0, 1.0)

    view.move(3, 4)
    view.zoom(2)
    view.viewport = (0.1, 0.2, 0.5, 0.5)

    assert tuple(view.center) == (8.0, 14.0)
    assert tuple(view.size) == (20.0, 40.0)
    assert tuple(view.viewport) == pytest.approx((0.1, 0.2, 0.5, 0.5))

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
    texture = sf.Texture.create(2, 2)

    assert tuple(image[0, 0]) == (255, 0, 0, 255)

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
