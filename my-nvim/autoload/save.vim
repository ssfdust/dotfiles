function save#super_write() abort
    write !sudo tee > /dev/null %
    edit!
endfunction
