import pytest

import sfml.window as sf


def test_state_is_explicit_and_fullscreen_is_not_a_style_flag():
    assert sf.State.WINDOWED != sf.State.FULLSCREEN
    assert sf.State.FULLSCREEN == 1
    assert not hasattr(sf.Style, "FULLSCREEN")



def test_obsolete_mouse_wheel_moved_event_is_not_part_of_sfml3_surface():
    assert not hasattr(sf.EventType, "MOUSE_WHEEL_MOVED")
    assert not hasattr(sf.Event, "MOUSE_WHEEL_MOVED")


def test_legacy_event_payload_wrappers_are_not_part_of_sfml3_surface():
    for name in (
        "SizeEvent",
        "KeyEvent",
        "TextEvent",
        "MouseMoveEvent",
        "MouseButtonEvent",
        "MouseWheelEvent",
        "MouseWheelScrollEvent",
        "JoystickMoveEvent",
        "JoystickButtonEvent",
        "JoystickConnectEvent",
        "TouchEvent",
        "SensorEvent",
    ):
        assert not hasattr(sf, name)



def test_videomode_and_contextsettings_are_usable_without_a_window():
    mode = sf.VideoMode(640, 480, 32)

    assert tuple(mode) == (640, 480, 32)
    assert mode.width == 640
    assert mode.height == 480
    assert mode.bits_per_pixel == 32
    assert isinstance(mode.is_valid(), bool)

    settings = sf.ContextSettings(24, 8, 4, 4, 1)

    assert settings.depth_bits == 24
    assert settings.stencil_bits == 8
    assert settings.antialiasing_level == 4
    assert settings.major_version == 4
    assert settings.minor_version == 1
    assert settings.srgb_capable is False



def test_videomode_ordering_and_fullscreen_modes_have_stable_shapes():
    low = sf.VideoMode(640, 480, 16)
    high = sf.VideoMode(640, 480, 32)
    modes = sf.VideoMode.get_fullscreen_modes()

    assert low < high
    assert low <= high
    assert high > low
    assert high >= low
    assert isinstance(modes, list)

    for mode in modes[:5]:
        assert isinstance(mode, sf.VideoMode)
        assert len(tuple(mode)) == 3
        assert all(isinstance(value, int) for value in tuple(mode))



def test_contextsettings_iterates_as_documented_tuple_shape():
    settings = sf.ContextSettings(24, 8, 4, 3, 2, sf.Attribute.DEBUG)

    assert tuple(settings) == (24, 8, 4, 3, 2)



def test_contextsettings_attribute_flags_are_exposed_and_mutable():
    settings = sf.ContextSettings(24, 8, 4, 3, 2, sf.Attribute.DEBUG)

    assert settings.attribute_flags == sf.Attribute.DEBUG

    settings.attribute_flags = sf.Attribute.CORE

    assert settings.attribute_flags == sf.Attribute.CORE



def test_contextsettings_expose_srgb_capability_flag():
    settings = sf.ContextSettings()

    assert settings.srgb_capable is False

    settings.srgb_capable = True

    assert settings.srgb_capable is True



def test_typed_event_classes_are_constructible_without_a_window():
    key_event = sf.KeyPressedEvent()
    key_event.code = sf.Key.A
    key_event.scancode = sf.Scancode.A
    key_event.alt = True
    key_event.control = False
    key_event.shift = True
    key_event.system = False

    assert key_event.type == sf.Event.KEY_PRESSED
    assert key_event.code == sf.Key.A
    assert key_event.scancode == sf.Scancode.A
    assert key_event.alt is True
    assert key_event.shift is True

    resized = sf.ResizedEvent()
    resized.size = (800, 600)

    assert resized.type == sf.Event.RESIZED
    assert tuple(resized.size) == (800, 600)

    raw_mouse = sf.MouseMovedRawEvent()
    raw_mouse.delta = (3, -2)

    assert raw_mouse.type == sf.Event.MOUSE_MOVED_RAW
    assert tuple(raw_mouse.delta) == (3, -2)


def test_window_size_constraints_round_trip_as_python_state():
    window = sf.Window()

    assert window.minimum_size is None
    assert window.maximum_size is None

    window.minimum_size = (320, 240)
    window.maximum_size = (1280, 720)

    assert tuple(window.minimum_size) == (320, 240)
    assert tuple(window.maximum_size) == (1280, 720)

    window.minimum_size = None
    window.maximum_size = None

    assert window.minimum_size is None
    assert window.maximum_size is None


def test_window_cursor_grab_method_is_exposed():
    window = sf.Window()

    window.set_mouse_cursor_grabbed(False)


def test_window_uses_explicit_methods_for_setter_only_operations():
    window = sf.Window()

    for attribute_name, value in (
        ("title", "PySFML"),
        ("visible", True),
        ("vertical_synchronization", True),
        ("mouse_cursor_visible", True),
        ("key_repeat_enabled", True),
        ("framerate_limit", 60),
        ("joystick_threshold", 15.0),
        ("active", False),
    ):
        with pytest.raises(AttributeError):
            setattr(window, attribute_name, value)

    assert callable(window.set_title)
    assert callable(window.set_visible)
    assert callable(window.set_vertical_synchronization_enabled)
    assert callable(window.set_mouse_cursor_visible)
    assert callable(window.set_key_repeat_enabled)
    assert callable(window.set_framerate_limit)
    assert callable(window.set_joystick_threshold)
    assert callable(window.set_active)



def test_keyboard_scancode_helpers_are_exposed():
    assert sf.Keyboard.localize(sf.Scancode.A) == sf.Key.A
    assert sf.Keyboard.delocalize(sf.Key.A) == sf.Scancode.A
    assert isinstance(sf.Keyboard.is_scancode_pressed(sf.Scancode.A), bool)

    description = sf.Keyboard.get_description(sf.Scancode.A)

    assert isinstance(description, str)
    assert description


def test_scancode_enum_matches_extended_sfml3_surface():
    assert sf.Scancode.F24 == 75
    assert sf.Scancode.CAPS_LOCK == 76
    assert sf.Scancode.NUMPAD_ENTER == 96
    assert sf.Scancode.NON_US_BACKSLASH == 108
    assert sf.Scancode.MEDIA_PREVIOUS_TRACK == 126
    assert sf.Scancode.L_SYSTEM == 130
    assert sf.Scancode.LAUNCH_MEDIA_SELECT == 145



def test_clipboard_get_string_returns_python_text():
    assert isinstance(sf.Clipboard.get_string(), str)



def test_cursor_can_be_created_from_a_system_type_when_supported():
    try:
        cursor = sf.Cursor.from_system(sf.CursorType.ARROW)
    except RuntimeError:
        pytest.skip("system cursor type is not available on this host")

    assert cursor is not None



def test_keyboard_facade_constants_match_key_enum_values():
    assert sf.Keyboard.Q == sf.Key.Q
    assert sf.Keyboard.SPACE == sf.Key.SPACE
    assert sf.Keyboard.KEY_COUNT == sf.Key.KEY_COUNT



def test_context_uses_explicit_set_active_api():
    context = sf.Context()

    with pytest.raises(AttributeError):
        _ = context.active

    with pytest.raises(AttributeError):
        context.active = False

    assert context.set_active(False) is True


def test_context_exposes_settings_and_gl_helper_functions():
    context = sf.Context()

    assert isinstance(context.settings, sf.ContextSettings)
    assert sf.Context.get_active_context() is context

    active_context_id = sf.Context.get_active_context_id()

    assert isinstance(active_context_id, int)
    assert active_context_id > 0
    assert isinstance(sf.Context.is_extension_available("GL_ARB_multitexture"), bool)

    function_pointer = sf.Context.get_function("glGetString")

    assert isinstance(function_pointer, int)
    assert function_pointer != 0

    assert context.set_active(False) is True
    assert sf.Context.get_active_context() is None
    assert sf.Context.get_active_context_id() == 0


def test_context_registry_tracks_multiple_standalone_contexts():
    first = sf.Context()
    second = sf.Context()

    assert sf.Context.get_active_context() is second
    assert second.set_active(False) is True
    assert sf.Context.get_active_context() is None

    assert first.set_active(True) is True
    assert sf.Context.get_active_context() is first
