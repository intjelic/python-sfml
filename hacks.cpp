#include "hacks.hpp"

#include <iostream>
#include <cassert>



// This file contains code that couldn't be written in Cython.



// C functions defined in sf.pyx
// Can't declare them in hacks.hpp because the const-qualifier will clash with
// the actual signature (Cython doesn't support const pointers)
extern "C"
{
    void set_error_message(const char* message);
}


// This should be big enough to contain any message error
static const int ERROR_MESSAGE_BUFFER_SIZE = 512;

// A custom streambuf that will put error messages in a Python dict
class MyBuff : public std::streambuf
{
public:
    MyBuff()
    {
        buffer = new char[ERROR_MESSAGE_BUFFER_SIZE];
        setp(buffer, buffer + ERROR_MESSAGE_BUFFER_SIZE);
    }

    ~MyBuff()
    {
        delete[] pbase();
    }

private:
    char* buffer;

    // This code is from SFML's bufstream. In our case overflow()
    // should never get called, unless I missed something. But I don't
    // undestand why it would get called when there's no overflow
    // either (i.e., when pptr() != epptr()), so let's be on the safe
    // side.
    virtual int overflow(int character)
    {
        if (character != EOF && pptr() != epptr())
        {
            // Valid character
            return sputc(static_cast<char>(character));
        }
        else if (character != EOF)
        {
            // Not enough space in the buffer: synchronize output and try again
            sync();
            return overflow(character);
        }
        else
        {
            // Invalid character: synchronize output
            return sync();
        }
    }

    virtual int sync()
    {
        if (pbase() != pptr())
        {
            // Replace '\n' at the end of the message with '\0'
            *(pptr() - 1) = '\0';

            // Call the function in sf.pyx that handles new messages
            set_error_message(pbase());

            setp(pbase(), epptr());
        }

        return 0;
    }
};


void replace_error_handler()
{
    static MyBuff my_buff;
    sf::Err().rdbuf(&my_buff);
}


PyDrawable::PyDrawable(void* obj):
sf::Drawable (),
m_obj (obj)
{
};

void PyDrawable::Render(sf::RenderTarget& target, sf::Renderer& renderer) const
{
    // TODO: Here may be done the same work as _callrender's work by
    // retrieving args (which are store in the PyObject itself) and 
    // sending it directly to the render method.

    // _callrender method calls render method with the right args
    PyObject_CallMethod(static_cast<PyObject*>(m_obj), "_callrender", NULL);
}

