#!/bin/sh
DEINDIR="$HOME"/.local/share/dein
NVIMCONF="$HOME"/.config/nvim
BAKCONF="$HOME"/.config/nvim.backup
pushd $(dirname "${0}") > /dev/null
BASEDIR=$(pwd -L)
# Use "pwd -P" for the path without links. man bash for more info.
popd > /dev/null
if [[ ! -d "${DEINDIR}" ]]
then
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | bash -s -- "$HOME"/.local/share/dein
fi
if [[ -L "${NVIMCONF}" && -d "${NVIMCONF}" ]]
then
    rm -f "${NVIMCONF}"
elif [[ -d "${NVIMCONF}" ]]
then
    mv ${NVIMCONF} ${BAKCONF}
fi
echo "${BASEDIR}"
ln -s "${BASEDIR}" "${NVIMCONF}"
nvim -c 'call dein#update()|q'
