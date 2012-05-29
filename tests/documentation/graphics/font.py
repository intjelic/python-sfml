# declare a new font
try:
	font = sf.Font.load_from_file("arial.ttf")
	
except sf.SFMLException: exit(1) # error...

# create a text which uses our font
text1 = sf.Text()
text1.font = font
text1.character_size = 30
text1.style = sf.Text.REGULAR

# create another text using the same font, but with different parameters
text2 = sf.Text()
text2.font = font
text2.character_size = 50
text2.style = sf.Text.ITALIC
