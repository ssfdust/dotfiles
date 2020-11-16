#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
if [[ ! -d "$HOME/.oh-my-zsh" ]];then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    ln -sf $basepath/zshrc $HOME/.zshrc
fi


iter_link() {
    parent=$(basename $1)
    for plugin in $1/*
    do
        plugin_name=$(basename $plugin)
        src_path="$basepath/$parent/$plugin_name"
        dst_path="$HOME/.oh-my-zsh/custom/$parent/$plugin_name"
        ln -sf $src_path $dst_path
    done
}
iter_link $basepath/plugins
