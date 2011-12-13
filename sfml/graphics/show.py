import sys,time, tempfile
import sfml as sf

window = sf.RenderWindow(sf.VideoMode(640, 480), 'SFML - Image preview')
window.framerate_limit = 60

image_filename = sys.argv[1]
print(image_filename)

image = sf.Texture.load_from_file(image_filename)
sprite = sf.Sprite(image)

running = True
while running:
	for event in window.iter_events():
		if event.type == sf.Event.CLOSED:
			running = False

	window.clear(sf.Color.WHITE)
	window.draw(sprite)
	window.display()
	time.sleep(0.150)
window.close()
