-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: dein.vim
-- url: https://github.com/Shougo/dein.vim

local set = vim.opt
local fn = vim.fn

-- Automatically install dein
local dein_home = fn.stdpath('data') .. '/dein'
local dein_runtime_path = dein_home .. '/repos/github.com/Shougo/dein.vim'
local script_path = os.tmpname()

if fn.empty(fn.glob(dein_home)) > 0 then
    local download_cmd = {
        'curl',
        '-fsSL',
        'https://raw.githubusercontent.com/Shougo/dein-installer.vim/main/installer.sh',
        '-o',
        script_path
    }
    local execute_cmd = {
        'bash',
        script_path,
        '-uNC', dein_home
    }

    print("Download command: " .. table.concat(download_cmd, ' '))
    fn.system(download_cmd)

    if (fn.file_readable(script_path) == 1)
    then
        print("Execute command: " .. table.concat(execute_cmd, ' '))
        fn.system(execute_cmd)
    else
        print("Installer download failed...")
    end
    -- Delete the init.vim
    os.remove(fn.stdpath('config') .. '/init.vim')
end

-- 'path' would be init.lua's parent directory.
-- That is, '~/.config/nvim'.
function activate_dein()
    -- Registe dein functions
    local add = fn['dein#add']
    local begin = fn['dein#begin']
    local check_install = fn['dein#check_install']
    local install = fn['dein#install']
    local load_toml = fn['dein#load_toml']
    local call_hook = fn['dein#call_hook']
    local end_ = fn['dein#end']
    -- Neovim is always "nocompatible".

    -- Required:
    -- Add the dein installation directory into runtimepath
    set.runtimepath:append(dein_runtime_path)

    -- Required:
    begin(dein_home)

    -- Let dein manage dein
    add(dein_runtime_path)

    -- General
    load_toml(_get_dein_toml(), {lazy=1})

    -- Add or remove your plugins here like this:
    -- add('Shougo/neosnippet.vim')
    -- add('Shougo/neosnippet-snippets')

    -- Required:
    end_()
    call_hook('post_source')

    -- Syntax highlighting is enabled by default on Neovim.

    -- If you want to install not installed plugins on startup.
    if check_install() == 1 then install() end
end

-- Load dein TOML configuration
function _get_dein_toml()
    local dein_toml = fn.fnamemodify(os.getenv('MYVIMRC'), ':h') .. '/dein.toml'
    if (fn.file_readable(dein_toml) == 1)
    then
        return dein_toml
    else
        return fn.get(vim.g, 'dein_toml', '')
    end
end

activate_dein()
