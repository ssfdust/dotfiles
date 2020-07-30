" Highlight the symbol and its references when holding the cursor.
au CursorHold * silent call CocActionAsync('highlight')

au BufWritePre *.py call CocAction('format')
au FileType python let b:delimitMate_nesting_quotes = ['`', "'", '"']
au FileType python set cc=79
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
