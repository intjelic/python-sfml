from pathlib import Path

from sfml import graphics as sf_graphics
from sfml import window as sf_window


RESOURCE_DIR = Path(__file__).resolve().parent / "resources"
MAX_LOG_LINES = 24


def format_position(vector) -> str:
    return f"({int(vector.x)}, {int(vector.y)})"


def main() -> None:
    window = sf_graphics.RenderWindow(
        sf_window.VideoMode(800, 600),
        "pySFML - Event Handling",
        sf_window.Style.TITLEBAR | sf_window.Style.CLOSE,
    )
    window.set_vertical_synchronization_enabled(True)

    font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "tuffy.ttf"))
    log_text = sf_graphics.Text(font, "", 20)
    log_text.fill_color = sf_graphics.Color.WHITE

    handler_text = sf_graphics.Text(font, "Current Handler: Concrete Event Classes", 24)
    handler_text.position = (280, 260)
    handler_text.fill_color = sf_graphics.Color.WHITE
    handler_text.style = sf_graphics.TextStyle.BOLD

    instructions = sf_graphics.Text(font, "Press Enter to clear the log", 24)
    instructions.position = (300, 310)
    instructions.fill_color = sf_graphics.Color.WHITE
    instructions.style = sf_graphics.TextStyle.BOLD

    log: list[str] = []

    def push(message: str) -> None:
        log.append(message)
        if len(log) > MAX_LOG_LINES:
            del log[: len(log) - MAX_LOG_LINES]

    while window.is_open:
        for event in window.events:
            if isinstance(event, sf_window.ClosedEvent):
                window.close()
            elif isinstance(event, sf_window.KeyPressedEvent):
                description = sf_window.Keyboard.get_description(event.scancode)
                push(f"Key Pressed: {description}")
                if event.scancode == sf_window.Scancode.ESCAPE:
                    window.close()
                elif event.scancode == sf_window.Scancode.ENTER:
                    log.clear()
            elif isinstance(event, sf_window.MouseMovedEvent):
                push(f"Mouse Moved: {format_position(event.position)}")
            elif isinstance(event, sf_window.MouseButtonPressedEvent):
                push(f"Mouse Pressed: {event.button} at {format_position(event.position)}")
            elif isinstance(event, sf_window.TouchBeganEvent):
                push(f"Touch Began: finger {event.finger} at {format_position(event.position)}")
            elif isinstance(event, sf_window.MouseMovedRawEvent):
                push(f"Mouse Raw Delta: {format_position(event.delta)}")

        window.clear()

        for index, message in enumerate(log):
            log_text.position = (50, index * 20 + 50)
            log_text.string = message
            window.draw(log_text)

        window.draw(handler_text)
        window.draw(instructions)
        window.display()


if __name__ == "__main__":
    main()