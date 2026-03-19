from math import cos, sin, fabs, pi
from pathlib import Path
from random import randint

from sfml import audio as sf_audio
from sfml import graphics as sf_graphics
from sfml import system as sf_system
from sfml import window as sf_window


DATA_DIR = Path(__file__).resolve().parent / "data"


def main():
    game_size = sf_system.Vector2(800, 600)
    paddle_size = sf_system.Vector2(25, 100)
    ball_radius = 10.0

    render_window = sf_graphics.RenderWindow(sf_window.VideoMode(800, 600), "PySFML - Pong")
    render_window.vertical_synchronization = True

    ball_sound_buffer = sf_audio.SoundBuffer.from_file(str(DATA_DIR / "ball.wav"))
    ball_sound = sf_audio.Sound(ball_sound_buffer)

    left_paddle = sf_graphics.RectangleShape((paddle_size.x - 3, paddle_size.y - 3))
    left_paddle.outline_thickness = 3
    left_paddle.outline_color = sf_graphics.Color.BLACK
    left_paddle.fill_color = sf_graphics.Color(100, 100, 200)
    left_paddle.origin = (left_paddle.size.x / 2, left_paddle.size.y / 2)

    right_paddle = sf_graphics.RectangleShape((paddle_size.x - 3, paddle_size.y - 3))
    right_paddle.outline_thickness = 3
    right_paddle.outline_color = sf_graphics.Color.BLACK
    right_paddle.fill_color = sf_graphics.Color(200, 100, 100)
    right_paddle.origin = (right_paddle.size.x / 2, right_paddle.size.y / 2)

    ball = sf_graphics.CircleShape(ball_radius - 3)
    ball.outline_thickness = 3
    ball.outline_color = sf_graphics.Color.BLACK
    ball.fill_color = sf_graphics.Color.WHITE
    ball.origin = (ball.radius, ball.radius)

    font = sf_graphics.Font.from_file(str(DATA_DIR / "sansation.ttf"))
    pause_message = sf_graphics.Text(
        "Welcome to PySFML pong!\nPress space to start the game",
        font,
        40,
    )
    pause_message.position = (170, 150)
    pause_message.color = sf_graphics.Color.WHITE

    ai_timer = sf_system.Clock()
    ai_time = sf_system.seconds(0.1)
    paddle_speed = 400.0
    right_paddle_speed = 0.0
    ball_speed = 400.0
    ball_angle = 0.0
    clock = sf_system.Clock()
    is_playing = False

    def reset_round():
        left_paddle.position = (10 + paddle_size.x / 2, game_size.y / 2)
        right_paddle.position = (game_size.x - 10 - paddle_size.x / 2, game_size.y / 2)
        ball.position = game_size / 2

        while True:
            angle = randint(0, 359) * 2 * pi / 360
            if not fabs(cos(angle)) < 0.7:
                return angle

    while render_window.is_open:
        for event in render_window.events:
            if event.type == sf_window.EventType.CLOSED:
                render_window.close()
            elif event.type == sf_window.EventType.KEY_PRESSED:
                if event.get("code") == sf_window.Keyboard.ESCAPE:
                    render_window.close()
                elif event.get("code") == sf_window.Keyboard.SPACE and not is_playing:
                    is_playing = True
                    clock.restart()
                    ball_angle = reset_round()

        if is_playing:
            delta_time = clock.restart().seconds

            if sf_window.Keyboard.is_key_pressed(sf_window.Keyboard.UP) and left_paddle.position.y - paddle_size.y / 2 > 5:
                left_paddle.move((0, -paddle_speed * delta_time))
            elif sf_window.Keyboard.is_key_pressed(sf_window.Keyboard.DOWN) and left_paddle.position.y + paddle_size.y / 2 < game_size.y - 5:
                left_paddle.move((0, paddle_speed * delta_time))

            if (right_paddle_speed < 0 and right_paddle.position.y - paddle_size.y / 2 > 5) or (
                right_paddle_speed > 0 and right_paddle.position.y + paddle_size.y / 2 < game_size.y - 5
            ):
                right_paddle.move((0, right_paddle_speed * delta_time))

            if ai_timer.elapsed_time > ai_time:
                ai_timer.restart()
                if ball.position.y + ball_radius > right_paddle.position.y + paddle_size.y / 2:
                    right_paddle_speed = paddle_speed
                elif ball.position.y - ball_radius < right_paddle.position.y - paddle_size.y / 2:
                    right_paddle_speed = -paddle_speed
                else:
                    right_paddle_speed = 0.0

            factor = ball_speed * delta_time
            ball.move((cos(ball_angle) * factor, sin(ball_angle) * factor))

            if ball.position.x - ball_radius < 0:
                is_playing = False
                pause_message.string = "You lost!\nPress space to restart or\nescape to exit"

            if ball.position.x + ball_radius > game_size.x:
                is_playing = False
                pause_message.string = "You won!\nPress space to restart or\nescape to exit"

            if ball.position.y - ball_radius < 0:
                ball_sound.play()
                ball_angle = -ball_angle
                ball.position = (ball.position.x, ball_radius + 0.1)

            if ball.position.y + ball_radius > game_size.y:
                ball_sound.play()
                ball_angle = -ball_angle
                ball.position = (ball.position.x, game_size.y - ball_radius - 0.1)

            if (
                ball.position.x - ball_radius < left_paddle.position.x + paddle_size.x / 2
                and ball.position.x - ball_radius > left_paddle.position.x
                and ball.position.y + ball_radius >= left_paddle.position.y - paddle_size.y / 2
                and ball.position.y - ball_radius <= left_paddle.position.y + paddle_size.y / 2
            ):
                if ball.position.y > left_paddle.position.y:
                    ball_angle = pi - ball_angle + randint(0, 19) * pi / 180
                else:
                    ball_angle = pi - ball_angle - randint(0, 19) * pi / 180

                ball_sound.play()
                ball.position = (left_paddle.position.x + ball_radius + paddle_size.x / 2 + 0.1, ball.position.y)

            if (
                ball.position.x + ball_radius > right_paddle.position.x - paddle_size.x / 2
                and ball.position.x + ball_radius < right_paddle.position.x
                and ball.position.y + ball_radius >= right_paddle.position.y - paddle_size.y / 2
                and ball.position.y - ball_radius <= right_paddle.position.y + paddle_size.y / 2
            ):
                if ball.position.y > right_paddle.position.y:
                    ball_angle = pi - ball_angle + randint(0, 19) * pi / 180
                else:
                    ball_angle = pi - ball_angle - randint(0, 19) * pi / 180

                ball_sound.play()
                ball.position = (right_paddle.position.x - ball_radius - paddle_size.x / 2 - 0.1, ball.position.y)

        render_window.clear(sf_graphics.Color(50, 200, 50))

        if is_playing:
            render_window.draw(left_paddle)
            render_window.draw(right_paddle)
            render_window.draw(ball)
        else:
            render_window.draw(pause_message)

        render_window.display()


if __name__ == "__main__":
    main()
