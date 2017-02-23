" Theme
set t_Co=256
colorscheme jellybeans

" Syntax
syntax on

" Line numbering
set number
set relativenumber

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Resize split when window is resized
au VimResized * :wincmd =

" Tabs
set showtabline=2
set tabpagemax=30

" Title
set title
set titlestring=Vim:\ %f\ %h%r%m

" Layout
set colorcolumn=80

" Whitespace display
set list
set listchars=tab:——,trail:·,extends:→,nbsp:·,precedes:←

" Status messages
set laststatus=2
set statusline=%f\ %l\|%c\ %m%=%p%%\ (%Y%R)
set shortmess=roOTnxtfilm
set showcmd
