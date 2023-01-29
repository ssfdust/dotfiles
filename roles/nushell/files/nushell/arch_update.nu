def __clean [] {
    echo $"deleting last files..."
    let pkgdir = (echo ~/.cache/updatepkgs | path expand)
    let current_pwd = (pwd)
    if ( $pkgdir | path exists) == true {
        ^find ~/.cache/updatepkgs -mindepth 1 -maxdepth 1 -mtime +5 -exec rm -rf "{}" ';'
    } else {
        mkdir $pkgdir
    }
    echo $"clean git repos..."
    let pkgdir_is_empty = (ls -a $pkgdir | is-empty)
    if (not $pkgdir_is_empty) {
        ls -a $pkgdir | where type == dir | each { |it| cd $it.name;git clean -xdf }
    }
}

# search the archlinux package
export def bb_search [...rest: string] {
    bauerbill -Ss --aur $rest | grep "^[^ ]" | fzf -m --preview 'bauerbill -Si {1}' | awk '{print $1}' | xargs -r wl-copy
}

# query the archlinux package
export def bb_query [...rest: string] {
    sudo bb-wrapper -Qs $rest --aur | pkgparser
}

# install archlinux packages
export def bb_ins [...rest: string] {
    sudo bb-wrapper -S $rest --aur --build-dir ~/.cache/updatepkgs
}

# upgrade system
export def bb_update [] {
    __clean
    yes | sudo bb-wrapper -Syu --build-dir ~/.cache/updatepkgs --noconfirm --needed
    sudo bb-wrapper -Syu --aur-only --build-dir ~/.cache/updatepkgs --noconfirm --needed
}

export def bb_vcs [] {
    sudo bb-wrapper -Syu --aur --build-dir ~/.cache/updatepkgs --noconfirm --build-vcs
}

# update or install wayfire packages from git
export def bb_wayfire [] {
    sudo bb-wrapper --aur --build-dir ~/.cache/updatepkgs --noconfirm --build-vcs -S 
}
