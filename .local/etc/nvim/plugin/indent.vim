" Retab
function! Tabbify(size)
	set noexpandtab
	let &l:tabstop = a:size
	%retab!
endfunction
command! -nargs=1 Tabbify call Tabbify( '<args>' )
cnoreabbrev rei Tabbify

" Indentation settings
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >><ESC>_
vnoremap <S-Tab> <<<ESC>_
inoremap <S-Tab> <<_
