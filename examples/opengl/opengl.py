from pathlib import Path

from OpenGL.GL import GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT, GL_DEPTH_TEST, GL_LINEAR, GL_LINEAR_MIPMAP_LINEAR, GL_MODELVIEW, GL_PROJECTION, GL_QUADS, GL_RGBA, GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_TEXTURE_MIN_FILTER, GL_TRUE, GL_UNSIGNED_BYTE, glBegin, glBindTexture, glClear, glClearDepth, glColor4f, glDeleteTextures, glDepthMask, glEnable, glEnd, glGenTextures, glLoadIdentity, glMatrixMode, glRotatef, glTexCoord2f, glTexParameteri, glTranslatef, glVertex3f, glViewport
from OpenGL.GLU import gluBuild2DMipmaps, gluPerspective

from sfml import graphics as sf_graphics
from sfml import system as sf_system
from sfml import window as sf_window


RESOURCE_DIR = Path(__file__).resolve().parent / "resources"


def configure_projection(size) -> None:
    width = max(int(size.x), 1)
    height = max(int(size.y), 1)

    glViewport(0, 0, width, height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(90.0, width / float(height), 1.0, 500.0)


def create_window(srgb: bool) -> sf_graphics.RenderWindow:
    context_settings = sf_window.ContextSettings(depth=24)
    context_settings.srgb_capable = srgb

    render_window = sf_graphics.RenderWindow(
        sf_window.VideoMode(800, 600),
        "pySFML graphics with OpenGL",
        sf_window.Style.DEFAULT,
        context_settings,
    )
    render_window.set_vertical_synchronization_enabled(True)
    render_window.minimum_size = (400, 300)
    render_window.maximum_size = (1200, 900)

    return render_window


def main():
    exit_requested = False
    srgb_enabled = False

    while not exit_requested:
        render_window = create_window(srgb_enabled)
        font = sf_graphics.Font.from_file(str(RESOURCE_DIR / "tuffy.ttf"))
        background_texture = sf_graphics.Texture.from_file(str(RESOURCE_DIR / "background.jpg"), srgb=srgb_enabled)
        background = sf_graphics.Sprite(background_texture)

        image = sf_graphics.Image.from_file(str(RESOURCE_DIR / "logo.png"))
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
        glEnable(GL_TEXTURE_2D)
        glBindTexture(GL_TEXTURE_2D, texture_id)
        glColor4f(1.0, 1.0, 1.0, 1.0)

        if not render_window.set_active(False):
            raise RuntimeError("failed to release the window OpenGL context")

        text = sf_graphics.Text(font, "SFML / OpenGL demo")
        text.fill_color = sf_graphics.Color(255, 255, 255, 170)
        text.position = (280, 450)

        srgb_instructions = sf_graphics.Text(font, "Press Space to toggle sRGB conversion")
        srgb_instructions.fill_color = sf_graphics.Color(255, 255, 255, 170)
        srgb_instructions.position = (175, 500)

        mipmap_instructions = sf_graphics.Text(font, "Press Enter to toggle mipmapping")
        mipmap_instructions.fill_color = sf_graphics.Color(255, 255, 255, 170)
        mipmap_instructions.position = (200, 550)

        view = sf_graphics.View()
        view.size = background_texture.size
        view.center = background_texture.size / 2
        render_window.view = view

        clock = sf_system.Clock()
        mipmap_enabled = True
        toggle_srgb = False

        try:
            while render_window.is_open:
                for event in render_window.events:
                    if isinstance(event, sf_window.ClosedEvent):
                        exit_requested = True
                        render_window.close()
                    elif isinstance(event, sf_window.KeyPressedEvent):
                        if event.scancode == sf_window.Scancode.ESCAPE:
                            exit_requested = True
                            render_window.close()
                        elif event.scancode == sf_window.Scancode.ENTER:
                            if mipmap_enabled:
                                image = sf_graphics.Image.from_file(str(RESOURCE_DIR / "logo.png"))
                                glBindTexture(GL_TEXTURE_2D, texture_id)
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
                                gluBuild2DMipmaps(
                                    GL_TEXTURE_2D,
                                    GL_RGBA,
                                    image.size.x,
                                    image.size.y,
                                    GL_RGBA,
                                    GL_UNSIGNED_BYTE,
                                    image.pixels,
                                )
                                mipmap_enabled = False
                            else:
                                glBindTexture(GL_TEXTURE_2D, texture_id)
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
                                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)
                                gluBuild2DMipmaps(
                                    GL_TEXTURE_2D,
                                    GL_RGBA,
                                    image.size.x,
                                    image.size.y,
                                    GL_RGBA,
                                    GL_UNSIGNED_BYTE,
                                    image.pixels,
                                )
                                mipmap_enabled = True
                        elif event.scancode == sf_window.Scancode.SPACE:
                            srgb_enabled = not srgb_enabled
                            toggle_srgb = True
                            render_window.close()
                    elif isinstance(event, sf_window.ResizedEvent):
                        if not render_window.set_active(True):
                            raise RuntimeError("failed to activate the window OpenGL context")
                        configure_projection(event.size)
                        if not render_window.set_active(False):
                            raise RuntimeError("failed to release the window OpenGL context")
                        view = sf_graphics.View()
                        view.size = background_texture.size
                        view.center = background_texture.size / 2
                        render_window.view = view

                render_window.push_GL_states()
                render_window.draw(background)
                render_window.pop_GL_states()

                if not render_window.set_active(True):
                    if toggle_srgb:
                        break
                    raise RuntimeError("failed to activate the window OpenGL context")

                configure_projection(render_window.size)
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

                if not render_window.set_active(False):
                    raise RuntimeError("failed to release the window OpenGL context")

                render_window.push_GL_states()
                render_window.draw(text)
                render_window.draw(srgb_instructions)
                render_window.draw(mipmap_instructions)
                render_window.pop_GL_states()
                render_window.display()

                if toggle_srgb:
                    break
        finally:
            glDeleteTextures([texture_id])


if __name__ == "__main__":
    main()
