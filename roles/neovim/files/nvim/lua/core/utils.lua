-----------------------------------------------------------
-- Custom Functions
-----------------------------------------------------------

local fn = vim.fn                -- Global vim functions
local cmd = vim.cmd              -- Execute vim command
local api = vim.api              -- Access vim API

Utils = {}

-- Super user write function
function Utils.super_write()
    cmd("silent write! !sudo tee % >/dev/null")
    cmd("edit!")
    api.nvim_input("<CR>")
end

-- Switch between windows
function Utils.switch_window(winnr)
    if (fn.winnr('$') >= winnr) then
        cmd(winnr .. 'wincmd w')
    end
end

-- Change directory to current file directory
function Utils.change_dir()
    local directory = fn.expand('%:h')
    cmd('cd ' .. fn.expand('%:h'))
end

return Utils
