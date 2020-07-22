function todo#add_new_todo(todo)
    call system('todo.sh a "'. a:todo . '"')
endfunction
