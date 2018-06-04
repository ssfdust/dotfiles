#!/bin/bash

BASEDIR=$(cd `dirname "$0"`;pwd)
echo "$BASEDIR"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
sed 's/⎆/爵/g' -i ~/.tmux/plugins/tmux-powerline/segments/ifstat_sys.sh
echo cp "$BASEDIR/ssfdust.sh" "~/.tmux/plugins/tmux-powerline/themes/"
