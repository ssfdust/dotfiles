#!/bin/bash

if [[ ! -d "$HOME/.oh-my-zsh" ]];then
    echo "You need to install oh-my-zsh first, and then run this script"
    echo "running the following command"
    echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    exit
fi
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf $HOME/.oh-my-zsh/custom/plugins
rm -rf $HOME/.oh-my-zsh/custom/themes

basepath=$(cd `dirname $0`; pwd)
ln -sf $basepath/zshrc $HOME/.zshrc
ln -sf $basepath/plugins $HOME/.oh-my-zsh/custom/plugins
ln -sf $basepath/themes $HOME/.oh-my-zsh/custom/themes
