-----------------------------------------------------------
-- Dark deno-powered UI framework configuration
-----------------------------------------------------------

-- Plugin Name: ddu.vim
-- url: https://github.com/Shougo/ddu.vim

DDU = {}
local fn = vim.fn                             -- Vim built-in functions
local cmd = vim.cmd                           -- Execute vim commands
local set_keymap = vim.keymap.set             -- Set key map
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
local patch_global = fn['ddu#custom#patch_global']
local ddu_start = fn['ddu#start']
local do_action = fn['ddu#ui#do_action']

-----------------------------------------------------------
-- DDU Global Patches
-----------------------------------------------------------
patch_global({ui = 'ff'})
patch_global({
    kindOptions = {
        file = {
            defaultAction = 'open'
        } 
    } 
})
patch_global({
    sourceOptions = {
        _ = {
            matchers = {'matcher_substring'}
        } 
    }
})
patch_global({
    sources = {
        {
            name = 'file',
            params = vim.empty_dict()
        }
    }
})
patch_global({
    sourceParams = {
        rg = {
            args = {'--json'}
        }
    }
})

-----------------------------------------------------------
-- DDU Custom Functions
-----------------------------------------------------------
--
-- Close DDU popup window
function DDU.close_filter_window() 
    local bufid = fn.bufnr("ddu-ff-filter")
    local winid = -1
    if (bufid > 0)
    then
        local winids = fn.win_findbuf(bufid)
        if (#winids > 0) then
            winid = winids[1]
        end
        if (winid ~= nil and winid > 0) then
            fn.win_gotoid(winid)
            cmd(':q')
        end
    end
end

function DDU.ddu_rg()
    local keyword = fn.input("Search key: ")
    ddu_start({
        name = 'file',
        ui = 'ff',
        sources = {
            {
                name = 'rg',
                params = {
                    input = keyword,
                },
            }
        },
        uiParams = {
            ff = {
                startFilter = vim.api.nvim_eval('v:true'),
                previewFloating = vim.api.nvim_eval('v:true'),
                split = 'floating'
            }
        },
     })
end

--- Search with gtags
--- Mode 0: Search definitions with gtags for word under cursor
--- Mode 1: Search references with gtags for word under cursor
--- Mode 2: Search definitions with gtags by inputing
--- Mode 3: Search references with gtags by inputing
function DDU.ddu_gtags(mode)
    local keyword = ''
    if (mode == 0 or mode ==1)
    then
        keyword = fn.expand('<cword>')
    else
        --- Mode 3 or 4
        keyword = fn.input("Search key: ")
    end

    --- Search for definitions by default
    local params = { input = keyword }
    if (mode == 1 or mode == 3)
    then
        --- Search for references
        params = { input = keyword, args = '-r' }
    end
    ddu_start({
        name = 'gtags',
        ui = 'ff',
        sources = {
            {
                name = 'gtags',
                params = params,
            }
        },
        uiParams = {
            ff = {
                startFilter = vim.api.nvim_eval('v:true'),
                previewFloating = vim.api.nvim_eval('v:true'),
                split = 'floating'
            }
        },
     })
end


local function find_ddu_bufnr()
    local ddu_bufnr = -1
    for somebufnr = 1, fn.bufnr('$'), 1 do
        local somebufname = fn.bufname(somebufnr)
        if (string.sub(somebufname, 1, 7) == "ddu-ff-" 
            and not string.find(somebufname, "-filter"))
        then
            ddu_bufnr = somebufnr
            break
        end
    end
    return ddu_bufnr
end

local function focus_on_ddu_window()
    local cur_win = fn.win_getid()
    local ddu_bufnr = find_ddu_bufnr()
    local ddu_winnr = fn.win_findbuf(ddu_bufnr)[1]
    fn.win_gotoid(ddu_winnr)
    return cur_win
end

-- Move cursor by line number
function DDU.move_ddu_win_cursor(lineno)
    local cur_win = focus_on_ddu_window()
    local cur_line = fn.line('.')
    local max_line = fn.line('$')
    if (lineno == 1) then
        do_action('cursorNext')
    else
        do_action('cursorPrevious')
    end
end

-- Custom ff window settings
local function ff_settings()
    local ddu_bufnr = find_ddu_bufnr()
    -- Enter to execute
    set_keymap(
        'n', 
        '<CR>',
        "<Cmd>call ddu#ui#do_action('itemAction')<CR>" ..
        "<Cmd>lua require'plugins/ddu'.close_filter_window()<CR>",
        { noremap = true, buffer = ddu_bufnr }
    )
    -- gq or q to quit
    set_keymap(
        'n', 
        'gq',
        "<Cmd>call ddu#ui#do_action('quit')<CR>" ..
        "<Cmd>lua require'plugins/ddu'.close_filter_window()<CR>",
        { noremap = true, buffer = ddu_bufnr }
    )
    set_keymap(
        'n', 
        'q',
        "<Cmd>call ddu#ui#do_action('quit')<CR>" ..
        "<Cmd>lua require'plugins/ddu'.close_filter_window()<CR>",
        { noremap = true, buffer = ddu_bufnr }
    )
    -- space to toggle item
    set_keymap(
        'n', 
        '<Space>',
        "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>",
        { noremap = true, buffer = ddu_bufnr }
    )
    -- i to open filter window
    set_keymap(
        'n', 
        'i',
        "<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>",
        { noremap = true, buffer = ddu_bufnr }
    )
end

local function ff_filter_settings()
    local bufid = fn.bufnr("ddu-ff-filter")
    -- j,k to move up and down
    set_keymap(
        'n', 
        'j',
        "<Cmd>lua require'plugins/ddu'.move_ddu_win_cursor(-1)<CR>",
        { noremap = true, buffer = bufid }
    )
    set_keymap(
        'n', 
        'k',
        "<Cmd>lua require'plugins/ddu'.move_ddu_win_cursor(1)<CR>",
        { noremap = true, buffer = bufid }
    )
    -- Enter to execute
    set_keymap(
        'n', 
        '<CR>',
        "<Cmd>call ddu#ui#do_action('itemAction')<CR>",
        { noremap = true, buffer = bufid }
    )
    set_keymap(
        'i', 
        '<CR>',
        "<Esc><Cmd>call ddu#ui#do_action('itemAction')<CR>",
        { noremap = true, buffer = bufid }
    )
    -- q or gq to quit
    set_keymap(
        'n', 
        'gq',
        "<Cmd>call ddu#ui#do_action('quit')<CR>",
        { noremap = true, buffer = bufid }
    )
    set_keymap(
        'n', 
        'q',
        "<Cmd>call ddu#ui#do_action('quit')<CR>",
        { noremap = true, buffer = bufid }
    )
end

-----------------------------------------------------------
-- DDU Autocommand
-----------------------------------------------------------
augroup('DDUCustom', { clear = true })
autocmd('Filetype', {
  group = 'DDUCustom',
  pattern = { 'ddu-ff' },
  callback = ff_settings
})
autocmd('Filetype', {
  group = 'DDUCustom',
  pattern = { 'ddu-ff-filter' },
  callback = ff_filter_settings
})
autocmd('CursorHold', {
  group = 'DDUCustom',
  pattern = { 'ddu-ff*' },
  command = 'call ddu#ui#do_action("preview")'
})

-----------------------------------------------------------
-- DDU Key Maps
-----------------------------------------------------------
set_keymap('n', '<Leader>ff', ':Ddu file_rec -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>fh', ':Ddu file_old -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>bb', ':Ddu buffer -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>fg', "<Cmd>lua require('plugins/ddu').ddu_rg()<CR>", { noremap = true, silent = true })
set_keymap('n', '<Leader>pl', ':Ddu dein -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>td', "<Cmd>lua require('plugins/ddu').ddu_gtags(0)<CR>", { noremap = true, silent = true })
set_keymap('n', '<Leader>tr', "<Cmd>lua require('plugins/ddu').ddu_gtags(1)<CR>", { noremap = true, silent = true })
set_keymap('n', '<Leader>tsd', "<Cmd>lua require('plugins/ddu').ddu_gtags(2)<CR>", { noremap = true, silent = true })
set_keymap('n', '<Leader>tsr', "<Cmd>lua require('plugins/ddu').ddu_gtags(3)<CR>", { noremap = true, silent = true })

-----------------------------------------------------------
-- DDU End
-----------------------------------------------------------
return DDU
