bb_search() {
    sudo bb-wrapper -Ss $@ --aur | pkgparser
}

bb_query() {
    sudo bb-wrapper -Qs $@ --aur | pkgparser
}

bb_ins() {
    sudo bb-wrapper -S $@ --aur --build-dir ~/Update_pkg
}

bb_clean() {
    echo "Do you want to clean Update_pkg directoy?[y/N]"
    read answer
    if [[ $answer =~ "[Yy]" && -d ~/Update_pkg ]]; then 
        for dir in ~/Update_pkg/*/; do
            pushd $dir > /dev/null
            git clean -xfd > /dev/null
            popd > /dev/null
        done
    fi
}

bb_update() {
    bb_clean
    sudo bb-wrapper -Syyu --aur --build-dir ~/Update_pkg
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
