-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local expand = vim.fn.expand       -- Expand
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
-- opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true                     -- Show line number
opt.relativenumber = true             -- Show relative line number
opt.showmatch = true                  -- Highlight matching parenthesis
opt.foldmethod = 'manual'             -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'                -- Line lenght marker at 80 columns
opt.splitright = true                 -- Vertical split to the right
opt.ignorecase = true                 -- Ignore case letters when search
opt.smartcase = true                  -- Ignore lowercase for the whole pattern
opt.linebreak = true                  -- Wrap on word boundary
opt.termguicolors = true              -- Enable 24-bit RGB colors
opt.laststatus = 3                    -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true                  -- Use spaces instead of tabs
opt.shiftwidth = 4                    -- Shift 4 spaces when tab
opt.tabstop = 4                       -- 1 tab == 4 spaces
opt.smartindent = true                -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true                     -- Enable background buffers
opt.history = 100                     -- Remember N lines in history
opt.lazyredraw = true                 -- Faster scrolling
opt.synmaxcol = 240                   -- Max column for syntax highlight
opt.updatetime = 250                  -- ms to wait for trigger an event

-----------------------------------------------------------
-- Undo, History
-----------------------------------------------------------
opt.undodir = expand("~/.vim/undodir") -- Directory to save undo files
opt.undofile = true                   -- save undo information in files
opt.undolevels = 300                  -- Maximum number of changes that can be done
opt.undoreload = 3000                 -- Max lines to save for undo on buffer reload                

-----------------------------------------------------------
-- File Encodings
-----------------------------------------------------------
opt.encoding = "utf8"                 -- Internal encoding
-- Support for GBK character files 
opt.fileencodings = "utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1"

-----------------------------------------------------------
-- Leader Key
-----------------------------------------------------------
g.mapleader = ' '                      -- Global leader key
g.maplocalleader = ','                 -- Local leader key
