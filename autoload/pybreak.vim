" This file contains the main pybreak functions
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

let s:set_trace=';import pdb; pdb.set_trace();'


" function! ToggleSetTrace() {{{
"   Toggle set_trace statements at current position
function! pybreak#ToggleSetTrace()
  let l:line=line('.')
  let l:current_line=getline(l:line)

  if match(l:current_line, s:set_trace) != -1
    " if the current line contained a set_trace statement, remove it..
    let l:current_line=<SID>RemoveSetTrace(l:current_line)
  else
    let l:col=col('.')

    " .. otherwise, split the current line in twain, at the cursor position..
    let l:fst_part=strpart(l:current_line, 0, l:col)
    let l:snd_part=strpart(l:current_line, l:col)

    " .. and insert the set_trace statement after the cursor position
    let l:current_line=l:fst_part.s:set_trace.l:snd_part
  endif

  call setline(l:line, l:current_line)
endfunction
" }}}


" function! pybreak#RemoveAllSetTraces() {{{
"   Remove all set_trace statements in the current buffer
function! pybreak#RemoveAllSetTraces()
  let l:lineno = 1
  
  " for each line in the active buffer..
  for l:line in getline(1, '$')
    if !empty(l:line)
      " .. if the line contains a set_trace statement..
      if match(l:line, s:set_trace) != -1
        " .. remove it
        let l:modified_line = <SID>RemoveSetTrace(l:line)
        call setline(l:lineno, l:modified_line)
      endif
    endif
    let l:lineno += 1
  endfor
endfunction
" }}}


" function! RemoveSetTrace() {{{
"   Remove set_trace statement(s) at a:line_str
"
" arguments:
"   line_str  - the string value of the line from which set_trace is to be
"     removed
" returns:
"   a line with any set_trace statements removed
function! <SID>RemoveSetTrace(line_str)
  return substitute(a:line_str, s:set_trace, '', '')
endfunction
" }}}
