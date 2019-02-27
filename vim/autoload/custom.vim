func! custom#before() abort
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
  let g:clang2_placeholder_next = ''
  let g:clang2_placeholder_prev = ''
  let g:table_mode_corner='|'

  let g:neomake_vim_enabled_makers = ['vint']
  let g:deoplete#auto_complete_delay = 150
  " let g:python_host_prog = '/usr/bin/python2'
  " let g:python3_host_prog = '/usr/bin/python3'

  " if has('python3')
      " let g:ctrlp_map = ''
      " nnoremap <silent> <C-p> :Denite file_rec<CR>
  " endif
  let g:neomake_python_flake8_maker = {
      \ 'args': [
      \ '--ignore=E711,E128,E126,E221,E241,E272,E127,E251,W702,E203,E201,E202,E302,W291,E712,W504,W605',
      \ '--format=default',
      \ '--max-line-length=125'
      \ ],
      \ 'errorformat':
          \ '%E%f:%l: could not compile,%-Z%p^,' .
          \ '%A%f:%l:%c: %t%n %m,' .
          \ '%A%f:%l: %t%n %m,' .
          \ '%-G%.%#',
      \ }
  let g:neomake_python_enabled_makers = ['flake8']

  " set my own snippet directory
  let g:neosnippet#snippets_directory = ['/home/ssfdust/dotfiles/snippets/']

  let g:neomake_rust_enabled_makers = ['rustc']
  let g:LanguageClient_rootMarkers = ['.root', 'project.*']

  " for rust-racer
  let g:racer_cmd = '/usr/bin/racer'

  let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_default_commands = ['gpl', 'mit', 'lgpl']

  " let vimfiler change Vim current directory when editing file
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_ignore_pattern = ['^\.']

  " autocmd
  " autocmd VimEnter * VimFilerExplorer

  " enable gutentags advanced command
  let g:gutentags_define_advanced_commands = 1

endf

func! custom#after() abort
  let g:deoplete#sources#jedi#show_docstring = 0
  " highlight Normal guibg=NONE ctermbg=NONE
  " highlight NonText guibg=NONE ctermbg=NONE
  " highlight EndOfBuffer guibg=NONE ctermbg=NONE
  " highlight CursorLine guibg=NONE ctermbg=NONE
  " set sys.path for project
  let g:deoplete#sources#jedi#python_path = '/home/ssfdust/.local/share/virtualenvs/megalithOA-zSUnPLHT/bin/python3.7'
  let g:deoplete#sources#jedi#extra_path = ['/home/ssfdust/Programming/development/megalithOA']
endf

