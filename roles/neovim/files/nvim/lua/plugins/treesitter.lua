-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

local status_ok, nvim_treesitter_parsers = pcall(require, 'nvim-treesitter.parsers')
if not status_ok then
  return
end

-- Nu Language support
local parser_config = nvim_treesitter_parsers.get_parser_configs()
parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
    'rust', 'typescript', 'vim', 'yaml', 'nu'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
