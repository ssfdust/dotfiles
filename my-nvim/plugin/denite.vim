scriptencoding utf-8
" load api
" denite option
let s:denite_options = {
            \ 'default' : {
            \ 'winheight' : 15,
            \ 'mode' : 'insert',
            \ 'start_filter' : 1,
            \ 'quit' : 1,
            \ 'highlight_matched_char' : 'MoreMsg',
            \ 'highlight_matched_range' : 'MoreMsg',
            \ 'direction': 'rightbelow',
            \ 'statusline' : has('patch-7.4.1154') ? v:false : 0,
            \ 'prompt' : '=>',
            \ }}

function! s:profile(opts) abort
    for fname in keys(a:opts)
        for dopt in keys(a:opts[fname])
            call denite#custom#option(fname, dopt, a:opts[fname][dopt])
        endfor
    endfor
endfunction

call s:profile(s:denite_options)

" buffer source
call denite#custom#var(
            \ 'buffer',
            \ 'date_format', '%m-%d-%Y %H:%M:%S')

" dein source customer open dir
call denite#custom#source('dein', 'default_action', 'open')

" denite command
    " For ripgrep
    " Note: It is slower than ag
call denite#custom#var('file/rec', 'command',
            \ ['rg', '--hidden', '--files', '--glob', '!.git', '--glob', '']
            \ )
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

" FIND and GREP COMMANDS
if executable('rg')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif

" Define mappings
augroup spacevim_layer_denite
    autocmd!
    autocmd FileType denite call s:denite_my_settings()
    autocmd FileType denite-filter call s:denite_filter_my_settings()
augroup END

function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> '
                \ denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-t>
                \ denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> <C-v>
                \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-s>
                \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><Tab> j
    nnoremap <silent><buffer><S-Tab> k
endfunction

function! s:denite_filter_my_settings() abort
    call s:clear_imap('<C-g>g')
    call s:clear_imap('<C-g>S')
    call s:clear_imap('<C-g>s')
    call s:clear_imap('<C-g>%')
    imap <silent><buffer> <Esc> <Plug>(denite_filter_quit)
    imap <silent><buffer> <C-g> <Plug>(denite_filter_quit):q<Cr>
    inoremap <silent><buffer> <Tab>
                \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <S-Tab>
                \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
    inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    " @fixme use this key binding only for sources which has delete action
    inoremap <silent><buffer><expr> <C-d>
                \ <SID>delete_action()
    if exists('*deoplete#custom#buffer_option')
        call deoplete#custom#buffer_option('auto_complete', v:false)
    endif
endfunction


function! s:delete_action() abort
    if denite#get_status("sources") =~# '^buffer'
        return denite#do_map('do_action', 'delete')
    else
        return ''
    endif
endfunction


function! s:clear_imap(map) abort
    if maparg(a:map, 'i')
        exe 'iunmap <buffer> ' . a:map
    endif
endfunction
