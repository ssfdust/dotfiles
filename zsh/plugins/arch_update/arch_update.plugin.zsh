clean() {
    echo "deleting last files..."
    find ~/Update_pkg -maxdepth 1 -mtime +5 -exec rm \-rf \{\} \;
    echo "clean git repos..."
    pushd ~/Update_pkg
    for directory in */ ;do
        pushd $directory
        git clean -xdf
        popd
    done
    popd
}

bb_search() {
    sudo bb-wrapper -Ss $@ --aur | pkgparser
}

bb_query() {
    sudo bb-wrapper -Qs $@ --aur | pkgparser
}

bb_ins() {
    sudo bb-wrapper -S $@ --aur --build-dir ~/Update_pkg
}

bb_update() {
    clean
    sudo bb-wrapper -Syu --aur --build-dir ~/Update_pkg --noconfirm --needed
}
bb_vcs(){
    sudo bb-wrapper -Su --aur --build-dir ~/Update_pkg --build-vcs
}

_pacman_get_command () {
    cmd=("pacman" "2>/dev/null")
    integer i
    for ((i = 2; i < CURRENT - 1; i++ )) do
        if [[ ${words[i]} = "--config" || ${words[i]} = "--root" ]]
        then
            cmd+=(${words[i,i+1]})
        fi
    done
}

_pacman_completions_all_packages () {
    local -a seq sep cmd packages repositories packages_long
    _pacman_get_command
    if [[ ${words[CURRENT-1]} == '--ignore' ]]
    then
        seq='_sequence'
        sep=(-S ',')
    else
        seq=
        sep=()
    fi
    if compset -P1 '*/*'
    then
        packages=($(_call_program packages $cmd[@] -Sql ${words[CURRENT]%/*}))
        typeset -U packages
        ${seq} _wanted repo_packages expl "repository/package" compadd ${sep[@]} ${(@)packages}
    else
        packages=($(_call_program packages $cmd[@] -Sql))
        typeset -U packages
        ${seq} _wanted packages expl "packages" compadd ${sep[@]} - "${(@)packages}"
        repositories=($(pacman-conf --repo-list))
        typeset -U repositories
        _wanted repo_packages expl "repository/package" compadd -S "/" $repositories
    fi
}

compdef _pacman_completions_all_packages bb_ins=pacman -S
