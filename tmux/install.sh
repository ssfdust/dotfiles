#!/bin/bash

BASEDIR=$(cd `dirname "$0"`;pwd)
echo "$BASEDIR"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
if [[ -d "$HOME/.tmux/plugins/tmux-powerline" ]];then
    sed 's/⎆/爵/g' -i ~/.tmux/plugins/tmux-powerline/segments/ifstat_sys.sh
    echo cp "$BASEDIR/ssfdust.sh" "~/.tmux/plugins/tmux-powerline/themes/"
else
    echo "please enter the tmux mode and install the plugins via C-A + I(大写的I, Capital I)"
    echo "then run the script again"
fi
