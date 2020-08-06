set expandtab
set foldmethod=manual
set mouse=a
set nu
set nocompatible
set rnu
set sw=4
set ts=4
set termguicolors
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

let g:dein_home = '~/.local/share/dein'

call manager#load_dein()

color gruvbox-material

" Indent Line
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_term = 202
let g:indentLine_char = '¦'

" coc extension
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-neosnippet',
            \ 'coc-explorer',
            \ 'coc-tag',
            \ 'coc-vimlsp',
            \ ]

" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

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

let g:rooter_patterns = ['.git', 'pyproject.toml']

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#denite#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\ue0b8"
let g:airline_right_sep = "\ue0be"

let g:pytest_term_opts = 'tabe'

let g:pydocstring_doq_path = '/usr/bin/doq'

let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_exclude = ['.mypy_cache']

let g:tmuxline_separators = {
            \ 'left': '',
            \ 'left_alt': '',
            \ 'right': '',
            \ 'right_alt': '',
            \ 'space': ' ',
            \ }

let g:airline#extensions#gutentags#enabled = 1

let g:markdown_folding = 1

let g:vimsyn_folding = 'af'

let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:todo_file = '~/Dropbox/todo/todo.txt'

let g:vimwiki_list = [
            \ {
                \ 'name': 'default',
                \ 'path': '~/Dropbox/notes/wiki/修行',
                \ 'syntax': 'markdown',
                \ 'ext': '.md',
                \ 'path_html': expand('~/vimwiki_html/'),
                \ 'custom_wiki2html': 'vimwiki_markdown',
                \ 'template_path': '~/Dropbox/notes/wiki/vimwiki-template/templates/',
                \ 'template_default': 'def_template',
                \ 'template_ext': '.html',
                \ 'html_filename_parameterization': 1,
                \ 'auto_generate_links': 0,
                \ 'auto_generate_tags': 0
            \ }
            \ ]

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
let g:mapleader = ' '
let g:maplocalleader = ','

let g:startify_lists = [
            \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
            \ { 'header': ['   MRU'],            'type': 'files' },
            \ { 'header': ['   Sessions'],       'type': 'sessions' },
            \ ]
