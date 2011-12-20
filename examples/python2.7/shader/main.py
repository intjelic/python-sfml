#! /usr/bin/env python2
# -*- coding: utf-8 -*-

# This example is ported from the SFML C++ examples.


import math

import sf


NOTHING, BLUR, COLORIZE, EDGE, FISHEYE, WAVE, PIXELATE = range(7)


# Quick and dirty port of the equivalent class in the C++ example, not
# very elegant but it does the trick. It uses a list and array indexes
# instead of a dict and iterators because Python's iterators don't
# allow to go backwards. collections.OrderedDict is probably the way
# to go but requires to access the __root internal attribute to go
# backwards AFAIK.
class ShaderSelector(object):
    def __init__(self, shaders):
        self.shaders = shaders
        self.current = 0

    def go_to_previous(self):
        if self.current > 0:
            self.current -= 1
        else:
            self.current = len(self.shaders) - 1

        assert 0 <= self.current < len(self.shaders)

    def go_to_next(self):
        if self.current < len(self.shaders) - 1:
            self.current += 1
        else:
            self.current = 0

        assert 0 <= self.current < len(self.shaders)

    def update(self, x, y):
        current = self.shaders[self.current]

        if self.current == BLUR:
            current.set_parameter('offset', x * y * 0.03)
        elif self.current == COLORIZE:
            current.set_parameter('color', 0.3, x, y)
        elif self.current == EDGE:
            current.set_parameter('threshold', x * y)
        elif self.current == FISHEYE:
            current.set_parameter('mouse', x, y)
        elif self.current == WAVE:
            current.set_parameter('offset', x, y)
        elif self.current == PIXELATE:
            current.set_parameter('mouse', x, y)
    
    def get_name(self):
        names = ['nothing', 'blur', 'colorize', 'edge', 'fisheye', 'wave',
                 'pixelate']

        return names[self.current]

    def get_shader(self):
        return self.shaders[self.current]


def display_error():
    # Create the main window
    window = sf.RenderWindow(sf.VideoMode(800, 600), 'SFML Shader example')

    # Define a string for displaying the error message
    error = sf.Text("Sorry, your system doesn't support shaders")
    error.position = (100.0, 250.0)
    error.color = sf.Color(200, 100, 150)

    # Start the game loop
    while window.opened:
        # Process events
        for event in window.iter_events():
            # Close window: exit
            if event.type == sf.Event.CLOSED:
                window.close()

            # Escape key: exit
            if (event.type == sf.Event.KEY_PRESSED and
                event.code == sf.Keyboard.ESCAPE):
                window.close()

        # Clear the window
        window.clear()

        # Draw the error message
        window.draw(error)

        # Finally, display the rendered frame on screen
        window.display()



def main():
    if not sf.Shader.IS_AVAILABLE:
        display_error()

    # Create the main window
    window = sf.RenderWindow(sf.VideoMode(800, 600), 'SFML shader example')

    # Create the render texture
    texture = sf.RenderTexture(window.width, window.height)

    # Load a background texture to display
    background_texture = sf.Texture.load_from_file('resources/background.jpg')
    background = sf.Sprite(background_texture)

    # Load a sprite which we'll move into the scene
    entity_texture = sf.Texture.load_from_file('resources/sprite.png')
    entity = sf.Sprite(entity_texture)

    # Load the text font
    font = sf.Font.load_from_file('resources/sansation.ttf')

    # Load the texture needed for the wave shader
    wave_texture = sf.Texture.load_from_file('resources/wave.jpg')

    # Load all shaders
    shaders = [None] * 7
    shaders[NOTHING] = sf.Shader.load_from_file('resources/nothing.sfx')
    shaders[BLUR] = sf.Shader.load_from_file('resources/blur.sfx')
    shaders[COLORIZE] = sf.Shader.load_from_file('resources/colorize.sfx')
    shaders[EDGE] = sf.Shader.load_from_file('resources/edge.sfx')
    shaders[FISHEYE] = sf.Shader.load_from_file('resources/fisheye.sfx')
    shaders[WAVE] = sf.Shader.load_from_file('resources/wave.sfx')
    shaders[PIXELATE] = sf.Shader.load_from_file('resources/pixelate.sfx')

    background_shader = ShaderSelector(shaders)
    entity_shader = ShaderSelector(shaders)
    global_shader = ShaderSelector(shaders)

    # Do specific initializations
    shaders[NOTHING].current_texture = 'texture'
    shaders[BLUR].current_texture = 'texture'
    shaders[BLUR].set_parameter('offset', 0.0)
    shaders[COLORIZE].current_texture = 'texture'
    shaders[COLORIZE].set_parameter('color', 1.0, 1.0, 1.0)
    shaders[EDGE].current_texture = 'texture'
    shaders[FISHEYE].current_texture = 'texture'
    shaders[WAVE].current_texture = 'texture'
    shaders[WAVE].set_texture('wave', wave_texture)
    shaders[PIXELATE].current_texture = 'texture'

    # Define a string for displaying the description of the current shader
    shader_str = sf.Text()
    shader_str.font = font
    shader_str.character_size = 20
    shader_str.position = (5.0, 0.0)
    shader_str.color = sf.Color(250, 100, 30)
    shader_str.string = ("Background shader: \"{0}\"\n"
                         "Flower shader: \"{1}\"\n"
                         "Global shader: \"{2}\"\n"
                         .format(background_shader.get_name(),
                                 entity_shader.get_name(),
                                 global_shader.get_name()))


    # Define a string for displaying help
    info_str = sf.Text()
    info_str.font = font
    info_str.character_size = 20
    info_str.position = (5.0, 500.0)
    info_str.color = sf.Color(250, 100, 30)
    info_str.string = ("Move your mouse to change the shaders' parameters\n"
                       "Press numpad 1/4 to change the background shader\n"
                       "Press numpad 2/5 to change the flower shader\n"
                       "Press numpad 3/6 to change the global shader")

    # Create a clock to measure the total time elapsed
    clock = sf.Clock()

    # Start the game loop
    while window.opened:
        # Process events
        for event in window.iter_events():
            # Close window : exit
            if event.type == sf.Event.CLOSED:
                window.close()

            if event.type == sf.Event.KEY_PRESSED:
                # Escape key : exit
                if event.code == sf.Keyboard.ESCAPE:
                    window.close()

                # Numpad : switch effect
                if event.code == sf.Keyboard.NUMPAD1:
                    background_shader.go_to_previous()
                elif event.code == sf.Keyboard.NUMPAD4:
                    background_shader.go_to_next()
                elif event.code == sf.Keyboard.NUMPAD2:
                    entity_shader.go_to_previous()
                elif event.code == sf.Keyboard.NUMPAD5:
                    entity_shader.go_to_next()
                elif event.code == sf.Keyboard.NUMPAD3:
                    global_shader.go_to_previous()
                elif event.code == sf.Keyboard.NUMPAD6:
                    global_shader.go_to_next()

                # Update the text
                shader_str.string = (
                    "Background shader: \"{0}\"\n"
                    "Entity shader: \"{1}\"\n"
                    "Global shader: \"{2}\"\n"
                    .format(background_shader.get_name(),
                            entity_shader.get_name(),
                            global_shader.get_name()))

        # Get the mouse position in the range [0, 1]
        if window.width and window.height:
            mouse_x = sf.Mouse.get_position(window)[0] / float(window.width)
            mouse_y = sf.Mouse.get_position(window)[1] / float(window.height)

        # Update the shaders
        background_shader.update(mouse_x, mouse_y);
        entity_shader.update(mouse_x, mouse_y);
        global_shader.update(mouse_x, mouse_y);

        # Animate the entity
        entity_x = (math.cos(clock.elapsed_time * 0.0013) + 1.2) * 300
        entity_y = (math.cos(clock.elapsed_time * 0.0008) + 1.2) * 200
        entity.position = (entity_x, entity_y)
        entity.rotate(window.frame_time * 0.1)

        # Draw the background and the moving entity to the render texture
        texture.clear()
        texture.draw(background, background_shader.get_shader())
        texture.draw(entity, entity_shader.get_shader())
        texture.display()

        # Draw the contents of the render texture to the window
        screen = sf.Sprite(texture.texture)
        window.draw(screen, global_shader.get_shader())

        # Draw the interface texts
        window.draw(shader_str)
        window.draw(info_str)

        # Finally, display the rendered frame on screen
        window.display()


if __name__ == '__main__':
    main()
