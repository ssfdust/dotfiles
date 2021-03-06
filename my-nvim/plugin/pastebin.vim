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
let g:pastebin_formats = {
            \  'text': 'text',
            \  'abap': 'abap',
            \  'abnf': 'abnf',
            \  'ada': 'ada',
            \  'adl': 'adl',
            \  'agda': 'agda',
            \  'aheui': 'aheui',
            \  'ahk': 'ahk',
            \  'alloy': 'alloy',
            \  'ampl': 'ampl',
            \  'antlr': 'antlr',
            \  'antlr-as': 'antlr-as',
            \  'antlr-cpp': 'antlr-cpp',
            \  'antlr-csharp': 'antlr-csharp',
            \  'antlr-java': 'antlr-java',
            \  'antlr-objc': 'antlr-objc',
            \  'antlr-perl': 'antlr-perl',
            \  'antlr-python': 'antlr-python',
            \  'antlr-ruby': 'antlr-ruby',
            \  'apacheconf': 'apacheconf',
            \  'apl': 'apl',
            \  'applescript': 'applescript',
            \  'arduino': 'arduino',
            \  'as': 'as',
            \  'as3': 'as3',
            \  'aspectj': 'aspectj',
            \  'aspx-cs': 'aspx-cs',
            \  'aspx-vb': 'aspx-vb',
            \  'asy': 'asy',
            \  'at': 'at',
            \  'autoit': 'autoit',
            \  'awk': 'awk',
            \  'basemake': 'basemake',
            \  'bash': 'bash',
            \  'bat': 'bat',
            \  'bbcode': 'bbcode',
            \  'bc': 'bc',
            \  'befunge': 'befunge',
            \  'bib': 'bib',
            \  'blitzbasic': 'blitzbasic',
            \  'blitzmax': 'blitzmax',
            \  'bnf': 'bnf',
            \  'boo': 'boo',
            \  'boogie': 'boogie',
            \  'bro': 'bro',
            \  'bst': 'bst',
            \  'bugs': 'bugs',
            \  'c': 'c',
            \  'c-objdump': 'c-objdump',
            \  'ca65': 'ca65',
            \  'cadl': 'cadl',
            \  'camkes': 'camkes',
            \  'capdl': 'capdl',
            \  'capnp': 'capnp',
            \  'cbmbas': 'cbmbas',
            \  'ceylon': 'ceylon',
            \  'cfc': 'cfc',
            \  'cfengine3': 'cfengine3',
            \  'cfm': 'cfm',
            \  'cfs': 'cfs',
            \  'chai': 'chai',
            \  'chapel': 'chapel',
            \  'cheetah': 'cheetah',
            \  'cirru': 'cirru',
            \  'clay': 'clay',
            \  'clean': 'clean',
            \  'clojure': 'clojure',
            \  'clojurescript': 'clojurescript',
            \  'cmake': 'cmake',
            \  'cobol': 'cobol',
            \  'cobolfree': 'cobolfree',
            \  'coffee-script': 'coffee-script',
            \  'common-lisp': 'common-lisp',
            \  'componentpascal': 'componentpascal',
            \  'console': 'console',
            \  'control': 'control',
            \  'coq': 'coq',
            \  'cpp': 'cpp',
            \  'cpp-objdump': 'cpp-objdump',
            \  'cpsa': 'cpsa',
            \  'cr': 'cr',
            \  'crmsh': 'crmsh',
            \  'croc': 'croc',
            \  'cryptol': 'cryptol',
            \  'csharp': 'csharp',
            \  'csound': 'csound',
            \  'csound-document': 'csound-document',
            \  'csound-score': 'csound-score',
            \  'css': 'css',
            \  'css+django': 'css+django',
            \  'css+php': 'css+php',
            \  'cucumber': 'cucumber',
            \  'cuda': 'cuda',
            \  'cypher': 'cypher',
            \  'cython': 'cython',
            \  'd': 'd',
            \  'vue': 'js',
            \  'javascript': 'js',
            \  'd-objdump': 'd-objdump',
            \  'dart': 'dart',
            \  'delphi': 'delphi',
            \  'dg': 'dg',
            \  'diff': 'diff',
            \  'django': 'django',
            \  'docker': 'docker',
            \  'doscon': 'doscon',
            \  'dpatch': 'dpatch',
            \  'dtd': 'dtd',
            \  'duel': 'duel',
            \  'dylan': 'dylan',
            \  'dylan-console': 'dylan-console',
            \  'dylan-lid': 'dylan-lid',
            \  'earl-grey': 'earl-grey',
            \  'easytrieve': 'easytrieve',
            \  'ebnf': 'ebnf',
            \  'ec': 'ec',
            \  'ecl': 'ecl',
            \  'eiffel': 'eiffel',
            \  'elixir': 'elixir',
            \  'elm': 'elm',
            \  'emacs': 'emacs',
            \  'erb': 'erb',
            \  'erl': 'erl',
            \  'erlang': 'erlang',
            \  'evoque': 'evoque',
            \  'extempore': 'extempore',
            \  'ezhil': 'ezhil',
            \  'factor': 'factor',
            \  'fan': 'fan',
            \  'fancy': 'fancy',
            \  'felix': 'felix',
            \  'fish': 'fish',
            \  'flatline': 'flatline',
            \  'forth': 'forth',
            \  'fortran': 'fortran',
            \  'fortranfixed': 'fortranfixed',
            \  'foxpro': 'foxpro',
            \  'fsharp': 'fsharp',
            \  'gap': 'gap',
            \  'gas': 'gas',
            \  'genshi': 'genshi',
            \  'genshitext': 'genshitext',
            \  'glsl': 'glsl',
            \  'gnuplot': 'gnuplot',
            \  'go': 'go',
            \  'golo': 'golo',
            \  'gooddata-cl': 'gooddata-cl',
            \  'gosu': 'gosu',
            \  'groff': 'groff',
            \  'groovy': 'groovy',
            \  'gst': 'gst',
            \  'haml': 'haml',
            \  'handlebars': 'handlebars',
            \  'haskell': 'haskell',
            \  'haxeml': 'haxeml',
            \  'hexdump': 'hexdump',
            \  'hsail': 'hsail',
            \  'html': 'html',
            \  'html+php': 'html+php',
            \  'http': 'http',
            \  'hx': 'hx',
            \  'hybris': 'hybris',
            \  'hylang': 'hylang',
            \  'i6t': 'i6t',
            \  'idl': 'idl',
            \  'idris': 'idris',
            \  'iex': 'iex',
            \  'igor': 'igor',
            \  'inform6': 'inform6',
            \  'inform7': 'inform7',
            \  'ini': 'ini',
            \  'io': 'io',
            \  'ioke': 'ioke',
            \  'irc': 'irc',
            \  'isabelle': 'isabelle',
            \  'j': 'j',
            \  'jags': 'jags',
            \  'jasmin': 'jasmin',
            \  'java': 'java',
            \  'jcl': 'jcl',
            \  'jlcon': 'jlcon',
            \  'js+django': 'js+django',
            \  'jsgf': 'jsgf',
            \  'json': 'json',
            \  'json-object': 'json-object',
            \  'jsonld': 'jsonld',
            \  'jsp': 'jsp',
            \  'julia': 'julia',
            \  'juttle': 'juttle',
            \  'kal': 'kal',
            \  'kconfig': 'kconfig',
            \  'koka': 'koka',
            \  'kotlin': 'kotlin',
            \  'lagda': 'lagda',
            \  'lasso': 'lasso',
            \  'lcry': 'lcry',
            \  'lean': 'lean',
            \  'less': 'less',
            \  'lhs': 'lhs',
            \  'lidr': 'lidr',
            \  'lighty': 'lighty',
            \  'limbo': 'limbo',
            \  'liquid': 'liquid',
            \  'live-script': 'live-script',
            \  'llvm': 'llvm',
            \  'logos': 'logos',
            \  'logtalk': 'logtalk',
            \  'lsl': 'lsl',
            \  'lua': 'lua',
            \  'make': 'make',
            \  'mako': 'mako',
            \  'maql': 'maql',
            \  'markdown': 'markdown',
            \  'mask': 'mask',
            \  'mason': 'mason',
            \  'mathematica': 'mathematica',
            \  'matlab': 'matlab',
            \  'matlabsession': 'matlabsession',
            \  'md': 'md',
            \  'minid': 'minid',
            \  'modelica': 'modelica',
            \  'modula2': 'modula2',
            \  'monkey': 'monkey',
            \  'monte': 'monte',
            \  'moocode': 'moocode',
            \  'moon': 'moon',
            \  'mozhashpreproc': 'mozhashpreproc',
            \  'mozpercentpreproc': 'mozpercentpreproc',
            \  'mql': 'mql',
            \  'mscgen': 'mscgen',
            \  'mupad': 'mupad',
            \  'mxml': 'mxml',
            \  'myghty': 'myghty',
            \  'mysql': 'mysql',
            \  'nasm': 'nasm',
            \  'ncl': 'ncl',
            \  'nemerle': 'nemerle',
            \  'nesc': 'nesc',
            \  'newlisp': 'newlisp',
            \  'newspeak': 'newspeak',
            \  'ng2': 'ng2',
            \  'nginx': 'nginx',
            \  'nim': 'nim',
            \  'nit': 'nit',
            \  'nixos': 'nixos',
            \  'nsis': 'nsis',
            \  'numpy': 'numpy',
            \  'nusmv': 'nusmv',
            \  'objdump': 'objdump',
            \  'objdump-nasm': 'objdump-nasm',
            \  'objective-c': 'objective-c',
            \  'objective-c++': 'objective-c++',
            \  'objective-j': 'objective-j',
            \  'ocaml': 'ocaml',
            \  'octave': 'octave',
            \  'odin': 'odin',
            \  'ooc': 'ooc',
            \  'opa': 'opa',
            \  'openedge': 'openedge',
            \  'pacmanconf': 'pacmanconf',
            \  'pan': 'pan',
            \  'parasail': 'parasail',
            \  'pawn': 'pawn',
            \  'perl': 'perl',
            \  'perl6': 'perl6',
            \  'php': 'php',
            \  'pig': 'pig',
            \  'pike': 'pike',
            \  'pkgconfig': 'pkgconfig',
            \  'plpgsql': 'plpgsql',
            \  'postgresql': 'postgresql',
            \  'postscript': 'postscript',
            \  'pot': 'pot',
            \  'pov': 'pov',
            \  'powershell': 'powershell',
            \  'praat': 'praat',
            \  'prolog': 'prolog',
            \  'properties': 'properties',
            \  'protobuf': 'protobuf',
            \  'ps1con': 'ps1con',
            \  'psql': 'psql',
            \  'pug': 'pug',
            \  'puppet': 'puppet',
            \  'py3tb': 'py3tb',
            \  'pycon': 'pycon',
            \  'pypylog': 'pypylog',
            \  'pytb': 'pytb',
            \  'python': 'python',
            \  'python3': 'python3',
            \  'qbasic': 'qbasic',
            \  'qml': 'qml',
            \  'qvto': 'qvto',
            \  'racket': 'racket',
            \  'ragel': 'ragel',
            \  'ragel-c': 'ragel-c',
            \  'ragel-cpp': 'ragel-cpp',
            \  'ragel-d': 'ragel-d',
            \  'ragel-em': 'ragel-em',
            \  'ragel-java': 'ragel-java',
            \  'ragel-objc': 'ragel-objc',
            \  'ragel-ruby': 'ragel-ruby',
            \  'raw': 'raw',
            \  'rb': 'rb',
            \  'rbcon': 'rbcon',
            \  'rconsole': 'rconsole',
            \  'rd': 'rd',
            \  'rebol': 'rebol',
            \  'red': 'red',
            \  'redcode': 'redcode',
            \  'registry': 'registry',
            \  'resource': 'resource',
            \  'rexx': 'rexx',
            \  'rhtml': 'rhtml',
            \  'rnc': 'rnc',
            \  'roboconf-graph': 'roboconf-graph',
            \  'roboconf-instances': 'roboconf-instances',
            \  'robotframework': 'robotframework',
            \  'rql': 'rql',
            \  'rsl': 'rsl',
            \  'rst': 'rst',
            \  'rts': 'rts',
            \  'rust': 'rust',
            \  'sas': 'sas',
            \  'sass': 'sass',
            \  'sc': 'sc',
            \  'scala': 'scala',
            \  'scaml': 'scaml',
            \  'scheme': 'scheme',
            \  'scilab': 'scilab',
            \  'scss': 'scss',
            \  'shen': 'shen',
            \  'silver': 'silver',
            \  'slim': 'slim',
            \  'smali': 'smali',
            \  'smalltalk': 'smalltalk',
            \  'smarty': 'smarty',
            \  'sml': 'sml',
            \  'snobol': 'snobol',
            \  'snowball': 'snowball',
            \  'sourceslist': 'sourceslist',
            \  'sp': 'sp',
            \  'sparql': 'sparql',
            \  'spec': 'spec',
            \  'splus': 'splus',
            \  'sql': 'sql',
            \  'sqlite3': 'sqlite3',
            \  'squidconf': 'squidconf',
            \  'ssp': 'ssp',
            \  'stan': 'stan',
            \  'stata': 'stata',
            \  'swift': 'swift',
            \  'swig': 'swig',
            \  'systemverilog': 'systemverilog',
            \  'tads3': 'tads3',
            \  'tap': 'tap',
            \  'tasm': 'tasm',
            \  'tcl': 'tcl',
            \  'tcsh': 'tcsh',
            \  'tcshcon': 'tcshcon',
            \  'tea': 'tea',
            \  'termcap': 'termcap',
            \  'terminfo': 'terminfo',
            \  'terraform': 'terraform',
            \  'tex': 'tex',
            \  'thrift': 'thrift',
            \  'todotxt': 'todotxt',
            \  'trac-wiki': 'trac-wiki',
            \  'treetop': 'treetop',
            \  'ts': 'ts',
            \  'tsql': 'tsql',
            \  'turtle': 'turtle',
            \  'twig': 'twig',
            \  'typoscript': 'typoscript',
            \  'typoscriptcssdata': 'typoscriptcssdata',
            \  'typoscripthtmldata': 'typoscripthtmldata',
            \  'urbiscript': 'urbiscript',
            \  'vala': 'vala',
            \  'vb.net': 'vb.net',
            \  'vcl': 'vcl',
            \  'vclsnippets': 'vclsnippets',
            \  'vctreestatus': 'vctreestatus',
            \  'velocity': 'velocity',
            \  'verilog': 'verilog',
            \  'vgl': 'vgl',
            \  'vhdl': 'vhdl',
            \  'vim': 'vim',
            \  'vimwiki': 'vimwiki',
            \  'wdiff': 'wdiff',
            \  'whiley': 'whiley',
            \  'x10': 'x10',
            \  'xml': 'xml',
            \  'xquery': 'xquery',
            \  'xslt': 'xslt',
            \  'xtend': 'xtend',
            \  'yaml': 'yaml',
            \  'zephir': 'zephir'
            \  }

function s:parse_rentry_header() abort
  let headers = webapi#http#get('https://rentry.co')['header']
  let csrf = ''
  for header in headers
    let csrf = matchstr(header, 'csrftoken=\zs[^;]*\ze;')
    if csrf !=# ''
      break
    endif
  endfor
  return csrf
endfunction

" The public function. If you've set a pastebin_api_dev_key it'll try to use it
" Otherwise it'll post anonymously
function! PasteBin(line1, line2)
  if s:GetPasteFormat() ==# 'vimwiki' || s:GetPasteFormat() ==# 'markdown'
    let content = join(getline(a:line1, a:line2), "\n")
    let csrf = s:parse_rentry_header()
    let res_content = webapi#http#post(
          \ 'https://rentry.co/api/new', 
          \ {
          \   'csrfmiddlewaretoken': csrf,
          \   'url': '',
          \   'edit_code': '',
          \   'text': content
          \ },
          \ {
          \   'Referer': 'https://rentry.co',
          \   'Cookie': 'csrftoken=' . csrf
          \ }
          \ ).content
    let url = webapi#json#decode(res_content)['url']
    call s:finished(url)
  else
    let content = join(getline(a:line1, a:line2), "\n")
    let res_content = webapi#http#post('https://paste.ubuntu.com/', {
                \  'poster': 'anonymously',
                \  'expiration': '',
                \  'syntax': s:GetPasteFormat(),
                \  'content': content,
                \  }).content
    let url = matchstr(res_content, '<a class="pturl" href="\zs\([/a-zA-Z0-9]\+\)\ze\/plain\/">Download as text<\/a>')
    call s:finished("https://paste.ubuntu.com" . url)
  endif
endfunction

" Get the (valid) format/type of this paste.
function! s:GetPasteFormat()
    if has_key(g:pastebin_formats, &ft)
        return g:pastebin_formats[&ft]
    else
        return 'text'
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
