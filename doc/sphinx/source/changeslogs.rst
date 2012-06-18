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
* sfml.Position moved to built-in type and is renamed sfml.Vector2
* sfml.Size removed
* sfml.Vector3 added
* Full variable/method/function/class name are clean
* Error message handler implemented
* open/load functions raises IOError and not sfml.SFMLException
* sfml.Shader's constants (VERTEX and FRAGMENT) removed
* sfml.Shader's constructors implemented
* sfml.Shader.set_parameter implemented
* sfml.Texture.update() implemented
* sfml.Vertex implemented
* sfml.VertexArray implemented
* Shader example added
* Pong example added
* sfml.Color are unpackable
* Network module uses sfml.Time
* Audio module uses sfml.Time
* Image.show() is implemented and platform-independant
* SoundStream and SoundRecorder can be subclassed

