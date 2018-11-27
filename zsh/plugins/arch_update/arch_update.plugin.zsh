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
    sudo bb-wrapper -Syyu --aur --build-dir ~/Update_pkg
}
