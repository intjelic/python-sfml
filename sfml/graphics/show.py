import sys, time, tempfile
import sfml as sf


image_filename = sys.argv[1]

try:
    image = sf.Image.load_from_file(image_filename)
except sf.SFMLException:
    print("An error occured: it couldn't find the temporary image.")
    exit()

desktop_mode = sf.VideoMode.get_desktop_mode()

if image.size > desktop_mode.size:
    video_size = (640, 480)
else:
    video_size = image.size
    
w, h = video_size
bpp = desktop_mode.bpp

window = sf.RenderWindow(sf.VideoMode(w, h, bpp), 'SFML - Image preview')
window.framerate_limit = 60

texture = sf.Texture.load_from_image(image)
sprite = sf.Sprite(texture)

running = True
while running:
	for event in window.events:
		if event.type == sf.Event.CLOSED:
			running = False

	window.clear(sf.Color.WHITE)
	window.draw(sprite)
	window.display()
	time.sleep(0.150)
window.close()
