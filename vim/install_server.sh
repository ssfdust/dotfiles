#!/bin/bash

rm -rf ~/.config/nvim
git clone https://github.com/afshinm/neovim-config.git ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sed -i.bak '/YouCompleteMe/d' ~/.config/nvim/init.vim
echo "install plugins"
nvim +PlugInstall +qall
