"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/ssfdust/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/ssfdust/.local/share/dein')
    call dein#begin('/home/ssfdust/.local/share/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/home/ssfdust/.local/share/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here like this:
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('joshdick/onedark.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('preservim/nerdcommenter')
    call dein#add('mgedmin/python-imports.vim')
    call dein#add('heavenshell/vim-pydocstring')
    call dein#add('ssfdust/pytest.vim')
    call dein#add('gisphm/vim-gitignore')
    call dein#add('antoyo/vim-licenses')
    call dein#add('Raimondi/delimitMate')
    call dein#add('t9md/vim-choosewin')
    call dein#add('Shougo/denite.nvim')
    call dein#add('neoclide/coc.nvim', {'rev': 'release'})
    call dein#add('mhinz/vim-startify')
    call dein#add('dyng/ctrlsf.vim')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('pseewald/vim-anyfold')

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on


" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"
set termguicolors
set expandtab
set ts=4
set sw=4
set nu
color onedark

function! s:list_commits()
    let git = 'git'
    let commits = systemlist(git .' log --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:neosnippet#enable_complete_done = 0
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1

let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
let g:licenses_default_commands = ['gpl', 'mit', 'lgpl', 'apache']
let g:pydocstring_formatter = 'google'

let g:choosewin_label = '123456789'
let g:choosewin_tablabel = 'ABCDEFGHIJKL'

let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = 'sonokai'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\ue0b8"
let g:airline_right_sep = "\ue0be"

let g:pytest_term_opts = 'tabe'

let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_exclude = ['.mypy_cache']

let g:tmuxline_separators = {
            \ 'left': '',
            \ 'left_alt': '',
            \ 'right': '',
            \ 'right_alt': '',
            \ 'space': ' ',
            \ }


let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
let g:mapleader = ' '

let g:startify_lists = [
            \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
            \ { 'header': ['   MRU'],            'type': 'files' },
            \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
            \ { 'header': ['   Sessions'],       'type': 'sessions' },
            \ ]

imap <C-s> <ESC>:w<CR>i
nmap <C-s> :w<CR>
nmap <leader>ss :FlyGrep<CR>
nmap <leader>w <Plug>(choosewin)
nmap <F3> :exe 'CocCommand explorer --toggle --position right --sources=buffer+,file+ '
            \ . (stridx(expand('%:p'), getcwd()) < 0? expand('%:p:h'): getcwd()) <CR><CR>


nmap <silent> <F4> :Pydocstring<CR>
nmap <silent> <F8> :PydocstringFormat<CR>
nmap <silent> <F5> :ImportName<CR>
imap <silent> <F5> <Esc>:ImportName<CR>a

nmap <Leader><Leader>w <Plug>(easymotion-w)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>

nmap gq :quit<CR>

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
au BufWritePre *.py undojoin | call CocAction('runCommand', 'python.sortImports') | call CocAction('format')
au FileType python let b:delimitMate_nesting_quotes = ['`', "'", '"']

command PluginUpdate :call dein#update()
