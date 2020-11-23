function buffer#get_filepath() abort
    let the_filepath = expand("%:p")
    echo the_filepath
    let @" = the_filepath
endfunction
