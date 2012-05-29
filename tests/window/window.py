#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# pySFML2 - Cython SFML Wrapper for Python
# Copyright 2012, Jonathan De Wachter <dewachter.jonathan@gmail.com>
#
# This software is released under the GPLv3 license.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sfml.window as sf

window = sf.Window(sf.VideoMode(800, 600), "pySFML Window")

print(window.opened)
print(window.settings)
assert type(window.settings) == sf.ContextSettings

loop = True
while loop:
	for event in window.events:
		print(event)
		print(type(event))
		
		if event.type == sf.Event.CLOSED:
			loop = False

input()
print("### sf.Window.poll_event() ###")			
event = window.poll_event()
print(event)
print(type(event))

print("### sf.Window.wait_event() ###")			
event = window.wait_event()
print(event)
print(type(event))
input()

#print("### sf.Window.position ###")
#print(window.position)
#window.position = sf.Position(0, 0)
#window.position = (200, 200)
#for event in window.events: pass
#print(window.position)
#assert window.position == sf.Position(200, 200)

#print("### sf.Window.size ###")
#print(window.size)
#window.size = sf.Size(512, 512)
#window.size = (300, 300)
#for event in window.events: pass
#assert window.size == sf.Size(300, 300)

print("### sf.Window.title ###")
#print(window.title)
window.title = "pySFML - New title"
#assert window.title == "pySFML - New title"

print("### sf.Window.icon ###")
#image = sf.Image.load_from_file("data/icon.png")


print("### sf.Window.visible ###")
print(window.visible)
input()
window.visible = not window.visible

print("### sf.Window.hide() ###")
window.hide()
input()

print("### sf.Window.show() ###")
window.show()
input()

print("### sf.Window.vertical_synchronization ###")
print(window.vertical_synchronization)
window.vertical_synchronization = True
window.vertical_synchronization = not window.vertical_synchronization
print(window.vertical_synchronization)
input()

print("### sf.Window.mouse_cursor_visible ###")
#print(window.mouse_cursor_visible)
window.mouse_cursor_visible = False
input()
window.mouse_cursor_visible = True
input()
#window.mouse_cursor_visible = not window.mouse_cursor_visible

print("### sf.Window.key_repeat_enabled ###")
#print(window.key_repeat_enabled)
window.key_repeat_enabled = False
window.key_repeat_enabled = True
#window.key_repeat_enabled = not window.key_repeat_enabled

print("### sf.Window.framerate_limit ###")
#print(window.framerate_limit)
window.framerate_limit = 20
window.framerate_limit = 30
window.framerate_limit = 40
#assert window.framerate_limit == 20

print("### sf.Window.joystick_threshold ###")
#print(window.joystick_threshold)
window.joystick_threshold = 0.2
window.joystick_threshold = 0.3

print("### sf.Window.active ###")
window.active = True
window.active = False
window.active = True

print("### sf.Window.display() ###")
window.display()

print("### sf.Window.on_create() and sf.Window.on_resize() ###")
class MyWindow(sf.Window):
   def __init__(self):
      sf.Window.__init__(self, sf.VideoMode(640, 480), "pySFML")

   def on_create(self):
      print("Window created or recreated...")
      
   def on_resize(self):
      print("Window size changed")
      
mywindow = MyWindow()

loop = True
while loop:
	for event in mywindow.events:
		print(event)
		
		if event.type == sf.Event.CLOSED:
			loop = False
		
input()




