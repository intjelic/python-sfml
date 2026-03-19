from math import cos
from pathlib import Path
from random import randint

from sfml import graphics as sf_graphics
from sfml import system as sf_system
from sfml import window as sf_window


DATA_DIR = Path(__file__).resolve().parent / "data"
ERROR_FONT = sf_graphics.Font.from_file(str(DATA_DIR / "sansation.ttf"))


class Effect(sf_graphics.Drawable):
    def __init__(self, name):
        sf_graphics.Drawable.__init__(self)

        self._name = name
        self.is_loaded = False

    def _get_name(self):
        return self._name

    def load(self):
        self.is_loaded = sf.Shader.is_available() and self.on_load()

    def update(self, time, x, y):
        if self.is_loaded:
            self.on_update(time, x, y)

    def draw(self, target, states):
        if self.is_loaded:
            self.on_draw(target, states)
        else:
            error = sf_graphics.Text("Shader not\nsupported", ERROR_FONT)
            error.position = (320, 200)
            error.character_size = 36
            target.draw(error, states)

    name = property(_get_name)

class Pixelate(Effect):
    def __init__(self):
        Effect.__init__(self, 'pixelate')

    def on_load(self):
        try:
            self.texture = sf_graphics.Texture.from_file(str(DATA_DIR / "background.jpg"))
            self.sprite = sf_graphics.Sprite(self.texture)
            self.shader = sf_graphics.Shader.from_file(fragment=str(DATA_DIR / "pixelate.frag"))
            self.shader.set_parameter("texture")
        except IOError as error:
            print(f"An error occurred: {error}")
            exit(1)

        return True

    def on_update(self, time, x, y):
        self.shader.set_parameter("pixel_threshold", (x + y) / 30)

    def on_draw(self, target, states):
        states.shader = self.shader
        target.draw(self.sprite, states)


class WaveBlur(Effect):
    def __init__(self):
        Effect.__init__(self, 'wave + blur')

    def on_load(self):
        with open(DATA_DIR / "text.txt", encoding="utf-8") as file:
            self.text = sf_graphics.Text(file.read(), ERROR_FONT, 22)
            self.text.position = (30, 20)

        try:
            self.shader = sf_graphics.Shader.from_file(
                vertex=str(DATA_DIR / "wave.vert"),
                fragment=str(DATA_DIR / "blur.frag"),
            )
        except IOError as error:
            print(f"An error occurred: {error}")
            exit(1)

        return True

    def on_update(self, time, x, y):
        self.shader.set_parameter("wave_phase", time)
        self.shader.set_parameter("wave_amplitude", x * 40, y * 40)
        self.shader.set_parameter("blur_radius", (x + y) * 0.008)

    def on_draw(self, target, states):
        states.shader = self.shader
        target.draw(self.text, states)


class StormBlink(Effect):
    def __init__(self):
        Effect.__init__(self, 'storm + blink')

        self.points = sf_graphics.VertexArray(sf_graphics.PrimitiveType.POINTS)

    def on_load(self):
        for i in range(40000):
            x = randint(0, 799)
            y = randint(0, 599)
            r = randint(0, 254)
            g = randint(0, 254)
            b = randint(0, 254)
            self.points.append(sf_graphics.Vertex((x, y), sf_graphics.Color(r, g, b)))

        try:
            self.shader = sf_graphics.Shader.from_file(
                vertex=str(DATA_DIR / "storm.vert"),
                fragment=str(DATA_DIR / "blink.frag"),
            )
        except IOError as error:
            print(f"An error occurred: {error}")
            exit(1)

        return True

    def on_update(self, time, x, y):
        radius = 200 + cos(time) * 150
        self.shader.set_parameter("storm_position", x * 800, y * 600)
        self.shader.set_parameter("storm_inner_radius", radius / 3)
        self.shader.set_parameter("storm_total_radius", radius)
        self.shader.set_parameter("blink_alpha", 0.5 + cos(time*3) * 0.25)

    def on_draw(self, target, states):
        states.shader = self.shader
        target.draw(self.points, states)

class Edge(Effect):
    def __init__(self):
        Effect.__init__(self, "edge post-effect")

    def on_load(self):
        self.surface = sf_graphics.RenderTexture(800, 600)
        self.surface.smooth = True

        self.background_texture = sf_graphics.Texture.from_file(str(DATA_DIR / "sfml.png"))
        self.background_texture.smooth = True

        self.entity_texture = sf_graphics.Texture.from_file(str(DATA_DIR / "devices.png"))
        self.entity_texture.smooth = True

        self.background_sprite = sf_graphics.Sprite(self.background_texture)
        self.background_sprite.position = (135, 100)

        self.entities = []

        for i in range(6):
            sprite = sf_graphics.Sprite(self.entity_texture, (96 * i, 0, 96, 96))
            self.entities.append(sprite)

        self.shader = sf_graphics.Shader.from_file(fragment=str(DATA_DIR / "edge.frag"))
        self.shader.set_parameter("texture")

        return True

    def on_update(self, time, x, y):
        self.shader.set_parameter("edge_threshold", 1 - (x + y) / 2)

        for i, entity in enumerate(self.entities):
            x_position = cos(0.25 * (time * i + (len(self.entities) - i))) * 300 + 350
            y_position = cos(0.25 * (time * (len(self.entities) - i) + i)) * 200 + 250
            entity.position = (x_position, y_position)

        self.surface.clear(sf_graphics.Color.WHITE)
        self.surface.draw(self.background_sprite)

        for entity in self.entities:
            self.surface.draw(entity)

        self.surface.display()

    def on_draw(self, target, states):
        states.shader = self.shader
        target.draw(sf_graphics.Sprite(self.surface.texture), states)


if __name__ == "__main__":
    render_window = sf_graphics.RenderWindow(sf_window.VideoMode(800, 600), "PySFML - Shader")
    render_window.vertical_synchronization = True

    effects = (Pixelate(), WaveBlur(), StormBlink(), Edge())
    current = 0

    for effect in effects:
        effect.load()

    try:
        text_background_texture = sf_graphics.Texture.from_file(str(DATA_DIR / "text-background.png"))
    except IOError as error:
        print(f"An error occurred: {error}")
        exit(1)

    text_background = sf_graphics.Sprite(text_background_texture)
    text_background.position = (0, 520)
    text_background.color = sf_graphics.Color(255, 255, 255, 200)

    try:
        font = sf_graphics.Font.from_file(str(DATA_DIR / "sansation.ttf"))
    except IOError as error:
        print(f"An error occurred: {error}")
        exit(1)

    description = sf_graphics.Text(f"Current effect: {effects[current].name}", font, 20)
    description.position = (10, 530)
    description.color = sf_graphics.Color(80, 80, 80)

    instructions = sf_graphics.Text("Press left and right arrows to change the current shader", font, 20)
    instructions.position = (280, 555)
    instructions.color = sf_graphics.Color(80, 80, 80)

    clock = sf_system.Clock()

    while render_window.is_open:
        mouse_position = sf_window.Mouse.get_position(render_window)
        x = mouse_position.x / render_window.size.x
        y = mouse_position.y / render_window.size.y
        effects[current].update(clock.elapsed_time.seconds, x, y)

        for event in render_window.events:
            if event.type == sf_window.EventType.CLOSED:
                render_window.close()
            elif event.type == sf_window.EventType.KEY_PRESSED:
                if event.get("code") == sf_window.Keyboard.ESCAPE:
                    render_window.close()
                elif event.get("code") == sf_window.Keyboard.LEFT:
                    current = len(effects) - 1 if current == 0 else current - 1
                    description.string = f"Current effect: {effects[current].name}"
                elif event.get("code") == sf_window.Keyboard.RIGHT:
                    current = 0 if current == len(effects) - 1 else current + 1
                    description.string = f"Current effect: {effects[current].name}"

        render_window.clear(sf_graphics.Color(255, 128, 0))
        render_window.draw(effects[current])
        render_window.draw(text_background)
        render_window.draw(instructions)
        render_window.draw(description)
        render_window.display()
