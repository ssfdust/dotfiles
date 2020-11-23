tnoremap <Esc> <C-\><C-n>
nnoremap <leader>fvd :tabe $MYVIMRC<CR>
nnoremap <leader>fdd :exe 'tabe ' . manager#get_dein_toml()<CR>

inoremap <C-s> <ESC>:w<CR>i
nnoremap <C-s> :w<CR>

nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bd :bd<cr>

vnoremap <leader>k zf
nnoremap <leader>j za
nnoremap <leader>k zc

nnoremap <leader>fy :call buffer#get_filepath()<CR>

cnoremap <expr> <C-X>dt strftime('%Y-%m-%d')

nnoremap gq :quit<CR>

