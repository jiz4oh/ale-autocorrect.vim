" Author: jiz4oh <me@jiz4oh.com>
" Description: Integration of autocorrect with ALE.

function! ale#fixers#autocorrect#Fix(buffer) abort
  return {
  \   'command': 'autocorrect --fix %t',
  \   'read_temporary_file': 1
  \}
endfunction
