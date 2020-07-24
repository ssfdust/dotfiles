function! s:safesubstitute(text, search, replace, mode) abort
    " Substitute regexp but do not interpret replace
    let escaped = escape(a:replace, '\&')
    return substitute(a:text, a:search, escaped, a:mode)
endfunction

function! vimwiki#generate_dir_links(create, ...) abort
    " Get pattern if present
    " Globlal to script to be passed to closure
    if a:0
        let s:pattern = a:1
    else
        let s:pattern = ''
    endif

    " Define link generator closure
    let GeneratorLinks = copy(l:)
    function! GeneratorLinks.f() abort
        let lines = []

        let links = vimwiki#base#get_wikilinks(vimwiki#vars#get_bufferlocal('wiki_nr'), 0, s:pattern)
        call sort(links)

        let bullet = repeat(' ', vimwiki#lst#get_list_margin()) . vimwiki#lst#default_symbol().' '
        let l:diary_file_paths = vimwiki#diary#get_diary_files()

        for link in links
            let link_infos = vimwiki#base#resolve_link(link)
            if !vimwiki#base#is_diary_file(link_infos.filename, copy(l:diary_file_paths))
                if vimwiki#vars#get_wikilocal('syntax') ==# 'markdown'
                    let link_tpl = vimwiki#vars#get_syntaxlocal('Weblink1Template')
                else
                    let link_tpl = vimwiki#vars#get_global('WikiLinkTemplate1')
                endif

                let link_caption = vimwiki#base#read_caption(link_infos.filename)
                if link_caption ==? '' " default to link if caption not found
                    let link_caption = link
                endif

                let entry = s:safesubstitute(link_tpl, '__LinkUrl__', link, '')
                let entry = s:safesubstitute(entry, '__LinkDescription__', link_caption, '')
                call add(lines, bullet. entry)
            endif
        endfor

        return lines
    endfunction

    let links_rx = '\%(^\s*$\)\|\%('.vimwiki#vars#get_syntaxlocal('rxListBullet').'\)'

    let dirs = vimwiki#base#get_wikilinks(vimwiki#vars#get_bufferlocal('wiki_nr'), 0, '*/')

    for dir in dirs
        if dir ==# 'Archieved/'
            continue
        endif
        let s:pattern = dir . '*.md'
        call vimwiki#base#update_listing_in_buffer(
                    \ GeneratorLinks,
                    \ substitute(dir, '\/', '', ''),
                    \ links_rx,
                    \ line('$')+1,
                    \ 2,
                    \ a:create)
    endfor
endfunction
