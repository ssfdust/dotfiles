-----------------------------------------------------------
-- Alpha Startup configuration file
-----------------------------------------------------------
--
-- Plugin: alpha-nvim
-- url: https://github.com/goolord/alpha-nvim

-- See: :help alpha.txt
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

local handle = io.popen('fortune')
local fortune = handle:read("*a")

handle:close()

dashboard.section.header.val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.footer.val = fortune

dashboard.config.opts.noautocmd = false
dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", "<Cmd>ene <CR>"),
    dashboard.button("SPC f f", "  Find file", "<Cmd>Ddu file_rec -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>"),
    dashboard.button("SPC f h", "  Recently opened files", "<Cmd>Ddu file_old -ui-param-ff-startFilter=v:true -name=file -ui-param-ff-previewFloating=v:true -ui-param-ff-split=floating<CR>"),
    dashboard.button("SPC f g", "  Find word", "<Cmd>lua require('plugins/ddu').ddu_rg()<CR>"),
    dashboard.button("SPC s l", "  Open local session", "<Cmd>source .session<CR>"),
    dashboard.button( "q", "  Quit NVIM" , "<Cmd>qa<CR>"),
}

dashboard.config.layout = {
    { type = "padding", val = 6 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 3 },
    dashboard.section.footer,
}

alpha.setup(dashboard.config)
