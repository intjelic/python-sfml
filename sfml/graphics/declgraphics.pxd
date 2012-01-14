########################################################################
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>   #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#
########################################################################


########################################################################
# Copyright 2011 Bastien Léonard. All rights reserved.                 #
#                                                                      #
# Redistribution and use in source and binary forms, with or without   #
# modification, are permitted provided that the following conditions   #
# are met:                                                             #
#                                                                      #
#    1. Redistributions of source code must retain the above copyright #
#    notice, this list of conditions and the following disclaimer.     #
#                                                                      #
#    2. Redistributions in binary form must reproduce the above        #
#    copyright notice, this list of conditions and the following       #
#    disclaimer in the documentation and/or other materials provided   #
#    with the distribution.                                            #
#                                                                      #
# THIS SOFTWARE IS PROVIDED BY BASTIEN LÉONARD ``AS IS'' AND ANY       #
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    #
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR   #
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BASTIEN LÉONARD OR         #
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,         #
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT     #
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF     #
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND  #
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   #
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT   #
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF   #
# SUCH DAMAGE.                                                         #
########################################################################


#from declsystem cimport Int16, Uint8, Uint32
#from declsystem cimport Vector2f, Vector2i, Vector3f
from declsystem cimport *
from declwindow cimport *

cimport declwindow

cimport blendmode
cimport text
cimport primitive

        
cdef extern from "error.hpp":
    void replace_error_handler()


cdef extern from "hacks.hpp":
    cdef cppclass PyDrawable:
        PyDrawable(void*)


# Useful sometimes to print values for debugging
cdef extern from "stdio.h":
    void printf(char*, ...)


# Declaration of the standard std::string class.  This is useful
# e.g. when you get a std::string and want to return a Python string,
# use c_str() and it will be converted to a Python object
# automatically if needed.
# Do not confuse with String, which is sf::String!
cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        char* c_str()


cdef extern from "SFML/Graphics.hpp" namespace "sf":
    # Forward declarations
    cdef cppclass RenderWindow


    cdef cppclass Matrix3:
        Matrix3()
        Matrix3(float, float, float,
                float, float, float,
                float, float, float)
        Vector2f Transform(Vector2f&)
        Matrix3 GetInverse()
        float* Get4x4Elements()

        Matrix3 operator*(Matrix3&)

    cdef cppclass Color:
        Color()
        Color(unsigned int r, unsigned int g, unsigned b)
        Color(unsigned int r, unsigned int g, unsigned b, unsigned int a)
        unsigned int r
        unsigned int g
        unsigned int b
        unsigned int a
        
    cdef cppclass Image:
        Image()
        Image(Image&)
        void Copy(Image&, unsigned int, unsigned int)
        void Copy(Image&, unsigned int, unsigned int, IntRect&)
        void Copy(Image&, unsigned int, unsigned int, IntRect&, bint)
        bint Create(unsigned int, unsigned int)
        bint Create(unsigned int, unsigned int, Color&)
        bint Create(unsigned int, unsigned int, Uint8*)
        void CreateMaskFromColor(Color&)
        void CreateMaskFromColor(Color&, unsigned char)
        unsigned int GetHeight()
        Color& GetPixel(unsigned int, unsigned int)
        unsigned char* GetPixelsPtr()
        unsigned int GetWidth() 
        bint LoadFromFile(char*)
        bint LoadFromMemory(void*, size_t)
        bint SaveToFile(string&)
        bint SaveToFile(char*)
        void SetPixel(unsigned int, unsigned int, Color&)

    cdef cppclass Texture:
        Texture()
        Texture(Texture&)
        void Bind()
        Image CopyToImage()
        bint Create(unsigned int, unsigned int)
        unsigned int GetHeight()
        FloatRect GetTexCoords(IntRect&)
        unsigned int GetWidth()
        bint IsSmooth()
        bint LoadFromFile(char*)
        bint LoadFromFile(char*, IntRect&)
        bint LoadFromImage(Image&)
        bint LoadFromImage(Image&, IntRect&)
        bint LoadFromMemory(void*, size_t)
        bint LoadFromMemory(void*, size_t, IntRect&)
        # bint LoadFromStream(InputStream&)
        # bint LoadFromStream(InputStream&, IntRect&)
        void SetSmooth(bint)
        void Update(Uint8*)
        void Update(Uint8*, unsigned int, unsigned int, unsigned int,
                    unsigned int)
        void Update(Image&)
        void Update(Image&, unsigned int, unsigned int)
        void Update(Window&)
        void Update(Window&, unsigned int, unsigned int)

    cdef cppclass Glyph:
        Glyph()
        int Advance
        IntRect Bounds
        IntRect SubRect

    cdef cppclass Font:
        Font()
        Font(Font&)
        Glyph& GetGlyph(Uint32, unsigned int, bint)
        Texture& GetTexture(unsigned int)
        int GetKerning(Uint32, Uint32, unsigned int)
        int GetLineSpacing(unsigned int)
        bint LoadFromFile(char*)
        bint LoadFromMemory(void*, size_t)

    cdef cppclass Drawable:
        Drawable()
        blendmode.Mode GetBlendMode()
        Color& GetColor()
        Vector2f& GetOrigin()
        Vector2f& GetPosition()
        float GetRotation()
        Vector2f& GetScale()
        void Move(float, float)
        void Move(Vector2f&)
        void Rotate(float)
        void Scale(float, float)
        void Scale(Vector2f&)
        void SetBlendMode(blendmode.Mode)
        void SetColor(Color&)
        void SetOrigin(float, float)
        void SetOrigin(Vector2f&)
        void SetPosition(float, float)
        void SetPosition(Vector2f&)
        void SetRotation(float)
        void SetScale(float, float)
        void SetScale(Vector2f&)
        void SetScaleX(float)
        void SetScaleY(float)
        void SetX(float)
        void SetY(float)
        Vector2f TransformToGlobal(Vector2f&)
        Vector2f TransformToLocal(Vector2f&)

    cdef cppclass Text:
        Text()
        Text(char*)
        Text(char*, Font&)
        Text(char*, Font&, unsigned int)
        Text(String&)
        Text(String&, Font&)
        Text(String&, Font&, unsigned int)
        Vector2f GetCharacterPos(size_t)
        unsigned int GetCharacterSize()
#        Color& GetColor()
        Font& GetFont()
        FloatRect GetRect()
        String& GetString()
        unsigned long GetStyle()
        void SetCharacterSize(unsigned int)
#        void SetColor(Color&)
        void SetFont(Font&)
        void SetString(char*)
        void SetString(String&)
        void SetStyle(unsigned long)

    cdef cppclass Sprite:
        Sprite()
        Sprite(Texture&)
        void FlipX(bint)
        void FlipY(bint)
#        Color& GetColor()
        Vector2f GetSize()
        IntRect& GetSubRect()
        Texture* GetTexture()
        void Resize(float, float)
        void Resize(Vector2f&)
#        void SetColor(Color&)
        void SetSubRect(IntRect&)
        void SetTexture(Texture&)
        void SetTexture(Texture&, bint)

    cdef cppclass View:
        View()
        View(FloatRect&)
        View(Vector2f&, Vector2f&)
        Vector2f& GetCenter()
        Matrix3& GetInverseMatrix()
        Matrix3& GetMatrix()
        float GetRotation()
        FloatRect& GetViewport()
        Vector2f& GetSize()
        void Move(float, float)
        void Move(Vector2f&)
        void Reset(FloatRect&)
        void Rotate(float)
        void SetCenter(float, float)
        void SetCenter(Vector2f&)
        void SetFromRect(FloatRect&)
        void SetRotation(float)
        void SetSize(float, float)
        void SetSize(Vector2f&)
        void SetViewport(FloatRect&)
        void Zoom(float)

    cdef cppclass Shader:
        Shader()
        void Bind()
        bint LoadFromFile(char*)
        bint LoadFromMemory(char*)
        void SetCurrentTexture(char*)
        void SetParameter(char*, float)
        void SetParameter(char*, float, float)
        void SetParameter(char*, float, float, float)
        void SetParameter(char*, float, float, float, float)
        void SetParameter(char*, Vector2f&)
        void SetParameter(char*, Vector3f&)
        void SetTexture(char*, Texture&)
        void Unbind()


    cdef cppclass RenderTarget:
        void Clear()
        void Clear(Color&)
        void Draw(Drawable&)
        void Draw(Drawable&, Shader&)
        unsigned int GetHeight()
        unsigned int GetWidth()
        void SetView(View&)
        View& GetView()
        View& GetDefaultView()
        IntRect GetViewport(View&)
        Vector2f ConvertCoords(unsigned int, unsigned int)
        Vector2f ConvertCoords(unsigned int, unsigned int, View&)
        void RestoreGLStates()
        void SaveGLStates()

        
    cdef cppclass RenderWindow:
        RenderWindow()
        RenderWindow(declwindow.VideoMode, char*)
        RenderWindow(declwindow.VideoMode, char*, unsigned long)
        RenderWindow(declwindow.VideoMode, char*, unsigned long, declwindow.ContextSettings&)
        RenderWindow(declwindow.WindowHandle window_handle)
        RenderWindow(declwindow.WindowHandle window_handle, declwindow.ContextSettings&)
        void Clear()
        void Clear(Color&)
        void Draw(Drawable&)
        void Draw(Drawable&, Shader&)
        unsigned int GetHeight()
        unsigned int GetWidth()
        void SetView(View&)
        View& GetView()
        View& GetDefaultView()
        IntRect GetViewport(View&)
        Vector2f ConvertCoords(unsigned int, unsigned int)
        Vector2f ConvertCoords(unsigned int, unsigned int, View&)
        void RestoreGLStates()
        void SaveGLStates()
        void Close()
        void Create(declwindow.VideoMode, char*)
        void Create(declwindow.VideoMode, char*, unsigned long)
        void Create(declwindow.VideoMode, char*, unsigned long, declwindow.ContextSettings&)
        void Display()
        void EnableKeyRepeat(bint)
        void EnableVerticalSync(bint)
        Uint32 GetFrameTime()
        declwindow.ContextSettings& GetSettings()
        unsigned long GetSystemHandle()
        bint IsOpened()
        bint PollEvent(declwindow.Event&)
        void SetActive()
        void SetActive(bint)
        void SetIcon(unsigned int, unsigned int, Uint8*)
        void SetJoystickThreshold(float)
        void SetFramerateLimit(unsigned int)
        void SetPosition(int, int)
        void SetSize(unsigned int, unsigned int)
        void SetTitle(char*)
        void Show(bint)
        void ShowMouseCursor(bint)
        void UseVerticalSync(bint)
        bint WaitEvent(declwindow.Event&)

    cdef cppclass RenderTexture:
        RenderTexture()
        bint Create(unsigned int, unsigned int)
        bint Create(unsigned int, unsigned int, bint depth)
        void SetSmooth(bint)
        bint IsSmooth()
        bint SetActive()
        bint SetActive(bint)
        void Display()
        Texture& GetTexture()
        bint IsAvailable()
    
    cdef cppclass Renderer:
        Renderer(RenderTarget&)
        void Initialize()
        void SaveGLStates()
        void RestoreGLStates()
        void Clear(Color&)
        void PushStates()
        void PopStates()
        void SetModelView(Matrix3&)
        void ApplyModelView(Matrix3&)
        void SetProjection(Matrix3&)
        void SetColor(Color&)
        void ApplyColor(Color&)
        void SetViewport(IntRect&)
        void SetBlendMode(blendmode.Mode)
        void SetTexture(Texture*)
        void SetShader(Shader*)
        void Begin(primitive.PrimitiveType)
        void End()
        void AddVertex(float x, float y)
        void AddVertex(float x, float y, float u, float v)
        void AddVertex(float x, float y, Color&)
        void AddVertex(float x, float y, float u, float v, Color&)        

    cdef cppclass Shape:
        Shape()
        void AddPoint(float, float)
        void AddPoint(float, float, Color&)
        void AddPoint(float, float, Color&, Color&)
        void AddPoint(Vector2f&)
        void AddPoint(Vector2f&, Color&)
        void AddPoint(Vector2f&, Color&, Color&)
        void EnableFill(bint)
        void EnableOutline(bint)
        Image* GetImage()
        float GetOutlineThickness()
        Color GetPixel(unsigned int, unsigned int)
        Color& GetPointColor(unsigned int)
        unsigned int GetPointsCount()
        Color& GetPointOutlineColor(unsigned int)
        Vector2f& GetPointPosition(unsigned int)
        IntRect& GetSubRect()
        void SetOutlineThickness(float)
        void SetPointPosition(unsigned int, Vector2f&)
        void SetPointPosition(unsigned int, float, float)
        void SetPointColor(unsigned int, Color&)
        void SetPointOutlineColor(unsigned int, Color&)
        
        
# import static methods and attributes
cimport shape
cimport texture
cimport font
cimport shader
cimport matrix3

