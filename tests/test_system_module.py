import math

import pytest

import sfml.system as sf


def test_time_factories_and_zero_constant():
    assert sf.Time().microseconds == 0
    assert sf.Time.ZERO.microseconds == 0

    duration = sf.seconds(1.5)

    assert duration.seconds == pytest.approx(1.5)
    assert duration.milliseconds == 1500
    assert duration.microseconds == 1_500_000


def test_time_arithmetic_and_reverse_scalar_multiplication():
    duration = sf.milliseconds(1500)

    assert (duration + sf.milliseconds(500)).milliseconds == 2000
    assert (duration - sf.milliseconds(250)).milliseconds == 1250
    assert (duration / 3).milliseconds == 500
    assert (duration / 2.0).milliseconds == 750
    assert duration / sf.milliseconds(500) == pytest.approx(3.0)
    assert (duration % sf.milliseconds(700)).milliseconds == 100
    assert (2 * sf.milliseconds(5)).milliseconds == 10


def test_time_inplace_operations():
    duration = sf.seconds(1)

    duration += sf.milliseconds(250)
    assert duration.milliseconds == 1250

    duration -= sf.milliseconds(50)
    assert duration.milliseconds == 1200

    duration *= 2
    assert duration.milliseconds == 2400

    duration /= 3
    assert duration.milliseconds == 800

    duration %= sf.milliseconds(300)
    assert duration.milliseconds == 200


def test_vector2_sequence_interop_and_scalar_arithmetic():
    vector = sf.Vector2(3, 4)

    assert tuple(vector) == (3, 4)
    assert vector == (3, 4)
    assert tuple(vector + (1, 2)) == (4, 6)
    assert tuple(vector - (1, 1)) == (2, 3)
    assert tuple(vector * 2) == (6, 8)
    assert tuple(2 * vector) == (6, 8)
    assert (vector / 2).x == pytest.approx(1.5)
    assert (vector / 2).y == pytest.approx(2.0)


def test_vector2_inplace_operations():
    vector = sf.Vector2(3, 4)

    vector += (1, 2)
    assert tuple(vector) == (4, 6)

    vector -= (2, 1)
    assert tuple(vector) == (2, 5)

    vector *= 2
    assert tuple(vector) == (4, 10)

    vector /= 2
    assert vector.x == pytest.approx(2.0)
    assert vector.y == pytest.approx(5.0)


def test_vector2_ordering_is_not_supported():
    left = sf.Vector2(1, 2)
    right = sf.Vector2(1, 2)

    assert left == right
    assert not (left != right)

    with pytest.raises(TypeError) as excinfo:
        left > right

    message = str(excinfo.value)
    assert "not supported" in message
    assert "Vector2" in message
    assert "BaseException" not in message


def test_vector3_sequence_interop_and_scalar_arithmetic():
    vector = sf.Vector3(3, 4, 5)

    assert tuple(vector) == (3, 4, 5)
    assert vector == (3, 4, 5)
    assert tuple(vector + (1, 1, 1)) == (4, 5, 6)
    assert tuple(vector - (1, 2, 3)) == (2, 2, 2)
    assert tuple(vector * 2) == (6, 8, 10)
    assert tuple(2 * vector) == (6, 8, 10)
    assert (vector / 2).x == pytest.approx(1.5)
    assert (vector / 2).y == pytest.approx(2.0)
    assert (vector / 2).z == pytest.approx(2.5)


def test_vector3_inplace_operations():
    vector = sf.Vector3(3, 4, 5)

    vector += (1, 0, -1)
    assert tuple(vector) == (4, 4, 4)

    vector -= (2, 1, 0)
    assert tuple(vector) == (2, 3, 4)

    vector *= 2
    assert tuple(vector) == (4, 6, 8)

    vector /= 2
    assert vector.x == pytest.approx(2.0)
    assert vector.y == pytest.approx(3.0)
    assert vector.z == pytest.approx(4.0)


def test_vector3_ordering_is_not_supported():
    with pytest.raises(TypeError):
        sf.Vector3(1, 2, 3) < sf.Vector3(3, 2, 1)


def test_clock_lifecycle_and_sleep_are_usable():
    clock = sf.Clock()

    assert clock.is_running is True

    sf.sleep(sf.milliseconds(5))
    elapsed = clock.elapsed_time

    assert elapsed.microseconds >= 3_000

    clock.stop()
    stopped = clock.elapsed_time.microseconds
    assert clock.is_running is False

    sf.sleep(sf.milliseconds(5))
    assert clock.elapsed_time.microseconds == pytest.approx(stopped, abs=1_000)

    clock.start()
    assert clock.is_running is True

    sf.sleep(sf.milliseconds(5))
    assert clock.elapsed_time.microseconds >= stopped + 3_000

    restarted = clock.restart()
    assert restarted.microseconds >= 3_000
    assert clock.is_running is True
    assert clock.elapsed_time.microseconds >= 0

    clock.stop()
    reset_elapsed = clock.reset()
    assert reset_elapsed.microseconds >= 0
    assert clock.is_running is False

    reset_value = clock.elapsed_time.microseconds
    sf.sleep(sf.milliseconds(2))
    assert clock.elapsed_time.microseconds == pytest.approx(reset_value, abs=500)


def test_angle_factories_and_normalization_helpers():
    assert sf.Angle.ZERO.degrees == pytest.approx(0.0)
    assert sf.Angle().radians == pytest.approx(0.0)
    assert sf.degrees(180).radians == pytest.approx(math.pi)
    assert sf.radians(math.pi / 2).degrees == pytest.approx(90.0)
    assert sf.degrees(540).wrap_signed().degrees == pytest.approx(-180.0)
    assert sf.degrees(-90).wrap_unsigned().degrees == pytest.approx(270.0)


def test_angle_arithmetic_and_inplace_operations():
    angle = sf.degrees(90)
    other = sf.degrees(30)

    assert (angle + other).degrees == pytest.approx(120.0)
    assert (angle - other).degrees == pytest.approx(60.0)
    assert (angle * 2).degrees == pytest.approx(180.0)
    assert (2 * angle).degrees == pytest.approx(180.0)
    assert (angle / 2).degrees == pytest.approx(45.0)
    assert angle / other == pytest.approx(3.0)
    assert (sf.degrees(-90) % sf.degrees(40)).degrees == pytest.approx(30.0)
    assert (-angle).degrees == pytest.approx(-90.0)

    angle += sf.degrees(15)
    assert angle.degrees == pytest.approx(105.0)

    angle -= sf.degrees(45)
    assert angle.degrees == pytest.approx(60.0)

    angle *= 2
    assert angle.degrees == pytest.approx(120.0)

    angle /= 3
    assert angle.degrees == pytest.approx(40.0)

    angle %= sf.degrees(15)
    assert angle.degrees == pytest.approx(10.0)
