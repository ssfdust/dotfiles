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
