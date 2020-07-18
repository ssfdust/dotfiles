if exists('g:loaded_pastebin')
  finish
endif
let g:loaded_pastebin = 1

" Section: Script variables
" If you don't want pastes to open directly in your browser - define
" g:pastebin_browser_command as "" in your vimrc
if !exists('g:pastebin_browser_command')
  if exists(':OpenBrowser')
    let g:pastebin_browser_command = ":OpenBrowser %URL%"
  elseif has('win32')
    let g:pastebin_browser_command = "!start rundll32 url.dll,FileProtocolHandler %URL%"
  elseif has('mac')
    let g:pastebin_browser_command = "open %URL%"
  elseif executable('xdg-open')
    let g:pastebin_browser_command = "xdg-open %URL%"
  else
    let g:pastebin_browser_command = "firefox %URL% &"
  endif
endif

" List of valid formats, extracted from http://pastebin.com/api#5
if !exists('g:pastebin_valid_formats')
  let g:pastebin_valid_formats = ['4cs', '6502acme', '6502kickass', '6502tasm', 'abap', 'actionscript', 'actionscript3', 'ada', 'algol68', 'apache', 'applescript', 'apt_sources', 'asm', 'asp', 'autoconf', 'autohotkey', 'autoit', 'avisynth', 'awk', 'bascomavr', 'bash', 'basic4gl', 'bibtex', 'blitzbasic', 'bnf', 'boo', 'bf', 'c', 'c_mac', 'cil', 'csharp', 'cpp', 'cpp-qt', 'c_loadrunner', 'caddcl', 'cadlisp', 'cfdg', 'chaiscript', 'clojure', 'klonec', 'klonecpp', 'cmake', 'cobol', 'coffeescript', 'cfm', 'css', 'cuesheet', 'd', 'dcs', 'delphi', 'oxygene', 'diff', 'div', 'dos', 'dot', 'e', 'ecmascript', 'eiffel', 'email', 'epc', 'erlang', 'fsharp', 'falcon', 'fo', 'f1', 'fortran', 'freebasic', 'gambas', 'gml', 'gdb', 'genero', 'genie', 'gettext', 'go', 'groovy', 'gwbasic', 'haskell', 'hicest', 'hq9plus', 'html4strict', 'html5', 'icon', 'idl', 'ini', 'inno', 'intercal', 'io', 'j', 'java', 'java5', 'javascript', 'jquery', 'kixtart', 'latex', 'lb', 'lsl2', 'lisp', 'llvm', 'locobasic', 'logtalk', 'lolcode', 'lotusformulas', 'lotusscript', 'lscript', 'lua', 'm68k', 'magiksf', 'make', 'mapbasic', 'matlab', 'mirc', 'mmix', 'modula2', 'modula3', '68000devpac', 'mpasm', 'mxml', 'mysql', 'newlisp', 'text', 'nsis', 'oberon2', 'objeck', 'objc', 'ocaml-brief', 'ocaml', 'pf', 'glsl', 'oobas', 'oracle11', 'oracle8', 'oz', 'pascal', 'pawn', 'pcre', 'per', 'perl', 'perl6', 'php', 'php-brief', 'pic16', 'pike', 'pixelbender', 'plsql', 'postgresql', 'povray', 'powershell', 'powerbuilder', 'proftpd', 'progress', 'prolog', 'properties', 'providex', 'purebasic', 'pycon', 'python', 'q', 'qbasic', 'rsplus', 'rails', 'rebol', 'reg', 'robots', 'rpmspec', 'ruby', 'gnuplot', 'sas', 'scala', 'scheme', 'scilab', 'sdlbasic', 'smalltalk', 'smarty', 'sql', 'systemverilog', 'tsql', 'tcl', 'teraterm', 'thinbasic', 'typoscript', 'unicon', 'uscript', 'vala', 'vbnet', 'verilog', 'vhdl', 'vim', 'visualprolog', 'vb', 'visualfoxpro', 'whitespace', 'whois', 'winbatch', 'xbasic', 'xml', 'xorg_conf', 'xpp', 'yaml', 'z80', 'zxbasic']
endif

" The public function. If you've set a pastebin_api_dev_key it'll try to use it
" Otherwise it'll post anonymously
function! PasteBin(line1, line2)
  let content = join(getline(a:line1, a:line2), "\n")
  let res_content = webapi#http#post('https://paste.ubuntu.com/', {
  \  'poster': 'anonymously',
  \  'expiration': '',
  \  'syntax': s:GetPasteFormat(),
  \  'content': content,
  \}).content
  let url = matchstr(res_content, '<a class="pturl" href="\zs\([/a-zA-Z0-9]\+\)\ze\/plain\/">Download as text<\/a>')
  call s:finished("https://paste.ubuntu.com" . url)
endfunction

" Get the (valid) format/type of this paste.
function! s:GetPasteFormat()
  return index(g:pastebin_valid_formats, &ft) != -1 ? &ft : 'text'
endfunction

" what to do with the return value - should be a url
function! s:finished(url)
  if a:url !~? '^https\?://'
    echoerr "PasteBin: an error occurred:" a:url
    return
  endif
  let @+ = a:url
  if g:pastebin_browser_command == ''
    echo a:url
    return
  endif

  let cmd = substitute(g:pastebin_browser_command, '%URL%', a:url, 'g')
  if cmd =~ '^!'
    silent! exec cmd
  elseif cmd =~ '^:[A-Z]'
    exec cmd
  else
    call system(cmd)
  endif
endfunction

command! -nargs=? -range=% PasteBin :call PasteBin(<line1>, <line2>)

" Section: Plugin completion
let g:loaded_pastebin = 2
