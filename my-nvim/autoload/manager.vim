let s:dein_home = expand(get(g:, "dein_home", '~/.local/share/dein'))

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
        call dein#load_toml(manager#get_dein_toml(), {'lazy': 1})

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

function manager#get_dein_toml() abort
    let dein_toml = fnamemodify($MYVIMRC, ':h') . '/dein.toml'   
    if file_readable(dein_toml)
        return dein_toml
    else
        return get(g:, 'dein_toml', '')
    endif
endfunction
