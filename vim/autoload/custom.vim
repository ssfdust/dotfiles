func! custom#before() abort
  let g:LanguageClient_settingsPath = '~/.SpaceVim.d/settings.json'
  let g:neosnippet#enable_complete_done = 0
  let g:vim_markdown_folding_style_pythonic = 1
  let g:neomake_html_enabled_makers = []
  " let g:LanguageClient_loggingLevel = 'debug'
  " let g:LanguageClient_loggingFile = '/tmp/lsp.log'
  let g:gutentags_define_advanced_commands = 1
  let g:gutentags_ctags_exclude = ['.mypy_cache']
  let g:gutentags_cache_dir = "~/.cache/tags/"
  let g:neomake_markdown_enabled_makers = ['remark']
  let g:neomake_python_enabled_makers = []
  let g:neoformat_enabled_python = ['isort', 'black']
  let g:pytest_term_opts = 'tabe'

  let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_default_commands = ['gpl', 'mit', 'lgpl', 'apache']
  let g:pydocstring_formatter = 'google'
endf

func! custom#after() abort
  nmap <silent> <F4> :Pydocstring<CR>
  nmap <silent> <F8> :PydocstringFormat<CR>
  nmap <silent> <F5> :ImportName<CR>
  imap <silent> <F5> <Esc>:ImportName<CR>a
  au BufWritePre *.py undojoin | Neoformat! python isort | Neoformat! python black
  au FileType python AnyFoldActivate
  au FileType python let b:delimitMate_nesting_quotes = ['`', "'", '"']
  " set foldlevel=0
endf
