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
* sfml.system.Position moved to built-in type and is renamed sfml.system.Vector2
* sfml.system.Size removed
* sfml.system.Vector3 added
* Full variable/method/function/class name are clean
* Error message handler implemented
* open/load functions raises IOError and not sfml.system.SFMLException
* sfml.graphics.Shader's constants (VERTEX and FRAGMENT) removed
* sfml.graphics.Shader's constructors implemented
* sfml.graphics.Shader.set_parameter implemented
* sfml.graphics.Texture.update() implemented
* sfml.graphics.Vertex implemented
* sfml.graphics.VertexArray implemented
* Shader example added
* Pong example added
* sfml.graphics.Color are unpackable
* Network module uses sfml.system.Time
* Audio module uses sfml.system.Time
* Image.show() is implemented and platform-independant
* SoundStream and SoundRecorder can be subclassed

