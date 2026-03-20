from pathlib import Path

from sfml import graphics as sf_graphics
from sfml import window as sf_window


RESOURCE_DIR = Path(__file__).resolve().parent / "resources"
WINDOW_SIZE = (520, 860)
LINE_HEIGHT = 20
THRESHOLD_STEP = 0.1
MIN_THRESHOLD = 0.1
MAX_THRESHOLD = 100.0
AXES = (
    (sf_window.Axis.X, "X"),
    (sf_window.Axis.Y, "Y"),
    (sf_window.Axis.Z, "Z"),
    (sf_window.Axis.R, "R"),
    (sf_window.Axis.U, "U"),
    (sf_window.Axis.V, "V"),
    (sf_window.Axis.POV_X, "PovX"),
    (sf_window.Axis.POV_Y, "PovY"),
)


def first_connected_joystick() -> int | None:
    for joystick_id in range(sf_window.Joystick.COUNT):
        if sf_window.Joystick.is_connected(joystick_id):
            return joystick_id
    return None


def build_lines(active_joystick: int | None, threshold: float) -> list[str]:
    threshold_line = f"{threshold:.1f}  (Change with up/down arrow keys)"

    if active_joystick is None:
        return [
            "<Not Connected>",
            "",
            f"Threshold: {threshold_line}",
            "",
            "Connect a joystick to inspect its state.",
            "Press Escape to close the window.",
        ]

    name, vendor_id, product_id = sf_window.Joystick.get_identification(active_joystick)
    lines = [
        f"Joystick {active_joystick}:",
        f"Name: {name or '<Unnamed>'}",
        f"Vendor ID: 0x{vendor_id:04X}",
        f"Product ID: 0x{product_id:04X}",
        "",
        f"Threshold: {threshold_line}",
        "",
        "Axes:",
    ]

    for axis, label in AXES:
        if sf_window.Joystick.has_axis(active_joystick, axis):
            position = sf_window.Joystick.get_axis_position(active_joystick, axis)
            lines.append(f"  {label}: {position:6.2f}")
        else:
            lines.append(f"  {label}: N/A")

    button_count = sf_window.Joystick.get_button_count(active_joystick)
    lines.append("")
    lines.append("Buttons:")
    for button in range(button_count):
        pressed = sf_window.Joystick.is_button_pressed(active_joystick, button)
        lines.append(f"  Button {button:02d}: {'true' if pressed else 'false'}")

    return lines


def main() -> None:
    window = sf_graphics.RenderWindow(
        sf_window.VideoMode(*WINDOW_SIZE),
        "pySFML - Joystick",
        sf_window.Style.TITLEBAR | sf_window.Style.CLOSE,
    )
    window.set_vertical_synchronization_enabled(True)

    font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "tuffy.ttf"))

    header_text = sf_graphics.Text(font, "Joystick", 24)
    header_text.position = (12, 8)
    header_text.fill_color = sf_graphics.Color.WHITE
    header_text.style = sf_graphics.TextStyle.BOLD

    body_text = sf_graphics.Text(font, "", 16)
    body_text.position = (12, 44)
    body_text.fill_color = sf_graphics.Color.WHITE
    body_text.line_spacing = LINE_HEIGHT / float(font.get_line_spacing(16))

    threshold = MIN_THRESHOLD
    active_joystick = first_connected_joystick()

    while window.is_open:
        for event in window.events:
            if isinstance(event, sf_window.ClosedEvent):
                window.close()
            elif isinstance(event, sf_window.KeyPressedEvent):
                if event.scancode == sf_window.Scancode.ESCAPE:
                    window.close()
                elif event.scancode == sf_window.Scancode.UP:
                    threshold = min(MAX_THRESHOLD, threshold + THRESHOLD_STEP)
                    window.set_joystick_threshold(threshold)
                elif event.scancode == sf_window.Scancode.DOWN:
                    threshold = max(MIN_THRESHOLD, threshold - THRESHOLD_STEP)
                    window.set_joystick_threshold(threshold)
            elif isinstance(event, sf_window.JoystickConnectedEvent):
                active_joystick = event.joystick_id
            elif isinstance(event, sf_window.JoystickDisconnectedEvent):
                if active_joystick == event.joystick_id:
                    active_joystick = first_connected_joystick()

        sf_window.Joystick.update()
        if active_joystick is not None and not sf_window.Joystick.is_connected(active_joystick):
            active_joystick = first_connected_joystick()

        body_text.string = "\n".join(build_lines(active_joystick, threshold))

        window.clear()
        window.draw(header_text)
        window.draw(body_text)
        window.display()


if __name__ == "__main__":
    main()