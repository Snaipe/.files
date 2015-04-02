" Autoreload file
set autoread
au CursorHold * checktime

" .vimrc reloading
if !exists("*ReloadVimrc")
	function! ReloadVimrc()
		so $MYVIMRC
	endfunction
endif
cnoreabbrev reloadvim :call ReloadVimrc()
map <leader>r :call ReloadVimrc()<CR>

" Auto reload .vimrc
augroup myvimrc
	au!
	au BufWritePost .nvimrc,nvimrc call ReloadVimrc()
augroup END
