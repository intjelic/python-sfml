from pathlib import Path

from sfml import audio as sf_audio
from sfml import graphics as sf_graphics
from sfml import system as sf_system
from sfml import window as sf_window


RESOURCE_DIR = Path(__file__).resolve().parent / "resources"
KEY_SIZE = 54.0
PADDING = 4.0
TEXT_SIZE = 18
SPACE = 2
LINE_SIZE = TEXT_SIZE + SPACE
UNKNOWN_SCANCODE = int(sf_window.Scancode.UNKNOWN)


def cell(scancode, width=1.0, height=1.0, margin_right=0.0):
    return (int(scancode), width * KEY_SIZE, height * KEY_SIZE, margin_right * KEY_SIZE)


KEYBOARD_ROWS = (
    (
        (
            cell(sf_window.Scancode.ESCAPE, margin_right=1.0),
            cell(sf_window.Scancode.F1),
            cell(sf_window.Scancode.F2),
            cell(sf_window.Scancode.F3),
            cell(sf_window.Scancode.F4, margin_right=0.5),
            cell(sf_window.Scancode.F5),
            cell(sf_window.Scancode.F6),
            cell(sf_window.Scancode.F7),
            cell(sf_window.Scancode.F8, margin_right=0.5),
            cell(sf_window.Scancode.F9),
            cell(sf_window.Scancode.F10),
            cell(sf_window.Scancode.F11),
            cell(sf_window.Scancode.F12, margin_right=0.5),
            cell(sf_window.Scancode.PRINT_SCREEN),
            cell(sf_window.Scancode.SCROLL_LOCK),
            cell(sf_window.Scancode.PAUSE),
        ),
        0.5 * KEY_SIZE,
    ),
    (
        (
            cell(sf_window.Scancode.GRAVE),
            cell(sf_window.Scancode.NUM1),
            cell(sf_window.Scancode.NUM2),
            cell(sf_window.Scancode.NUM3),
            cell(sf_window.Scancode.NUM4),
            cell(sf_window.Scancode.NUM5),
            cell(sf_window.Scancode.NUM6),
            cell(sf_window.Scancode.NUM7),
            cell(sf_window.Scancode.NUM8),
            cell(sf_window.Scancode.NUM9),
            cell(sf_window.Scancode.NUM0),
            cell(sf_window.Scancode.HYPHEN),
            cell(sf_window.Scancode.EQUAL),
            cell(sf_window.Scancode.BACKSPACE, 2.0, 1.0, 0.5),
            cell(sf_window.Scancode.INSERT),
            cell(sf_window.Scancode.HOME),
            cell(sf_window.Scancode.PAGE_UP, margin_right=0.5),
            cell(sf_window.Scancode.NUM_LOCK),
            cell(sf_window.Scancode.NUMPAD_DIVIDE),
            cell(sf_window.Scancode.NUMPAD_MULTIPLY),
            cell(sf_window.Scancode.NUMPAD_MINUS),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.TAB, 1.5),
            cell(sf_window.Scancode.Q),
            cell(sf_window.Scancode.W),
            cell(sf_window.Scancode.E),
            cell(sf_window.Scancode.R),
            cell(sf_window.Scancode.T),
            cell(sf_window.Scancode.Y),
            cell(sf_window.Scancode.U),
            cell(sf_window.Scancode.I),
            cell(sf_window.Scancode.O),
            cell(sf_window.Scancode.P),
            cell(sf_window.Scancode.L_BRACKET),
            cell(sf_window.Scancode.R_BRACKET),
            cell(sf_window.Scancode.BACKSLASH, 1.5, 1.0, 0.5),
            cell(sf_window.Scancode.DELETE),
            cell(sf_window.Scancode.END),
            cell(sf_window.Scancode.PAGE_DOWN, margin_right=0.5),
            cell(sf_window.Scancode.NUMPAD7),
            cell(sf_window.Scancode.NUMPAD8),
            cell(sf_window.Scancode.NUMPAD9),
            cell(sf_window.Scancode.NUMPAD_PLUS),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.CAPS_LOCK, 1.75),
            cell(sf_window.Scancode.A),
            cell(sf_window.Scancode.S),
            cell(sf_window.Scancode.D),
            cell(sf_window.Scancode.F),
            cell(sf_window.Scancode.G),
            cell(sf_window.Scancode.H),
            cell(sf_window.Scancode.J),
            cell(sf_window.Scancode.K),
            cell(sf_window.Scancode.L),
            cell(sf_window.Scancode.SEMICOLON),
            cell(sf_window.Scancode.APOSTROPHE),
            cell(sf_window.Scancode.ENTER, 2.25, 1.0, 4.0),
            cell(sf_window.Scancode.NUMPAD4),
            cell(sf_window.Scancode.NUMPAD5),
            cell(sf_window.Scancode.NUMPAD6),
            cell(sf_window.Scancode.NUMPAD_EQUAL),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.L_SHIFT, 1.25),
            cell(sf_window.Scancode.NON_US_BACKSLASH),
            cell(sf_window.Scancode.Z),
            cell(sf_window.Scancode.X),
            cell(sf_window.Scancode.C),
            cell(sf_window.Scancode.V),
            cell(sf_window.Scancode.B),
            cell(sf_window.Scancode.N),
            cell(sf_window.Scancode.M),
            cell(sf_window.Scancode.COMMA),
            cell(sf_window.Scancode.PERIOD),
            cell(sf_window.Scancode.SLASH),
            cell(sf_window.Scancode.R_SHIFT, 2.75, 1.0, 1.5),
            cell(sf_window.Scancode.UP, margin_right=1.5),
            cell(sf_window.Scancode.NUMPAD1),
            cell(sf_window.Scancode.NUMPAD2),
            cell(sf_window.Scancode.NUMPAD3),
            cell(sf_window.Scancode.NUMPAD_ENTER, 1.0, 2.0),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.L_CONTROL, 1.5),
            cell(sf_window.Scancode.L_SYSTEM, 1.25),
            cell(sf_window.Scancode.L_ALT, 1.5),
            cell(sf_window.Scancode.SPACE, 5.75),
            cell(sf_window.Scancode.R_ALT, 1.25),
            cell(sf_window.Scancode.R_SYSTEM, 1.25),
            cell(sf_window.Scancode.MENU, 1.25),
            cell(sf_window.Scancode.R_CONTROL, 1.25, 1.0, 0.5),
            cell(sf_window.Scancode.LEFT),
            cell(sf_window.Scancode.DOWN),
            cell(sf_window.Scancode.RIGHT, margin_right=0.5),
            cell(sf_window.Scancode.NUMPAD0, 2.0),
            cell(sf_window.Scancode.NUMPAD_DECIMAL),
        ),
        0.5 * KEY_SIZE,
    ),
    (
        (
            cell(sf_window.Scancode.F13),
            cell(sf_window.Scancode.F14),
            cell(sf_window.Scancode.F15),
            cell(sf_window.Scancode.F16),
            cell(sf_window.Scancode.F17),
            cell(sf_window.Scancode.F18),
            cell(sf_window.Scancode.F19),
            cell(sf_window.Scancode.F20),
            cell(sf_window.Scancode.F21),
            cell(sf_window.Scancode.F22),
            cell(sf_window.Scancode.F23),
            cell(sf_window.Scancode.F24),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.APPLICATION),
            cell(sf_window.Scancode.EXECUTE),
            cell(sf_window.Scancode.MODE_CHANGE),
            cell(sf_window.Scancode.HELP),
            cell(sf_window.Scancode.SELECT),
            cell(sf_window.Scancode.REDO),
            cell(sf_window.Scancode.UNDO),
            cell(sf_window.Scancode.CUT),
            cell(sf_window.Scancode.COPY),
            cell(sf_window.Scancode.PASTE),
            cell(sf_window.Scancode.VOLUME_MUTE),
            cell(sf_window.Scancode.VOLUME_UP),
            cell(sf_window.Scancode.VOLUME_DOWN),
            cell(sf_window.Scancode.MEDIA_PLAY_PAUSE),
            cell(sf_window.Scancode.MEDIA_STOP),
            cell(sf_window.Scancode.MEDIA_NEXT_TRACK),
            cell(sf_window.Scancode.MEDIA_PREVIOUS_TRACK),
        ),
        0.0,
    ),
    (
        (
            cell(sf_window.Scancode.BACK),
            cell(sf_window.Scancode.FORWARD),
            cell(sf_window.Scancode.REFRESH),
            cell(sf_window.Scancode.STOP),
            cell(sf_window.Scancode.SEARCH),
            cell(sf_window.Scancode.FAVORITES),
            cell(sf_window.Scancode.HOME_PAGE),
            cell(sf_window.Scancode.LAUNCH_APPLICATION1),
            cell(sf_window.Scancode.LAUNCH_APPLICATION2),
            cell(sf_window.Scancode.LAUNCH_MAIL),
            cell(sf_window.Scancode.LAUNCH_MEDIA_SELECT),
        ),
        0.0,
    ),
)

MAX_SCANCODE = max(scancode for row, _ in KEYBOARD_ROWS for scancode, _, _, _ in row)
KNOWN_KEYS = sorted(
    {
        int(sf_window.Keyboard.localize(scancode))
        for row, _ in KEYBOARD_ROWS
        for scancode, _, _, _ in row
        if scancode != UNKNOWN_SCANCODE and int(sf_window.Keyboard.localize(scancode)) != int(sf_window.Key.UNKNOWN)
    }
)


def enum_name(enum_type, value, prefix):
    try:
        return f"{prefix}.{enum_type(int(value)).name}"
    except ValueError:
        return f"{prefix}({int(value)})"


def key_identifier(code):
    return enum_name(sf_window.Key, code, "Key")


def scancode_identifier(scancode):
    return enum_name(sf_window.Scancode, scancode, "Scancode")


def text_event_description(text_entered):
    text = text_entered.unicode or ""
    code_point = ord(text[0]) if text else 0
    return f"Text Entered\n\n{text}\nU+{code_point:04X}"


def event_is_odd(key_event):
    code = int(key_event.code)
    scancode = int(key_event.scancode)
    if code == int(sf_window.Key.UNKNOWN) or scancode == UNKNOWN_SCANCODE:
        return True

    description = sf_window.Keyboard.get_description(scancode)
    return (
        description == ""
        or int(sf_window.Keyboard.localize(scancode)) != code
        or int(sf_window.Keyboard.delocalize(code)) != scancode
    )


def key_event_description(title, key_event):
    description = [title, "", key_identifier(key_event.code), scancode_identifier(key_event.scancode)]
    if event_is_odd(key_event):
        description.extend(
            [
                f"Localized:\t{key_identifier(sf_window.Keyboard.localize(key_event.scancode))}",
                f"Delocalized:\t{scancode_identifier(sf_window.Keyboard.delocalize(key_event.code))}",
            ]
        )
    return "\n".join(description)


def get_spacing_factor(font):
    return LINE_SIZE / float(font.get_line_spacing(TEXT_SIZE))


def make_text(font, string, position):
    text = sf_graphics.Text(font, string, TEXT_SIZE)
    text.line_spacing = get_spacing_factor(font)
    text.position = position
    text.fill_color = sf_graphics.Color.WHITE
    return text


class ShinyText:
    DURATION = 0.150

    def __init__(self, font, string, position):
        self.text = make_text(font, string, position)
        self.text.outline_thickness = 2.0
        self._remaining = 0.0

    def set_string(self, string):
        self.text.string = string

    def shine(self, color=sf_graphics.Color.YELLOW):
        self.text.outline_color = color
        self._remaining = self.DURATION

    def update(self, frame_time_seconds):
        ratio = self._remaining / self.DURATION if self.DURATION else 0.0
        alpha = max(0.0, ratio * (2.0 - ratio)) * 0.5
        color = self.text.outline_color
        self.text.outline_color = sf_graphics.Color(color.r, color.g, color.b, int(255 * alpha))
        if self._remaining > 0.0:
            self._remaining = max(0.0, self._remaining - frame_time_seconds)


class KeyboardView(sf_graphics.Drawable):
    CORNERS = ((0.0, 0.0), (1.0, 0.0), (0.0, 1.0), (0.0, 1.0), (1.0, 0.0), (1.0, 1.0))

    def __init__(self, font, position=(16.0, 16.0)):
        super().__init__()
        self.position = position
        self.triangles = sf_graphics.VertexArray(sf_graphics.PrimitiveType.TRIANGLES, (MAX_SCANCODE + 1) * 6)
        self.labels = [None] * (MAX_SCANCODE + 1)
        self.move_factors = [0.0] * (MAX_SCANCODE + 1)

        for scancode, rect in self._iter_key_rectangles():
            index = int(scancode)
            localized = int(sf_window.Keyboard.delocalize(sf_window.Keyboard.localize(scancode)))
            base_color = sf_graphics.Color.RED if localized != index else sf_graphics.Color.WHITE

            label = sf_graphics.Text(font, sf_window.Keyboard.get_description(scancode), 14)
            label.fill_color = base_color
            label.position = (rect["x"] + rect["width"] / 2.0, rect["y"] + rect["height"] / 2.0)

            bounds = label.local_bounds
            if rect["width"] < bounds.size.x + PADDING * 2.0 + 2.0:
                label.string = label.string.replace(" ", "\n")

            while rect["width"] < label.local_bounds.size.x + PADDING * 2.0 + 2.0 and label.character_size > 6:
                label.character_size -= 2

            bounds = label.local_bounds
            label.origin = (
                round(bounds.position.x + bounds.size.x / 2.0),
                round(label.character_size / 2.0),
            )
            self.labels[index] = label

            for vertex_offset in range(6):
                vertex = self.triangles[index * 6 + vertex_offset]
                vertex.color = base_color
                self.triangles[index * 6 + vertex_offset] = vertex

    def _iter_key_rectangles(self):
        x = 0.0
        y = 0.0
        for cells, margin_bottom in KEYBOARD_ROWS:
            for scancode, width, height, margin_right in cells:
                yield scancode, {"x": x, "y": y, "width": width, "height": height}
                x += width + margin_right
            x = 0.0
            y += KEY_SIZE + margin_bottom

    def handle(self, event):
        if isinstance(event, sf_window.KeyPressedEvent) and int(event.scancode) != UNKNOWN_SCANCODE:
            self.move_factors[int(event.scancode)] = 1.0
        elif isinstance(event, sf_window.KeyReleasedEvent) and int(event.scancode) != UNKNOWN_SCANCODE:
            self.move_factors[int(event.scancode)] = -1.0

    def update(self, frame_time):
        transition_duration = 0.200
        frame_time_seconds = frame_time.seconds

        for index, factor in enumerate(self.move_factors):
            absolute_change = min(abs(factor), frame_time_seconds / transition_duration if transition_duration else 0.0)
            if factor > 0.0:
                self.move_factors[index] = factor - absolute_change
            else:
                self.move_factors[index] = factor + absolute_change

        for scancode, rect in self._iter_key_rectangles():
            index = int(scancode)
            move_factor = self.move_factors[index]
            move_y = 2.0 * move_factor * (1.0 - abs(move_factor)) * PADDING
            pressed = sf_window.Keyboard.is_scancode_pressed(scancode)

            for vertex_offset, (corner_x, corner_y) in enumerate(self.CORNERS):
                vertex = self.triangles[index * 6 + vertex_offset]
                vertex.position = (
                    self.position[0] + rect["x"] + PADDING + (rect["width"] - 2.0 * PADDING) * corner_x,
                    self.position[1] + rect["y"] + PADDING + (rect["height"] - 2.0 * PADDING) * corner_y + move_y,
                )
                color = vertex.color
                vertex.color = sf_graphics.Color(color.r, color.g, color.b, 96 if pressed else 48)
                self.triangles[index * 6 + vertex_offset] = vertex

            label = self.labels[index]
            if label is not None:
                label.position = (
                    self.position[0] + rect["x"] + rect["width"] / 2.0,
                    self.position[1] + rect["y"] + rect["height"] / 2.0 + move_y,
                )

    def draw(self, target, states):
        target.draw(self.triangles, states)
        for label in self.labels:
            if label is not None:
                target.draw(label, states)


def main():
    window = sf_graphics.RenderWindow(
        sf_window.VideoMode(1280, 720),
        "pySFML - Keyboard",
        sf_window.Style.TITLEBAR | sf_window.Style.CLOSE,
    )
    window.set_framerate_limit(25)

    error_buffer = sf_audio.SoundBuffer.from_file(str(RESOURCE_DIR / "error_005.ogg"))
    pressed_buffer = sf_audio.SoundBuffer.from_file(str(RESOURCE_DIR / "mouseclick1.ogg"))
    released_buffer = sf_audio.SoundBuffer.from_file(str(RESOURCE_DIR / "mouserelease1.ogg"))

    error_sound = sf_audio.Sound(error_buffer)
    pressed_sound = sf_audio.Sound(pressed_buffer)
    released_sound = sf_audio.Sound(released_buffer)

    font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "Tuffy.ttf"))
    keyboard_view = KeyboardView(font)

    key_pressed_text = ShinyText(font, "Key Pressed", (16, 575))
    key_released_text = ShinyText(font, "Key Released", (300, 575))
    text_entered_text = ShinyText(font, "Text Entered", (600, 575))
    key_pressed_check_text = make_text(font, "", (900, 575))

    clock = sf_system.Clock()

    while window.is_open:
        for event in window.events:
            if isinstance(event, sf_window.ClosedEvent):
                window.close()
            elif isinstance(event, sf_window.ResizedEvent):
                window.view = sf_graphics.View((0, 0, event.size.x, event.size.y))

            if isinstance(event, sf_window.KeyPressedEvent):
                key_pressed_text.set_string(key_event_description("Key Pressed", event))
                if event_is_odd(event):
                    key_pressed_text.shine(sf_graphics.Color.RED)
                    error_sound.play()
                else:
                    key_pressed_text.shine(sf_graphics.Color.GREEN)
                    pressed_sound.play()
            elif isinstance(event, sf_window.KeyReleasedEvent):
                key_released_text.set_string(key_event_description("Key Released", event))
                if event_is_odd(event):
                    key_released_text.shine(sf_graphics.Color.RED)
                    error_sound.play()
                else:
                    key_released_text.shine(sf_graphics.Color.GREEN)
                    released_sound.play()
            elif isinstance(event, sf_window.TextEnteredEvent):
                text_entered_text.set_string(text_event_description(event))
                text_entered_text.shine()

            keyboard_view.handle(event)

        frame_time = clock.restart()
        keyboard_view.update(frame_time)
        key_pressed_text.update(frame_time.seconds)
        key_released_text.update(frame_time.seconds)
        text_entered_text.update(frame_time.seconds)

        pressed_lines = ["is_key_pressed(sfml.window.Key)", ""]
        for key_code in KNOWN_KEYS:
            if sf_window.Keyboard.is_key_pressed(key_code):
                pressed_lines.append(key_identifier(key_code))
        key_pressed_check_text.string = "\n".join(pressed_lines)

        window.clear()
        window.draw(keyboard_view)
        window.draw(key_pressed_text.text)
        window.draw(key_released_text.text)
        window.draw(text_entered_text.text)
        window.draw(key_pressed_check_text)
        window.display()


if __name__ == "__main__":
    main()