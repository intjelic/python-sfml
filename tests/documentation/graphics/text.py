# declare and load a font
try:
	font = sf.Font.load_from_file("arial.ttf")
	
except sf.SFMLException: exit(1)

# create a text
text = sf.Text("hello")
text.font = font
text.character_size = 30
text.style = sf.Text.BOLD
text.color = sf.Color.RED

# draw it
window.draw(text)
