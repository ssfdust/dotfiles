function! window#jump(nr) abort
    if winnr('$') >= a:nr
        exe a:nr . 'wincmd w'
    endif
endfunction

function window#create_terminal() abort
    :below 14split term://zsh
    :sleep 300ms
    :startinsert
endfunction
