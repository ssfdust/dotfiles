" Find the current file location
nmap <leader>fo :exe 'CocCommand explorer --position right --sources=buffer+,file+ '
            \ . (stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()) <CR><CR>
" Open the file manager
nmap <F3> :CocCommand explorer --toggle --position right --sources=buffer+,file+<CR>
