import os
import threading
import time

import pytest

import sfml.window as sf


requires_display = pytest.mark.skipif(
    not os.environ.get("DISPLAY"),
    reason="requires an X11 display or xvfb-run",
)


def _create_window():
    return sf.Window(sf.VideoMode(96, 72), "PySFML Xvfb", sf.Style.DEFAULT)


def _drain_events(window):
    while window.poll_event() is not None:
        pass


@requires_display
def test_window_poll_event_reports_startup_event_under_display():
    window = _create_window()

    try:
        assert window.is_open is True

        deadline = time.monotonic() + 1.0
        while time.monotonic() < deadline:
            event = window.poll_event()
            if event is None:
                time.sleep(0.01)
                continue

            if event == sf.Event.RESIZED:
                current_size = tuple(window.size)
                assert event["width"] == current_size[0]
                assert event["height"] == current_size[1]

            return

        pytest.fail("expected poll_event() to produce at least one startup event")

        window.close()

        assert window.is_open is False
        assert window.poll_event() is None
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_wait_event_reports_startup_event_under_display():
    window = _create_window()

    try:
        def close_later():
            time.sleep(0.25)
            if window.is_open:
                window.close()

        threading.Thread(target=close_later, daemon=True).start()

        event = window.wait_event()

        assert event is not None

        if event == sf.Event.RESIZED:
            current_size = tuple(window.size)
            assert event["width"] == current_size[0]
            assert event["height"] == current_size[1]
    finally:
        if window.is_open:
            window.close()