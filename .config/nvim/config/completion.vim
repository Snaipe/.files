NeoBundle 'Shougo/deoplete.nvim'

" Completion
" set omnifunc=syntaxcomplete#Complete
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

let g:deoplete#enable_at_startup = 1

" Make deoplete work with multiple cursors
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction
