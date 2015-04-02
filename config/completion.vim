" Completion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <leader>j <C-X><C-O>
nnoremap <leader>j <C-X><C-O>
inoremap <C-Space> <C-X><C-O>
nnoremap <C-Space> <C-X><C-O>
inoremap <C-@> <C-X><C-O>
nnoremap <C-@> <C-X><C-O>

" command completion
set wildmenu
set wildmode=list:longest:full
set wildignore+=*.o,*.aux
