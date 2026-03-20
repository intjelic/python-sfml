# Graphics Module

This is a quick Python-oriented guide for the PySFML graphics module on the SFML 3 release line.

> The SFML graphics module is the 2D rendering layer. It provides images, textures, sprites, text, shapes, shaders, views, render states, and render targets.

## Quick Feel

```python
from sfml import graphics, window

render_window = graphics.RenderWindow(window.VideoMode(800, 600), "Graphics")

texture = graphics.Texture.from_file("player.png")
sprite = graphics.Sprite(texture)
sprite.position = (100, 120)

while render_window.is_open:
    for event in render_window.events:
        if isinstance(event, window.ClosedEvent):
            render_window.close()

    render_window.clear(graphics.Color.BLACK)
    render_window.draw(sprite)
    render_window.display()
```

## CPU Images, GPU Textures, And Drawables

The module separates CPU-side pixel work from GPU-side rendering resources:

- `Image` for editable pixels in memory
- `Texture` for GPU-backed image data
- `Sprite`, `Text`, and shapes for drawable scene objects

```python
from sfml import graphics

image = graphics.Image.from_file("tiles.png")
texture = graphics.Texture.from_image(image)
sprite = graphics.Sprite(texture)

image[0, 0] = graphics.Color.RED
```

Use `Image` when you need pixel access. Use `Texture` when you want to render.

## Text And Fonts

```python
from sfml import graphics

font = graphics.Font.from_file("DejaVuSans.ttf")
label = graphics.Text(font, "Hello", 32)
label.position = (24, 24)
label.style = graphics.TextStyle.BOLD | graphics.TextStyle.UNDERLINED
label.outline_thickness = 2
```

The current SFML 3 surface exposes a richer text API than older PySFML releases, including:

- `TextStyle`
- `letter_spacing`
- `line_spacing`
- `outline_color`
- `outline_thickness`

## Transforms And Angles

Graphics rotation works with `sfml.system.Angle` or with degree scalars.

```python
from sfml import graphics, system

shape = graphics.RectangleShape((120, 60))
shape.position = (200, 200)
shape.rotation = system.degrees(15)
shape.scale_by((1.5, 1.5))
```

This is one of the important SFML 3-era changes: angles are explicit values instead of being only raw numbers in the public model.

## Rectangles, Views, And Render Targets

`Rect` has both the classic scalar fields and the newer grouped view of the same data.

```python
viewport = graphics.Rect((0, 0), (400, 300))
print(tuple(viewport.position), tuple(viewport.size))
```

Useful render-target types:

- `RenderWindow` for on-screen drawing
- `RenderTexture` for off-screen drawing

`RenderTexture` is the usual way to build a texture dynamically:

```python
from sfml import graphics

canvas = graphics.RenderTexture(256, 256)
canvas.clear(graphics.Color.TRANSPARENT)
canvas.draw(graphics.CircleShape(40))
canvas.display()

preview = graphics.Sprite(canvas.texture)
```

## Shaders And Render States

The shader API uses `set_uniform()`.

```python
from sfml import graphics

shader = graphics.Shader.from_file(fragment="post.frag")
shader.set_uniform("tint", 1.0, 0.8, 0.6, 1.0)
shader.set_uniform("source", graphics.CurrentTexture)
```

`RenderStates` packages the state you want to draw with:

- blend mode
- stencil mode
- transform
- coordinate type
- texture
- shader

That is broader than the older PySFML surface, especially now that stencil and coordinate type are part of the documented API.

## Raw Geometry

For custom geometry, start with `VertexArray` or `draw_vertices(...)`.

```python
from sfml import graphics

triangle = graphics.VertexArray(graphics.PrimitiveType.TRIANGLES, 3)
triangle[0] = graphics.Vertex((0, 0), graphics.Color.RED)
triangle[1] = graphics.Vertex((100, 0), graphics.Color.GREEN)
triangle[2] = graphics.Vertex((50, 80), graphics.Color.BLUE)
```

`VertexBuffer` is also available for GPU-backed geometry, but backend behavior should still be validated across your target platforms if you rely heavily on vertex-buffer rendering.

## Differences From C++ Worth Knowing

- `Rect` is exposed as one dynamic Python type instead of separate typed rectangle classes.
- Transformables use a `scale` property and `scale_by()` method on the Python surface.
- `Shader.set_uniform()` replaces the older `set_parameter()` shape.
- `TextStyle` is the public text-style enum.
- `CurrentTexture` is an explicit sentinel for shader uniform binding.
- SFML 3 no longer exposes `QUADS` in primitive types.
- `Rect.find_intersection()` returns `None` when there is no overlap.

## Missing Or Deferred Pieces

The big missing area is not basic 2D drawing. It is deeper parity and validation work around advanced corners:

- more deterministic coverage for stencil, scissor, and text-metric behavior
- broader validation of raw vertex and vertex-buffer rendering across graphics backends
- stream-backed resource loading stories that depend on the deferred input-stream design

If you stay within textures, sprites, text, shapes, views, and ordinary render windows, this module covers the core graphics workflows expected by most PySFML applications.

## Related Guides

- See `window-module.md` for events, input, and window creation.
- See `system-module.md` for `Angle`, `Time`, and vectors.
- See `modules.md` for the high-level module map.