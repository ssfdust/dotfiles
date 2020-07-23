for i in range(1, 9)
    exe 'nmap <silent><leader>' . i . ' :call window#jump(' . i . ')<CR>'
endfor
