func! custom#before() abort
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
  let g:clang2_placeholder_next = ''
  let g:clang2_placeholder_prev = ''
  let g:table_mode_corner='|'

  let g:neomake_vim_enabled_makers = ['vimlint', 'vint']
  let g:deoplete#auto_complete_delay = 150
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'

  " if has('python3')
      " let g:ctrlp_map = ''
      " nnoremap <silent> <C-p> :Denite file_rec<CR>
  " endif
  if (has('nvim'))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  let g:neomake_python_flake8_maker = {
      \ 'args': [
      \ '--ignore=E221,E241,E272,E251,W702,E203,E201,E202,E302,W291,E712,W504,W605',
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

  let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_default_commands = ['gpl', 'mit']

  " let vimfiler change Vim current directory when editing file
  let g:vimfiler_enable_auto_cd = 1
  let g:vimfiler_ignore_pattern = ['^\.']

  " autocmd
  " autocmd VimEnter * VimFilerExplorer

  " enable gutentags advanced command
  let g:gutentags_define_advanced_commands = 1

  " set sys.path for lazuli project
  " let g:deoplete#sources#jedi#extra_path = ['/home/ssfdust/workspace/lazuli/']
endf

func! custom#after() abort
  " fix bugs for python-neovim
  let g:deoplete#sources#jedi#show_docstring = 1
  " set completeopt+=preview
  " call deoplete#custom#option('num_processes', 1)
endf

