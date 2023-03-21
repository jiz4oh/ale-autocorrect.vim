call ale#Set('autocorrect_executable', 'autocorrect')
call ale#Set('autocorrect_options', '')

function! ale#handlers#autocorrect#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'autocorrect_executable')
endfunction

function! ale#handlers#autocorrect#GetCommand(buffer) abort
    let l:executable = ale#handlers#autocorrect#GetExecutable(a:buffer)
    let l:options = ale#Var(a:buffer, 'autocorrect_options')

    return ale#Escape(l:executable)
    \ . (empty(l:options) ? '' : ' ' . l:options) . ' --lint --format json %t'
endfunction

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
  \   'executable': function('ale#handlers#autocorrect#GetExecutable'),
  \   'command': function('ale#handlers#autocorrect#GetCommand'),
  \   'callback': 'ale#handlers#autocorrect#Handle',
  \})
endfunction
