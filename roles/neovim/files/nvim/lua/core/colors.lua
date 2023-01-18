-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

-- See: https://github.com/brainfucksec/neovim-lua#appearance

-- Color Schema: Gruvbox Material
-- url: https://github.com/sainnhe/gruvbox-material

local g = vim.g       -- Global variables
local colorscheme = 'gruvbox-material'

-----------------------------------------------------------
-- Gruvbox Material
-----------------------------------------------------------
g.gruvbox_material_diagnostic_line_highlight = 1
g.gruvbox_material_background = 'soft'
g.gruvbox_material_transparent_background = 0
g.gruvbox_material_visual = 'reverse'

-----------------------------------------------------------
-- Load color schema
-----------------------------------------------------------
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
