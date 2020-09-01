let s:template = {
    \ 'md_header_template': [
    \ '<head>',
    \ '<style type="text/css">',
    \ 'h1 {',
    \ '  text-align:center;',
    \ '}',
    \ 'p {',
    \ '  font-size:25pt;',
    \ '}',
    \ '</style>',
    \ '</head>',
    \ '',
    \ '#  每日任务',
    \ ''
    \ ],
    \ 'md_tail_template': [
    \ '',
    \ '# 静坐'
    \ ]
    \ }

function! chinese#ph_split() abort
    for cmd in [':silent g/^\r/d', ':silent %s/ //g', ':silent %s/\r//g', ':%s/<br>//g']
        try
            exe cmd
        catch /.*/
            echo v:exception
        finally
        endtry
    endfor
    let text = substitute(join(getline(1, '$')), ' ', '', 'g')
    let regexs = s:get_regex(text)
    let buffer = join(getline(1, '$'), "\n")
    let total = 0
    let content = []
    let toc = []
    for item in regexs
        let idx = index(regexs, item) + 1
        let matched = matchstr(buffer, item)
        let cur_cnt = s:get_count(matched)
        let total += cur_cnt
        if matched != ''
            let matched_lst = split('<span id="content' . idx . '" ></span>' . matched . '。(' . cur_cnt . '/' . total . ")\n", "\n")
            call map(matched_lst, '"　　" . v:val')
            call extend(content, matched_lst + [''])
        endif
        let buffer = substitute(buffer, matched, '', '')
    endfor
    for count in range(1, len(regexs))
        call add(toc, '- [段落'.count . '](#content' . count .')')
    endfor
    let @r = join(toc, "\n")
    exe 'normal ggdG'
    call append(0, s:rtrim(content))
    exe 'normal Gddgg'
    exe ':silent g/\v([^)])$/s//\1<br>/'
    call append(0, s:get_template('md_header_template'))
    call append('$', s:get_template('md_tail_template'))
    exe ':%s/{\[TOC\]}/\=@r/'
endfunction

function s:get_template(key) abort
    let template = get(g:, a:key, '')
    if template != '' && file_readable(expand(template))
        return readfile(expand(template))
    endif
    return s:template[a:key]
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
    " 将字符串正则转为特殊字符正则
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
