" This file contains python specific settings for the pybreak plugin
"
" Last Change:  2012-08-21
" Maintainer:   Niklas Thörne  <notrupertthorne@gmail.com>
"
" License:      Copyright (C) 2012 Niklas Thörne
"
" This file is part of pybreak.
"
" pybreak is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" pybreak is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with pybreak.  If not, see <http://www.gnu.org/licenses/>.


" Only load this ftplugin once per buffer
if exists("b:did_pybreak_plugin")
  finish
endif
let b:did_pybreak_plugin = 1


""" }}}
""" keymappings {{{
"""

nnoremap <localleader>d :call pybreak#ToggleBreakpoint()<CR>


""" }}}
