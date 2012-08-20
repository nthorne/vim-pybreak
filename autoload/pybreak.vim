" This file contains the main pybreak functions
"
" Last Change:  2012-08-20
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


" function! ToggleBreakpoint() {{{
"   Toggle python breakpoint at current position
function! pybreak#ToggleBreakpoint()
  let l:breakpoint=';import pdb; pdb.set_trace();'

  let l:line=line('.')
  let l:col=col('.')
  let l:current_line=getline(l:line)

  if match(l:current_line, l:breakpoint) != -1
    let l:current_line=substitute(l:current_line, l:breakpoint, '', '')
  else
    let l:fst_part=strpart(l:current_line, 0, l:col)
    let l:snd_part=strpart(l:current_line, l:col)

    let l:current_line=l:fst_part.l:breakpoint.l:snd_part
  endif

  call setline(l:line, l:current_line)


endfunction
" }}}
