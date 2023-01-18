export alias pacupg = sudo pacman -Syu
export alias pacin = sudo pacman -S
export alias pacins = sudo pacman -U
export alias pacre = sudo pacman -R
export alias pacrem = sudo pacman -Rns
export alias pacrep = pacman -Si
export alias pacreps = pacman -Ss
export alias paclocs = pacman -Qs
export alias pacinsd = sudo pacman -S --asdeps
export alias pacmir = sudo pacman -Syy
export alias paclsorphans = sudo pacman -Qdt
export alias pacrmorphans = sudo pacman -Rs $(pacman -Qtdq)
export alias pacfileupg = sudo pacman -Fy
export alias pacfiles = pacman -F
export alias pacown = pacman -Qo
export alias pacupd = sudo pacman -Sy
export alias upgrade = sudo pacman -Syu

export def pacls [...args] {
    pacman -Ql $args | lines | parse -r '(?P<name>[^\s]+)\s+(?P<path>.*)'
}

export def pacloc [...args] {
    pacman -Qi kdeconnect | lines | where not ($it | str starts-with ' ') or $it =~ 'Optional Deps' | parse '{key} : {val}' | str trim | reduce -f {} {|it, acc| $acc | upsert $it.key $it.val}
}
