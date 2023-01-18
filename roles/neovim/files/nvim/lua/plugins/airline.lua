-----------------------------------------------------------
-- Airline configuration file
-----------------------------------------------------------

-- Plugin: Airline
-- url: https://github.com/vim-airline/vim-airline

vim.g.airline_powerline_fonts = 1

vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#show_splits"] = 0

vim.g["airline#extensions#branch#enabled"] = 0
vim.g["airline#extensions#branch#vcs_priority"] = {"git", "mercurial"}

vim.g["airline#extensions#fugitiveline#enabled"] = 1

vim.g["airline#extensions#keymap#enabled"] = 0

vim.g["airline#extensions#wordcount#enabled"] = 1

vim.g["airline#extensions#coc#enabled"] = 1

vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
