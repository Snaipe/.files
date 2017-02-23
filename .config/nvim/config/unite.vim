NeoBundle 'Shougo/unite.vim'

" Unite configuration
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
endfunction

let g:unite_enable_start_insert = 1
"let g:unite_data_directory=s:get_cache_dir('unite')
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000

function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-s> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
endfunction
autocmd FileType unite call s:unite_settings()

nnoremap <leader>t     :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader><s-t> :<C-u>Unite           -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f     :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader><s-f> :<C-u>Unite           -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r     :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o     :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y     :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e     :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>/     :<C-u>Unite grep:.<cr>
