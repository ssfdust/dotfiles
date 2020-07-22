" Custome command
command -nargs=1 AddTodo :call todo#add_new_todo(<q-args>)
command OpenTodo exe 'tabe' . g:todo_file
