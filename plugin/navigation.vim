" No arrow keys, thanks
nnoremap <up>	 <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>	 <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Navigation
nnoremap k gk
nnoremap j gj
nmap <silent> <left> :wincmd h<CR>
nmap <silent> <down> :wincmd j<CR>
nmap <silent> <up> :wincmd k<CR>
nmap <silent> <right> :wincmd l<CR>

" Selection
nmap <S-j> <ESC>vj
vmap <S-j> j
nmap <S-k> <ESC>vk
vmap <S-k> k
nmap <S-h> <ESC>vh
vmap <S-h> h
nmap <S-l> <ESC>vl
vmap <S-l> l

" Return to line when reopening a file
augroup line_return
	au!
	au BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\	execute 'normal! g`"zvzz' |
		\ endif
augroup END
