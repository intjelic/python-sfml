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
    with pytest.raises(TypeError):
        sf.Vector2(1, 2) < sf.Vector2(2, 3)


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


def test_clock_and_sleep_are_usable():
    clock = sf.Clock()

    sf.sleep(sf.milliseconds(5))
    elapsed = clock.elapsed_time

    assert elapsed.microseconds >= 3_000
    assert clock.restart().microseconds >= 3_000
    assert clock.elapsed_time.microseconds >= 0