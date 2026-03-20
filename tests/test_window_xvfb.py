import os
import time

import pytest

import sfml.system as sf_system
import sfml.window as sf


requires_display = pytest.mark.skipif(
    not os.environ.get("DISPLAY"),
    reason="requires an X11 display or xvfb-run",
)



def _create_window(*, state=sf.State.WINDOWED):
    return sf.Window(sf.VideoMode(96, 72), "PySFML Xvfb", sf.Style.DEFAULT, state)



def _drain_events(window):
    while window.poll_event() is not None:
        pass


@requires_display
def test_window_poll_event_returns_typed_event_objects_under_display():
    window = _create_window()

    try:
        assert window.is_open is True

        deadline = time.monotonic() + 1.0
        while time.monotonic() < deadline:
            event = window.poll_event()
            if event is None:
                time.sleep(0.01)
                continue

            assert isinstance(event, sf.Event)

            if isinstance(event, sf.ResizedEvent):
                current_size = tuple(window.size)
                assert tuple(event.size) == current_size

            return

        pytest.fail("expected poll_event() to produce at least one startup event")
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_wait_event_supports_timeouts_under_display():
    window = _create_window()

    try:
        _drain_events(window)

        deadline = time.monotonic() + 1.0
        while time.monotonic() < deadline:
            start = time.monotonic()
            event = window.wait_event(sf_system.milliseconds(75))
            elapsed = time.monotonic() - start

            if event is None:
                assert elapsed >= 0.05
                return

        pytest.fail("expected wait_event(timeout=...) to time out once the queue was drained")
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_wait_event_returns_typed_startup_events_under_display():
    window = _create_window()

    try:
        event = window.wait_event(sf_system.milliseconds(500))

        assert event is not None
        assert isinstance(event, sf.Event)

        if isinstance(event, sf.ResizedEvent):
            current_size = tuple(window.size)
            assert tuple(event.size) == current_size
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_resized_events_track_live_size_changes_under_display():
    window = _create_window()

    try:
        _drain_events(window)

        window.size = (140, 100)
        deadline = time.monotonic() + 1.0
        while time.monotonic() < deadline:
            if tuple(window.size) == (140, 100):
                break
            time.sleep(0.01)

        assert tuple(window.size) == (140, 100)

        resized_event = None
        deadline = time.monotonic() + 0.25
        while time.monotonic() < deadline:
            event = window.poll_event()
            if event is None:
                time.sleep(0.01)
                continue

            if isinstance(event, sf.ResizedEvent):
                resized_event = event
                break

        if resized_event is not None:
            assert tuple(resized_event.size) == (140, 100)
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_applies_size_constraints_and_cursor_grab_under_display():
    window = _create_window()

    try:
        window.minimum_size = (80, 60)
        window.maximum_size = (180, 140)

        assert tuple(window.minimum_size) == (80, 60)
        assert tuple(window.maximum_size) == (180, 140)

        window.set_mouse_cursor_grabbed(False)
        window.set_mouse_cursor_grabbed(True)
        window.set_mouse_cursor_grabbed(False)
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_clipboard_round_trip_under_display_when_supported():
    window = _create_window()

    try:
        _drain_events(window)
        value = "PySFML clipboard round-trip"
        sf.Clipboard.set_string(value)

        deadline = time.monotonic() + 0.5
        while time.monotonic() < deadline:
            if sf.Clipboard.get_string() == value:
                return
            _drain_events(window)
            time.sleep(0.01)

        pytest.skip("clipboard round-trip is not available on this host")
    finally:
        if window.is_open:
            window.close()


@requires_display
def test_window_accepts_a_system_cursor_under_display():
    window = _create_window()

    try:
        try:
            cursor = sf.Cursor.from_system(sf.CursorType.HAND)
        except RuntimeError:
            pytest.skip("system cursor type is not available on this host")

        window.set_mouse_cursor(cursor)
    finally:
        if window.is_open:
            window.close()
