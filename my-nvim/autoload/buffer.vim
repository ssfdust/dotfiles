function buffer#get_filepath() abort
    let the_filepath = expand("%:p")
    echo the_filepath
    let @" = the_filepath
endfunction


function! buffer#init_rotate_sub()
    let s:rs_idx = 0
endfunction

function! buffer#rotate_sub(list)
    let res = a:list[s:rs_idx]
    let s:rs_idx += 1
    if s:rs_idx == len(a:list)
        let s:rs_idx = 0
    endif
    return res
endfunction

