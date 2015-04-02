if !1 | finish | endif

let vimhome = $HOME . '/.nvim'
let mapleader=','

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.nvim/bundle/neobundle.vim/
endif

call neobundle#begin(expand(vimhome . '/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Lokaltog/vim-easymotion'

for f in split(glob(vimhome . '/config/*.vim'), '\n')
    exe 'source' f
endfor

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
