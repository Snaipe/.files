" History
set undolevels=1000
set undoreload=-1
let undodir=vimhome . '/undo'
let &undodir=undodir
set undofile

if !isdirectory(undodir)
    call mkdir(undodir)
endif
