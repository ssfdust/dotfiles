func! custom#before() abort
  let g:LanguageClient_settingsPath = '~/.SpaceVim.d/settings.json'
  let g:neosnippet#enable_complete_done = 0
  let g:vim_markdown_folding_style_pythonic = 1

  let g:licenses_copyright_holders_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_authors_name = 'RedLotus <ssfdust@gmail.com>'
  let g:licenses_default_commands = ['gpl', 'mit', 'lgpl']
endf

func! custom#after() abort
  autocmd Filetype python AnyFoldActivate
  set foldlevel=99
  nmap <F4> :call LanguageClient#textDocument_formatting()<CR>
endf
