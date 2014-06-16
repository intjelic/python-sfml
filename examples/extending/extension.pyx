cimport libcpp.sfml as sf
from pysfml.graphics cimport Image

def flip_image(Image image):
    image.p_this.flipHorizontally()
    image.p_this.flipVertically()
