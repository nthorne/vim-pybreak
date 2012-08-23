" This file contains the main pybreak functions
"
" Last Change:  2012-08-23
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

let s:set_trace = 'import pdb; pdb.set_trace();'


" function! ToggleSetTrace() {{{
"   Toggle set_trace statements at current position
function! pybreak#ToggleSetTrace()
  let l:line = line('.')
  let l:current_line = getline(l:line)

  if match(l:current_line, s:set_trace) != -1
    " if the current line contained a set_trace statement, remove it..
    let l:current_line = <SID>RemoveSetTrace(l:current_line)
  else
    let l:col = col('.')
    " .. and append the set_trace statement after the cursor position
    let l:current_line = <SID>AppendSetTrace(l:col, l:line)
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
  let l:result = substitute(a:line_str, ';\{0,1}'.s:set_trace, '', '')
  return substitute(l:result, '^\s\{1,}$', '', '')
endfunction
" }}}


" function! AppendSetTrace() {{{
"   Append set_trace statement after cursor position.
"
" arguments:
"   col - the column after which the set_trace statement is to be appended
"   line - the line at which the set_trace is to be appended
" returns:
"   a line in which the set_trace statement has been injected 
function! <SID>AppendSetTrace(col, line)
    let l:current_line = getline(a:line)

    " .. otherwise, split the current line in twain, at the cursor position..
    let l:fst_part = strpart(l:current_line, 0, a:col)
    let l:snd_part = strpart(l:current_line, a:col)

    let l:result = ''

    if 1 != a:line
      let l:previous_line = getline(a:line - 1)
      let l:previous_indentation = substitute(l:previous_line, '^\(\s*\).*$', '\1', '')
      let l:result = l:result.l:previous_indentation
    endif
  
    let l:result = l:result.l:fst_part

    " if the part of the line to the left of the cursor contains any
    " characters, we preceed the set_trace statement with a ';'
    if match(l:fst_part, '^\s*$') == -1
      let l:result = l:result.';'
    endif

    let l:result = l:result.s:set_trace.l:snd_part

    return l:result
endfunction
" }}}

