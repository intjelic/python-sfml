# declare and load a texture
texture = sf.Texture.load_from_file("texture.png")

# create a sprite
sprite = sf.Sprite(texture)
sprite.texture_rectangle = sf.Rectangle((10, 10), (50, 30))
sprite.color = sf.Color(255, 255, 255, 200)
sprite.position = sf.Position(100, 25)

# draw it
window.draw(sprite)
