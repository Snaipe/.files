" Pair matching
set showmatch
set matchtime=3

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set matchpairs+=<:>
map! <leader>c <ESC>:let @/ = ""<CR>

" Search/Replace preview
set inccommand=split
