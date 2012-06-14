Changes Logs
============

These lists are **not exhaustive**.

v0.9 -> v1.0
------------
* System module updated to the new API interface
* Window module updated to the new API interface
* Graphics module updated to the new API interface
* Audio module updated to the new API interface
* Network module updated to the new API interface
* Code entirely clean and follow convention

* Audio module imports the system module with him
* The official ftp example implemented

v1.0 -> v1.1
------------
* sf.Position moved to built-in type and is renamed sf.Vector2
* sf.Size removed
* sf.Vector3 added
* Full variable/method/function/class name are clean
* Error message handler implemented
* open/load functions raises IOError and not sf.SFMLException
* sf.Shader's constants (VERTEX and FRAGMENT) removed
* sf.Shader's constructors implemented
* sf.Shader.set_parameter implemented
* sf.Texture.update() implemented
* sf.Vertex implemented
* sf.VertexArray implemented
* Shader example added
* Pong example added
* sf.Color are unpackable
* Network module uses sf.Time
* Audio module uses sf.Time
* Image.show() is implemented and platform-independant
* SoundStream and SoundRecorder can be subclassed

