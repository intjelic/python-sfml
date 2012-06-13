view = sf.View()

# initialize the view to a rectangle located at (100, 100) and with a size of 400x200
view.reset(sf.Rectangle((100, 100), (400, 200)))

# rotate it by 45 degrees
view.rotate(45)

# set its target viewport to be half of the window
view.viewport = sf.Rectangle((0, 0), (0.5, 1))

# apply it
window.view = view

# render stuff
window.draw(some_sprites)

# set the default view back
window.view = window.default_view

# render stuff not affected by the view
window.draw(some_text)
