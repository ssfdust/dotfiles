-----------------------------------------------------------
-- Key Mapping
-----------------------------------------------------------

-- Define keymaps with Lua APIs

local set_keymap = vim.keymap.set             -- Set key map
local fn = vim.fn                             -- Global vim functions

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  set_keymap(mode, lhs, rhs, options)
end

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Buffer action keys
map('n', '<leader>bn', '<Cmd>bn<CR>')
map('n', '<leader>bp', '<Cmd>bp<CR>')
map('n', '<leader>bd', '<Cmd>bd<CR>')

-- Ctrl-S for save
map('i', '<C-s>', '<Esc><Cmd>w<CR>i')
map('n', '<C-s>', '<Cmd>w<CR>')

-- Termnal
-- If nu binary is not found, check if zsh is installed, otherwise use $SHELL
-- Use if statement to avoid error when running on Windows
if fn.executable('nu') == 1 then
    shell = 'nu'
elseif fn.executable('zsh') == 1 then
    shell = 'zsh'
else
    shell = '$SHELL'
end
map('n', '<leader>\'', '<Cmd>call deol#start({"split": "floating", "toggle": v:true, "winwidth": 108, "winheight": 25, "command": "' .. shell .. '"})<CR>')
map('t', '<Esc>', '<C-\\><C-n>')

-- Change directory to file path
map('n', '<leader>cd', "<Cmd>lua require('core/utils').change_dir()<CR>", { noremap=false})

-- Cancel search highlight
map('n', '<leader><Esc>', '<Cmd>noh<CR>')

-- Copy file path
map('n', '<leader>fy', "<Cmd>lua require('core/utils').get_filepath()")

-- Switch window by number key
for i=1, 9 do
    map('n', '<leader>' .. i, "<Cmd>lua require('core/utils').switch_window(" .. i .. ")<CR>")
end

-- neo snippets
map('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)')
map('s', '<C-k>', '<Plug>(neosnippet_expand_or_jump)')
map('s', '<C-k>', '<Plug>(neosnippet_expand_target)')

-- Map write with sudo
map('c', 'w!!', "<Cmd>lua require('core/utils').super_write()<CR>")

-- Quit
map('n', 'gq', ':quit<CR>')
