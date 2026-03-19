import pytest

import sfml.window as sf


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


def test_event_payload_is_mapping_style_only():
    event = sf.Event(sf.Event.KEY_PRESSED)
    code = event['code']

    assert event.type == sf.Event.KEY_PRESSED
    assert event == sf.Event.KEY_PRESSED
    assert event != sf.Event.CLOSED
    assert 'code' in event
    assert event.get('code') == code
    assert dict(event.items())['code'] == code

    with pytest.raises(AttributeError, match="has no attribute 'code'"):
        _ = event.code


def test_closed_event_has_no_payload_data():
    event = sf.Event(sf.Event.CLOSED)

    assert event.type == sf.Event.CLOSED
    assert 'code' not in event
    assert event.get('code') is None
    assert list(event.items()) == []

    with pytest.raises(KeyError, match='Event has no data'):
        _ = event['code']


def test_context_active_is_write_only():
    context = sf.Context()

    with pytest.raises(AttributeError, match="not readable"):
        _ = context.active

    context.active = False