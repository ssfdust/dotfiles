#!/bin/bash

BASEDIR=$(cd `dirname "$0"`;pwd)
echo "$BASEDIR"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$BASEDIR/tmux.conf" "$HOME/.tmux.conf"
if [[ -d "$HOME/.tmux/plugins/tmux-powerline" ]];then
    sed 's/⎆/爵/g' -i ~/.tmux/plugins/tmux-powerline/segments/ifstat_sys.sh
    bash ~/.tmux/plugins/tmux-powerline/generate_rc.sh
    cp -f "$BASEDIR/ssfdust.sh" ~/.tmux/plugins/tmux-powerline/themes/
    cp -f "$BASEDIR/rainbarf.conf" ~/.rainbarf.conf
    sudo cpan -i App::rainbarf
    mv -f ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc
    sed 's/\(TMUX_POWERLINE_THEME="\)default/\1ssfdust/g' -i ~/.tmux-powerlinerc
    sed 's/\(TMUX_POWERLINE_SEG_WEATHER_LOCATION="\)/\12137082/g' -i ~/.tmux-powerlinerc
else
    echo "please enter the tmux mode and install the plugins via C-A + I(大写的I, Capital I)"
    echo "then run the script again"
fi
