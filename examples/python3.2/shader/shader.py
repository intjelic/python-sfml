from math import cos
import sfml.graphics as sf


class ShaderSelector:
    def __init__(self, shaders):
        self._shaders = shaders
        self._keys = list(shaders.keys())
        self._current = 0
        
    def next(self):
        # select the next shader
        self._current += 1
        if self._current == len(self._keys):
            self._current = 0
        
    def previous(self):
        # select the previous shader
        if self._current == 0:
            self._current = len(self._keys)
        self._current -= 1
        
    def update(self, position):
        # update the shader parameters
        x, y = position
        
        if self.name == "blur": self.shader.set_parameter(b"offset", x * y * 0.03)
        elif self.name == "colorize": self.shader.set_parameter(b"color", 0.3, x, y)
        elif self.name == "edge": self.shader.set_parameter(b"threshold", x * y)
        elif self.name == "fisheye": self.shader.set_parameter(b"mouse", x, y)
        elif self.name == "wave": self.shader.set_parameter(b"offset", x, y)
        elif self.name == "pixelate": self.shader.set_parameter(b"mouse", x, y)
    
    def _get_name(self):
        return self._keys[self._current]
        
    def _get_shader(self):
        return self._shaders[self.name]
    
    name = property(_get_name) # get the name of the current shader
    shader = property(_get_shader) # get the current shader

    
def main():
    """ Entry point of application. """
    
    # create the main window
    window = sf.RenderWindow(sf.VideoMode(800, 600), "pySFML - Shader")
    window.framerate_limit = 60
    
    try:
        # create the render texture 
        w, h = window.size
        texture = sf.RenderTexture(w, h)
        
        # load a background texture to display
        background_texture = sf.Texture.load_from_file("data/background.jpg")
        background = sf.Sprite(background_texture)
        
        # load a sprite which we'll move into the scene    
        entity_texture = sf.Texture.load_from_file("data/sprite.png")
        entity = sf.Sprite(entity_texture)
        
        # load the text font
        font = sf.Font.load_from_file("data/sansation.ttf")
        
        # load the texture needed for the wave shader    
        wave_texture = sf.Texture.load_from_file("data/wave.jpg")
        
        # load all shaders
        shaders = {}
        shaders["nothing"] = sf.Shader.load_from_file("data/nothing.sfx")
        shaders["blur"] = sf.Shader.load_from_file("data/blur.sfx")
        shaders["colorize"] = sf.Shader.load_from_file("data/colorize.sfx")
        shaders["edge"] = sf.Shader.load_from_file("data/edge.sfx")
        shaders["fisheye"] = sf.Shader.load_from_file("data/fisheye.sfx")
        shaders["wave"] = sf.Shader.load_from_file("data/wave.sfx")
        shaders["pixelate"] = sf.Shader.load_from_file("data/pixelate.sfx")

    except sf.SFMLException as error:
        print(str(error))
        exit(1)
        
    # do specific initializations
    for shader in shaders:
        shaders[shader].current_texture = b"texture"
        
    shaders["blur"].set_parameter(b"offset", 0);
    shaders["colorize"].set_parameter(b"color", 1, 1, 1);
    shaders["wave"].set_texture(b"wave", wave_texture);
    
    # initialize three shader selectors
    background_shader = ShaderSelector(shaders)
    entity_shader = ShaderSelector(shaders)
    global_shader = ShaderSelector(shaders)
    
    # define a string for displaying the description of the current shader
    shaderStr = sf.Text()
    shaderStr.font = font
    shaderStr.character_size = 20
    shaderStr.position = sf.Position(5, 0)
    shaderStr.color = sf.Color(250, 100, 30)
    shaderStr.string = "Background shader: '{0}'\nFlower shader: '{1}'\nGlobal shader: '{2}'".format(background_shader.name, entity_shader.name, global_shader.name)

    # define a string for displaying help
    infoStr = sf.Text()
    infoStr.font = font
    infoStr.character_size = 20
    infoStr.position = sf.Position(5, 500)
    infoStr.color = sf.Color(250, 100, 30)
    infoStr.string = "Move your mouse to change the shaders' parameters\nPress numpad 1/4 to change the background shader\nPress numpad 2/5 to change the flower shader\nPress numpad 3/6 to change the global shader"
    
    # create a clock to measure the total time elapsed
    clock = sf.Clock()
    
    # start the game loop
    loop = True
    while loop:
        
        # process events
        for event in window.events:
            # close window : exit
            if event.type == sf.Event.CLOSED:
                loop = False
            elif event.type == sf.Event.KEY_PRESSED:
                # escape key : exit                
                if event.code is sf.Keyboard.ESCAPE:
                    pass
                
                # numpad: switch effect
                if event.code is sf.Keyboard.NUMPAD1: background_shader.previous()
                elif event.code is sf.Keyboard.NUMPAD4: background_shader.next()
                elif event.code is sf.Keyboard.NUMPAD2: entity_shader.previous()
                elif event.code is sf.Keyboard.NUMPAD5: entity_shader.next()
                elif event.code is sf.Keyboard.NUMPAD3: global_shader.previous()
                elif event.code is sf.Keyboard.NUMPAD6: global_shader.next()
                
                # update the text
                shaderStr.string = "Background shader: '{0}'\nFlower shader: '{1}'\nGlobal shader: '{2}'".format(background_shader.name, entity_shader.name, global_shader.name)
                
        # get the mouse position in the range [0, 1]
        mouse_position = sf.Mouse.get_position(window)
        mouse_position /= window.size
        
        # update the shaders
        background_shader.update(mouse_position);
        entity_shader.update(mouse_position);
        global_shader.update(mouse_position);
        
        # animate the entity
        entity_x = (cos(clock.elapsed_time * 0.0013) + 1.2) * 300
        entity_y = (cos(clock.elapsed_time * 0.0008) + 1.2) * 200
        entity.position = (entity_x, entity_y)
        entity.rotate(window.frame_time * 0.1)
        
        # draw the background and the moving entity to the render texture
        texture.clear()
        texture.draw(background, background_shader.shader)
        texture.draw(entity, entity_shader.shader)
        texture.display()

        # draw the contents of the render texture to the window
        screen = sf.Sprite(texture.texture)
        window.draw(screen, global_shader.shader)

        # draw the interface texts
        window.draw(shaderStr)
        window.draw(infoStr)
        
        # finally, display the rendered frame on screen
        window.display()
        
    window.close()


if __name__ == "__main__":
    # check that the system can use shaders
    if not sf.Shader.IS_AVAILABLE:
        print("Sorry, your system doesn't support shaders.")
        exit(1)
        
    # call the entry point of application
    main()
