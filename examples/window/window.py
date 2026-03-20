from OpenGL.GL import (
    GL_COLOR_BUFFER_BIT,
    GL_DEPTH_BUFFER_BIT,
    GL_DEPTH_TEST,
    GL_LIGHTING,
    GL_MODELVIEW,
    GL_PROJECTION,
    GL_TEXTURE_2D,
    GL_TRIANGLES,
    GL_TRUE,
    glBegin,
    glClear,
    glClearColor,
    glClearDepth,
    glColor4f,
    glDepthMask,
    glDisable,
    glEnable,
    glEnd,
    glFrustum,
    glLoadIdentity,
    glMatrixMode,
    glRotatef,
    glTranslatef,
    glVertex3f,
    glViewport,
)

from sfml import system as sf_system
from sfml import window as sf_window


CUBE_VERTICES = (
    ((-50.0, -50.0, -50.0), (0.0, 0.0, 1.0, 1.0)),
    ((-50.0, 50.0, -50.0), (0.0, 0.0, 1.0, 1.0)),
    ((-50.0, -50.0, 50.0), (0.0, 0.0, 1.0, 1.0)),
    ((-50.0, -50.0, 50.0), (0.0, 0.0, 1.0, 1.0)),
    ((-50.0, 50.0, -50.0), (0.0, 0.0, 1.0, 1.0)),
    ((-50.0, 50.0, 50.0), (0.0, 0.0, 1.0, 1.0)),
    ((50.0, -50.0, -50.0), (0.0, 1.0, 0.0, 1.0)),
    ((50.0, 50.0, -50.0), (0.0, 1.0, 0.0, 1.0)),
    ((50.0, -50.0, 50.0), (0.0, 1.0, 0.0, 1.0)),
    ((50.0, -50.0, 50.0), (0.0, 1.0, 0.0, 1.0)),
    ((50.0, 50.0, -50.0), (0.0, 1.0, 0.0, 1.0)),
    ((50.0, 50.0, 50.0), (0.0, 1.0, 0.0, 1.0)),
    ((-50.0, -50.0, -50.0), (1.0, 0.0, 0.0, 1.0)),
    ((50.0, -50.0, -50.0), (1.0, 0.0, 0.0, 1.0)),
    ((-50.0, -50.0, 50.0), (1.0, 0.0, 0.0, 1.0)),
    ((-50.0, -50.0, 50.0), (1.0, 0.0, 0.0, 1.0)),
    ((50.0, -50.0, -50.0), (1.0, 0.0, 0.0, 1.0)),
    ((50.0, -50.0, 50.0), (1.0, 0.0, 0.0, 1.0)),
    ((-50.0, 50.0, -50.0), (0.0, 1.0, 1.0, 1.0)),
    ((50.0, 50.0, -50.0), (0.0, 1.0, 1.0, 1.0)),
    ((-50.0, 50.0, 50.0), (0.0, 1.0, 1.0, 1.0)),
    ((-50.0, 50.0, 50.0), (0.0, 1.0, 1.0, 1.0)),
    ((50.0, 50.0, -50.0), (0.0, 1.0, 1.0, 1.0)),
    ((50.0, 50.0, 50.0), (0.0, 1.0, 1.0, 1.0)),
    ((-50.0, -50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((50.0, -50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((-50.0, 50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((-50.0, 50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((50.0, -50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((50.0, 50.0, -50.0), (1.0, 0.0, 1.0, 1.0)),
    ((-50.0, -50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
    ((50.0, -50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
    ((-50.0, 50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
    ((-50.0, 50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
    ((50.0, -50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
    ((50.0, 50.0, 50.0), (1.0, 1.0, 0.0, 1.0)),
)


def configure_projection(size) -> None:
    width = max(int(size.x), 1)
    height = max(int(size.y), 1)

    glViewport(0, 0, width, height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    ratio = width / float(height)
    glFrustum(-ratio, ratio, -1.0, 1.0, 1.0, 500.0)


def draw_cube() -> None:
    glBegin(GL_TRIANGLES)
    for position, color in CUBE_VERTICES:
        glColor4f(*color)
        glVertex3f(*position)
    glEnd()


def main() -> None:
    context_settings = sf_window.ContextSettings(depth=24)
    window = sf_window.Window(
        sf_window.VideoMode(640, 480),
        "pySFML window with OpenGL",
        sf_window.Style.DEFAULT,
        sf_window.State.WINDOWED,
        context_settings,
    )

    if not window.set_active():
        raise RuntimeError("failed to activate the window OpenGL context")

    glClearDepth(1.0)
    glClearColor(0.0, 0.0, 0.0, 1.0)
    glEnable(GL_DEPTH_TEST)
    glDepthMask(GL_TRUE)
    glDisable(GL_LIGHTING)
    glDisable(GL_TEXTURE_2D)

    configure_projection(window.size)
    clock = sf_system.Clock()

    while window.is_open:
        for event in window.events:
            if isinstance(event, sf_window.ClosedEvent):
                window.close()
            elif isinstance(event, sf_window.KeyPressedEvent) and event.scancode == sf_window.Scancode.ESCAPE:
                window.close()
            elif isinstance(event, sf_window.ResizedEvent):
                configure_projection(event.size)

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

        elapsed_seconds = clock.elapsed_time.seconds

        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()
        glTranslatef(0.0, 0.0, -200.0)
        glRotatef(elapsed_seconds * 50.0, 1.0, 0.0, 0.0)
        glRotatef(elapsed_seconds * 30.0, 0.0, 1.0, 0.0)
        glRotatef(elapsed_seconds * 90.0, 0.0, 0.0, 1.0)

        draw_cube()
        window.display()


if __name__ == "__main__":
    main()