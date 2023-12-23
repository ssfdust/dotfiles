-----------------------------------------------------------
-- Rooter configuration
-----------------------------------------------------------

-- Plugin Name: vim-rooter
-- url: https://github.com/airblade/vim-rooter

local g = vim.g      -- Gloabl Variables

g.rooter_patterns = {'.git', 'pyproject.toml', '.root', '.svn', 'ansible.cfg'}
