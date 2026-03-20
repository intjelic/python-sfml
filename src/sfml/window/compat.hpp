/*
* PySFML - Python bindings for SFML
* Copyright (c) 2012-2026, Jonathan De Wachter <dewachter.jonathan@gmail.com>
*
* This file is part of PySFML and is available under the zlib license.
*/

#ifndef PYSFML_WINDOW_COMPAT_HPP
#define PYSFML_WINDOW_COMPAT_HPP

#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/Window/Clipboard.hpp>
#include <SFML/Window/Context.hpp>
#include <SFML/Window/Cursor.hpp>
#include <SFML/Window/Event.hpp>

#include <cstdint>
#include <optional>
#include <string_view>
#include <utility>
#include <vector>

namespace pysfml::style_compat
{
enum : std::uint32_t
{
    None       = sf::Style::None,
    Titlebar   = sf::Style::Titlebar,
    Resize     = sf::Style::Resize,
    Close      = sf::Style::Close,
    Fullscreen = 1u << 3,
    Default    = sf::Style::Default
};
}

namespace pysfml::keyboard_compat
{
enum Key
{
    Unknown = static_cast<int>(sf::Keyboard::Key::Unknown),
    A = static_cast<int>(sf::Keyboard::Key::A),
    B = static_cast<int>(sf::Keyboard::Key::B),
    C = static_cast<int>(sf::Keyboard::Key::C),
    D = static_cast<int>(sf::Keyboard::Key::D),
    E = static_cast<int>(sf::Keyboard::Key::E),
    F = static_cast<int>(sf::Keyboard::Key::F),
    G = static_cast<int>(sf::Keyboard::Key::G),
    H = static_cast<int>(sf::Keyboard::Key::H),
    I = static_cast<int>(sf::Keyboard::Key::I),
    J = static_cast<int>(sf::Keyboard::Key::J),
    K = static_cast<int>(sf::Keyboard::Key::K),
    L = static_cast<int>(sf::Keyboard::Key::L),
    M = static_cast<int>(sf::Keyboard::Key::M),
    N = static_cast<int>(sf::Keyboard::Key::N),
    O = static_cast<int>(sf::Keyboard::Key::O),
    P = static_cast<int>(sf::Keyboard::Key::P),
    Q = static_cast<int>(sf::Keyboard::Key::Q),
    R = static_cast<int>(sf::Keyboard::Key::R),
    S = static_cast<int>(sf::Keyboard::Key::S),
    T = static_cast<int>(sf::Keyboard::Key::T),
    U = static_cast<int>(sf::Keyboard::Key::U),
    V = static_cast<int>(sf::Keyboard::Key::V),
    W = static_cast<int>(sf::Keyboard::Key::W),
    X = static_cast<int>(sf::Keyboard::Key::X),
    Y = static_cast<int>(sf::Keyboard::Key::Y),
    Z = static_cast<int>(sf::Keyboard::Key::Z),
    Num0 = static_cast<int>(sf::Keyboard::Key::Num0),
    Num1 = static_cast<int>(sf::Keyboard::Key::Num1),
    Num2 = static_cast<int>(sf::Keyboard::Key::Num2),
    Num3 = static_cast<int>(sf::Keyboard::Key::Num3),
    Num4 = static_cast<int>(sf::Keyboard::Key::Num4),
    Num5 = static_cast<int>(sf::Keyboard::Key::Num5),
    Num6 = static_cast<int>(sf::Keyboard::Key::Num6),
    Num7 = static_cast<int>(sf::Keyboard::Key::Num7),
    Num8 = static_cast<int>(sf::Keyboard::Key::Num8),
    Num9 = static_cast<int>(sf::Keyboard::Key::Num9),
    Escape = static_cast<int>(sf::Keyboard::Key::Escape),
    LControl = static_cast<int>(sf::Keyboard::Key::LControl),
    LShift = static_cast<int>(sf::Keyboard::Key::LShift),
    LAlt = static_cast<int>(sf::Keyboard::Key::LAlt),
    LSystem = static_cast<int>(sf::Keyboard::Key::LSystem),
    RControl = static_cast<int>(sf::Keyboard::Key::RControl),
    RShift = static_cast<int>(sf::Keyboard::Key::RShift),
    RAlt = static_cast<int>(sf::Keyboard::Key::RAlt),
    RSystem = static_cast<int>(sf::Keyboard::Key::RSystem),
    Menu = static_cast<int>(sf::Keyboard::Key::Menu),
    LBracket = static_cast<int>(sf::Keyboard::Key::LBracket),
    RBracket = static_cast<int>(sf::Keyboard::Key::RBracket),
    SemiColon = static_cast<int>(sf::Keyboard::Key::Semicolon),
    Comma = static_cast<int>(sf::Keyboard::Key::Comma),
    Period = static_cast<int>(sf::Keyboard::Key::Period),
    Quote = static_cast<int>(sf::Keyboard::Key::Apostrophe),
    Slash = static_cast<int>(sf::Keyboard::Key::Slash),
    BackSlash = static_cast<int>(sf::Keyboard::Key::Backslash),
    Tilde = static_cast<int>(sf::Keyboard::Key::Grave),
    Equal = static_cast<int>(sf::Keyboard::Key::Equal),
    Dash = static_cast<int>(sf::Keyboard::Key::Hyphen),
    Space = static_cast<int>(sf::Keyboard::Key::Space),
    Return = static_cast<int>(sf::Keyboard::Key::Enter),
    BackSpace = static_cast<int>(sf::Keyboard::Key::Backspace),
    Tab = static_cast<int>(sf::Keyboard::Key::Tab),
    PageUp = static_cast<int>(sf::Keyboard::Key::PageUp),
    PageDown = static_cast<int>(sf::Keyboard::Key::PageDown),
    End = static_cast<int>(sf::Keyboard::Key::End),
    Home = static_cast<int>(sf::Keyboard::Key::Home),
    Insert = static_cast<int>(sf::Keyboard::Key::Insert),
    Delete = static_cast<int>(sf::Keyboard::Key::Delete),
    Add = static_cast<int>(sf::Keyboard::Key::Add),
    Subtract = static_cast<int>(sf::Keyboard::Key::Subtract),
    Multiply = static_cast<int>(sf::Keyboard::Key::Multiply),
    Divide = static_cast<int>(sf::Keyboard::Key::Divide),
    Left = static_cast<int>(sf::Keyboard::Key::Left),
    Right = static_cast<int>(sf::Keyboard::Key::Right),
    Up = static_cast<int>(sf::Keyboard::Key::Up),
    Down = static_cast<int>(sf::Keyboard::Key::Down),
    Numpad0 = static_cast<int>(sf::Keyboard::Key::Numpad0),
    Numpad1 = static_cast<int>(sf::Keyboard::Key::Numpad1),
    Numpad2 = static_cast<int>(sf::Keyboard::Key::Numpad2),
    Numpad3 = static_cast<int>(sf::Keyboard::Key::Numpad3),
    Numpad4 = static_cast<int>(sf::Keyboard::Key::Numpad4),
    Numpad5 = static_cast<int>(sf::Keyboard::Key::Numpad5),
    Numpad6 = static_cast<int>(sf::Keyboard::Key::Numpad6),
    Numpad7 = static_cast<int>(sf::Keyboard::Key::Numpad7),
    Numpad8 = static_cast<int>(sf::Keyboard::Key::Numpad8),
    Numpad9 = static_cast<int>(sf::Keyboard::Key::Numpad9),
    F1 = static_cast<int>(sf::Keyboard::Key::F1),
    F2 = static_cast<int>(sf::Keyboard::Key::F2),
    F3 = static_cast<int>(sf::Keyboard::Key::F3),
    F4 = static_cast<int>(sf::Keyboard::Key::F4),
    F5 = static_cast<int>(sf::Keyboard::Key::F5),
    F6 = static_cast<int>(sf::Keyboard::Key::F6),
    F7 = static_cast<int>(sf::Keyboard::Key::F7),
    F8 = static_cast<int>(sf::Keyboard::Key::F8),
    F9 = static_cast<int>(sf::Keyboard::Key::F9),
    F10 = static_cast<int>(sf::Keyboard::Key::F10),
    F11 = static_cast<int>(sf::Keyboard::Key::F11),
    F12 = static_cast<int>(sf::Keyboard::Key::F12),
    F13 = static_cast<int>(sf::Keyboard::Key::F13),
    F14 = static_cast<int>(sf::Keyboard::Key::F14),
    F15 = static_cast<int>(sf::Keyboard::Key::F15),
    Pause = static_cast<int>(sf::Keyboard::Key::Pause),
    KeyCount = static_cast<int>(sf::Keyboard::KeyCount)
};

inline bool isKeyPressed(Key key)
{
    return sf::Keyboard::isKeyPressed(static_cast<sf::Keyboard::Key>(key));
}

inline bool isScancodePressed(int scancode)
{
    return sf::Keyboard::isKeyPressed(static_cast<sf::Keyboard::Scancode>(scancode));
}

inline Key localize(int scancode)
{
    return static_cast<Key>(sf::Keyboard::localize(static_cast<sf::Keyboard::Scancode>(scancode)));
}

inline int delocalize(Key key)
{
    return static_cast<int>(sf::Keyboard::delocalize(static_cast<sf::Keyboard::Key>(key)));
}

inline sf::String getDescription(int scancode)
{
    return sf::Keyboard::getDescription(static_cast<sf::Keyboard::Scancode>(scancode));
}

inline void setVirtualKeyboardVisible(bool visible)
{
    sf::Keyboard::setVirtualKeyboardVisible(visible);
}
}

namespace pysfml::clipboard_compat
{
inline sf::String getString()
{
    return sf::Clipboard::getString();
}

inline void setString(const sf::String& text)
{
    sf::Clipboard::setString(text);
}
}

namespace pysfml::cursor_compat
{
enum Type
{
    Arrow = static_cast<int>(sf::Cursor::Type::Arrow),
    ArrowWait = static_cast<int>(sf::Cursor::Type::ArrowWait),
    Wait = static_cast<int>(sf::Cursor::Type::Wait),
    Text = static_cast<int>(sf::Cursor::Type::Text),
    Hand = static_cast<int>(sf::Cursor::Type::Hand),
    SizeHorizontal = static_cast<int>(sf::Cursor::Type::SizeHorizontal),
    SizeVertical = static_cast<int>(sf::Cursor::Type::SizeVertical),
    SizeTopLeftBottomRight = static_cast<int>(sf::Cursor::Type::SizeTopLeftBottomRight),
    SizeBottomLeftTopRight = static_cast<int>(sf::Cursor::Type::SizeBottomLeftTopRight),
    SizeLeft = static_cast<int>(sf::Cursor::Type::SizeLeft),
    SizeRight = static_cast<int>(sf::Cursor::Type::SizeRight),
    SizeTop = static_cast<int>(sf::Cursor::Type::SizeTop),
    SizeBottom = static_cast<int>(sf::Cursor::Type::SizeBottom),
    SizeTopLeft = static_cast<int>(sf::Cursor::Type::SizeTopLeft),
    SizeBottomRight = static_cast<int>(sf::Cursor::Type::SizeBottomRight),
    SizeBottomLeft = static_cast<int>(sf::Cursor::Type::SizeBottomLeft),
    SizeTopRight = static_cast<int>(sf::Cursor::Type::SizeTopRight),
    SizeAll = static_cast<int>(sf::Cursor::Type::SizeAll),
    Cross = static_cast<int>(sf::Cursor::Type::Cross),
    Help = static_cast<int>(sf::Cursor::Type::Help),
    NotAllowed = static_cast<int>(sf::Cursor::Type::NotAllowed)
};

inline sf::Cursor* createFromSystem(int type)
{
    try
    {
        return new sf::Cursor(static_cast<sf::Cursor::Type>(type));
    }
    catch (...)
    {
        return nullptr;
    }
}

inline sf::Cursor* createFromPixels(const std::uint8_t* pixels,
                                    unsigned int width,
                                    unsigned int height,
                                    unsigned int hotspotX,
                                    unsigned int hotspotY)
{
    try
    {
        return new sf::Cursor(pixels, {width, height}, {hotspotX, hotspotY});
    }
    catch (...)
    {
        return nullptr;
    }
}

inline void setMouseCursor(sf::Window& window, const sf::Cursor& cursor)
{
    window.setMouseCursor(cursor);
}
}

namespace pysfml::mouse_compat
{
enum Button
{
    Left = static_cast<int>(sf::Mouse::Button::Left),
    Right = static_cast<int>(sf::Mouse::Button::Right),
    Middle = static_cast<int>(sf::Mouse::Button::Middle),
    XButton1 = static_cast<int>(sf::Mouse::Button::Extra1),
    XButton2 = static_cast<int>(sf::Mouse::Button::Extra2),
    ButtonCount = static_cast<int>(sf::Mouse::ButtonCount)
};

enum Wheel
{
    VerticalWheel = static_cast<int>(sf::Mouse::Wheel::Vertical),
    HorizontalWheel = static_cast<int>(sf::Mouse::Wheel::Horizontal)
};

inline bool isButtonPressed(Button button)
{
    return sf::Mouse::isButtonPressed(static_cast<sf::Mouse::Button>(button));
}

inline sf::Vector2i getPosition()
{
    return sf::Mouse::getPosition();
}

inline sf::Vector2i getPosition(const sf::Window& window)
{
    return sf::Mouse::getPosition(window);
}

inline void setPosition(sf::Vector2i position)
{
    sf::Mouse::setPosition(position);
}

inline void setPosition(sf::Vector2i position, const sf::Window& window)
{
    sf::Mouse::setPosition(position, window);
}
}

namespace pysfml::event_compat
{
enum EventType
{
    Closed,
    Resized,
    LostFocus,
    GainedFocus,
    TextEntered,
    KeyPressed,
    KeyReleased,
    MouseWheelMoved,
    MouseWheelScrolled,
    MouseButtonPressed,
    MouseButtonReleased,
    MouseMoved,
    MouseMovedRaw,
    MouseEntered,
    MouseLeft,
    JoystickButtonPressed,
    JoystickButtonReleased,
    JoystickMoved,
    JoystickConnected,
    JoystickDisconnected,
    TouchBegan,
    TouchMoved,
    TouchEnded,
    SensorChanged,
    Count
};

struct SizeEvent { unsigned int width{}; unsigned int height{}; };
struct KeyEvent { keyboard_compat::Key code{keyboard_compat::Unknown}; int scancode{-1}; bool alt{}; bool control{}; bool shift{}; bool system{}; };
struct TextEvent { std::uint32_t unicode{}; };
struct MouseMoveEvent { int x{}; int y{}; };
struct MouseMoveRawEvent { int deltaX{}; int deltaY{}; };
struct MouseButtonEvent { mouse_compat::Button button{mouse_compat::Left}; int x{}; int y{}; };
struct MouseWheelEvent { int delta{}; int x{}; int y{}; };
struct MouseWheelScrollEvent { mouse_compat::Wheel wheel{mouse_compat::VerticalWheel}; float delta{}; int x{}; int y{}; };
struct JoystickConnectEvent { unsigned int joystickId{}; };
struct JoystickMoveEvent { unsigned int joystickId{}; sf::Joystick::Axis axis{}; float position{}; };
struct JoystickButtonEvent { unsigned int joystickId{}; unsigned int button{}; };
struct TouchEvent { unsigned int finger{}; int x{}; int y{}; };
struct SensorEvent { sf::Sensor::Type type{}; float x{}; float y{}; float z{}; };

struct Event
{
    EventType type{Closed};
    SizeEvent size{};
    KeyEvent key{};
    TextEvent text{};
    MouseMoveEvent mouseMove{};
    MouseMoveRawEvent mouseMoveRaw{};
    MouseButtonEvent mouseButton{};
    MouseWheelEvent mouseWheel{};
    MouseWheelScrollEvent mouseWheelScroll{};
    JoystickMoveEvent joystickMove{};
    JoystickButtonEvent joystickButton{};
    JoystickConnectEvent joystickConnect{};
    TouchEvent touch{};
    SensorEvent sensor{};
};

inline void convertEvent(const sf::Event& source, Event& target)
{
    if (source.is<sf::Event::Closed>())
    {
        target.type = Closed;
    }
    else if (const auto* event = source.getIf<sf::Event::Resized>())
    {
        target.type = Resized;
        target.size.width = event->size.x;
        target.size.height = event->size.y;
    }
    else if (source.is<sf::Event::FocusLost>())
    {
        target.type = LostFocus;
    }
    else if (source.is<sf::Event::FocusGained>())
    {
        target.type = GainedFocus;
    }
    else if (const auto* event = source.getIf<sf::Event::TextEntered>())
    {
        target.type = TextEntered;
        target.text.unicode = static_cast<std::uint32_t>(event->unicode);
    }
    else if (const auto* event = source.getIf<sf::Event::KeyPressed>())
    {
        target.type = KeyPressed;
        target.key.code = static_cast<keyboard_compat::Key>(event->code);
        target.key.scancode = static_cast<int>(event->scancode);
        target.key.alt = event->alt;
        target.key.control = event->control;
        target.key.shift = event->shift;
        target.key.system = event->system;
    }
    else if (const auto* event = source.getIf<sf::Event::KeyReleased>())
    {
        target.type = KeyReleased;
        target.key.code = static_cast<keyboard_compat::Key>(event->code);
        target.key.scancode = static_cast<int>(event->scancode);
        target.key.alt = event->alt;
        target.key.control = event->control;
        target.key.shift = event->shift;
        target.key.system = event->system;
    }
    else if (const auto* event = source.getIf<sf::Event::MouseWheelScrolled>())
    {
        target.type = MouseWheelScrolled;
        target.mouseWheelScroll.wheel = static_cast<mouse_compat::Wheel>(event->wheel);
        target.mouseWheelScroll.delta = event->delta;
        target.mouseWheelScroll.x = event->position.x;
        target.mouseWheelScroll.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::MouseButtonPressed>())
    {
        target.type = MouseButtonPressed;
        target.mouseButton.button = static_cast<mouse_compat::Button>(event->button);
        target.mouseButton.x = event->position.x;
        target.mouseButton.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::MouseButtonReleased>())
    {
        target.type = MouseButtonReleased;
        target.mouseButton.button = static_cast<mouse_compat::Button>(event->button);
        target.mouseButton.x = event->position.x;
        target.mouseButton.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::MouseMoved>())
    {
        target.type = MouseMoved;
        target.mouseMove.x = event->position.x;
        target.mouseMove.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::MouseMovedRaw>())
    {
        target.type = MouseMovedRaw;
        target.mouseMoveRaw.deltaX = event->delta.x;
        target.mouseMoveRaw.deltaY = event->delta.y;
    }
    else if (source.is<sf::Event::MouseEntered>())
    {
        target.type = MouseEntered;
    }
    else if (source.is<sf::Event::MouseLeft>())
    {
        target.type = MouseLeft;
    }
    else if (const auto* event = source.getIf<sf::Event::JoystickButtonPressed>())
    {
        target.type = JoystickButtonPressed;
        target.joystickButton.joystickId = event->joystickId;
        target.joystickButton.button = event->button;
    }
    else if (const auto* event = source.getIf<sf::Event::JoystickButtonReleased>())
    {
        target.type = JoystickButtonReleased;
        target.joystickButton.joystickId = event->joystickId;
        target.joystickButton.button = event->button;
    }
    else if (const auto* event = source.getIf<sf::Event::JoystickMoved>())
    {
        target.type = JoystickMoved;
        target.joystickMove.joystickId = event->joystickId;
        target.joystickMove.axis = event->axis;
        target.joystickMove.position = event->position;
    }
    else if (const auto* event = source.getIf<sf::Event::JoystickConnected>())
    {
        target.type = JoystickConnected;
        target.joystickConnect.joystickId = event->joystickId;
    }
    else if (const auto* event = source.getIf<sf::Event::JoystickDisconnected>())
    {
        target.type = JoystickDisconnected;
        target.joystickConnect.joystickId = event->joystickId;
    }
    else if (const auto* event = source.getIf<sf::Event::TouchBegan>())
    {
        target.type = TouchBegan;
        target.touch.finger = event->finger;
        target.touch.x = event->position.x;
        target.touch.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::TouchMoved>())
    {
        target.type = TouchMoved;
        target.touch.finger = event->finger;
        target.touch.x = event->position.x;
        target.touch.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::TouchEnded>())
    {
        target.type = TouchEnded;
        target.touch.finger = event->finger;
        target.touch.x = event->position.x;
        target.touch.y = event->position.y;
    }
    else if (const auto* event = source.getIf<sf::Event::SensorChanged>())
    {
        target.type = SensorChanged;
        target.sensor.type = event->type;
        target.sensor.x = event->value.x;
        target.sensor.y = event->value.y;
        target.sensor.z = event->value.z;
    }
}
}

namespace pysfml::window_compat
{
inline sf::State toWindowState(std::uint32_t style)
{
    return (style & style_compat::Fullscreen) ? sf::State::Fullscreen : sf::State::Windowed;
}

inline std::uint32_t toWindowStyle(std::uint32_t style)
{
    return style & ~style_compat::Fullscreen;
}

inline sf::ContextSettings makeContextSettings(unsigned int depth,
                                               unsigned int stencil,
                                               unsigned int antialiasing,
                                               unsigned int major,
                                               unsigned int minor,
                                               std::uint32_t attributes)
{
    sf::ContextSettings settings;
    settings.depthBits = depth;
    settings.stencilBits = stencil;
    settings.antiAliasingLevel = antialiasing;
    settings.majorVersion = major;
    settings.minorVersion = minor;
    settings.attributeFlags = attributes;
    return settings;
}

inline sf::VideoMode makeVideoMode(unsigned int width, unsigned int height, unsigned int bitsPerPixel)
{
    return sf::VideoMode({width, height}, bitsPerPixel);
}

inline sf::VideoMode getDesktopMode()
{
    return sf::VideoMode::getDesktopMode();
}

inline const std::vector<sf::VideoMode>& getFullscreenModes()
{
    return sf::VideoMode::getFullscreenModes();
}

inline void createWindow(sf::Window& window,
                         sf::VideoMode mode,
                         const sf::String& title,
                         std::uint32_t style,
                         const sf::ContextSettings& settings)
{
    window.create(mode, title, toWindowStyle(style), toWindowState(style), settings);
}

inline void createWindowWithState(sf::Window& window,
                                  sf::VideoMode mode,
                                  const sf::String& title,
                                  std::uint32_t style,
                                  std::uint32_t state,
                                  const sf::ContextSettings& settings)
{
    window.create(mode, title, style, static_cast<sf::State>(state), settings);
}

inline void createRenderWindow(sf::RenderWindow& window,
                               sf::VideoMode mode,
                               const sf::String& title,
                               std::uint32_t style,
                               const sf::ContextSettings& settings)
{
    window.create(mode, title, toWindowStyle(style), toWindowState(style), settings);
}

inline bool pollEvent(sf::Window& window, event_compat::Event& event)
{
    if (const std::optional<sf::Event> source = window.pollEvent())
    {
        event_compat::convertEvent(*source, event);
        return true;
    }

    return false;
}

inline bool waitEvent(sf::Window& window, event_compat::Event& event)
{
    if (const std::optional<sf::Event> source = window.waitEvent())
    {
        event_compat::convertEvent(*source, event);
        return true;
    }

    return false;
}

inline bool waitEventWithTimeout(sf::Window& window, event_compat::Event& event, const sf::Time& timeout)
{
    if (const std::optional<sf::Event> source = window.waitEvent(timeout))
    {
        event_compat::convertEvent(*source, event);
        return true;
    }

    return false;
}

inline void setIcon(sf::Window& window, unsigned int width, unsigned int height, const std::uint8_t* pixels)
{
    window.setIcon({width, height}, pixels);
}

inline void setMinimumSize(sf::Window& window, bool hasValue, unsigned int width, unsigned int height)
{
    if (hasValue)
    {
        window.setMinimumSize(sf::Vector2u{width, height});
    }
    else
    {
        window.setMinimumSize(std::nullopt);
    }
}

inline void setMaximumSize(sf::Window& window, bool hasValue, unsigned int width, unsigned int height)
{
    if (hasValue)
    {
        window.setMaximumSize(sf::Vector2u{width, height});
    }
    else
    {
        window.setMaximumSize(std::nullopt);
    }
}

inline void setMouseCursorGrabbed(sf::Window& window, bool grabbed)
{
    window.setMouseCursorGrabbed(grabbed);
}
}

namespace pysfml::context_compat
{
inline sf::ContextSettings getSettings(const sf::Context& context)
{
    return context.getSettings();
}

inline bool isExtensionAvailable(const char* name)
{
    return sf::Context::isExtensionAvailable(name);
}

inline std::uint64_t getFunction(const char* name)
{
    return reinterpret_cast<std::uint64_t>(sf::Context::getFunction(name));
}

inline std::uint64_t getActiveContextId()
{
    return sf::Context::getActiveContextId();
}
}

#endif // PYSFML_WINDOW_COMPAT_HPP