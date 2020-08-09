function! chinese#ph_split() abort
    exe ':silent g/^\r/d'
    exe ':silent %s/ //g'
    exe ':silent %s/\r//g'
    let text = substitute(join(getline(1, '$')), ' ', '', 'g')
    let regexs = s:get_regex(text)
    let buffer = join(getline(1, '$'), "\n")
    let total = 0
    let content = []
    for item in regexs
        let matched = matchstr(buffer, item)
        let cur_cnt = s:get_count(matched)
        let total += cur_cnt
        if matched != ''
            let matched_lst = split(matched . '。(' . cur_cnt . '/' . total . ")\n", "\n") + ['']
            call extend(content, matched_lst)
        endif
        let buffer = substitute(buffer, matched, '', '')
    endfor
    exe 'normal ggdG'
    call append(0, s:rtrim(content))
    exe 'normal Gddgg'
endfunction

function chinese#count_word() range
    exe ":'<,'>s/[\u4E00-\u9FCC]//gn"
endfunction

function s:rtrim(content) abort
    let length = len(a:content)
    while length != 0 && a:content[length - 1] == ''
        call remove(a:content, length - 1)
        let length -= 1
    endwhile
    return a:content
endfunction

function s:get_regex(text) abort
    let text = a:text
    let regex = '\([\u4E00-\u9FCC][^\u4E00-\u9FCC]\{0,1}\)\{107}[\u4E00-\u9FCC]\{-}[^\u4E00-\u9FCC]'
    let res = []
    while text != ''
        let subtext = matchstr(text, regex)
        if subtext != ''
            let text = substitute(text, subtext, '', 'g')
            call add(res, s:get_unicode(subtext))
        else
            call add(res, s:get_unicode(text))
            let text = ''
        endif
    endwhile
    return res
endfunction

function! s:get_unicode(text) abort
    let rv = split(a:text, '[^\u4E00-\u9FCC]')
    return join(rv, '\_[^\u4E00-\u9FCC]\{0,2}')
endfunction

function s:lst2str(strlst) abort
    let text = ''
    exe 'let text' . "='" . join(a:strlst, "'.'") . "'"
    return text
endfunction

function! s:get_count(text) abort
    let cnt = 0
    for chr in split(a:text, '\zs')
        if chr =~# '[\u4E00-\u9FCC]'
            let cnt += 1
        endif
    endfor
    return cnt
endfunction
