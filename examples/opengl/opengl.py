from pathlib import Path

from OpenGL.GL import GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT, GL_DEPTH_TEST, GL_LINEAR, GL_LINEAR_MIPMAP_LINEAR, GL_MODELVIEW, GL_PROJECTION, GL_QUADS, GL_RGBA, GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_TEXTURE_MIN_FILTER, GL_TRUE, GL_UNSIGNED_BYTE, glBegin, glBindTexture, glClear, glClearDepth, glColor4f, glDeleteTextures, glDepthMask, glEnable, glEnd, glGenTextures, glLoadIdentity, glMatrixMode, glRotatef, glTexCoord2f, glTexParameteri, glTranslatef, glVertex3f, glViewport
from OpenGL.GLU import gluBuild2DMipmaps, gluPerspective

from sfml import graphics as sf_graphics
from sfml import system as sf_system
from sfml import window as sf_window


RESOURCE_DIR = Path(__file__).resolve().parent / "resources"


def main():
    render_window = sf_graphics.RenderWindow(
        sf_window.VideoMode(800, 600),
        "PySFML - OpenGL",
        sf_window.Style.DEFAULT,
        sf_window.ContextSettings(depth=32),
    )
    render_window.vertical_synchronization = True

    font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "sansation.ttf"))
    background_texture = sf_graphics.Texture.from_file(str(RESOURCE_DIR / "background.jpg"))
    background = sf_graphics.Sprite(background_texture)

    image = sf_graphics.Image.from_file(str(RESOURCE_DIR / "texture.jpg"))
    texture_id = int(glGenTextures(1))
    glBindTexture(GL_TEXTURE_2D, texture_id)
    gluBuild2DMipmaps(
        GL_TEXTURE_2D,
        GL_RGBA,
        image.size.x,
        image.size.y,
        GL_RGBA,
        GL_UNSIGNED_BYTE,
        image.pixels,
    )
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)

    glEnable(GL_DEPTH_TEST)
    glDepthMask(GL_TRUE)
    glClearDepth(1.0)
    glViewport(0, 0, render_window.size.x, render_window.size.y)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(90.0, render_window.size.x / float(render_window.size.y), 1.0, 500.0)

    glEnable(GL_TEXTURE_2D)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    glColor4f(1.0, 1.0, 1.0, 1.0)

    title = sf_graphics.Text("PySFML / OpenGL demo", font)
    title.color = sf_graphics.Color(255, 255, 255, 170)
    title.position = (230, 450)

    clock = sf_system.Clock()

    try:
        while render_window.is_open:
            for event in render_window.events:
                if event.type == sf_window.EventType.CLOSED:
                    render_window.close()
                elif event.type == sf_window.EventType.KEY_PRESSED and event.get("code") == sf_window.Keyboard.ESCAPE:
                    render_window.close()
                elif event.type == sf_window.EventType.RESIZED:
                    glViewport(0, 0, event["width"], event["height"])
                    glMatrixMode(GL_PROJECTION)
                    glLoadIdentity()
                    gluPerspective(90.0, event["width"] / float(event["height"]), 1.0, 500.0)

            render_window.push_GL_states()
            render_window.draw(background)
            render_window.pop_GL_states()

            render_window.active = True
            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

            mouse_position = sf_window.Mouse.get_position(render_window)
            x = mouse_position.x * 200.0 / render_window.size.x - 100.0
            y = -mouse_position.y * 200.0 / render_window.size.y + 100.0
            elapsed_seconds = clock.elapsed_time.seconds

            glMatrixMode(GL_MODELVIEW)
            glLoadIdentity()
            glTranslatef(x, y, -100.0)
            glRotatef(elapsed_seconds * 50.0, 1.0, 0.0, 0.0)
            glRotatef(elapsed_seconds * 30.0, 0.0, 1.0, 0.0)
            glRotatef(elapsed_seconds * 90.0, 0.0, 0.0, 1.0)

            size = 20.0
            glBegin(GL_QUADS)

            glTexCoord2f(0, 0)
            glVertex3f(-size, -size, -size)
            glTexCoord2f(0, 1)
            glVertex3f(-size, size, -size)
            glTexCoord2f(1, 1)
            glVertex3f(size, size, -size)
            glTexCoord2f(1, 0)
            glVertex3f(size, -size, -size)

            glTexCoord2f(0, 0)
            glVertex3f(-size, -size, size)
            glTexCoord2f(0, 1)
            glVertex3f(-size, size, size)
            glTexCoord2f(1, 1)
            glVertex3f(size, size, size)
            glTexCoord2f(1, 0)
            glVertex3f(size, -size, size)

            glTexCoord2f(0, 0)
            glVertex3f(-size, -size, -size)
            glTexCoord2f(0, 1)
            glVertex3f(-size, size, -size)
            glTexCoord2f(1, 1)
            glVertex3f(-size, size, size)
            glTexCoord2f(1, 0)
            glVertex3f(-size, -size, size)

            glTexCoord2f(0, 0)
            glVertex3f(size, -size, -size)
            glTexCoord2f(0, 1)
            glVertex3f(size, size, -size)
            glTexCoord2f(1, 1)
            glVertex3f(size, size, size)
            glTexCoord2f(1, 0)
            glVertex3f(size, -size, size)

            glTexCoord2f(0, 1)
            glVertex3f(-size, -size, size)
            glTexCoord2f(0, 0)
            glVertex3f(-size, -size, -size)
            glTexCoord2f(1, 0)
            glVertex3f(size, -size, -size)
            glTexCoord2f(1, 1)
            glVertex3f(size, -size, size)

            glTexCoord2f(0, 1)
            glVertex3f(-size, size, size)
            glTexCoord2f(0, 0)
            glVertex3f(-size, size, -size)
            glTexCoord2f(1, 0)
            glVertex3f(size, size, -size)
            glTexCoord2f(1, 1)
            glVertex3f(size, size, size)

            glEnd()

            render_window.push_GL_states()
            render_window.draw(title)
            render_window.pop_GL_states()
            render_window.display()
    finally:
        glDeleteTextures([texture_id])


if __name__ == "__main__":
    main()
