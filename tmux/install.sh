#!/bin/bash

BASEDIR=$(dirname "$0")
echo "$BASEDIR"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
