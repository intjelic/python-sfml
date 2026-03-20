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
        "pySFML - Raw Mouse Input",
        sf_window.Style.TITLEBAR | sf_window.Style.CLOSE,
    )
    window.set_vertical_synchronization_enabled(True)

    font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "tuffy.ttf"))

    mouse_position = sf_graphics.Text(font, "Mouse Position: (0, 0)", 20)
    mouse_position.position = (400, 300)
    mouse_position.fill_color = sf_graphics.Color.WHITE

    mouse_raw_movement = sf_graphics.Text(font, "", 20)
    mouse_raw_movement.fill_color = sf_graphics.Color.WHITE

    log: list[str] = []

    while window.is_open:
        for event in window.events:
            if isinstance(event, sf_window.ClosedEvent):
                window.close()
            elif isinstance(event, sf_window.MouseMovedEvent):
                mouse_position.string = f"Mouse Position: {format_position(event.position)}"
            elif isinstance(event, sf_window.MouseMovedRawEvent):
                log.append(f"Mouse Movement: {format_position(event.delta)}")
                if len(log) > MAX_LOG_LINES:
                    del log[0]

        window.clear()
        window.draw(mouse_position)

        for index, message in enumerate(log):
            mouse_raw_movement.position = (50, index * 20 + 50)
            mouse_raw_movement.string = message
            window.draw(mouse_raw_movement)

        window.display()


if __name__ == "__main__":
    main()