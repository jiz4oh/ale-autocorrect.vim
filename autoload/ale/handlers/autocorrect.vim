function! ale#handlers#autocorrect#GetType(severity) abort
    if a:severity == 1
        return 'E'
    elseif a:severity == 2
        return 'W'
    endif

    return 'E'
endfunction

function! ale#handlers#autocorrect#Handle(buffer, lines)
  try
    let l:errors = json_decode(join(a:lines, ''))
  catch
    return []
  endtry

  if empty(l:errors)
    return []
  endif

  let l:output = []

  for l:message in l:errors.messages
    for l:error in l:message.lines
      call add(l:output, {
      \   'filename': l:message['filepath'],
      \   'lnum': l:error['l'],
      \   'col': l:error['c'],
      \   'text': l:error['new'],
      \   'type': ale#handlers#autocorrect#GetType(l:error['severity'])
      \})
    endfor
  endfor

  return l:output
endfunction

function! ale#handlers#autocorrect#DefineLinter(filetype) abort
  call ale#linter#Define(a:filetype, {
  \   'name': 'autocorrect',
  \   'executable': 'autocorrect',
  \   'command': 'autocorrect --lint --format json %t',
  \   'callback': 'ale#handlers#autocorrect#Handle',
  \})
endfunction
