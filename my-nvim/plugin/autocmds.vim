" Highlight the symbol and its references when holding the cursor.
au CursorHold * silent call CocActionAsync('highlight')

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
