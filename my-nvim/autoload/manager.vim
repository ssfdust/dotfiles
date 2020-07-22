let s:dein_home = get(g:, "dein_home", expand('~/.local/share/dein'))

let s:dein_runtime_path = s:dein_home . '/repos/github.com/Shougo/dein.vim'

" Required:
exe 'set runtimepath+=' . s:dein_runtime_path

" Required:
function! manager#load_dein() abort
    if dein#load_state(s:dein_home)
        call dein#begin(s:dein_home)

        " Let dein manage dein
        " Required:
        call dein#add(s:dein_runtime_path)

        " Add or remove your plugins here like this:
        "
        " General
        " * UI
        for plugin_lst in get(g:, "dein_plugins", [])
            if len(plugin_lst) == 1
                call dein#add(plugin_lst[0])
            elseif len(plugin_lst) == 2
                call dein#add(plugin_lst[0], plugin_lst[1])
            endif
        endfor

        " Required:
        call dein#end()
        call dein#save_state()
    endif

    " Required:
    filetype plugin indent on

    " If you want to install not installed plugins on startup.
    if dein#check_install()
        call dein#install()
    endif
endfunction
