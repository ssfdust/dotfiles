func! custom#before() abort
  let g:LanguageClient_settingsPath = '~/.SpaceVim.d/settings.json'
  let g:neosnippet#enable_complete_done = 0
  let g:vim_markdown_folding_style_pythonic = 1
  let g:neomake_html_enabled_makers = []
  " let g:LanguageClient_loggingLevel = 'debug'
  " let g:LanguageClient_loggingFile = '/tmp/lsp.log'
  let g:neomake_markdown_enabled_makers = ['remark']
  let g:neomake_python_enabled_makers = []
  let g:neoformat_enabled_python = ['autoflake']

  let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_default_commands = ['gpl', 'mit', 'lgpl', 'apache']
endf

func! custom#after() abort
  aug! python_delimit
  aug python_delimit
      au Filetype python AnyFoldActivate
      au FileType python let b:delimitMate_nesting_quotes = ['`', "'", '"']
  aug END
  set foldlevel=99
  nmap <F4> <Plug>(coc-format)
  nmap <F4> <Plug>(coc-references)
endf
