" Find the current file location
nmap <silent><leader>fo :exe 'CocCommand explorer --no-toggle --position left --sources=buffer+,file+ '
            \ . (stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()) <CR><CR>
" Open the file manager
nmap <silent><F3> :CocCommand explorer --toggle --position left --sources=buffer+,file+<CR>
