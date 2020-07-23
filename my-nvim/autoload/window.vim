function! window#jump(nr) abort
    if winnr('$') >= a:nr
        exe a:nr . 'wincmd w'
    endif
endfunction
