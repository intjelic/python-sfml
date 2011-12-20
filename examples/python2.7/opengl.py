import OpenGL
OpenGL.ERROR_LOGGING = False
from OpenGL.GL import *

import sfml as sf

def main():
    window = sf.Window(sf.VideoMode(800, 600), "SFML OpenGL", sf.Style.DEFAULT, sf.ContextSettings(32))
    
    background_texture = sf.Texture.load_from_file("resources/background.jpg")
    background = sf.Sprite(background_texture)
    
    # load an OpenGL texture.
    # we could directly use a sf.Texture as an OpenGL texture (with its bind() member function),
    # but here we want more control on it (generate mipmaps, ...) so we create a new one from an image
    
    #GLuint texture = 0;
    #{
        #image = sf.Image.load_from_file("resources/texture.jpg")

        #glGenTextures(1, &texture);
        #glBindTexture(GL_TEXTURE_2D, texture);
        #gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, image.GetWidth(), image.GetHeight(), GL_RGBA, GL_UNSIGNED_BYTE, image.GetPixelsPtr());
        #glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        #glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    #}

    ## enable Z-buffer read and write
    #glEnable(GL_DEPTH_TEST);
    #glDepthMask(GL_TRUE);
    #glClearDepth(1.f);

    ## setup a perspective projection
    #glMatrixMode(GL_PROJECTION);
    #glLoadIdentity();
    #gluPerspective(90.f, 1.f, 1.f, 500.f);

    ## bind our texture
    #glEnable(GL_TEXTURE_2D);
    #glBindTexture(GL_TEXTURE_2D, texture);
    #glColor4f(1.f, 1.f, 1.f, 1.f);

    ## create a clock for measuring the time elapsed
    #clock = sf.Clock()

    ## start game loop
    #loop = True
    #while loop:
        ## process events
        #for event in window.events:
            #if event.type == sf.Event.CLOSED:
                #loop = False
                
            ## adjust the viewport when the window is resized
            #if event.type == sf.Event.RESIZED:
                #glViewport(0, 0, event.Size.Width, event.Size.Height);


        ## draw the background
        #window.SaveGLStates();
        #window.Draw(background);
        #window.RestoreGLStates();

        ## activate the window before using OpenGL commands.
        ## this is useless here because we have only one window which is
        ## always the active one, but don't forget it if you use multiple windows
        #window.set_active();

        ## clear the depth buffer
        #glClear(GL_DEPTH_BUFFER_BIT);

        ## we get the position of the mouse cursor, so that we can move the box accordingly
        #float x =  sf::Mouse::GetPosition(window).x * 200.f / window.GetWidth()  - 100.f;
        #float y = -sf::Mouse::GetPosition(window).y * 200.f / window.GetHeight() + 100.f;

        ## apply some transformations
        #glMatrixMode(GL_MODELVIEW);
        #glLoadIdentity();
        #glTranslatef(x, y, -100.f);
        #glRotatef(clock.GetElapsedTime() * 0.05f, 1.f, 0.f, 0.f);
        #glRotatef(clock.GetElapsedTime() * 0.03f, 0.f, 1.f, 0.f);
        #glRotatef(clock.GetElapsedTime() * 0.09f, 0.f, 0.f, 1.f);

        ## draw a cube
        #float size = 20.f;
        #glBegin(GL_QUADS);

            #glTexCoord2f(0, 0); glVertex3f(-size, -size, -size);
            #glTexCoord2f(0, 1); glVertex3f(-size,  size, -size);
            #glTexCoord2f(1, 1); glVertex3f( size,  size, -size);
            #glTexCoord2f(1, 0); glVertex3f( size, -size, -size);

            #glTexCoord2f(0, 0); glVertex3f(-size, -size, size);
            #glTexCoord2f(0, 1); glVertex3f(-size,  size, size);
            #glTexCoord2f(1, 1); glVertex3f( size,  size, size);
            #glTexCoord2f(1, 0); glVertex3f( size, -size, size);

            #glTexCoord2f(0, 0); glVertex3f(-size, -size, -size);
            #glTexCoord2f(0, 1); glVertex3f(-size,  size, -size);
            #glTexCoord2f(1, 1); glVertex3f(-size,  size,  size);
            #glTexCoord2f(1, 0); glVertex3f(-size, -size,  size);

            #glTexCoord2f(0, 0); glVertex3f(size, -size, -size);
            #glTexCoord2f(0, 1); glVertex3f(size,  size, -size);
            #glTexCoord2f(1, 1); glVertex3f(size,  size,  size);
            #glTexCoord2f(1, 0); glVertex3f(size, -size,  size);

            #glTexCoord2f(0, 1); glVertex3f(-size, -size,  size);
            #glTexCoord2f(0, 0); glVertex3f(-size, -size, -size);
            #glTexCoord2f(1, 0); glVertex3f( size, -size, -size);
            #glTexCoord2f(1, 1); glVertex3f( size, -size,  size);

            #glTexCoord2f(0, 1); glVertex3f(-size, size,  size);
            #glTexCoord2f(0, 0); glVertex3f(-size, size, -size);
            #glTexCoord2f(1, 0); glVertex3f( size, size, -size);
            #glTexCoord2f(1, 1); glVertex3f( size, size,  size);

        #glEnd();

        ## draw some text on top of our OpenGL object
        #window.SaveGLStates();
        #sf::Text text("SFML / OpenGL demo");
        #text.SetPosition(250.f, 450.f);
        #text.SetColor(sf::Color(255, 255, 255, 170));
        #window.Draw(text);
        #window.RestoreGLStates();

        ## finally, display the rendered frame on screen
        #window.Display();
    #}

    ## don't forget to destroy our texture
    #glDeleteTextures(1, &texture);


if __name__ == "__main__":
    main()
