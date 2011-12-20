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


#from cpp cimport Vector2i, RenderWindow
#cdef cppclass Vector2i
#cdef cppclass RenderWindow
cdef extern from "SFML/Window.hpp" namespace "sf":
    cppclass Window
    
cdef extern from "SFML/System.hpp" namespace "sf":
    cppclass Vector2i
    

cdef extern from "SFML/Window.hpp" namespace "sf::Mouse":
    cdef cppclass Button
    
    int Left
    int Right
    int Middle
    int XButton1
    int XButton2
    int ButtonCount

    cdef bint IsButtonPressed(Button)
    cdef Vector2i GetPosition()
    cdef Vector2i GetPosition(Window&)
    cdef void SetPosition(Vector2i&)
    cdef void SetPosition(Vector2i&, Window&)
