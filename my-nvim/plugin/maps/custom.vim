tmap <Esc> <C-\><C-n>
nmap <leader>fvd :tabe $MYVIMRC<CR>
nmap <leader>fdd :exe 'tabe ' . manager#get_dein_toml()<CR>

imap <C-s> <ESC>:w<CR>i
nmap <C-s> :w<CR>

nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bd :bd<cr>

vmap <leader>k zf
nmap <leader>j za
nmap <leader>k zc

cnoremap <expr> <C-X>dt strftime('%Y-%m-%d')

nmap gq :quit<CR>
