set backspace=indent,eol,start

" Encoding
set encoding=utf-8

" Yank / paste to system clipboard
set clipboard=unnamedplus
nnoremap <leader> y "+y
nnoremap <leader> x "+x
nnoremap <leader> p "+gP
nnoremap Y y$

set pastetoggle=<F12>

" Write as root
cnoreabbrev w!! w !sudo tee % >/dev/null

" Misc
set ttyfast
set cursorline

" Spelling
set dictionary=/usr/share/dict/words

" Completion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <leader>j <C-X><C-O>
inoremap <C-Space> <C-X><C-O>
inoremap <C-@> <C-X><C-O>
