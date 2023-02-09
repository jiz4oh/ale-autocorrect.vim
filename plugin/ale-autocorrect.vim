if exists('g:loaded_ale_autocorrect')
  finish
endif

let g:loaded_ale_autocorrect = 1

if !exists('g:loaded_ale')
  echo "please install ale first"
  finish
endif

" supported filetypes
" https://github.com/huacnlee/autocorrect/tree/main/autocorrect/grammar
call ale#fix#registry#Add('autocorrect',
      \'ale#fixers#autocorrect#Fix', 
      \[
      \'asciidoc',
      \'c',
      \'conf',
      \'toml',
      \'dosini',
      \'cfg',
      \'jproperties',
      \'cs',
      \'css',
      \'dart',
      \'elixir',
      \'go',
      \'gettext',
      \'html',
      \'java',
      \'javascript',
      \'json',
      \'jupyter',
      \'kotlin',
      \'tex',
      \'markdown',
      \'objc',
      \'php',
      \'python',
      \'ruby',
      \'rust',
      \'scala',
      \'sql',
      \'strings',
      \'swift',
      \'xml',
      \'yaml',
      \'text',
      \], 
      \'Correct spaces, words, and punctuations between CJK (Chinese, Japanese, Korean). '
      \)
