function! chinese#count_ch() range
    let selection = s:get_visual_selection()
    let cnt = 0
    for chr in split(selection, '\zs')
        if chr =~? '[\u4E00-\u9FCC]'
            let cnt = cnt + 1
        endif
    endfor
    echo cnt
endfunction

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
