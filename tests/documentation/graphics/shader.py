shader.set_parameter("offset", 2)
shader.set_parameter("color", 0.5, 0.8, 0.3)
shader.set_parameter("matrix", transform) # transform is a sf.Transform
shader.set_parameter("overlay", texture)  # texture is a sf.Texture
shader.set_parameter("texture")           # set the current texture type

window.draw(sprite, shader)

states = sf.RenderStates()
states.shader = shader
window.draw(




sf::RenderStates states;
 states.shader = shader;
 window.draw(sprite, states);
 
 
 window.setActive();
 shader.bind();
 ... render OpenGL geometry ...
 shader.unbind();
