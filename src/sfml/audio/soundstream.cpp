#include "hacks.hpp"


CppSoundStream::CppSoundStream(void* pyThis):
sf::SoundStream (),
m_ogdFormat     (""),
m_ogdMethodName ("on_get_data"),
m_osFormat      (""),
m_osMethodName  ("on_seek"),
m_pyThis        (obj)
{
};

bool CppSoundStream::OnGetData(sf::Chunk& data)
{
    PyObject* pyTarget = (PyObject*)(wrap_render_target_instance(&target));
    PyObject* pyRenderer = (PyObject*)(wrap_renderer_instance(&renderer));
    
    PyObject_CallMethod(static_cast<PyObject*>(m_pyThis), m_methodName, m_format, pyTarget, pyRenderer);
}

bool CppSoundStream::OnSeek(sf::Uint32 timeOffset)
{
    
}
