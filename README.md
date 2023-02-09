# ale-autocorrect.vim

Add [autocorrect](https://github.com/huacnlee/autocorrect) support for [ALE](https://github.com/dense-analysis/ale)


## Installation

If you don't have a preferred installation method, I recommend
installing [vim-plug](https://github.com/junegunn/vim-plug), and
then add following codes.

```vim
Plug 'jiz4oh/ale-autocorrect.vim'
```

## Configuration

ALE linters are automatically run without any configurations in most filetypes. But some filetypes have been defined a default `linters` e.g python, go.
You can found more detail by `:h ale_linters`, and add following codes into your vimrc if you are work with those filetypes.

```vim
" For example, you can enable only `autocorrect` for Python files
let g:ale_linters = { 'python': ['autocorrect'] }
```

If you need fix by ALE, add following codes into your vimrc.

```vim
" For example, enable only `autocorrect` for Python files
let g:ale_fixers = { 'python': ['autocorrect'] }
```

## License

This project under MIT license.

